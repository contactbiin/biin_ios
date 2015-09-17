//  BNIcon_InformationSmall.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_InformationSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(20, 9.82))
        bezier2Path.addCurveToPoint(CGPointMake(10, 20), controlPoint1: CGPointMake(20.1, 15.32), controlPoint2: CGPointMake(15.55, 19.91))
        bezier2Path.addCurveToPoint(CGPointMake(0, 10.18), controlPoint1: CGPointMake(4.5, 20.1), controlPoint2: CGPointMake(0.09, 15.69))
        bezier2Path.addCurveToPoint(CGPointMake(10, 0), controlPoint1: CGPointMake(-0.09, 4.68), controlPoint2: CGPointMake(4.46, 0.09))
        bezier2Path.addCurveToPoint(CGPointMake(20, 9.82), controlPoint1: CGPointMake(15.5, -0.09), controlPoint2: CGPointMake(19.91, 4.32))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(10, 11.37))
        bezier4Path.addLineToPoint(CGPointMake(10, 5))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Group 2
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(10, 14))
        bezier6Path.addLineToPoint(CGPointMake(10, 14))
        bezier6Path.addCurveToPoint(CGPointMake(9, 15.04), controlPoint1: CGPointMake(9.43, 14), controlPoint2: CGPointMake(9, 14.47))
        bezier6Path.addCurveToPoint(CGPointMake(10, 16), controlPoint1: CGPointMake(9, 15.57), controlPoint2: CGPointMake(9.47, 16))
        bezier6Path.addCurveToPoint(CGPointMake(10.03, 16), controlPoint1: CGPointMake(10, 16), controlPoint2: CGPointMake(10, 16))
        bezier6Path.addCurveToPoint(CGPointMake(11, 14.97), controlPoint1: CGPointMake(10.6, 16), controlPoint2: CGPointMake(11.03, 15.54))
        bezier6Path.addCurveToPoint(CGPointMake(10, 14), controlPoint1: CGPointMake(11, 14.44), controlPoint2: CGPointMake(10.53, 14))
        bezier6Path.addLineToPoint(CGPointMake(10, 14))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()

        CGContextRestoreGState(context)
    }
}