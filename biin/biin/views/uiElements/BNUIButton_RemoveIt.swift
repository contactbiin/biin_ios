//  BNUIButton_RemoveIt.swift
//  biin
//  Created by Esteban Padilla on 2/25/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_RemoveIt:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect, color:UIColor?){
        self.init(frame:frame)
        //self.backgroundColor = color!
//        self.layer.cornerRadius = frame.width / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = color!.CGColor
        self.layer.borderWidth = 1
        icon = BNIcon_XSmall(color:color!, position: CGPointMake(4.5, 4.5))
    }
}