//
//  YelpBusinessTableViewCell.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import UIKit

class YelpBusinessCellData {
    let name: String
    let cellImage: UIImage
    let distance: Double
    let rating: Double
    
    init(name: String, image: UIImage,
         distance: Double, rating: Double) {
        self.name = name; self.cellImage = image;
        self.distance = distance; self.rating = rating
    }
    
    init(with businessModel: BusinessModel) {
        self.name = businessModel.name
        self.cellImage = #imageLiteral(resourceName: "chinese")
        self.distance = businessModel.distance
        self.rating = businessModel.rating
    }
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
