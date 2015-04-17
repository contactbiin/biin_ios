//  BNUIDiscountView.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIDiscountView:UIView {
    
    var text:UILabel?
    var icon:BNIcon?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, text:String) {
        self.init(frame: frame)

        self.backgroundColor = UIColor.appMainColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.text = UILabel(frame: CGRectMake(3, 12, self.frame.width, 10))
        self.text!.textColor = UIColor.appMainColor()
        self.text!.textAlignment = NSTextAlignment.Center
        self.text!.font = UIFont(name: "Lato-Black", size:8)
        self.text!.text = "\(text)%"
        self.addSubview(self.text!)
        
        icon = BNIcon_PigSmall(color:UIColor.bnRed(), position: CGPointMake(9, 5))
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}
