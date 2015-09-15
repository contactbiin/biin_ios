//  BNIcon_CollectIt.swift
//  biin
//  Created by Esteban Padilla on 9/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CollectIt:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(7.58, 0))
        bezierPath.addLineToPoint(CGPointMake(7.58, 15))
        bezierPath.lineCapStyle = kCGLineCapRound
        
        bezierPath.lineJoinStyle = kCGLineJoinRound
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(15, 7.37))
        bezier2Path.addLineToPoint(CGPointMake(0, 7.37))
        bezier2Path.lineCapStyle = kCGLineCapRound
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

