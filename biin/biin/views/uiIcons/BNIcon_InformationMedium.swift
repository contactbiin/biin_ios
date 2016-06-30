//  BNIcon_InformationMedium.swift
//  biin
//  Created by Esteban Padilla on 7/9/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_InformationMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color0 = UIColor(red: 0.678, green: 0.687, blue: 0.696, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(26, 12.77))
        bezier2Path.addCurveToPoint(CGPointMake(13, 26), controlPoint1: CGPointMake(26.12, 19.92), controlPoint2: CGPointMake(20.21, 25.89))
        bezier2Path.addCurveToPoint(CGPointMake(0, 13.24), controlPoint1: CGPointMake(5.85, 26.12), controlPoint2: CGPointMake(0.12, 20.39))
        bezier2Path.addCurveToPoint(CGPointMake(13, 0), controlPoint1: CGPointMake(-0.12, 6.09), controlPoint2: CGPointMake(5.79, 0.12))
        bezier2Path.addCurveToPoint(CGPointMake(26, 12.77), controlPoint1: CGPointMake(20.15, -0.12), controlPoint2: CGPointMake(25.89, 5.62))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color0.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(13, 14.78))
        bezier4Path.addLineToPoint(CGPointMake(13, 6.5))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color0.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        //// Group 2
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(13, 18))
        bezier6Path.addLineToPoint(CGPointMake(13, 18))
        bezier6Path.addCurveToPoint(CGPointMake(12, 19.55), controlPoint1: CGPointMake(12.43, 18), controlPoint2: CGPointMake(12, 18.7))
        bezier6Path.addCurveToPoint(CGPointMake(13, 21), controlPoint1: CGPointMake(12, 20.35), controlPoint2: CGPointMake(12.47, 21))
        bezier6Path.addCurveToPoint(CGPointMake(13.03, 21), controlPoint1: CGPointMake(13, 21), controlPoint2: CGPointMake(13, 21))
        bezier6Path.addCurveToPoint(CGPointMake(14, 19.45), controlPoint1: CGPointMake(13.6, 21), controlPoint2: CGPointMake(14.03, 20.3))
        bezier6Path.addCurveToPoint(CGPointMake(13, 18), controlPoint1: CGPointMake(14, 18.65), controlPoint2: CGPointMake(13.53, 18))
        bezier6Path.addLineToPoint(CGPointMake(13, 18))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color0.setFill()
        bezier6Path.fill()
        
        
        
        
        
        CGContextRestoreGState(context)
    }
}
