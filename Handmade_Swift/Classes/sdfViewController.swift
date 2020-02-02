//
//  sdfViewController.swift
//  Handmade_Swift
//
//  Created by PST on 2020/02/02.
//  Copyright © 2020 PST. All rights reserved.
//

import UIKit

class sdfViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var categoryView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
           
           // Set Image ScrollView
           imageScrollView.frame.size.height = imageScrollView.contentSize.height + 20
           contentView.frame.origin.y = imageScrollView.frame.maxY + 8
           categoryView.frame.origin.y = contentView.frame.maxY + 8
           
           // Set Main ScrollView
           scrollView.frame.size.height = UIScreen.main.bounds.height
           scrollView.contentSize = CGSize(width: scrollView.frame.width, height: categoryView.frame.maxY + 44)
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
