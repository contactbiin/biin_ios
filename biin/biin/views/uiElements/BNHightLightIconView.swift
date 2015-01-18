//  BNHightLightIconView.swift
//  Biin
//  Created by Esteban Padilla on 12/8/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNHightLightIconView:UIView {
    
    var icon:BNIcon?
    var isActive = true
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, icon:BNIcon) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        self.icon = icon
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
}