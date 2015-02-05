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
        let logoColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// back Drawing
        var backPath = UIBezierPath()
        backPath.moveToPoint(CGPointMake(48.5, 81.6))
        backPath.addLineToPoint(CGPointMake(33, 81.6))
        backPath.addCurveToPoint(CGPointMake(0, 48.6), controlPoint1: CGPointMake(14.8, 81.6), controlPoint2: CGPointMake(0, 66.8))
        backPath.addLineToPoint(CGPointMake(0, 33))
        backPath.addCurveToPoint(CGPointMake(33, 0), controlPoint1: CGPointMake(0, 14.8), controlPoint2: CGPointMake(14.8, 0))
        backPath.addLineToPoint(CGPointMake(48.6, 0))
        backPath.addCurveToPoint(CGPointMake(81.6, 33), controlPoint1: CGPointMake(66.8, 0), controlPoint2: CGPointMake(81.6, 14.8))
        backPath.addLineToPoint(CGPointMake(81.6, 48.6))
        backPath.addCurveToPoint(CGPointMake(48.5, 81.6), controlPoint1: CGPointMake(81.5, 66.8), controlPoint2: CGPointMake(66.8, 81.6))
        backPath.closePath()
        backPath.miterLimit = 4;
        
        color!.setFill()
        backPath.fill()
        
        
        //// logo Drawing
        var logoPath = UIBezierPath()
        logoPath.moveToPoint(CGPointMake(35.6, 33.2))
        logoPath.addCurveToPoint(CGPointMake(42.7, 31.5), controlPoint1: CGPointMake(37.7, 32.1), controlPoint2: CGPointMake(40.1, 31.5))
        logoPath.addCurveToPoint(CGPointMake(58, 46.8), controlPoint1: CGPointMake(51.2, 31.5), controlPoint2: CGPointMake(58, 38.4))
        logoPath.addCurveToPoint(CGPointMake(42.7, 62.1), controlPoint1: CGPointMake(58, 55.2), controlPoint2: CGPointMake(51.1, 62.1))
        logoPath.addCurveToPoint(CGPointMake(27.4, 46.8), controlPoint1: CGPointMake(34.3, 62.1), controlPoint2: CGPointMake(27.4, 55.2))
        logoPath.addLineToPoint(CGPointMake(27.4, 19.6))
        logoPath.lineCapStyle = kCGLineCapRound;
        
        logoPath.lineJoinStyle = kCGLineJoinRound;
        
        logoColor.setStroke()
        logoPath.lineWidth = 6
        logoPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
