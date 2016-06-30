//  BNIcon_SiteEmailButton.swift
//  biin
//  Created by Esteban Padilla on 5/20/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SiteEmailButton:BNIcon {
    
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
        bezierPath.moveToPoint(CGPoint(x: 17.78, y: 0.24))
        bezierPath.addCurveToPoint(CGPoint(x: 16.81, y: 0.04), controlPoint1: CGPoint(x: 17.57, y: 0.04), controlPoint2: CGPoint(x: 17.13, y: -0.06))
        bezierPath.addLineToPoint(CGPoint(x: 0.53, y: 6.42))
        bezierPath.addCurveToPoint(CGPoint(x: 0, y: 7.24), controlPoint1: CGPoint(x: 0.21, y: 6.52), controlPoint2: CGPoint(x: 0, y: 6.93))
        bezierPath.addCurveToPoint(CGPoint(x: 0.64, y: 7.95), controlPoint1: CGPoint(x: 0, y: 7.55), controlPoint2: CGPoint(x: 0.32, y: 7.86))
        bezierPath.addLineToPoint(CGPoint(x: 7.61, y: 9.81))
        bezierPath.addLineToPoint(CGPoint(x: 9.65, y: 16.38))
        bezierPath.addCurveToPoint(CGPoint(x: 10.39, y: 17), controlPoint1: CGPoint(x: 9.76, y: 16.69), controlPoint2: CGPoint(x: 10.08, y: 17))
        bezierPath.addLineToPoint(CGPoint(x: 10.39, y: 17))
        bezierPath.addCurveToPoint(CGPoint(x: 11.13, y: 16.49), controlPoint1: CGPoint(x: 10.71, y: 17), controlPoint2: CGPoint(x: 11.03, y: 16.8))
        bezierPath.addLineToPoint(CGPoint(x: 17.88, y: 1.08))
        bezierPath.addCurveToPoint(CGPoint(x: 17.78, y: 0.24), controlPoint1: CGPoint(x: 18.1, y: 0.86), controlPoint2: CGPoint(x: 17.99, y: 0.45))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        CGContextRestoreGState(context)

    }
}