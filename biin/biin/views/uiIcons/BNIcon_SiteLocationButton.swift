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
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 7.5, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 0, y: 7.24), controlPoint1: CGPoint(x: 3.5, y: 0), controlPoint2: CGPoint(x: 0, y: 3.21))
        bezierPath.addCurveToPoint(CGPoint(x: 7.5, y: 19), controlPoint1: CGPoint(x: 0, y: 13.77), controlPoint2: CGPoint(x: 7.5, y: 19))
        bezierPath.addCurveToPoint(CGPoint(x: 15, y: 7.24), controlPoint1: CGPoint(x: 7.5, y: 19), controlPoint2: CGPoint(x: 15, y: 13.77))
        bezierPath.addCurveToPoint(CGPoint(x: 7.5, y: 0), controlPoint1: CGPoint(x: 15, y: 3.21), controlPoint2: CGPoint(x: 11.5, y: 0))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 7.5, y: 11.4))
        bezierPath.addCurveToPoint(CGPoint(x: 3.12, y: 7.12), controlPoint1: CGPoint(x: 5, y: 11.4), controlPoint2: CGPoint(x: 3.12, y: 9.5))
        bezierPath.addCurveToPoint(CGPoint(x: 7.5, y: 2.85), controlPoint1: CGPoint(x: 3.12, y: 4.75), controlPoint2: CGPoint(x: 5.13, y: 2.85))
        bezierPath.addCurveToPoint(CGPoint(x: 11.88, y: 7.12), controlPoint1: CGPoint(x: 10, y: 2.85), controlPoint2: CGPoint(x: 11.88, y: 4.75))
        bezierPath.addCurveToPoint(CGPoint(x: 7.5, y: 11.4), controlPoint1: CGPoint(x: 12, y: 9.5), controlPoint2: CGPoint(x: 10, y: 11.4))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}

