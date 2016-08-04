//  BNUIView_PriceX.swift
//  biin
//  Created by Esteban Padilla on 4/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIView_PriceX:UIView {

    var icon:BNIcon?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor, position:CGPoint, size:CGFloat, strokeWidth:CGFloat ) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_RedX(color: color, position: position)
        icon!.width = size
        icon!.strokeWidth = strokeWidth
    }
    

    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
}
