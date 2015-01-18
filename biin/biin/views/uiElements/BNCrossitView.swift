//  BNCrossitView.swift
//  Biin
//  Created by Esteban Padilla on 9/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNCrossitView:UIView {
    
    var icon:BNIcon?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, iconColor:UIColor, iconScale:CGFloat, iconStroke:CGFloat ) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        icon = CrossitIcon(color:iconColor, scale:iconScale, position:CGPointMake(2, 2), stroke:iconStroke, isFilled:false)
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
}



