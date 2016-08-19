//  BNUIButton_SiteEmail.swift
//  biin
//  Created by Esteban Padilla on 5/20/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_SiteEmail:BNUIButton {
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_SiteEmailButton(color: UIColor.whiteColor(), position: CGPointMake(7, 9))
    }
}
