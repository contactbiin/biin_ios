//  BNUIBackButton.swift
//  biin
//  Created by Esteban Padilla on 2/2/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Back:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_LeftArrowSmall(color: UIColor.biinColor(), position: CGPointMake(10, 4.5))
    }
}
