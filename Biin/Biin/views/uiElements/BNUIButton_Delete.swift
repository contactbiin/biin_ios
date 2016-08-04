//  BNUIButton_Delete.swift
//  Biin
//  Created by Esteban Padilla on 7/18/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Delete:BNUIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect, iconColor:UIColor){
        self.init(frame: frame)
        icon = BNIcon_Delete(color:iconColor, position: CGPoint(x: 5, y: 5))
    }
}