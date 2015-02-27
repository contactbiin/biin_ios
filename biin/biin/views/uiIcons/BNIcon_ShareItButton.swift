//  BNIcon_ShareItButton.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShareItButton:BNIcon {
    
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
        backPath.moveToPoint(CGPointMake(24, 35))
        backPath.addLineToPoint(CGPointMake(11, 35))
        backPath.addCurveToPoint(CGPointMake(0, 24), controlPoint1: CGPointMake(4.9, 35), controlPoint2: CGPointMake(0, 30.1))
        backPath.addLineToPoint(CGPointMake(0, 11))
        backPath.addCurveToPoint(CGPointMake(11, 0), controlPoint1: CGPointMake(0, 4.9), controlPoint2: CGPointMake(4.9, 0))
        backPath.addLineToPoint(CGPointMake(24, 0))
        backPath.addCurveToPoint(CGPointMake(35, 11), controlPoint1: CGPointMake(30.1, 0), controlPoint2: CGPointMake(35, 4.9))
        backPath.addLineToPoint(CGPointMake(35, 24))
        backPath.addCurveToPoint(CGPointMake(24, 35), controlPoint1: CGPointMake(35, 30.1), controlPoint2: CGPointMake(30.1, 35))
        backPath.closePath()
        backPath.miterLimit = 4;
        
        color!.setFill()
        backPath.fill()
        
        
        //// logo Drawing
        var logoPath = UIBezierPath()
        logoPath.moveToPoint(CGPointMake(25.4, 9.1))
        logoPath.addCurveToPoint(CGPointMake(24.5, 8.9), controlPoint1: CGPointMake(25.2, 8.9), controlPoint2: CGPointMake(24.8, 8.8))
        logoPath.addLineToPoint(CGPointMake(9.3, 15.1))
        logoPath.addCurveToPoint(CGPointMake(8.8, 15.9), controlPoint1: CGPointMake(9, 15.2), controlPoint2: CGPointMake(8.8, 15.6))
        logoPath.addCurveToPoint(CGPointMake(9.4, 16.6), controlPoint1: CGPointMake(8.8, 16.2), controlPoint2: CGPointMake(9.1, 16.5))
        logoPath.addLineToPoint(CGPointMake(15.9, 18.4))
        logoPath.addLineToPoint(CGPointMake(17.8, 24.8))
        logoPath.addCurveToPoint(CGPointMake(18.5, 25.4), controlPoint1: CGPointMake(17.9, 25.1), controlPoint2: CGPointMake(18.2, 25.4))
        logoPath.addLineToPoint(CGPointMake(18.5, 25.4))
        logoPath.addCurveToPoint(CGPointMake(19.2, 24.9), controlPoint1: CGPointMake(18.8, 25.4), controlPoint2: CGPointMake(19.1, 25.2))
        logoPath.addLineToPoint(CGPointMake(25.5, 9.9))
        logoPath.addCurveToPoint(CGPointMake(25.4, 9.1), controlPoint1: CGPointMake(25.7, 9.7), controlPoint2: CGPointMake(25.6, 9.3))
        logoPath.closePath()
        logoPath.miterLimit = 4;
        
        logoColor.setStroke()
        logoPath.lineWidth = 2.5
        logoPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

