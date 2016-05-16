//  BNIcon_LikeIt_Big.swift
//  biin
//  Created by Esteban Padilla on 5/15/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LikeIt_Big:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let strokeColor = UIColor(red: 0.173, green: 0.173, blue: 0.173, alpha: 1.000)
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 58.7, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 40.25, y: 10.18), controlPoint1: CGPoint(x: 50.92, y: 0), controlPoint2: CGPoint(x: 44.1, y: 4.07))
        bezierPath.addCurveToPoint(CGPoint(x: 21.8, y: 0), controlPoint1: CGPoint(x: 36.39, y: 4.07), controlPoint2: CGPoint(x: 29.58, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 0, y: 21.72), controlPoint1: CGPoint(x: 9.76, y: 0), controlPoint2: CGPoint(x: 0, y: 9.72))
        bezierPath.addCurveToPoint(CGPoint(x: 15.09, y: 51.78), controlPoint1: CGPoint(x: 0, y: 33.71), controlPoint2: CGPoint(x: 6.71, y: 43.43))
        bezierPath.addCurveToPoint(CGPoint(x: 40.25, y: 73.5), controlPoint1: CGPoint(x: 23.48, y: 60.14), controlPoint2: CGPoint(x: 36.89, y: 70.16))
        bezierPath.addCurveToPoint(CGPoint(x: 65.41, y: 51.78), controlPoint1: CGPoint(x: 43.6, y: 70.16), controlPoint2: CGPoint(x: 57.02, y: 60.14))
        bezierPath.addCurveToPoint(CGPoint(x: 80.5, y: 21.72), controlPoint1: CGPoint(x: 73.79, y: 43.43), controlPoint2: CGPoint(x: 80.5, y: 33.71))
        bezierPath.addCurveToPoint(CGPoint(x: 58.7, y: 0), controlPoint1: CGPoint(x: 80.5, y: 9.72), controlPoint2: CGPoint(x: 70.74, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 58.7, y: 0))
        bezierPath.closePath()
        
        color!.setFill()
        bezierPath.fill()

        color!.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        CGContextRestoreGState(context)

    }
}