//  BNIcon_LoyaltiesMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LoyaltiesMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(12.5, 0))
        bezier2Path.addLineToPoint(CGPointMake(15.52, 9.86))
        bezier2Path.addLineToPoint(CGPointMake(25, 9.86))
        bezier2Path.addLineToPoint(CGPointMake(17.41, 15.56))
        bezier2Path.addLineToPoint(CGPointMake(20.69, 26))
        bezier2Path.addLineToPoint(CGPointMake(12.5, 19.72))
        bezier2Path.addLineToPoint(CGPointMake(4.31, 26))
        bezier2Path.addLineToPoint(CGPointMake(7.59, 15.82))
        bezier2Path.addLineToPoint(CGPointMake(0, 9.86))
        bezier2Path.addLineToPoint(CGPointMake(9.48, 9.86))
        bezier2Path.addLineToPoint(CGPointMake(12.5, 0))
        bezier2Path.closePath()
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}


