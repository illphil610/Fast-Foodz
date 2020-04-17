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
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let selectedRow = tableView.indexPathForSelectedRow
        if let row = selectedRow {
            tableView.deselectRow(at: row, animated: true)
        }
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? YelpBusinessTableViewCell
        
        let storyboard = UIStoryboard(name: FastFoodzStringConstants.storyboardMain, bundle: Bundle.main)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: FastFoodzStringConstants.detailsVC) as? DetailsViewController {
            detailsVC.updateViewsWithBusinessData(for: yelpBusinessData[indexPath.row])
            self.navigationController?.pushViewController(detailsVC, animated: true)
            //UIView.animate(withDuration: 1, animations: { cell?.seperatorView.alpha = 1 })
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? YelpBusinessTableViewCell
        cell?.seperatorView.alpha = 0
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? YelpBusinessTableViewCell
        if !(navigationController?.topViewController?.isKind(of: DetailsViewController.self) ?? true) {
            UIView.animate(withDuration: 1, animations: { cell?.seperatorView.alpha = 1 })
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
        cell?.distanceLabel.text = String(format:"%.2f", getMiles(from: yelpBusinessData[indexPath.row].distance ?? 0.0)) + " miles"
        cell?.ratingsLabel.attributedText = determineRatings(for: yelpBusinessData[indexPath.row].price ?? "")
        cell?.categoryImage?.image = UIImage(named: determineImage(for: yelpBusinessData[indexPath.row].categories))
        return cell ?? UITableViewCell()
    }
    
}

fileprivate extension ListViewController {
    
    // MARK: Private Methods
    
    func configureTableView() {
        tableView.separatorColor = UIColor.londonSky
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func determineImage(for categories: [Category]) -> String {
        for category in categories {
            guard let title = category.title else { continue }
            
            switch title.lowercased() {
            case "pizza", "burgers", "chinese", "mexican":
                return title.lowercased()
            default: break
            }
        }
        return ""
    }
    
    func determineRatings(for price: String) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: FastFoodzStringConstants.ratingDollars)
        attributedString.setColorForText(textForAttribute: price, withColor: UIColor.pickleGreen)
        return attributedString
    }
    
    func getMiles(from meters: Double) -> Double {
        return meters * 0.000621371192
    }
    
}

