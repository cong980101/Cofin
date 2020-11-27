//
//  CitiesCafeListTableViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/8.
//

import UIKit
import Firebase
import SVProgressHUD

class CitiesCafeListTableViewController: UITableViewController{
    
    
    
    var cityEngName: String?
    var apiCitiesReq = APICitiesReq()
    var apiDatas = [APIData]()
    
    var searchController: UISearchController!
    var searchResults = [APIData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)]
        //navigationController?.hidesBarsOnSwipe = true
        
        
        apiCitiesReq.delegate = self
        if let cityName = cityEngName{
            apiCitiesReq.fetchCity(cityName: cityName)
        }
        
        //SearchController
        
        //searchController = UISearchController(searchResultsController: nil)
        //self.navigationItem.searchController = searchController


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    // Hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        } else {
            return apiDatas.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesCafeListCell", for: indexPath) as! CitiesCafeListTableViewCell
        let random = Int.random(in: 1...18)
        cell.cafeNameLabel.text = apiDatas[indexPath.row].name
        cell.cafeAddressLabel.text = apiDatas[indexPath.row].address
        cell.thumbnailImageView.image = UIImage(named: "image\(random)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        
        let AddAction = UIContextualAction(style: .normal, title: "Like") {(action, sourceView, completionHandler) in
            
            let userID = Auth.auth().currentUser?.email
            let uid = Auth.auth().currentUser?.uid
            
            SVProgressHUD.setMinimumDismissTimeInterval(1.5)
            SVProgressHUD.show()
            
            let db = Firestore.firestore()
            let documentID = String(Date().timeIntervalSince1970 * 1000)
            let data: [String: Any] = ["userID": userID!,
                                       "documentID": documentID,
                                       "name": self.apiDatas[indexPath.row].name,
                                       "city": self.apiDatas[indexPath.row].city,
                                       "tasty": self.apiDatas[indexPath.row].tasty,
                                       "address": self.apiDatas[indexPath.row].address,
                                       "mrt": self.apiDatas[indexPath.row].mrt!,
                                       "url": self.apiDatas[indexPath.row].url!,
                                       "open_time": self.apiDatas[indexPath.row].open_time!,
                                       "latitude": self.apiDatas[indexPath.row].latitude,
                                       "longitude": self.apiDatas[indexPath.row].longitude]
            
            db.collection("UserFavorite").document(uid!).collection("detail").document(documentID).setData(data) { (error) in
                if let error = error {
                    print(error)
                }
            }
            
            SVProgressHUD.showSuccess(withStatus: "Save Successd!")
            
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [AddAction])
        return swipeConfiguration
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showCityCafeDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CityCafeDateilTableViewController
                destinationController.detailData = apiDatas[indexPath.row]
            }
        }
        
    }
    // MARK: - Search bar
    
    func filterContent(for searchText: String){
        searchResults = apiDatas.filter({(data) -> Bool in
            if let name: String? = data.name {
                let isMatch = name!.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = (searchController.searchBar.text){
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }


}



// MARK: - APICitiesReqDelegate Methods

extension CitiesCafeListTableViewController: APICitiesReqDelegate{
    func updateData(_ apiCitiesReq: APICitiesReq, finalData: [APIData]){
        DispatchQueue.main.async {
            self.apiDatas = finalData
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error){
        print(error)
    }
}
