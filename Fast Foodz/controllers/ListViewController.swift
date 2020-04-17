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
        
        tableView.dataSource = self
    }
    
    func presentBusinessDataOnList(with yelpBusinessModels: [BusinessModel]) {
        yelpBusinessData = yelpBusinessModels.compactMap { business in YelpBusinessCellData(with: business) }
    }
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yelpBusinessData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YelpBusinessTableViewCell") as? YelpBusinessTableViewCell
        //cell?.imageView?.image = yelpBusinessData[indexPath.row].cellImage
        cell?.nameLabel.text = yelpBusinessData[indexPath.row].name
        cell?.distanceLabel.text = String(format:"%.2f", yelpBusinessData[indexPath.row].distance)
        cell?.ratingsLabel.text = yelpBusinessData[indexPath.row].rating.description
        
        return cell ?? UITableViewCell()
    }
    
}


