//  BNIcon_ProfileMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ProfileMedium:BNIcon {
    
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
        
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(17.35, 26.6))
        bezier6Path.addLineToPoint(CGPointMake(9.11, 26.6))
        bezier6Path.addCurveToPoint(CGPointMake(0, 17.48), controlPoint1: CGPointMake(4.08, 26.6), controlPoint2: CGPointMake(0, 22.51))
        bezier6Path.addLineToPoint(CGPointMake(0, 9.12))
        bezier6Path.addCurveToPoint(CGPointMake(9.11, 0), controlPoint1: CGPointMake(0, 4.09), controlPoint2: CGPointMake(4.08, 0))
        bezier6Path.addLineToPoint(CGPointMake(15.27, 0))
        bezier6Path.addLineToPoint(CGPointMake(17.39, 0))
        bezier6Path.addCurveToPoint(CGPointMake(26.5, 9.12), controlPoint1: CGPointMake(22.42, 0), controlPoint2: CGPointMake(26.5, 4.09))
        bezier6Path.addLineToPoint(CGPointMake(26.5, 17.43))
        bezier6Path.addCurveToPoint(CGPointMake(17.35, 26.6), controlPoint1: CGPointMake(26.5, 22.47), controlPoint2: CGPointMake(22.38, 26.6))
        bezier6Path.closePath()
        color!.setStroke()
        bezier6Path.lineWidth = 2
        bezier6Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(20.1, 13.98))
        bezier2Path.addCurveToPoint(CGPointMake(13.2, 20.8), controlPoint1: CGPointMake(20.1, 17.66), controlPoint2: CGPointMake(17, 20.8))
        bezier2Path.addCurveToPoint(CGPointMake(6.3, 13.98), controlPoint1: CGPointMake(9.4, 20.8), controlPoint2: CGPointMake(6.3, 17.66))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(18.99, 9.51))
        bezier4Path.addCurveToPoint(CGPointMake(15.38, 9.51), controlPoint1: CGPointMake(18.99, 8.52), controlPoint2: CGPointMake(15.38, 8.52))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(7.5, 7.4, 3.2, 3.2))
        color!.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}