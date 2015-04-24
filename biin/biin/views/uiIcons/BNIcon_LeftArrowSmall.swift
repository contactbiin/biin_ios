//  BNIcon_LeftArrowSmall.swift
//  biin
//  Created by Esteban Padilla on 2/2/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LeftArrowSmall:BNIcon {
    
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
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(15.1, 5.96))
        bezierPath.addLineToPoint(CGPointMake(1.45, 5.96))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(6.02, 11.6))
        bezier2Path.addLineToPoint(CGPointMake(0, 5.8))
        bezier2Path.addLineToPoint(CGPointMake(0, 5.8))
        bezier2Path.addLineToPoint(CGPointMake(6.02, 0))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}