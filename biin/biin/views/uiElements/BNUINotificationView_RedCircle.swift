//  BNUINotificationView_RedCircle.swift
//  biin
//  Created by Esteban Padilla on 1/21/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUINotificationView_RedCircle:UIView {

    var label:UILabel?
    
//    override init() {
//        super.init()
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(position: CGPoint) {
        self.init(frame:CGRectMake(position.x, position.y, 18, 18))
        self.backgroundColor = UIColor.appNotificationRedColor()
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
        
        label = UILabel(frame: CGRectMake(0, 1, 18, 18))
        label!.textColor = UIColor.appMainColor()
        label!.textAlignment = NSTextAlignment.Center
        label!.font = UIFont(name: "Lato-Regular", size: 12)
        self.addSubview(label!)
    }
    
    func show(quantity:Int) {
        self.alpha = 1
        label!.text = "\(quantity)"
        label!.sizeToFit()
        let width = label!.frame.width + 11
        label!.frame = CGRectMake(label!.frame.origin.x, label!.frame.origin.y, width, label!.frame.height)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.height)
    }
    
    func hide(){
        self.alpha = 0
    }
}

