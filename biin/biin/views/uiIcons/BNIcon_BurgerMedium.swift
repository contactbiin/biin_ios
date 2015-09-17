//  BNIcon_BurgerMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BurgerMedium:BNIcon {
    
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
        
        //// Group 2
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(6.5, 3.5))
        bezier2Path.addCurveToPoint(CGPointMake(6, 4), controlPoint1: CGPointMake(6.2, 3.5), controlPoint2: CGPointMake(6, 3.7))
        bezier2Path.addCurveToPoint(CGPointMake(6.5, 4.5), controlPoint1: CGPointMake(6, 4.3), controlPoint2: CGPointMake(6.2, 4.5))
        bezier2Path.addCurveToPoint(CGPointMake(7, 4), controlPoint1: CGPointMake(6.8, 4.5), controlPoint2: CGPointMake(7, 4.3))
        bezier2Path.addCurveToPoint(CGPointMake(6.5, 3.5), controlPoint1: CGPointMake(7, 3.7), controlPoint2: CGPointMake(6.8, 3.5))
        bezier2Path.addLineToPoint(CGPointMake(6.5, 3.5))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        //// Group 3
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(9, 2.5))
        bezier4Path.addCurveToPoint(CGPointMake(8.5, 3), controlPoint1: CGPointMake(8.7, 2.5), controlPoint2: CGPointMake(8.5, 2.7))
        bezier4Path.addCurveToPoint(CGPointMake(9, 3.5), controlPoint1: CGPointMake(8.5, 3.3), controlPoint2: CGPointMake(8.7, 3.5))
        bezier4Path.addCurveToPoint(CGPointMake(9.5, 3), controlPoint1: CGPointMake(9.3, 3.5), controlPoint2: CGPointMake(9.5, 3.3))
        bezier4Path.addCurveToPoint(CGPointMake(9, 2.5), controlPoint1: CGPointMake(9.5, 2.7), controlPoint2: CGPointMake(9.3, 2.5))
        bezier4Path.addLineToPoint(CGPointMake(9, 2.5))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        
        
        //// Group 4
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(14, 2.5))
        bezier6Path.addCurveToPoint(CGPointMake(13.5, 3), controlPoint1: CGPointMake(13.7, 2.5), controlPoint2: CGPointMake(13.5, 2.7))
        bezier6Path.addCurveToPoint(CGPointMake(14, 3.5), controlPoint1: CGPointMake(13.5, 3.3), controlPoint2: CGPointMake(13.7, 3.5))
        bezier6Path.addCurveToPoint(CGPointMake(14.5, 3), controlPoint1: CGPointMake(14.3, 3.5), controlPoint2: CGPointMake(14.5, 3.3))
        bezier6Path.addCurveToPoint(CGPointMake(14, 2.5), controlPoint1: CGPointMake(14.5, 2.7), controlPoint2: CGPointMake(14.3, 2.5))
        bezier6Path.addLineToPoint(CGPointMake(14, 2.5))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        
        
        
        //// Group 5
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(11.5, 3.5))
        bezier8Path.addCurveToPoint(CGPointMake(11, 4), controlPoint1: CGPointMake(11.2, 3.5), controlPoint2: CGPointMake(11, 3.7))
        bezier8Path.addCurveToPoint(CGPointMake(11.5, 4.5), controlPoint1: CGPointMake(11, 4.3), controlPoint2: CGPointMake(11.2, 4.5))
        bezier8Path.addCurveToPoint(CGPointMake(12, 4), controlPoint1: CGPointMake(11.8, 4.5), controlPoint2: CGPointMake(12, 4.3))
        bezier8Path.addCurveToPoint(CGPointMake(11.5, 3.5), controlPoint1: CGPointMake(12, 3.7), controlPoint2: CGPointMake(11.8, 3.5))
        bezier8Path.addLineToPoint(CGPointMake(11.5, 3.5))
        bezier8Path.closePath()
        bezier8Path.miterLimit = 4;
        
        color!.setFill()
        bezier8Path.fill()
        
        
        
        
        //// Group 6
        //// Bezier 10 Drawing
        let bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(16.5, 3.5))
        bezier10Path.addCurveToPoint(CGPointMake(16, 4), controlPoint1: CGPointMake(16.2, 3.5), controlPoint2: CGPointMake(16, 3.7))
        bezier10Path.addCurveToPoint(CGPointMake(16.5, 4.5), controlPoint1: CGPointMake(16, 4.3), controlPoint2: CGPointMake(16.2, 4.5))
        bezier10Path.addCurveToPoint(CGPointMake(17, 4), controlPoint1: CGPointMake(16.8, 4.5), controlPoint2: CGPointMake(17, 4.3))
        bezier10Path.addCurveToPoint(CGPointMake(16.5, 3.5), controlPoint1: CGPointMake(17, 3.7), controlPoint2: CGPointMake(16.8, 3.5))
        bezier10Path.addLineToPoint(CGPointMake(16.5, 3.5))
        bezier10Path.closePath()
        bezier10Path.miterLimit = 4;
        
        color!.setFill()
        bezier10Path.fill()
        
        
        
        
        //// Bezier 12 Drawing
        let bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(11.5, 16))
        bezier12Path.addLineToPoint(CGPointMake(17.5, 19))
        bezier12Path.addLineToPoint(CGPointMake(20.5, 16))
        bezier12Path.lineCapStyle = CGLineCap.Round;
        
        bezier12Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier12Path.lineWidth = 1
        bezier12Path.stroke()
        
        
        //// Bezier 14 Drawing
        let bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(23, 18))
        bezier14Path.addCurveToPoint(CGPointMake(21, 20), controlPoint1: CGPointMake(23, 19.1), controlPoint2: CGPointMake(22.1, 20))
        bezier14Path.addLineToPoint(CGPointMake(2, 20))
        bezier14Path.addCurveToPoint(CGPointMake(0, 18), controlPoint1: CGPointMake(0.9, 20), controlPoint2: CGPointMake(0, 19.1))
        bezier14Path.addCurveToPoint(CGPointMake(2, 16), controlPoint1: CGPointMake(0, 16.9), controlPoint2: CGPointMake(0.9, 16))
        bezier14Path.addLineToPoint(CGPointMake(21, 16))
        bezier14Path.addCurveToPoint(CGPointMake(23, 18), controlPoint1: CGPointMake(22.1, 16), controlPoint2: CGPointMake(23, 16.9))
        bezier14Path.closePath()
        bezier14Path.lineCapStyle = CGLineCap.Round;
        
        bezier14Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier14Path.lineWidth = 1
        bezier14Path.stroke()
        
        
        //// Bezier 16 Drawing
        let bezier16Path = UIBezierPath()
        bezier16Path.moveToPoint(CGPointMake(21, 12))
        bezier16Path.addCurveToPoint(CGPointMake(23, 14), controlPoint1: CGPointMake(22.1, 12), controlPoint2: CGPointMake(23, 12.9))
        bezier16Path.addCurveToPoint(CGPointMake(21, 16), controlPoint1: CGPointMake(23, 15.1), controlPoint2: CGPointMake(22.1, 16))
        bezier16Path.addLineToPoint(CGPointMake(2, 16))
        bezier16Path.addCurveToPoint(CGPointMake(0, 14), controlPoint1: CGPointMake(0.9, 16), controlPoint2: CGPointMake(0, 15.1))
        bezier16Path.addCurveToPoint(CGPointMake(2, 12), controlPoint1: CGPointMake(0, 12.9), controlPoint2: CGPointMake(0.9, 12))
        bezier16Path.lineCapStyle = CGLineCap.Round;
        
        bezier16Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier16Path.lineWidth = 1
        bezier16Path.stroke()
        
        
        //// Bezier 18 Drawing
        let bezier18Path = UIBezierPath()
        bezier18Path.moveToPoint(CGPointMake(2, 20))
        bezier18Path.addLineToPoint(CGPointMake(2, 21))
        bezier18Path.addCurveToPoint(CGPointMake(4, 23), controlPoint1: CGPointMake(2, 22.1), controlPoint2: CGPointMake(2.9, 23))
        bezier18Path.addLineToPoint(CGPointMake(19, 23))
        bezier18Path.addCurveToPoint(CGPointMake(21, 21), controlPoint1: CGPointMake(20.1, 23), controlPoint2: CGPointMake(21, 22.1))
        bezier18Path.addLineToPoint(CGPointMake(21, 20))
        bezier18Path.addLineToPoint(CGPointMake(2, 20))
        bezier18Path.closePath()
        bezier18Path.lineCapStyle = CGLineCap.Round;
        
        bezier18Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier18Path.lineWidth = 1
        bezier18Path.stroke()
        
        //// Bezier 20 Drawing
        let bezier20Path = UIBezierPath()
        bezier20Path.moveToPoint(CGPointMake(21, 9))
        bezier20Path.addCurveToPoint(CGPointMake(11.5, 0), controlPoint1: CGPointMake(21, 3.8), controlPoint2: CGPointMake(16.7, 0))
        bezier20Path.addCurveToPoint(CGPointMake(2, 9), controlPoint1: CGPointMake(6.3, 0), controlPoint2: CGPointMake(2, 3.8))
        bezier20Path.addLineToPoint(CGPointMake(21, 9))
        bezier20Path.closePath()
        bezier20Path.lineCapStyle = CGLineCap.Round;
        
        bezier20Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier20Path.lineWidth = 1
        bezier20Path.stroke()
        
        
        //// Bezier 22 Drawing
        let bezier22Path = UIBezierPath()
        bezier22Path.moveToPoint(CGPointMake(2, 9))
        bezier22Path.addCurveToPoint(CGPointMake(0, 10.5), controlPoint1: CGPointMake(2, 9), controlPoint2: CGPointMake(0, 9.4))
        bezier22Path.addCurveToPoint(CGPointMake(2, 12), controlPoint1: CGPointMake(0, 11.6), controlPoint2: CGPointMake(0.9, 12))
        bezier22Path.addCurveToPoint(CGPointMake(3.5, 11.5), controlPoint1: CGPointMake(2.5, 12), controlPoint2: CGPointMake(3.1, 11.8))
        bezier22Path.addCurveToPoint(CGPointMake(6, 13), controlPoint1: CGPointMake(4, 12.4), controlPoint2: CGPointMake(4.9, 13))
        bezier22Path.addCurveToPoint(CGPointMake(8.5, 11.5), controlPoint1: CGPointMake(7.2, 13), controlPoint2: CGPointMake(8, 12.6))
        bezier22Path.addCurveToPoint(CGPointMake(11.5, 13), controlPoint1: CGPointMake(9, 12.6), controlPoint2: CGPointMake(10.3, 13))
        bezier22Path.addCurveToPoint(CGPointMake(14.5, 11.5), controlPoint1: CGPointMake(12.7, 13), controlPoint2: CGPointMake(14, 12.6))
        bezier22Path.addCurveToPoint(CGPointMake(17, 13), controlPoint1: CGPointMake(15, 12.6), controlPoint2: CGPointMake(15.8, 13))
        bezier22Path.addCurveToPoint(CGPointMake(19.5, 11.5), controlPoint1: CGPointMake(18.1, 13), controlPoint2: CGPointMake(19, 12.4))
        bezier22Path.addCurveToPoint(CGPointMake(21, 12), controlPoint1: CGPointMake(19.9, 11.8), controlPoint2: CGPointMake(20.5, 12))
        bezier22Path.addCurveToPoint(CGPointMake(23, 10.5), controlPoint1: CGPointMake(22.1, 12), controlPoint2: CGPointMake(23, 11.6))
        bezier22Path.addCurveToPoint(CGPointMake(21, 9), controlPoint1: CGPointMake(23, 9.4), controlPoint2: CGPointMake(21, 9))
        bezier22Path.lineCapStyle = CGLineCap.Round;
        
        bezier22Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier22Path.lineWidth = 1
        bezier22Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
