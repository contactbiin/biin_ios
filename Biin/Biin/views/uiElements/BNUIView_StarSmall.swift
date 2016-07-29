//  BNUIView_StarSmall.swift
//  Biin
//  Created by Esteban Padilla on 7/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIView_StarSmall:UIView {
    
    var icon:BNIcon_StarSmall?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_StarSmall(color: color, position: CGPoint(x: 0, y: 0))
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
}