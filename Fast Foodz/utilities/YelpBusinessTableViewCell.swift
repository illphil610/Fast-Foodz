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
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView()
        selectedView.backgroundColor = .powderBlue
        selectedBackgroundView = selectedView
        contentView.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
