//  BNUIBiinItLargeButton.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_BiinItLarge:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_BiinItLargeButton(color: UIColor.biinColor(), position: CGPointMake(1, 1))
    }
    
    override func showDisable() {
        self.enabled = false
        self.icon!.color = UIColor.appButtonColor_Disable().colorWithAlphaComponent(0.5)
        //.colorWithAlphaComponent(0.75)
        self.setNeedsDisplay()
    }
    
    override func showEnable() {
        self.enabled = true
        self.icon!.color = UIColor.biinColor()
        self.setNeedsDisplay()
    }
}
