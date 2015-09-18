//  BNIcon_Warning.swift
//  biin
//  Created by Esteban Padilla on 7/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Warning:BNIcon {
    
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
        
        
        
        //// ball Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 44, 44)
        CGContextRotateCTM(context, 44.85 * CGFloat(M_PI) / 180)
        
        let ballPath = UIBezierPath(ovalInRect: CGRectMake(-30.93, -31.3, 61.86, 62.6))
        color!.setStroke()
        ballPath.lineWidth = 2.5
        ballPath.stroke()
        
        CGContextRestoreGState(context)
        
        
        //// stick Drawing
        let stickPath = UIBezierPath()
        stickPath.moveToPoint(CGPointMake(43.98, 48.24))
        stickPath.addLineToPoint(CGPointMake(43.98, 28.44))
        stickPath.lineCapStyle = CGLineCap.Round;
        
        stickPath.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        stickPath.lineWidth = 4
        stickPath.stroke()
        
        
        //// point Drawing
        let pointPath = UIBezierPath()
        pointPath.moveToPoint(CGPointMake(43.98, 55.28))
        pointPath.addLineToPoint(CGPointMake(43.94, 55.28))
        pointPath.addCurveToPoint(CGPointMake(41.16, 58.15), controlPoint1: CGPointMake(42.39, 55.32), controlPoint2: CGPointMake(41.12, 56.59))
        pointPath.addCurveToPoint(CGPointMake(43.98, 60.93), controlPoint1: CGPointMake(41.2, 59.7), controlPoint2: CGPointMake(42.43, 60.93))
        pointPath.addLineToPoint(CGPointMake(44.03, 60.93))
        pointPath.addCurveToPoint(CGPointMake(46.81, 58.07), controlPoint1: CGPointMake(45.58, 60.89), controlPoint2: CGPointMake(46.85, 59.62))
        pointPath.addCurveToPoint(CGPointMake(43.98, 55.28), controlPoint1: CGPointMake(46.81, 56.51), controlPoint2: CGPointMake(45.54, 55.28))
        pointPath.addLineToPoint(CGPointMake(43.98, 55.28))
        pointPath.closePath()
        pointPath.miterLimit = 4;
        
        color!.setFill()
        pointPath.fill()
        
        
        
        CGContextRestoreGState(context)
        
    }
}

