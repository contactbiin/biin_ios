//  CompletedCircleIcon.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CompletedGameIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// back Drawing
        var backPath = UIBezierPath()
        backPath.moveToPoint(CGPointMake(48.5, 81.5))
        backPath.addLineToPoint(CGPointMake(33, 81.5))
        backPath.addCurveToPoint(CGPointMake(0, 48.5), controlPoint1: CGPointMake(14.8, 81.5), controlPoint2: CGPointMake(0, 66.7))
        backPath.addLineToPoint(CGPointMake(0, 33))
        backPath.addCurveToPoint(CGPointMake(33, 0), controlPoint1: CGPointMake(0, 14.8), controlPoint2: CGPointMake(14.8, 0))
        backPath.addLineToPoint(CGPointMake(48.6, 0))
        backPath.addCurveToPoint(CGPointMake(81.6, 33), controlPoint1: CGPointMake(66.8, 0), controlPoint2: CGPointMake(81.6, 14.8))
        backPath.addLineToPoint(CGPointMake(81.6, 48.6))
        backPath.addCurveToPoint(CGPointMake(48.5, 81.5), controlPoint1: CGPointMake(81.5, 66.8), controlPoint2: CGPointMake(66.7, 81.5))
        backPath.closePath()
        backPath.miterLimit = 4;
        
        backPath.lineCapStyle = kCGLineCapRound;
        
        backPath.lineJoinStyle = kCGLineJoinRound;
        
        color0.setStroke()
        backPath.lineWidth = 3
        backPath.stroke()
        
        
        //// icon Drawing
        var iconPath = UIBezierPath()
        iconPath.moveToPoint(CGPointMake(57.1, 21.2))
        iconPath.addLineToPoint(CGPointMake(32, 46.3))
        iconPath.addLineToPoint(CGPointMake(25, 39.3))
        iconPath.addLineToPoint(CGPointMake(17.9, 46.3))
        iconPath.addLineToPoint(CGPointMake(32, 60.4))
        iconPath.addLineToPoint(CGPointMake(64.1, 28.3))
        iconPath.addLineToPoint(CGPointMake(57.1, 21.2))
        iconPath.closePath()
        iconPath.miterLimit = 4;
        
        iconPath.lineCapStyle = kCGLineCapRound;
        
        iconPath.lineJoinStyle = kCGLineJoinRound;
        
        color0.setStroke()
        iconPath.lineWidth = 3
        iconPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
