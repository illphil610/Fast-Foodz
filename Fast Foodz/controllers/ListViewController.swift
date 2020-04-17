//
//  ListViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var yelpBusinessData = [YelpBusinessCellData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yelpBusinessData.append(YelpBusinessCellData(name: "Phil's Bar", image: #imageLiteral(resourceName: "pizza"), distance: 0.0, rating: 0.0))

        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 40
    }
    
    func presentBusinessDataOnList(with yelpBusinessModels: [BusinessModel]) {
        yelpBusinessData = yelpBusinessModels.compactMap { business in YelpBusinessCellData(with: business) }
    }
    
}

extension ListViewController: UITableViewDelegate {
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yelpBusinessData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YelpBusinessTableViewCell") as? YelpBusinessTableViewCell
        //cell?.imageView?.image = yelpBusinessData[indexPath.row].cellImage
        cell?.nameLabel.text = yelpBusinessData[indexPath.row].name
        cell?.distanceLabel.text = yelpBusinessData[indexPath.row].distance.description
        cell?.ratingsLabel.text = yelpBusinessData[indexPath.row].rating.description
        
        return cell ?? UITableViewCell()
    }
    
}


