//  BNIcon_BiinItButton.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BiinItButton:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        //let color0 = UIColor(red: 0.237, green: 0.727, blue: 0.935, alpha: 1.000)
        let colorLogo = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        //let colorLogo = UIColor(red:63/255, green: 169/255, blue: 245/199, alpha: 1)
        
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
        backPath.addCurveToPoint(CGPointMake(24, 35), controlPoint1: CGPointMake(35, 30.1), controlPoint2: CGPointMake(30, 35))
        backPath.closePath()
        backPath.miterLimit = 4;
        
        color!.setFill()
        backPath.fill()
        
        
        //// logo Drawing
        var logoPath = UIBezierPath()
        logoPath.moveToPoint(CGPointMake(14.7, 14.5))
        logoPath.addCurveToPoint(CGPointMake(17.5, 13.8), controlPoint1: CGPointMake(15.5, 14.1), controlPoint2: CGPointMake(16.5, 13.8))
        logoPath.addCurveToPoint(CGPointMake(23.6, 19.9), controlPoint1: CGPointMake(20.9, 13.8), controlPoint2: CGPointMake(23.6, 16.5))
        logoPath.addCurveToPoint(CGPointMake(17.5, 26), controlPoint1: CGPointMake(23.6, 23.3), controlPoint2: CGPointMake(20.9, 26))
        logoPath.addCurveToPoint(CGPointMake(11.4, 19.9), controlPoint1: CGPointMake(14.1, 26), controlPoint2: CGPointMake(11.4, 23.3))
        logoPath.addLineToPoint(CGPointMake(11.4, 9.1))
        logoPath.lineCapStyle = kCGLineCapRound;
        
        logoPath.lineJoinStyle = kCGLineJoinRound;
        
        colorLogo.setStroke()
        logoPath.lineWidth = 2.5
        logoPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}