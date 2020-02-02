//
//  UIViewExtension.swift
//  Handmade_Swift
//
//  Created by PST on 2020/01/31.
//  Copyright © 2020 PST. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            
            return layer.cornerRadius
        }
        
        set {
            
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            
            return layer.borderWidth
        }
        
        set {
            
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            
            return UIColor(cgColor: layer.borderColor!)
        }
        
        set {
            
            layer.borderColor = newValue?.cgColor
        }
    }
}
