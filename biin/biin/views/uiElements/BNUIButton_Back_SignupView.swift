//
//  BNUIBackButton_SignupView.swift
//  biin
//
//  Created by Esteban Padilla on 2/10/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Back_SignupView:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_LeftArrowMedium(color: UIColor.appTextColor(), position: CGPoint(x:5, y: 2))
    }
}

