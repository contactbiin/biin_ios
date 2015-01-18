//  BNUIGradientView.swift
//  Biin
//  Created by Esteban Padilla on 8/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNUIGradientView:UIView {
    
    override init() {
        super.init()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.insertSublayer(greyGradient(frame), atIndex: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func greyGradient(frame:CGRect)-> CAGradientLayer {

        var color1 = UIColor(white: 0, alpha: 0.2).CGColor
        var color2 = UIColor(white: 0, alpha: 0.15).CGColor
        var color3 = UIColor(white: 0, alpha: 0.05).CGColor
        var color4 = UIColor(white: 0, alpha: 0).CGColor
        
        var stop1:CGFloat = 0.0
        var stop2:CGFloat = 0.01
        var stop3:CGFloat = 0.65
        var stop4:CGFloat = 1.0
        
        var arrayColors: [ AnyObject ] = [ color1, color2, color3, color4 ]
        
        var locations: [AnyObject] = [ stop1, stop2, stop3, stop4 ]

        var gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = arrayColors
        gradient.locations = locations
        
        return gradient
    }
}