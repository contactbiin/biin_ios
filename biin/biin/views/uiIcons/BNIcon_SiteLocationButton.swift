//  BNIcon_SiteLocationButton.swift
//  biin
//  Created by Esteban Padilla on 9/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SiteLocationButton:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(11, 5.69))
        bezierPath.addCurveToPoint(CGPointMake(5.5, 15), controlPoint1: CGPointMake(11, 10.86), controlPoint2: CGPointMake(5.5, 15))
        bezierPath.addCurveToPoint(CGPointMake(0, 5.69), controlPoint1: CGPointMake(5.5, 15), controlPoint2: CGPointMake(0, 10.86))
        bezierPath.addCurveToPoint(CGPointMake(5.5, 0), controlPoint1: CGPointMake(0, 2.53), controlPoint2: CGPointMake(2.6, 0))
        bezierPath.addCurveToPoint(CGPointMake(11, 5.69), controlPoint1: CGPointMake(8.4, 0), controlPoint2: CGPointMake(11, 2.56))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound
        
        bezierPath.lineJoinStyle = kCGLineJoinRound
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(2, 2, 7, 7))
        color!.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        CGContextRestoreGState(context)
    }
}

