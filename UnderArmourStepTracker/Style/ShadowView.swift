//
//  ShadowView.swift
//  UnderArmourStepTracker
//
//  Created by Pranav Bhandari on 4/29/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.withAlphaComponent(0.2).cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    var shadowOffset : CGSize = CGSize.zero
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shouldRasterize: Bool = false {
        didSet {
            self.layer.shouldRasterize = shouldRasterize
        }
    }
    
    @IBInspectable var rasterizationScale: Bool = true {
        didSet {
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    
}
