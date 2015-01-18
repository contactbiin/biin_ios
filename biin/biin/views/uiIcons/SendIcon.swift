//  SendIcon.swift
//  Biin
//  Created by Esteban Padilla on 9/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class SendIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 6.75))
        bezierPath.addLineToPoint(CGPointMake(17.18, 0))
        bezierPath.addLineToPoint(CGPointMake(10.08, 16.33))
        bezierPath.addLineToPoint(CGPointMake(7.84, 8.88))
        bezierPath.addLineToPoint(CGPointMake(0, 6.75))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        if isFilled {
            color!.setFill()
            bezierPath.fill()
        }
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        CGContextRestoreGState(context)

    }
}