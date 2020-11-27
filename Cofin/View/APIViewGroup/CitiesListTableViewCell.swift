//
//  CitiesListTableViewCell.swift
//  Cofin
//
//  Created by Cong on 2020/11/8.
//

import UIKit

class CitiesListTableViewCell: UITableViewCell {
    
    @IBOutlet var cityNameLabel: UILabel!
    //@IBOutlet var locationLabel: UILabel!
    //@IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet{
            thumbnailImageView.layer.cornerRadius = 30.0
            thumbnailImageView.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
