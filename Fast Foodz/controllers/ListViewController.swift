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
        let cell = tableView.dequeueReusableCell(withIdentifier: "YelpBusinessTableViewCell") as? YelpBusinessTableViewCell
        //cell?.imageView?.image = yelpBusinessData[indexPath.row].categories
        cell?.nameLabel.text = yelpBusinessData[indexPath.row].name
        cell?.distanceLabel.text = String(format:"%.2f", yelpBusinessData[indexPath.row].distance)
        cell?.ratingsLabel.text = yelpBusinessData[indexPath.row].rating.description
        
        determineImage(for: yelpBusinessData[indexPath.row].categories)
        
        return cell ?? UITableViewCell()
    }
    
}

fileprivate extension ListViewController {
    
    enum CategoryType {
        case pizza, chinese, burger, mexican
    }
    
//    func determineImage(for categories: [Category]) -> String {
//        
//        categories.forEach { category in
//            switch category.title {
//            case .pizza:
//                break
//            case .mexican:
//                break,
//            case .chinese:
//                break,
//            case, burger:
//                break
//            }
//        }
//        
//        return ""
//        
//    }
}


