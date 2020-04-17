//
//  ListViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var yelpBusinessData = [BusinessModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func presentBusinessDataOnList(with yelpBusinessModels: [BusinessModel]) {
        yelpBusinessData = yelpBusinessModels
    }
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: FastFoodzStringConstants.storyboardMain, bundle: Bundle.main)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: FastFoodzStringConstants.detailsVC) as? DetailsViewController {
            detailsVC.updateViewsWithBusinessData(for: yelpBusinessData[indexPath.row])
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
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


