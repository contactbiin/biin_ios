//  BNUIBiinItButton.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_BiinIt:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_LikeIt_Empty(color: UIColor.biinColor(), position: CGPointMake(4, 5))
    }
    
    override func showDisable() {
        self.enabled = false
        //self.icon!.color = UIColor.appButtonColor_Disable().colorWithAlphaComponent(0.5)
        //self.setNeedsDisplay()
    }
    
    override func showEnable() {
        self.enabled = true
        //self.icon!.color = UIColor.biinColor()
        //self.setNeedsDisplay()
    }
    
    func changedIcon(value:Bool) {
        icon = nil
        if value {
            icon = BNIcon_LikeIt_Full(color: UIColor.blackColor(), position: CGPointMake(4, 5))
        } else {
            icon = BNIcon_LikeIt_Empty(color: UIColor.blackColor(), position: CGPointMake(4, 5))
        }
        setNeedsDisplay()
    }
}
