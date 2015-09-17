//  BNUIButton_LikeIt.swift
//  biin
//  Created by Esteban Padilla on 9/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_LikeIt:BNUIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_LikeIt_Empty(color: UIColor.biinColor(), position: CGPointMake(4, 5))
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
