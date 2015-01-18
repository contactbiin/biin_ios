//  CactusIcon.swift
//  Biin
//  Created by Esteban Padilla on 11/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class CactusIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        //// Color Declarations
        let color1 = UIColor(red: 0.995, green: 0.735, blue: 0.058, alpha: 1.000)
        let color2 = UIColor(red: 0.075, green: 0.573, blue: 0.264, alpha: 1.000)
        let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(18.5, 30))
        bezier2Path.addLineToPoint(CGPointMake(7.5, 30))
        bezier2Path.addLineToPoint(CGPointMake(6, 22))
        bezier2Path.addLineToPoint(CGPointMake(20, 22))
        bezier2Path.addLineToPoint(CGPointMake(18.5, 30))
        bezier2Path.closePath()
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color1.setFill()
        bezier2Path.fill()
        color0.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(9, 22))
        bezier4Path.addLineToPoint(CGPointMake(9, 15))
        bezier4Path.addCurveToPoint(CGPointMake(4, 15), controlPoint1: CGPointMake(8.4, 15), controlPoint2: CGPointMake(4, 15))
        bezier4Path.addCurveToPoint(CGPointMake(2, 13), controlPoint1: CGPointMake(4, 15), controlPoint2: CGPointMake(2, 14.9))
        bezier4Path.addCurveToPoint(CGPointMake(2, 9), controlPoint1: CGPointMake(2, 11.1), controlPoint2: CGPointMake(2, 9.6))
        bezier4Path.addCurveToPoint(CGPointMake(4, 7), controlPoint1: CGPointMake(2, 9), controlPoint2: CGPointMake(2.1, 7))
        bezier4Path.addCurveToPoint(CGPointMake(6, 9), controlPoint1: CGPointMake(5.9, 7), controlPoint2: CGPointMake(6, 9))
        bezier4Path.addLineToPoint(CGPointMake(6, 11))
        bezier4Path.addCurveToPoint(CGPointMake(7, 12), controlPoint1: CGPointMake(6, 11.6), controlPoint2: CGPointMake(6.4, 12))
        bezier4Path.addCurveToPoint(CGPointMake(9, 12), controlPoint1: CGPointMake(7.1, 12), controlPoint2: CGPointMake(7.6, 12))
        bezier4Path.addCurveToPoint(CGPointMake(9, 8.5), controlPoint1: CGPointMake(9, 12), controlPoint2: CGPointMake(9, 9.1))
        bezier4Path.addCurveToPoint(CGPointMake(13, 4), controlPoint1: CGPointMake(9, 7.9), controlPoint2: CGPointMake(9.2, 4))
        bezier4Path.addCurveToPoint(CGPointMake(17, 8.5), controlPoint1: CGPointMake(16.8, 4), controlPoint2: CGPointMake(17, 7.9))
        bezier4Path.addCurveToPoint(CGPointMake(17, 16), controlPoint1: CGPointMake(17, 9.1), controlPoint2: CGPointMake(17, 16))
        bezier4Path.addCurveToPoint(CGPointMake(20, 16), controlPoint1: CGPointMake(17, 16), controlPoint2: CGPointMake(18.7, 16))
        bezier4Path.addCurveToPoint(CGPointMake(22.5, 13.5), controlPoint1: CGPointMake(22, 16), controlPoint2: CGPointMake(20.6, 13.5))
        bezier4Path.addCurveToPoint(CGPointMake(24, 15.5), controlPoint1: CGPointMake(23.8, 13.5), controlPoint2: CGPointMake(24, 14.5))
        bezier4Path.addCurveToPoint(CGPointMake(24, 17.5), controlPoint1: CGPointMake(24, 15.5), controlPoint2: CGPointMake(24, 16.9))
        bezier4Path.addCurveToPoint(CGPointMake(21.5, 19), controlPoint1: CGPointMake(24, 18.5), controlPoint2: CGPointMake(22.8, 19))
        bezier4Path.addCurveToPoint(CGPointMake(17, 19), controlPoint1: CGPointMake(20.2, 19), controlPoint2: CGPointMake(17, 19))
        bezier4Path.addLineToPoint(CGPointMake(17, 22))
        color2.setFill()
        bezier4Path.fill()
        color0.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(22.5, 11.5))
        bezier6Path.addLineToPoint(CGPointMake(22.5, 13.5))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(25, 13))
        bezier8Path.addLineToPoint(CGPointMake(23.7, 14.2))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(26, 16))
        bezier10Path.addLineToPoint(CGPointMake(24, 16))
        bezier10Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()
        
        
        //// Bezier 12 Drawing
        var bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(20.5, 13))
        bezier12Path.addLineToPoint(CGPointMake(21.5, 14))
        bezier12Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier12Path.lineWidth = 1
        bezier12Path.stroke()
        
        
        //// Bezier 14 Drawing
        var bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(13, 1))
        bezier14Path.addLineToPoint(CGPointMake(13, 4))
        bezier14Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier14Path.lineWidth = 1
        bezier14Path.stroke()
        
        
        //// Bezier 16 Drawing
        var bezier16Path = UIBezierPath()
        bezier16Path.moveToPoint(CGPointMake(18, 3))
        bezier16Path.addLineToPoint(CGPointMake(16, 5.4))
        bezier16Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier16Path.lineWidth = 1
        bezier16Path.stroke()
        
        
        //// Bezier 18 Drawing
        var bezier18Path = UIBezierPath()
        bezier18Path.moveToPoint(CGPointMake(8, 3))
        bezier18Path.addLineToPoint(CGPointMake(9.8, 5.5))
        bezier18Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier18Path.lineWidth = 1
        bezier18Path.stroke()
        
        
        //// Bezier 20 Drawing
        var bezier20Path = UIBezierPath()
        bezier20Path.moveToPoint(CGPointMake(20, 8))
        bezier20Path.addLineToPoint(CGPointMake(17, 8))
        bezier20Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier20Path.lineWidth = 1
        bezier20Path.stroke()
        
        
        //// Bezier 22 Drawing
        var bezier22Path = UIBezierPath()
        bezier22Path.moveToPoint(CGPointMake(4, 5))
        bezier22Path.addLineToPoint(CGPointMake(4, 7))
        bezier22Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier22Path.lineWidth = 1
        bezier22Path.stroke()
        
        
        //// Bezier 24 Drawing
        var bezier24Path = UIBezierPath()
        bezier24Path.moveToPoint(CGPointMake(7, 6))
        bezier24Path.addLineToPoint(CGPointMake(5.4, 7.6))
        bezier24Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier24Path.lineWidth = 1
        bezier24Path.stroke()
        
        
        //// Bezier 26 Drawing
        var bezier26Path = UIBezierPath()
        bezier26Path.moveToPoint(CGPointMake(1, 6))
        bezier26Path.addLineToPoint(CGPointMake(2.5, 7.6))
        bezier26Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier26Path.lineWidth = 1
        bezier26Path.stroke()
        
        
        //// Bezier 28 Drawing
        var bezier28Path = UIBezierPath()
        bezier28Path.moveToPoint(CGPointMake(6, 19))
        bezier28Path.addLineToPoint(CGPointMake(9, 19))
        bezier28Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier28Path.lineWidth = 1
        bezier28Path.stroke()

    }
}