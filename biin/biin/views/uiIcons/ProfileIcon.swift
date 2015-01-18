//  ProfileIcon.swift
//  Biin
//  Created by Esteban Padilla on 7/22/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class ProfileIcon:BNIcon {
    
//    let color:UIColor?
//    let scale:CGFloat = 1.0
//    let position:CGPoint = CGPoint.zeroPoint
//    let stroke:CGFloat = 1.0
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(11.9, 18.3))
        bezier2Path.addCurveToPoint(CGPointMake(10, 14.5), controlPoint1: CGPointMake(11.9, 18.3), controlPoint2: CGPointMake(10, 17.7))
        bezier2Path.addCurveToPoint(CGPointMake(10, 12), controlPoint1: CGPointMake(9, 14.5), controlPoint2: CGPointMake(9, 12))
        bezier2Path.addCurveToPoint(CGPointMake(11.3, 7.6), controlPoint1: CGPointMake(10, 11.6), controlPoint2: CGPointMake(8.1, 7))
        bezier2Path.addCurveToPoint(CGPointMake(19.5, 7.6), controlPoint1: CGPointMake(11.9, 5.1), controlPoint2: CGPointMake(18.9, 5.1))
        bezier2Path.addCurveToPoint(CGPointMake(18.9, 12), controlPoint1: CGPointMake(19.9, 9.3), controlPoint2: CGPointMake(18.9, 11.7))
        bezier2Path.addCurveToPoint(CGPointMake(18.9, 14.5), controlPoint1: CGPointMake(19.9, 12), controlPoint2: CGPointMake(19.9, 14.5))
        bezier2Path.addCurveToPoint(CGPointMake(17, 18.3), controlPoint1: CGPointMake(18.9, 17.7), controlPoint2: CGPointMake(17, 18.3))
        bezier2Path.addLineToPoint(CGPointMake(17, 21.5))
        bezier2Path.addCurveToPoint(CGPointMake(24.8, 24.7), controlPoint1: CGPointMake(20.1, 22.7), controlPoint2: CGPointMake(23.2, 23.6))
        bezier2Path.addCurveToPoint(CGPointMake(29, 14.5), controlPoint1: CGPointMake(27.4, 22.1), controlPoint2: CGPointMake(29, 18.5))
        bezier2Path.addCurveToPoint(CGPointMake(14.5, 0), controlPoint1: CGPointMake(29, 6.5), controlPoint2: CGPointMake(22.5, 0))
        bezier2Path.addCurveToPoint(CGPointMake(0, 14.5), controlPoint1: CGPointMake(6.5, 0), controlPoint2: CGPointMake(0, 6.5))
        bezier2Path.addCurveToPoint(CGPointMake(4.2, 24.7), controlPoint1: CGPointMake(0, 18.5), controlPoint2: CGPointMake(1.6, 22.1))
        bezier2Path.addCurveToPoint(CGPointMake(12, 21.4), controlPoint1: CGPointMake(5.9, 23.5), controlPoint2: CGPointMake(9.2, 22.5))
        bezier2Path.addLineToPoint(CGPointMake(12, 18.3))
        bezier2Path.addLineToPoint(CGPointMake(11.9, 18.3))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Bezier 1 Drawing
        var bezier1Path = UIBezierPath()
        bezier1Path.moveToPoint(CGPointMake(4.1, 24.7))
        bezier1Path.addCurveToPoint(CGPointMake(14.4, 29), controlPoint1: CGPointMake(6.7, 27.4), controlPoint2: CGPointMake(10.4, 29))
        bezier1Path.addCurveToPoint(CGPointMake(24.7, 24.7), controlPoint1: CGPointMake(18.4, 29), controlPoint2: CGPointMake(22.1, 27.3))
        bezier1Path.lineCapStyle = kCGLineCapRound;
        
        bezier1Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier1Path.lineWidth = stroke
        bezier1Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}