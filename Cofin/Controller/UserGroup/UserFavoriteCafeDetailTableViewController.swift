//
//  UserFavoriteCafeDetailTableViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/24.
//

import UIKit
import SafariServices
import Firebase
import MapKit

class UserFavoriteCafeDetailTableViewController: UITableViewController {
    
    var detailData: UserCafeDatas?
    var randomNumber: Int?
    var number = Int.random(in: 1...18)
    
    @IBOutlet var headerView: UserFavoriteCafeDetailHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = detailData {
            headerView.nameLabel.text = data.name
            headerView.headerImageView.image = UIImage(named: "image\(number)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserFavoriteCafeDetailTableViewCell.self), for: indexPath) as! UserFavoriteCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "alarm")
            cell.infoLabel.text = detailData?.open_time ?? ""
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserFavoriteCafeDetailTableViewCell.self), for: indexPath) as! UserFavoriteCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "map")
            cell.infoLabel.text = detailData?.address
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserFavoriteCafeDetailTableViewCell.self), for: indexPath) as! UserFavoriteCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "tram.fill")
            cell.infoLabel.text = detailData?.mrt ?? ""
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserFavoriteCafeDetailTableViewCell.self), for: indexPath) as! UserFavoriteCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "heart.circle.fill")
            cell.infoLabel.text = detailData?.tasty.description
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserFavoriteCafeDetailTableViewCell.self), for: indexPath) as! UserFavoriteCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "globe")
            cell.infoLabel.text = detailData?.url ?? ""
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserFavoriteCafeDetailMapTableViewCell.self), for: indexPath) as! UserFavoriteCafeDetailMapTableViewCell
            
            cell.configure(location: detailData!.address)
                
            
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4{
            if let urlString = detailData?.url{
                if let url = URL(string: urlString){
                    let safariController = SFSafariViewController(url: url)
                    present(safariController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showUserMap" {
            if let _ = tableView.indexPathForSelectedRow, let data = detailData{
                let destination = segue.destination as! UserMapViewController
                destination.cafeData = data
            }
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
