//  BNUIButton_NotificationGo.swift
//  biin
//  Created by Esteban Padilla on 3/9/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_NotificationGo:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.appButtonColor()
        self.layer.cornerRadius = frame.width / 2
        self.layer.masksToBounds = true
        icon = BNIcon_RightArrowSmall(color: UIColor.appMainColor(), position: CGPointMake(4.5, 4.5))
    }
}
