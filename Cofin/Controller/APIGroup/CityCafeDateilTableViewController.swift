//
//  CityCafeDateilTableViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/9.
//

import UIKit
import Firebase
import SafariServices


class CityCafeDateilTableViewController: UITableViewController {
    
    var detailData: APIData?
    var randomNumber: Int?
    var number = Int.random(in: 1...18)
    
    
    @IBOutlet weak var headerView: CityCafeDetailHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigaitionController
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        //DO not cut the header
        tableView.contentInsetAdjustmentBehavior = .never
        
        
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

    /*override func numberOfSections(in tableView: UITableView) -> Int {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCafeDetailTableViewCell.self), for: indexPath) as! CityCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "alarm")
            cell.infoLabel.text = detailData?.open_time ?? ""
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCafeDetailTableViewCell.self), for: indexPath) as! CityCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "map")
            cell.infoLabel.text = detailData?.address
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCafeDetailTableViewCell.self), for: indexPath) as! CityCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "tram.fill")
            cell.infoLabel.text = detailData?.mrt ?? ""
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCafeDetailTableViewCell.self), for: indexPath) as! CityCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "heart.circle.fill")
            cell.infoLabel.text = detailData?.tasty.description
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCafeDetailTableViewCell.self), for: indexPath) as! CityCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "globe")
            cell.infoLabel.text = detailData?.url ?? ""
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCafeDetailMapTableViewCell.self), for: indexPath) as! CityCafeDetailMapTableViewCell
            if let data = detailData {
                let lat = Double(data.latitude)
                let lon = Double(data.longitude)
                let name = data.name
                cell.getLocation(lat: lat!, lon: lon!, name: name)
            }
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMap" {
            if let _ = tableView.indexPathForSelectedRow, let data = detailData{
                let destination = segue.destination as! MapViewController
                destination.apiData = data
            }
        }
        
    }
    

}
