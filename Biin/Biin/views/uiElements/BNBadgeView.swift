//  BNBadgeView.swift
//  Biin
//  Created by Esteban Padilla on 7/7/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNBadgeView:UIView {
    
    var text:UILabel?
    var size:CGFloat = 0
    var value:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(position:CGPoint, size:CGFloat) {
        let frame = CGRect(origin: position, size: CGSize(width: size, height: size))
        self.init(frame: frame)
        
        self.size = size
        self.layer.cornerRadius = (size / 2)
        self.backgroundColor = UIColor.redColor()
        
        text = UILabel(frame: CGRect(x: 0, y: 0, width:size, height:size))
        text!.font = UIFont(name: "HelveticaNeue", size: 16)
        text!.textAlignment = NSTextAlignment.Center
        text!.textColor = UIColor.whiteColor()
        self.addSubview(text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(value:Int) {
        
        if value == 0 {
            self.alpha = 0
            return
        } else {
            self.alpha = 1
        }
        
        self.value = value
        
        if value >= 1000 {
            self.text!.text = "\(value / 1000)K"
        } else {
            self.text!.text = "\(value)"
        }
        
        self.text!.sizeToFit()
        
        if self.text!.frame.width > (size / 2) {
            self.frame = CGRect(x: 0, y: 0, width: (self.text!.frame.width + 15), height: size)
        }
        
        self.text!.frame.origin.x = ((self.frame.width - self.text!.frame.width) / 2)
    }
}