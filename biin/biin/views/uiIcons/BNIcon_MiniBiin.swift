//  BNIcon_MiniBiin.swift
//  biin
//  Created by Esteban Padilla on 4/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_MiniBiin:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(3.27, 4.99))
        bezier2Path.addCurveToPoint(CGPointMake(6.06, 4.35), controlPoint1: CGPointMake(4.12, 4.6), controlPoint2: CGPointMake(5.06, 4.35))
        bezier2Path.addCurveToPoint(CGPointMake(12.09, 9.98), controlPoint1: CGPointMake(9.4, 4.35), controlPoint2: CGPointMake(12.09, 6.86))
        bezier2Path.addCurveToPoint(CGPointMake(6.06, 15.6), controlPoint1: CGPointMake(12.09, 13.09), controlPoint2: CGPointMake(9.4, 15.6))
        bezier2Path.addCurveToPoint(CGPointMake(0, 9.98), controlPoint1: CGPointMake(2.72, 15.6), controlPoint2: CGPointMake(0, 13.09))
        bezier2Path.addLineToPoint(CGPointMake(0, 0))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(15.68, 15.6))
        bezier4Path.addLineToPoint(CGPointMake(15.68, 7.71))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(19.31, 15.6))
        bezier6Path.addLineToPoint(CGPointMake(19.31, 7.71))
        bezier6Path.lineCapStyle = CGLineCap.Round;
        
        bezier6Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier6Path.lineWidth = 2
        bezier6Path.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(18, 2.4, 3.2, 3.2))
        color!.setFill()
        oval2Path.fill()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(32.6, 15.6))
        bezier8Path.addLineToPoint(CGPointMake(32.6, 8.86))
        bezier8Path.addCurveToPoint(CGPointMake(27.77, 4.35), controlPoint1: CGPointMake(32.6, 6.38), controlPoint2: CGPointMake(30.43, 4.35))
        bezier8Path.addCurveToPoint(CGPointMake(22.94, 8.86), controlPoint1: CGPointMake(25.11, 4.35), controlPoint2: CGPointMake(22.94, 6.38))
        bezier8Path.addLineToPoint(CGPointMake(22.94, 15.6))
        bezier8Path.lineCapStyle = CGLineCap.Round;
        
        bezier8Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier8Path.lineWidth = 2
        bezier8Path.stroke()
        
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalInRect: CGRectMake(13.9, 2.4, 3.1, 3.2))
        color!.setFill()
        oval4Path.fill()
        
        
        
        CGContextRestoreGState(context)
        
    }
}