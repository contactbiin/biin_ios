//  BNIcon_SitePhoneButton.swift
//  biin
//  Created by Esteban Padilla on 5/20/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SitePhoneButton:BNIcon {
    
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
        bezierPath.moveToPoint(CGPoint(x: 14.65, y: 11.02))
        bezierPath.addCurveToPoint(CGPoint(x: 13.19, y: 10.37), controlPoint1: CGPoint(x: 14.28, y: 10.62), controlPoint2: CGPoint(x: 13.73, y: 10.37))
        bezierPath.addCurveToPoint(CGPoint(x: 11.72, y: 11.02), controlPoint1: CGPoint(x: 12.64, y: 10.37), controlPoint2: CGPoint(x: 12.13, y: 10.58))
        bezierPath.addLineToPoint(CGPoint(x: 11.35, y: 11.41))
        bezierPath.addCurveToPoint(CGPoint(x: 6.24, y: 6.01), controlPoint1: CGPoint(x: 9.5, y: 9.79), controlPoint2: CGPoint(x: 7.77, y: 7.96))
        bezierPath.addLineToPoint(CGPoint(x: 6.61, y: 5.62))
        bezierPath.addCurveToPoint(CGPoint(x: 6.61, y: 2.56), controlPoint1: CGPoint(x: 7.43, y: 4.75), controlPoint2: CGPoint(x: 7.43, y: 3.38))
        bezierPath.addLineToPoint(CGPoint(x: 4.77, y: 0.65))
        bezierPath.addCurveToPoint(CGPoint(x: 3.31, y: 0), controlPoint1: CGPoint(x: 4.4, y: 0.25), controlPoint2: CGPoint(x: 3.85, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 1.84, y: 0.65), controlPoint1: CGPoint(x: 2.76, y: 0), controlPoint2: CGPoint(x: 2.25, y: 0.22))
        bezierPath.addLineToPoint(CGPoint(x: 0.85, y: 1.69))
        bezierPath.addCurveToPoint(CGPoint(x: 0.48, y: 5.58), controlPoint1: CGPoint(x: -0.14, y: 2.74), controlPoint2: CGPoint(x: -0.27, y: 4.35))
        bezierPath.addCurveToPoint(CGPoint(x: 11.76, y: 17.5), controlPoint1: CGPoint(x: 3.41, y: 10.26), controlPoint2: CGPoint(x: 7.29, y: 14.4))
        bezierPath.addCurveToPoint(CGPoint(x: 13.36, y: 18), controlPoint1: CGPoint(x: 12.23, y: 17.82), controlPoint2: CGPoint(x: 12.78, y: 18))
        bezierPath.addCurveToPoint(CGPoint(x: 15.4, y: 17.1), controlPoint1: CGPoint(x: 14.14, y: 18), controlPoint2: CGPoint(x: 14.85, y: 17.67))
        bezierPath.addLineToPoint(CGPoint(x: 16.39, y: 16.05))
        bezierPath.addCurveToPoint(CGPoint(x: 16.39, y: 13), controlPoint1: CGPoint(x: 17.2, y: 15.19), controlPoint2: CGPoint(x: 17.2, y: 13.82))
        bezierPath.addLineToPoint(CGPoint(x: 14.65, y: 11.02))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}