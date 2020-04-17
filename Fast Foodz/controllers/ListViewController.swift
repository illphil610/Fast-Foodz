//
//  ListViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var yelpBusinessData = [BusinessModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: FastFoodzStringConstants.storyboardMain, bundle: Bundle.main)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: FastFoodzStringConstants.detailsVC) as? DetailsViewController {
            detailsVC.updateViewsWithBusinessData(for: yelpBusinessData[indexPath.row])
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    // MARK: TableView DataSource Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yelpBusinessData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FastFoodzStringConstants.yelpBusinessTableViewCell) as? YelpBusinessTableViewCell
        cell?.nameLabel.text = yelpBusinessData[indexPath.row].name
        cell?.distanceLabel.text = String(format:"%.2f", yelpBusinessData[indexPath.row].distance)
        cell?.ratingsLabel.attributedText = determineRatings(for: yelpBusinessData[indexPath.row].price ?? "")
        cell?.categoryImage?.image = UIImage(named: determineImage(for: yelpBusinessData[indexPath.row].categories))
        return cell ?? UITableViewCell()
    }
    
}

fileprivate extension ListViewController {
    
    // MARK: Private Methods
    
    func determineImage(for categories: [Category]) -> String {
        for category in categories {
            switch category.title.lowercased() {
            case "pizza", "burgers", "chinese", "mexican":
                return category.title.lowercased()
            default: break
            }
        }
        return ""
    }
    
    func determineRatings(for price: String) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "$$$$")
        attributedString.setColorForText(textForAttribute: price, withColor: UIColor.pickleGreen)
        return attributedString
    }
    
}

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}


