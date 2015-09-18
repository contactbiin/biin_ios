//  BNIcon_LikeIt_Full.swift
//  biin
//  Created by Esteban Padilla on 9/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LikeIt_Full:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group 2
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(8.75, 15.5))
        bezierPath.addCurveToPoint(CGPointMake(17.5, 4.31), controlPoint1: CGPointMake(8.75, 15.5), controlPoint2: CGPointMake(17.5, 9.74))
        bezierPath.addCurveToPoint(CGPointMake(8.75, 3.89), controlPoint1: CGPointMake(17.5, -1.15), controlPoint2: CGPointMake(9.74, -1.57))
        bezierPath.addCurveToPoint(CGPointMake(0, 4.73), controlPoint1: CGPointMake(7.76, -1.57), controlPoint2: CGPointMake(0, -1.15))
        bezierPath.addCurveToPoint(CGPointMake(8.75, 15.5), controlPoint1: CGPointMake(0, 10.6), controlPoint2: CGPointMake(8.75, 15.5))
        bezierPath.closePath()
        bezierPath.lineJoinStyle = CGLineJoin.Round
        
        color!.setFill()
        bezierPath.fill()
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
        
    }
}
