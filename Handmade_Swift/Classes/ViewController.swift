//
//  ViewController.swift
//  Handmade_Swift
//
//  Created by PST on 2020/01/21.
//  Copyright © 2020 PST. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var servicesList: ServiceData?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let urlString = "https://itunes.apple.com/search?term=핸드메이드&country=kr&media=software"
        let escapeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        if let url = URL(string: escapeString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data = data {
                    
                    do {
                        
                        self.servicesList = try JSONDecoder().decode(ServiceData.self, from: data)
                        
                        DispatchQueue.main.async {
                            
                            self.performSegue(withIdentifier: "ListTableViewControlleSegue", sender: nil)
                        }
                    }
                    catch let error {
                        
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "ListTableViewControlleSegue":
            
            let viewController = segue.destination as! ServicesListViewController
            viewController.services = servicesList
        
        default:
            break
        }
    }
}

