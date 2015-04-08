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
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier1 Drawing
        var bezier1Path = UIBezierPath()
        bezier1Path.moveToPoint(CGPointMake(0, 6.1))
        bezier1Path.addLineToPoint(CGPointMake(4.6, 0))
        bezier1Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier1Path.lineWidth = 3
        bezier1Path.stroke()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 6.1))
        bezierPath.addLineToPoint(CGPointMake(4.6, 12.2))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}