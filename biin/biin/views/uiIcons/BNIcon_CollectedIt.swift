//  BNIcon_CollectedIt.swift
//  biin
//  Created by Esteban Padilla on 9/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CollectedIt:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group 2
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(15, 0))
        bezierPath.addLineToPoint(CGPointMake(4.26, 15))
        bezierPath.addLineToPoint(CGPointMake(0, 10.77))
        bezierPath.lineCapStyle = kCGLineCapRound
        bezierPath.lineJoinStyle = kCGLineJoinRound
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}
