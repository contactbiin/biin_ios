//  ShoesIcon.swift
//  Biin
//  Created by Esteban Padilla on 11/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.


import Foundation
import UIKit
import QuartzCore

class ShoesIcon:BNIcon {
    
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
        let color2 = UIColor(red: 0.899, green: 0.000, blue: 0.111, alpha: 1.000)
        let color4 = UIColor(red: 0.683, green: 0.691, blue: 0.701, alpha: 1.000)
        let color1 = UIColor(red: 0.076, green: 0.615, blue: 0.920, alpha: 1.000)
        let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(12, 12))
        bezier2Path.addLineToPoint(CGPointMake(29, 18.5))
        bezier2Path.addCurveToPoint(CGPointMake(30, 19.5), controlPoint1: CGPointMake(29.5, 18.7), controlPoint2: CGPointMake(30, 19))
        bezier2Path.addLineToPoint(CGPointMake(30, 23))
        bezier2Path.addLineToPoint(CGPointMake(1, 23))
        bezier2Path.addLineToPoint(CGPointMake(1, 13.5))
        bezier2Path.addCurveToPoint(CGPointMake(2.5, 12), controlPoint1: CGPointMake(1, 12.5), controlPoint2: CGPointMake(1.5, 12))
        bezier2Path.addLineToPoint(CGPointMake(4, 12))
        bezier2Path.addCurveToPoint(CGPointMake(8, 14), controlPoint1: CGPointMake(4, 13), controlPoint2: CGPointMake(5.8, 14))
        bezier2Path.addCurveToPoint(CGPointMake(12, 12), controlPoint1: CGPointMake(10.8, 14), controlPoint2: CGPointMake(12, 13.1))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color1.setFill()
        bezier2Path.fill()
        color0.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(16, 13.6))
        bezier4Path.addLineToPoint(CGPointMake(14.5, 15))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color2.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(18.2, 14.4))
        bezier6Path.addLineToPoint(CGPointMake(17, 15.5))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color2.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(22.6, 16.1))
        bezier8Path.addCurveToPoint(CGPointMake(21, 18), controlPoint1: CGPointMake(22.6, 16.8), controlPoint2: CGPointMake(21.7, 18))
        bezier8Path.addLineToPoint(CGPointMake(17, 18))
        bezier8Path.addCurveToPoint(CGPointMake(15.5, 19.5), controlPoint1: CGPointMake(16, 18), controlPoint2: CGPointMake(15.5, 18.5))
        bezier8Path.addLineToPoint(CGPointMake(15.5, 20))
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color0.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(5, 20))
        bezier10Path.addCurveToPoint(CGPointMake(1, 16), controlPoint1: CGPointMake(5, 17.9), controlPoint2: CGPointMake(3.1, 16))
        bezier10Path.lineCapStyle = kCGLineCapRound;
        
        bezier10Path.lineJoinStyle = kCGLineJoinRound;
        
        color0.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(1, 20.5, 29, 2.6))
        color4.setFill()
        rectangle2Path.fill()
        color0.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        
        //// Bezier 12 Drawing
        var bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(19, 12))
        bezier12Path.addLineToPoint(CGPointMake(2, 5.5))
        bezier12Path.addCurveToPoint(CGPointMake(1, 4.5), controlPoint1: CGPointMake(1.5, 5.3), controlPoint2: CGPointMake(1, 5))
        bezier12Path.addLineToPoint(CGPointMake(1, 1))
        bezier12Path.addLineToPoint(CGPointMake(30, 1))
        bezier12Path.addLineToPoint(CGPointMake(30, 10.5))
        bezier12Path.addCurveToPoint(CGPointMake(28.5, 12), controlPoint1: CGPointMake(30, 11.5), controlPoint2: CGPointMake(29.5, 12))
        bezier12Path.addLineToPoint(CGPointMake(27, 12))
        bezier12Path.addCurveToPoint(CGPointMake(23, 10), controlPoint1: CGPointMake(27, 11), controlPoint2: CGPointMake(25.2, 10))
        bezier12Path.addCurveToPoint(CGPointMake(19, 12), controlPoint1: CGPointMake(20.2, 10), controlPoint2: CGPointMake(19, 11))
        bezier12Path.closePath()
        bezier12Path.lineCapStyle = kCGLineCapRound;
        
        bezier12Path.lineJoinStyle = kCGLineJoinRound;
        
        color2.setFill()
        bezier12Path.fill()
        color0.setStroke()
        bezier12Path.lineWidth = 1
        bezier12Path.stroke()
        
        
        //// Bezier 14 Drawing
        var bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(15, 10.5))
        bezier14Path.addLineToPoint(CGPointMake(16.5, 9))
        bezier14Path.lineCapStyle = kCGLineCapRound;
        
        bezier14Path.lineJoinStyle = kCGLineJoinRound;
        
        color1.setStroke()
        bezier14Path.lineWidth = 1
        bezier14Path.stroke()
        
        
        //// Bezier 16 Drawing
        var bezier16Path = UIBezierPath()
        bezier16Path.moveToPoint(CGPointMake(12.8, 9.6))
        bezier16Path.addLineToPoint(CGPointMake(14, 8.5))
        bezier16Path.lineCapStyle = kCGLineCapRound;
        
        bezier16Path.lineJoinStyle = kCGLineJoinRound;
        
        color1.setStroke()
        bezier16Path.lineWidth = 1
        bezier16Path.stroke()
        
        
        //// Bezier 18 Drawing
        var bezier18Path = UIBezierPath()
        bezier18Path.moveToPoint(CGPointMake(8.4, 8))
        bezier18Path.addCurveToPoint(CGPointMake(10, 6.1), controlPoint1: CGPointMake(8.4, 7.3), controlPoint2: CGPointMake(9.3, 6.1))
        bezier18Path.addLineToPoint(CGPointMake(14, 6.1))
        bezier18Path.addCurveToPoint(CGPointMake(15.5, 4.6), controlPoint1: CGPointMake(15, 6.1), controlPoint2: CGPointMake(15.5, 5.6))
        bezier18Path.addLineToPoint(CGPointMake(15.5, 4.1))
        bezier18Path.lineJoinStyle = kCGLineJoinRound;
        
        color2.setFill()
        bezier18Path.fill()
        color0.setStroke()
        bezier18Path.lineWidth = 1
        bezier18Path.stroke()
        
        
        //// Bezier 20 Drawing
        var bezier20Path = UIBezierPath()
        bezier20Path.moveToPoint(CGPointMake(26, 4))
        bezier20Path.addCurveToPoint(CGPointMake(30, 8), controlPoint1: CGPointMake(26, 6.1), controlPoint2: CGPointMake(27.9, 8))
        bezier20Path.lineCapStyle = kCGLineCapRound;
        
        bezier20Path.lineJoinStyle = kCGLineJoinRound;
        
        color2.setFill()
        bezier20Path.fill()
        color0.setStroke()
        bezier20Path.lineWidth = 1
        bezier20Path.stroke()
        
        
        //// Rectangle 4 Drawing
        let rectangle4Path = UIBezierPath(rect: CGRectMake(1, 1, 29, 2.6))
        color4.setFill()
        rectangle4Path.fill()
        color0.setStroke()
        rectangle4Path.lineWidth = 1
        rectangle4Path.stroke()

    }
}