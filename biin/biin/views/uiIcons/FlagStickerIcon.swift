//  FlagStickerIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class FlagStickerIcon:BNIcon {
    
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
        let colorBorder = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0.1, 3.5))
        bezier2Path.addLineToPoint(CGPointMake(6, 18.7))
        bezier2Path.addLineToPoint(CGPointMake(0, 33.9))
        bezier2Path.addLineToPoint(CGPointMake(12, 33.9))
        bezier2Path.addLineToPoint(CGPointMake(12, 3.5))
        bezier2Path.addLineToPoint(CGPointMake(0.1, 3.5))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        UIColor.darkGrayColor().setFill()
        bezier2Path.fill()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(61.7, 0))
        bezier6Path.addLineToPoint(CGPointMake(8, 0))
        bezier6Path.addLineToPoint(CGPointMake(8, 30.4))
        bezier6Path.addLineToPoint(CGPointMake(61.6, 30.4))
        bezier6Path.addLineToPoint(CGPointMake(68.2, 15.1))
        bezier6Path.addLineToPoint(CGPointMake(61.7, 0))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(61.1, 1))
        bezier8Path.addLineToPoint(CGPointMake(9, 1))
        bezier8Path.addLineToPoint(CGPointMake(9, 29.4))
        bezier8Path.addLineToPoint(CGPointMake(61.1, 29.4))
        bezier8Path.addLineToPoint(CGPointMake(67.2, 15.2))
        bezier8Path.addLineToPoint(CGPointMake(61.1, 1))
        bezier8Path.closePath()
        colorBorder.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(63.7, 13.8))
        bezier10Path.addLineToPoint(CGPointMake(61.5, 13.8))
        bezier10Path.addLineToPoint(CGPointMake(60.8, 11.4))
        bezier10Path.addCurveToPoint(CGPointMake(60.5, 11.2), controlPoint1: CGPointMake(60.8, 11.3), controlPoint2: CGPointMake(60.7, 11.2))
        bezier10Path.addCurveToPoint(CGPointMake(60.2, 11.4), controlPoint1: CGPointMake(60.4, 11.2), controlPoint2: CGPointMake(60.3, 11.3))
        bezier10Path.addLineToPoint(CGPointMake(59.5, 13.8))
        bezier10Path.addLineToPoint(CGPointMake(57.3, 13.8))
        bezier10Path.addCurveToPoint(CGPointMake(57.1, 14), controlPoint1: CGPointMake(57.2, 13.8), controlPoint2: CGPointMake(57.1, 13.9))
        bezier10Path.addCurveToPoint(CGPointMake(57.2, 14.3), controlPoint1: CGPointMake(57.1, 14.1), controlPoint2: CGPointMake(57.1, 14.2))
        bezier10Path.addLineToPoint(CGPointMake(58.9, 15.7))
        bezier10Path.addLineToPoint(CGPointMake(57.9, 17.9))
        bezier10Path.addCurveToPoint(CGPointMake(58, 18.2), controlPoint1: CGPointMake(57.9, 18), controlPoint2: CGPointMake(57.9, 18.1))
        bezier10Path.addCurveToPoint(CGPointMake(58.3, 18.2), controlPoint1: CGPointMake(58.1, 18.3), controlPoint2: CGPointMake(58.2, 18.3))
        bezier10Path.addLineToPoint(CGPointMake(60.5, 16.7))
        bezier10Path.addLineToPoint(CGPointMake(62.7, 18.2))
        bezier10Path.addLineToPoint(CGPointMake(62.8, 18.2))
        bezier10Path.addCurveToPoint(CGPointMake(63, 18.1), controlPoint1: CGPointMake(62.9, 18.2), controlPoint2: CGPointMake(62.9, 18.2))
        bezier10Path.addCurveToPoint(CGPointMake(63.1, 17.8), controlPoint1: CGPointMake(63.1, 18), controlPoint2: CGPointMake(63.1, 17.9))
        bezier10Path.addLineToPoint(CGPointMake(62.1, 15.6))
        bezier10Path.addLineToPoint(CGPointMake(63.8, 14.2))
        bezier10Path.addCurveToPoint(CGPointMake(63.9, 13.9), controlPoint1: CGPointMake(63.9, 14.1), controlPoint2: CGPointMake(63.9, 14))
        bezier10Path.addCurveToPoint(CGPointMake(63.7, 13.8), controlPoint1: CGPointMake(63.9, 13.8), controlPoint2: CGPointMake(63.8, 13.8))
        bezier10Path.closePath()
        bezier10Path.miterLimit = 4;
        
        colorBorder.setFill()
        bezier10Path.fill()
  
    
    }
}