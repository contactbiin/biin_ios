//  CircleStickerIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class CircleStickerIcon:BNIcon {
    
    var starColor:UIColor?
    var colorLines:UIColor?
    
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
//        let color = UIColor(red: 0.445, green: 0.113, blue: 0.475, alpha: 1.000)
//        let colorLines = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
//        let starColor = UIColor(red: 1.000, green: 0.255, blue: 0.255, alpha: 1.000)
        
        //// Group
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 47.4, 47.4))
        color!.setFill()
        oval2Path.fill()
        
        
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(0.9, 0.9, 45.6, 45.6))
        colorLines?.setStroke()
        oval4Path.lineWidth = 1
        oval4Path.stroke()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(26, 6))
        bezier2Path.addLineToPoint(CGPointMake(24.4, 6))
        bezier2Path.addLineToPoint(CGPointMake(23.9, 4.2))
        bezier2Path.addCurveToPoint(CGPointMake(23.7, 4.1), controlPoint1: CGPointMake(23.9, 4.1), controlPoint2: CGPointMake(23.8, 4.1))
        bezier2Path.addCurveToPoint(CGPointMake(23.5, 4.2), controlPoint1: CGPointMake(23.6, 4.1), controlPoint2: CGPointMake(23.5, 4.2))
        bezier2Path.addLineToPoint(CGPointMake(23, 6))
        bezier2Path.addLineToPoint(CGPointMake(21.4, 6))
        bezier2Path.addCurveToPoint(CGPointMake(21.2, 6.1), controlPoint1: CGPointMake(21.3, 6), controlPoint2: CGPointMake(21.2, 6))
        bezier2Path.addCurveToPoint(CGPointMake(21.3, 6.3), controlPoint1: CGPointMake(21.2, 6.2), controlPoint2: CGPointMake(21.2, 6.3))
        bezier2Path.addLineToPoint(CGPointMake(22.5, 7.3))
        bezier2Path.addLineToPoint(CGPointMake(21.8, 8.9))
        bezier2Path.addCurveToPoint(CGPointMake(21.9, 9.1), controlPoint1: CGPointMake(21.8, 9), controlPoint2: CGPointMake(21.8, 9.1))
        bezier2Path.addCurveToPoint(CGPointMake(22.1, 9.1), controlPoint1: CGPointMake(22, 9.2), controlPoint2: CGPointMake(22.1, 9.2))
        bezier2Path.addLineToPoint(CGPointMake(23.7, 8))
        bezier2Path.addLineToPoint(CGPointMake(25.3, 9.1))
        bezier2Path.addLineToPoint(CGPointMake(25.4, 9.1))
        bezier2Path.addLineToPoint(CGPointMake(25.5, 9.1))
        bezier2Path.addCurveToPoint(CGPointMake(25.6, 9), controlPoint1: CGPointMake(25.6, 9.1), controlPoint2: CGPointMake(25.6, 9))
        bezier2Path.addLineToPoint(CGPointMake(24.9, 7.4))
        bezier2Path.addLineToPoint(CGPointMake(26.1, 6.4))
        bezier2Path.addCurveToPoint(CGPointMake(26.2, 6.2), controlPoint1: CGPointMake(26.2, 6.3), controlPoint2: CGPointMake(26.2, 6.3))
        bezier2Path.addCurveToPoint(CGPointMake(26, 6), controlPoint1: CGPointMake(26.1, 6.1), controlPoint2: CGPointMake(26, 6))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        starColor?.setFill()
        bezier2Path.fill()

    }
}
