//  BNUIButton_Close.swift
//  biin
//  Created by Esteban Padilla on 9/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Close:BNUIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect, iconColor:UIColor){
        self.init(frame: frame)
        
//        self.layer.borderColor = iconColor.CGColor
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = self.frame.width / 2
//        self.layer.masksToBounds = true
        
        icon = BNIcon_CloseSmall(color:iconColor, position: CGPoint(x: 5, y: 5))
    }
}

