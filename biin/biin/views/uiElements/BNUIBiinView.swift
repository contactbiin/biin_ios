//  BNUIBiinView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIBiinView:UIView {
    
    var icon:BNIcon?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_Biin(color: UIColor.appMainColor(), position: CGPoint(x: 5, y: 5))
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}
