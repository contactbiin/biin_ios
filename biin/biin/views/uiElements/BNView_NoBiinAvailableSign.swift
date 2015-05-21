//  BNView_NoBiinAvailableSign.swift
//  biin
//  Created by Esteban Padilla on 5/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNView_NoBiinAvailableSign: UIView {
    
    var icon:BNIcon?
    var color:UIColor?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor, iconPosition:CGPoint) {
        self.init(frame:frame)
        self.icon = BNIcon_NoBiinAvailableSign(color: color, position:iconPosition)
        self.color = color
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }

}
