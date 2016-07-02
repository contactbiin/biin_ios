//  BNUIButton_More.swift
//  biin
//  Created by Esteban Padilla on 2/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_More:BNUIButton {
    
    //    override init() {
    //        super.init()
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_More(color: UIColor.appTextColor(), position: CGPoint(x:(frame.width / 2), y: ((frame.height / 2) - 5.5)))
    }
}

