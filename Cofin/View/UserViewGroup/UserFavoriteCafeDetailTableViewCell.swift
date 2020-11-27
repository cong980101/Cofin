//
//  UserFavoriteCafeDetailTableViewCell.swift
//  Cofin
//
//  Created by Cong on 2020/11/24.
//

import UIKit

class UserFavoriteCafeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
