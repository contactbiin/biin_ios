//  BNIcon_ShareSmall.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShareSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 3.1))
        bezierPath.addLineToPoint(CGPointMake(7.5, 0))
        bezierPath.addLineToPoint(CGPointMake(4.4, 7.5))
        bezierPath.addLineToPoint(CGPointMake(3.42, 4.08))
        bezierPath.addLineToPoint(CGPointMake(0, 3.1))
        bezierPath.closePath()
        bezierPath.lineCapStyle = CGLineCap.Round;
        
        bezierPath.lineJoinStyle = CGLineJoin.Round;
        
        color!.setFill()
        bezierPath.fill()
        color!.setStroke()
        bezierPath.lineWidth = 1.5
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}
