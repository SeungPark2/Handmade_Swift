//
//  ServicesListViewController.swift
//  Handmade_Swift
//
//  Created by PST on 2020/01/29.
//  Copyright © 2020 PST. All rights reserved.
//

import UIKit

class ServicesListViewController: UITableViewController {
    
    var services: ServiceData? = nil {
        
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Table View data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesCell", for: indexPath) as! ServicesCell
        cell.index = indexPath.row
        
        if let item = services?.results[indexPath.row] {
            
            if let url = URL(string: item.artworkUrl512) {
                do {
                    
                    let data = try Data(contentsOf: url)
                    cell.servicesImage?.image = UIImage(data: data)
                }
                catch let error {
                    print(error)
                }
            }
            
            cell.serviceLabel?.text = item.trackName
            cell.licenseLabel?.text = item.sellerName
            cell.categoryLabel?.text = item.genres.joined(separator: ", ")
            cell.priceLabel?.text = item.formattedPrice
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services?.results.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
        let cell = sender as! ServicesCell
        
        if let index = cell.index {
            
            let item = services?.results[index]
            
            let viewController = segue.destination as! DetailViewController
            viewController.serviceList = item
        }
    }

}

class ServicesCell: UITableViewCell {
    
    var index: Int?
    
    @IBOutlet weak var servicesImage: UIImageView?
    
    @IBOutlet weak var serviceLabel: UILabel?
    @IBOutlet weak var licenseLabel: UILabel?
    
    @IBOutlet weak var categoryLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    
}


