//
//  UserFavoriteTableViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/17.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import SVProgressHUD


class UserFavoriteTableViewController: UITableViewController {
    
    var userCafeDatas = [UserCafeDatas]()
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)]
        navigationController?.hidesBarsOnSwipe = true
        
        
        
        
        
        loadCafeData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userCafeDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCityCafecell", for: indexPath) as! UserFavoriteCafeTableViewCell
        let random = Int.random(in: 1...18)
        
        cell.cafeNameLabel.text = userCafeDatas[indexPath.row].name
        cell.cafeAddressLabel.text = userCafeDatas[indexPath.row].address
        cell.thumbnailImageView.image = UIImage(named: "image\(random)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let uid = Auth.auth().currentUser?.uid
        let ref = db.collection("UserFavorite").document(uid!).collection("detail")
        let documentId = userCafeDatas[indexPath.row].documentId
        
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.show()
        
        userCafeDatas.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        ref.document(documentId).delete() { error in
            if let error = error{
                print("Error removing document: \(error)")
            }else{
                print("\(documentId) removed")
                SVProgressHUD.showSuccess(withStatus: "Removed!")
            }
        }
        
    }

    func loadCafeData() {
        //let userId = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
        
        let ref = db.collection("UserFavorite").document(uid!).collection("detail")
        ref.getDocuments { (querySnapshot, error) in
            self.userCafeDatas = []
            if let error = error{
                print("There was an issue retrieving data from Firestore. \(error)")
            } else{
                
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for doc in snapshotDocuments{
                        
                        let data = doc.data()
                        
                        if let userId = data["userID"] as? String,
                           let documentId = data["documentID"] as? String,
                           let name = data["name"] as? String,
                           let city = data["city"] as? String,
                           let tasty = data["tasty"] as? Double,
                           let address = data["address"] as? String,
                           let mrt = data["mrt"] as? String,
                           let url = data["url"] as? String,
                           let open_time = data["open_time"] as? String,
                           let latitude  = data["latitude"] as? String,
                           let longitude = data["longitude"] as? String{

                           let newUserCafeDatas = UserCafeDatas(userId: userId, documentId: documentId, name: name, city: city, tasty: tasty, address: address, mrt: mrt, url: url, open_time: open_time, latitude: latitude, longitude: longitude)
                            
                            
                            self.userCafeDatas.append(newUserCafeDatas)
                            DispatchQueue.main.async {
                            self.tableView.reloadData()
                            }
                        }
                    }
                    
                }
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserCafeDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! UserFavoriteCafeDetailTableViewController
                destinationVC.detailData = userCafeDatas[indexPath.row]
                print(userCafeDatas)
            }
        }
    }
}



