//  StarIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class StarIcon:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(10.75, 0))
        bezierPath.addLineToPoint(CGPointMake(13.74, 7.03))
        bezierPath.addLineToPoint(CGPointMake(21.5, 7.03))
        bezierPath.addLineToPoint(CGPointMake(15.27, 12.17))
        bezierPath.addLineToPoint(CGPointMake(17.92, 20.5))
        bezierPath.addLineToPoint(CGPointMake(10.75, 15.23))
        bezierPath.addLineToPoint(CGPointMake(3.58, 20.5))
        bezierPath.addLineToPoint(CGPointMake(6.23, 12.17))
        bezierPath.addLineToPoint(CGPointMake(0, 7.03))
        bezierPath.addLineToPoint(CGPointMake(7.76, 7.03))
        bezierPath.addLineToPoint(CGPointMake(10.75, 0))
        bezierPath.closePath()
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