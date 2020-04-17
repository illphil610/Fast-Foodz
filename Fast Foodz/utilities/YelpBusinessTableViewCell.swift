//
//  YelpBusinessTableViewCell.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import UIKit

struct YelpBusinessCellData {
    let name: String
    let cellImage: UIImage
    let distance: Double
    let rating: Double
}

class YelpBusinessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var celImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
