//  BNIcon_LikeIt_Big_Full.swift
//  biin
//  Created by Esteban Padilla on 5/15/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LikeIt_Big_Full:BNIcon {
    
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
        bezierPath.moveToPoint(CGPoint(x: 18.59, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 12.75, y: 3.12), controlPoint1: CGPoint(x: 16.13, y: 0), controlPoint2: CGPoint(x: 13.97, y: 1.25))
        bezierPath.addCurveToPoint(CGPoint(x: 6.91, y: 0), controlPoint1: CGPoint(x: 11.53, y: 1.25), controlPoint2: CGPoint(x: 9.37, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 0, y: 6.65), controlPoint1: CGPoint(x: 3.09, y: 0), controlPoint2: CGPoint(x: 0, y: 2.98))
        bezierPath.addCurveToPoint(CGPoint(x: 4.78, y: 15.85), controlPoint1: CGPoint(x: 0, y: 10.32), controlPoint2: CGPoint(x: 2.12, y: 13.3))
        bezierPath.addCurveToPoint(CGPoint(x: 12.75, y: 22.5), controlPoint1: CGPoint(x: 7.44, y: 18.41), controlPoint2: CGPoint(x: 11.69, y: 21.48))
        bezierPath.addCurveToPoint(CGPoint(x: 20.72, y: 15.85), controlPoint1: CGPoint(x: 13.81, y: 21.48), controlPoint2: CGPoint(x: 18.06, y: 18.41))
        bezierPath.addCurveToPoint(CGPoint(x: 25.5, y: 6.65), controlPoint1: CGPoint(x: 23.37, y: 13.3), controlPoint2: CGPoint(x: 25.5, y: 10.32))
        bezierPath.addCurveToPoint(CGPoint(x: 18.59, y: 0), controlPoint1: CGPoint(x: 25.5, y: 2.98), controlPoint2: CGPoint(x: 22.41, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 18.59, y: 0))
        bezierPath.closePath()
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setFill()
        bezierPath.fill()
        color!.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}