//  BurgerIcon.swift
//  Biin
//  Created by Esteban Padilla on 11/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.


import Foundation
import QuartzCore
import UIKit

class BurgerIcon:BNIcon {
    
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
        let color4 = UIColor(red: 0.488, green: 0.745, blue: 0.191, alpha: 1.000)
        let color1 = UIColor(red: 0.995, green: 0.768, blue: 0.151, alpha: 1.000)
        let color2 = UIColor(red: 0.579, green: 0.281, blue: 0.140, alpha: 1.000)
        let color3 = UIColor(red: 0.920, green: 0.262, blue: 0.106, alpha: 1.000)
        let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(3.6, 26.9))
        bezier2Path.addLineToPoint(CGPointMake(3.6, 28.5))
        bezier2Path.addCurveToPoint(CGPointMake(6.2, 31.1), controlPoint1: CGPointMake(3.6, 29.9), controlPoint2: CGPointMake(4.7, 31.1))
        bezier2Path.addLineToPoint(CGPointMake(25.9, 31.1))
        bezier2Path.addCurveToPoint(CGPointMake(28.5, 28.5), controlPoint1: CGPointMake(27.3, 31.1), controlPoint2: CGPointMake(28.5, 30))
        bezier2Path.addLineToPoint(CGPointMake(28.5, 26.9))
        bezier2Path.addLineToPoint(CGPointMake(3.6, 26.9))
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
        bezier4Path.moveToPoint(CGPointMake(31, 24.3))
        bezier4Path.addCurveToPoint(CGPointMake(28.4, 26.9), controlPoint1: CGPointMake(31, 25.7), controlPoint2: CGPointMake(29.9, 26.9))
        bezier4Path.addLineToPoint(CGPointMake(3.6, 26.9))
        bezier4Path.addCurveToPoint(CGPointMake(1, 24.3), controlPoint1: CGPointMake(2.2, 26.9), controlPoint2: CGPointMake(1, 25.8))
        bezier4Path.addCurveToPoint(CGPointMake(3.6, 21.7), controlPoint1: CGPointMake(1, 22.9), controlPoint2: CGPointMake(2.1, 21.7))
        bezier4Path.addLineToPoint(CGPointMake(28.4, 21.7))
        bezier4Path.addCurveToPoint(CGPointMake(31, 24.3), controlPoint1: CGPointMake(29.9, 21.7), controlPoint2: CGPointMake(31, 22.8))
        bezier4Path.closePath()
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color2.setFill()
        bezier4Path.fill()
        color0.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(16, 21.7))
        bezier6Path.addLineToPoint(CGPointMake(23.8, 25.8))
        bezier6Path.addLineToPoint(CGPointMake(27.9, 21.7))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color1.setFill()
        bezier6Path.fill()
        color0.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(3.6, 16.5))
        bezier8Path.addCurveToPoint(CGPointMake(1, 19.1), controlPoint1: CGPointMake(2.2, 16.5), controlPoint2: CGPointMake(1, 17.6))
        bezier8Path.addCurveToPoint(CGPointMake(3.6, 21.7), controlPoint1: CGPointMake(1, 20.5), controlPoint2: CGPointMake(2.1, 21.7))
        bezier8Path.addLineToPoint(CGPointMake(28.4, 21.7))
        bezier8Path.addCurveToPoint(CGPointMake(31, 19.1), controlPoint1: CGPointMake(29.8, 21.7), controlPoint2: CGPointMake(31, 20.6))
        bezier8Path.addCurveToPoint(CGPointMake(28.4, 16.5), controlPoint1: CGPointMake(31, 17.7), controlPoint2: CGPointMake(29.9, 16.5))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color3.setFill()
        bezier8Path.fill()
        color0.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(3.6, 12.4))
        bezier10Path.addCurveToPoint(CGPointMake(1, 15), controlPoint1: CGPointMake(3.6, 12.4), controlPoint2: CGPointMake(1, 14))
        bezier10Path.addCurveToPoint(CGPointMake(3.6, 16.6), controlPoint1: CGPointMake(1, 16.4), controlPoint2: CGPointMake(2.1, 16.6))
        bezier10Path.addCurveToPoint(CGPointMake(5.7, 16.1), controlPoint1: CGPointMake(4.3, 16.6), controlPoint2: CGPointMake(5.2, 16.5))
        bezier10Path.addCurveToPoint(CGPointMake(8.8, 18.2), controlPoint1: CGPointMake(6.4, 17.3), controlPoint2: CGPointMake(7.3, 18.2))
        bezier10Path.addCurveToPoint(CGPointMake(12.4, 15.6), controlPoint1: CGPointMake(10.4, 18.2), controlPoint2: CGPointMake(11.8, 17))
        bezier10Path.addCurveToPoint(CGPointMake(16, 17.7), controlPoint1: CGPointMake(13, 17), controlPoint2: CGPointMake(14.4, 17.7))
        bezier10Path.addCurveToPoint(CGPointMake(19.6, 15.6), controlPoint1: CGPointMake(17.6, 17.7), controlPoint2: CGPointMake(19, 17))
        bezier10Path.addCurveToPoint(CGPointMake(23.2, 18.2), controlPoint1: CGPointMake(20.2, 17), controlPoint2: CGPointMake(21.6, 18.2))
        bezier10Path.addCurveToPoint(CGPointMake(26.8, 16.1), controlPoint1: CGPointMake(24.7, 18.2), controlPoint2: CGPointMake(26.2, 17.3))
        bezier10Path.addCurveToPoint(CGPointMake(28.9, 16.6), controlPoint1: CGPointMake(27.3, 16.5), controlPoint2: CGPointMake(28.2, 16.6))
        bezier10Path.addCurveToPoint(CGPointMake(31, 15), controlPoint1: CGPointMake(30.3, 16.6), controlPoint2: CGPointMake(31, 16.5))
        bezier10Path.addCurveToPoint(CGPointMake(28.4, 12.4), controlPoint1: CGPointMake(31, 14), controlPoint2: CGPointMake(28.4, 12.4))
        bezier10Path.lineCapStyle = kCGLineCapRound;
        
        bezier10Path.lineJoinStyle = kCGLineJoinRound;
        
        color4.setFill()
        bezier10Path.fill()
        color0.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()
        
        
        //// Bezier 12 Drawing
        var bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(28.4, 12.4))
        bezier12Path.addCurveToPoint(CGPointMake(16, 1), controlPoint1: CGPointMake(28.4, 5.5), controlPoint2: CGPointMake(22.8, 1))
        bezier12Path.addCurveToPoint(CGPointMake(3.6, 12.4), controlPoint1: CGPointMake(9.2, 1), controlPoint2: CGPointMake(3.6, 5.5))
        bezier12Path.addLineToPoint(CGPointMake(28.4, 12.4))
        bezier12Path.closePath()
        bezier12Path.lineCapStyle = kCGLineCapRound;
        
        bezier12Path.lineJoinStyle = kCGLineJoinRound;
        
        color1.setFill()
        bezier12Path.fill()
        color0.setStroke()
        bezier12Path.lineWidth = 1
        bezier12Path.stroke()
        
        
        //// Bezier 14 Drawing
        var bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(9.3, 5.7))
        bezier14Path.addCurveToPoint(CGPointMake(8.8, 6.2), controlPoint1: CGPointMake(9, 5.7), controlPoint2: CGPointMake(8.8, 5.9))
        bezier14Path.addCurveToPoint(CGPointMake(9.3, 6.7), controlPoint1: CGPointMake(8.8, 6.5), controlPoint2: CGPointMake(9, 6.7))
        bezier14Path.addCurveToPoint(CGPointMake(9.8, 6.2), controlPoint1: CGPointMake(9.6, 6.7), controlPoint2: CGPointMake(9.8, 6.5))
        bezier14Path.addCurveToPoint(CGPointMake(9.3, 5.7), controlPoint1: CGPointMake(9.8, 5.9), controlPoint2: CGPointMake(9.6, 5.7))
        bezier14Path.addLineToPoint(CGPointMake(9.3, 5.7))
        bezier14Path.closePath()
        bezier14Path.miterLimit = 4;
        
        color0.setFill()
        bezier14Path.fill()
        
        
        //// Bezier 16 Drawing
        var bezier16Path = UIBezierPath()
        bezier16Path.moveToPoint(CGPointMake(16.5, 5.7))
        bezier16Path.addCurveToPoint(CGPointMake(16, 6.2), controlPoint1: CGPointMake(16.2, 5.7), controlPoint2: CGPointMake(16, 5.9))
        bezier16Path.addCurveToPoint(CGPointMake(16.5, 6.7), controlPoint1: CGPointMake(16, 6.5), controlPoint2: CGPointMake(16.2, 6.7))
        bezier16Path.addCurveToPoint(CGPointMake(17, 6.2), controlPoint1: CGPointMake(16.8, 6.7), controlPoint2: CGPointMake(17, 6.5))
        bezier16Path.addCurveToPoint(CGPointMake(16.5, 5.7), controlPoint1: CGPointMake(17, 5.9), controlPoint2: CGPointMake(16.8, 5.7))
        bezier16Path.addLineToPoint(CGPointMake(16.5, 5.7))
        bezier16Path.closePath()
        bezier16Path.miterLimit = 4;
        
        color0.setFill()
        bezier16Path.fill()
        
        
        //// Bezier 18 Drawing
        var bezier18Path = UIBezierPath()
        bezier18Path.moveToPoint(CGPointMake(22.7, 5.7))
        bezier18Path.addCurveToPoint(CGPointMake(22.2, 6.2), controlPoint1: CGPointMake(22.4, 5.7), controlPoint2: CGPointMake(22.2, 5.9))
        bezier18Path.addCurveToPoint(CGPointMake(22.7, 6.7), controlPoint1: CGPointMake(22.2, 6.5), controlPoint2: CGPointMake(22.4, 6.7))
        bezier18Path.addCurveToPoint(CGPointMake(23.2, 6.2), controlPoint1: CGPointMake(23, 6.7), controlPoint2: CGPointMake(23.2, 6.5))
        bezier18Path.addCurveToPoint(CGPointMake(22.7, 5.7), controlPoint1: CGPointMake(23.2, 5.9), controlPoint2: CGPointMake(23, 5.7))
        bezier18Path.addLineToPoint(CGPointMake(22.7, 5.7))
        bezier18Path.closePath()
        bezier18Path.miterLimit = 4;
        
        color0.setFill()
        bezier18Path.fill()
        
        
        //// Bezier 20 Drawing
        var bezier20Path = UIBezierPath()
        bezier20Path.moveToPoint(CGPointMake(12.4, 3.6))
        bezier20Path.addCurveToPoint(CGPointMake(11.9, 4.1), controlPoint1: CGPointMake(12.1, 3.6), controlPoint2: CGPointMake(11.9, 3.8))
        bezier20Path.addCurveToPoint(CGPointMake(12.4, 4.6), controlPoint1: CGPointMake(11.9, 4.4), controlPoint2: CGPointMake(12.1, 4.6))
        bezier20Path.addCurveToPoint(CGPointMake(12.9, 4.1), controlPoint1: CGPointMake(12.7, 4.6), controlPoint2: CGPointMake(12.9, 4.4))
        bezier20Path.addCurveToPoint(CGPointMake(12.4, 3.6), controlPoint1: CGPointMake(12.9, 3.8), controlPoint2: CGPointMake(12.7, 3.6))
        bezier20Path.addLineToPoint(CGPointMake(12.4, 3.6))
        bezier20Path.closePath()
        bezier20Path.miterLimit = 4;
        
        color0.setFill()
        bezier20Path.fill()
        
        
        //// Bezier 22 Drawing
        var bezier22Path = UIBezierPath()
        bezier22Path.moveToPoint(CGPointMake(19.6, 3.6))
        bezier22Path.addCurveToPoint(CGPointMake(19.1, 4.1), controlPoint1: CGPointMake(19.3, 3.6), controlPoint2: CGPointMake(19.1, 3.8))
        bezier22Path.addCurveToPoint(CGPointMake(19.6, 4.6), controlPoint1: CGPointMake(19.1, 4.4), controlPoint2: CGPointMake(19.3, 4.6))
        bezier22Path.addCurveToPoint(CGPointMake(20.1, 4.1), controlPoint1: CGPointMake(19.9, 4.6), controlPoint2: CGPointMake(20.1, 4.4))
        bezier22Path.addCurveToPoint(CGPointMake(19.6, 3.6), controlPoint1: CGPointMake(20.1, 3.8), controlPoint2: CGPointMake(19.9, 3.6))
        bezier22Path.addLineToPoint(CGPointMake(19.6, 3.6))
        bezier22Path.closePath()
        bezier22Path.miterLimit = 4;
        
        color0.setFill()
        bezier22Path.fill()


        
    }
}