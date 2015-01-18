//
//  TV.swift
//  Biin
//
//  Created by Esteban Padilla on 11/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class TV:BNIcon {
    
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
        let color2 = UIColor(red: 0.952, green: 0.506, blue: 0.097, alpha: 1.000)
        let color4 = UIColor(red: 0.899, green: 0.000, blue: 0.111, alpha: 1.000)
        let color3 = UIColor(red: 0.074, green: 0.591, blue: 0.839, alpha: 1.000)
        let color5 = UIColor(red: 0.078, green: 0.600, blue: 0.250, alpha: 1.000)
        let color1 = UIColor(red: 0.920, green: 0.262, blue: 0.106, alpha: 1.000)
        let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(10, 9))
        bezier2Path.addCurveToPoint(CGPointMake(15.5, 5), controlPoint1: CGPointMake(10, 7), controlPoint2: CGPointMake(13, 5))
        bezier2Path.addCurveToPoint(CGPointMake(21, 9), controlPoint1: CGPointMake(18, 5), controlPoint2: CGPointMake(21, 7))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        color1.setFill()
        bezier2Path.fill()
        color0.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(30, 26))
        bezier4Path.addCurveToPoint(CGPointMake(27, 29), controlPoint1: CGPointMake(30, 27.7), controlPoint2: CGPointMake(28.6, 29))
        bezier4Path.addLineToPoint(CGPointMake(4, 29))
        bezier4Path.addCurveToPoint(CGPointMake(1, 26), controlPoint1: CGPointMake(2.4, 29), controlPoint2: CGPointMake(1, 27.7))
        bezier4Path.addLineToPoint(CGPointMake(1, 12))
        bezier4Path.addCurveToPoint(CGPointMake(4, 9), controlPoint1: CGPointMake(1, 10.4), controlPoint2: CGPointMake(2.4, 9))
        bezier4Path.addLineToPoint(CGPointMake(27, 9))
        bezier4Path.addCurveToPoint(CGPointMake(30, 12), controlPoint1: CGPointMake(28.6, 9), controlPoint2: CGPointMake(30, 10.4))
        bezier4Path.addLineToPoint(CGPointMake(30, 26))
        bezier4Path.closePath()
        color2.setFill()
        bezier4Path.fill()
        color0.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(4, 23.8))
        bezier6Path.addCurveToPoint(CGPointMake(10.5, 27), controlPoint1: CGPointMake(4, 25.1), controlPoint2: CGPointMake(5, 27))
        bezier6Path.addCurveToPoint(CGPointMake(14.3, 27), controlPoint1: CGPointMake(14.3, 27), controlPoint2: CGPointMake(10.5, 27))
        bezier6Path.addCurveToPoint(CGPointMake(21, 24), controlPoint1: CGPointMake(20, 27), controlPoint2: CGPointMake(21, 25))
        bezier6Path.addCurveToPoint(CGPointMake(21, 13.9), controlPoint1: CGPointMake(21, 20.6), controlPoint2: CGPointMake(21, 18))
        bezier6Path.addCurveToPoint(CGPointMake(14.3, 11), controlPoint1: CGPointMake(21, 12.6), controlPoint2: CGPointMake(20, 11))
        bezier6Path.addCurveToPoint(CGPointMake(10.5, 11), controlPoint1: CGPointMake(10.5, 11), controlPoint2: CGPointMake(14.3, 11))
        bezier6Path.addCurveToPoint(CGPointMake(4, 13.7), controlPoint1: CGPointMake(5, 11), controlPoint2: CGPointMake(4, 12.5))
        bezier6Path.addCurveToPoint(CGPointMake(4, 23.8), controlPoint1: CGPointMake(4, 20.4), controlPoint2: CGPointMake(4, 17.1))
        bezier6Path.closePath()
        color3.setFill()
        bezier6Path.fill()
        color0.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(23.5, 12.5, 4, 4))
        color4.setFill()
        oval2Path.fill()
        color0.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
        
        
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(23.5, 19.5, 4, 4))
        color5.setFill()
        oval4Path.fill()
        color0.setStroke()
        oval4Path.lineWidth = 1
        oval4Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(18, 5.5))
        bezier8Path.addLineToPoint(CGPointMake(22.5, 1))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(13, 5.5))
        bezier10Path.addLineToPoint(CGPointMake(8.5, 1))
        bezier10Path.lineCapStyle = kCGLineCapRound;
        
        color0.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()

    }
    
}
