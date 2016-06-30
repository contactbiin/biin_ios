//  BNUIBiinMiniView.swift
//  biin
//  Created by Esteban Padilla on 4/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIBiinMiniView:UIView {
    
    var icon:BNIcon?
    
    //    override init() {
    //        super.init()
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.clearColor()
        //icon = BNIcon_MiniBiin(color: UIColor.appMainColor(), position: CGPoint(x: 5, y: 5))
    }
    
    convenience init(frame: CGRect, color:UIColor) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_MiniBiin(color: color, position: CGPoint(x: 5, y: 5))
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}