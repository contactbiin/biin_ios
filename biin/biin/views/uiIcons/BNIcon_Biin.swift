//  BNIcon_Biin.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Biin:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    convenience init(color:UIColor, position:CGPoint, scale:CGFloat) {
        self.init(color:color, position:position)
        self.scale = scale
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(3.8, 5.95))
        bezier2Path.addCurveToPoint(CGPointMake(7.04, 5.19), controlPoint1: CGPointMake(4.78, 5.48), controlPoint2: CGPointMake(5.88, 5.19))
        bezier2Path.addCurveToPoint(CGPointMake(14.05, 11.9), controlPoint1: CGPointMake(10.92, 5.19), controlPoint2: CGPointMake(14.05, 8.18))
        bezier2Path.addCurveToPoint(CGPointMake(7.04, 18.6), controlPoint1: CGPointMake(14.05, 15.61), controlPoint2: CGPointMake(10.92, 18.6))
        bezier2Path.addCurveToPoint(CGPointMake(0, 11.9), controlPoint1: CGPointMake(3.16, 18.6), controlPoint2: CGPointMake(0, 15.61))
        bezier2Path.addLineToPoint(CGPointMake(0, 0))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(18.75, 18.6))
        bezier4Path.addLineToPoint(CGPointMake(18.75, 9.19))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 3
        bezier4Path.stroke()
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(23.3, 18.6))
        bezier6Path.addLineToPoint(CGPointMake(23.3, 9.19))
        bezier6Path.lineCapStyle = CGLineCap.Round;
        
        bezier6Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier6Path.lineWidth = 3
        bezier6Path.stroke()
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(21.7, 3.4, 3.2, 3.2))
        color!.setFill()
        oval2Path.fill()
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(39.1, 18.6))
        bezier8Path.addLineToPoint(CGPointMake(39.1, 10.56))
        bezier8Path.addCurveToPoint(CGPointMake(33.59, 5.19), controlPoint1: CGPointMake(39.1, 7.61), controlPoint2: CGPointMake(36.62, 5.19))
        bezier8Path.addCurveToPoint(CGPointMake(28.07, 10.56), controlPoint1: CGPointMake(30.55, 5.19), controlPoint2: CGPointMake(28.07, 7.61))
        bezier8Path.addLineToPoint(CGPointMake(28.07, 18.6))
        bezier8Path.lineCapStyle = CGLineCap.Round;
        
        bezier8Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier8Path.lineWidth = 3
        bezier8Path.stroke()
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalInRect: CGRectMake(17.1, 3.4, 3.2, 3.2))
        color!.setFill()
        oval4Path.fill()
        
        CGContextRestoreGState(context)

    }
}
