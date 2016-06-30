//  BNIcon_BiinItLargeButton.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BiinItLargeButton:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        //let fillColor = UIColor(red: 0.278, green: 0.776, blue: 0.949, alpha: 1.000)
        let strokeColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// biinitLarge.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(48.5, 81.6))
        bezierPath.addLineToPoint(CGPointMake(33, 81.6))
        bezierPath.addCurveToPoint(CGPointMake(0, 48.6), controlPoint1: CGPointMake(14.8, 81.6), controlPoint2: CGPointMake(0, 66.8))
        bezierPath.addLineToPoint(CGPointMake(0, 33))
        bezierPath.addCurveToPoint(CGPointMake(33, 0), controlPoint1: CGPointMake(0, 14.8), controlPoint2: CGPointMake(14.8, 0))
        bezierPath.addLineToPoint(CGPointMake(48.6, 0))
        bezierPath.addCurveToPoint(CGPointMake(81.6, 33), controlPoint1: CGPointMake(66.8, 0), controlPoint2: CGPointMake(81.6, 14.8))
        bezierPath.addLineToPoint(CGPointMake(81.6, 48.6))
        bezierPath.addCurveToPoint(CGPointMake(48.5, 81.6), controlPoint1: CGPointMake(81.5, 66.8), controlPoint2: CGPointMake(66.8, 81.6))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color!.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, (position.x + 20), (position.y + 25))
        
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(28.55, 0))
        bezier2Path.addCurveToPoint(CGPointMake(20.07, 3.97), controlPoint1: CGPointMake(25.16, 0), controlPoint2: CGPointMake(22.05, 1.56))
        bezier2Path.addCurveToPoint(CGPointMake(11.45, 0), controlPoint1: CGPointMake(17.95, 1.56), controlPoint2: CGPointMake(14.98, 0))
        bezier2Path.addCurveToPoint(CGPointMake(0, 11.62), controlPoint1: CGPointMake(5.09, 0), controlPoint2: CGPointMake(0, 5.24))
        bezier2Path.addCurveToPoint(CGPointMake(20.07, 35), controlPoint1: CGPointMake(0, 26.21), controlPoint2: CGPointMake(20.07, 35))
        bezier2Path.addCurveToPoint(CGPointMake(40, 11.62), controlPoint1: CGPointMake(20.07, 35), controlPoint2: CGPointMake(40, 26.21))
        bezier2Path.addCurveToPoint(CGPointMake(28.55, 0), controlPoint1: CGPointMake(40, 5.1), controlPoint2: CGPointMake(34.91, 0))
        bezier2Path.closePath()
        strokeColor.setStroke()
        bezier2Path.lineWidth = 4.84
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
        
        
        
        CGContextRestoreGState(context)
    }
}
