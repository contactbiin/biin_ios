//  HomeIcon.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class HomeIcon:BNIcon {

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
        bezier2Path.moveToPoint(CGPointMake(4, 15))
        bezier2Path.addLineToPoint(CGPointMake(4, 27))
        bezier2Path.addLineToPoint(CGPointMake(11, 27))
        bezier2Path.addLineToPoint(CGPointMake(11, 18))
        bezier2Path.addLineToPoint(CGPointMake(18, 18))
        bezier2Path.addLineToPoint(CGPointMake(18, 27))
        bezier2Path.addLineToPoint(CGPointMake(25, 27))
        bezier2Path.addLineToPoint(CGPointMake(25, 15))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(0, 14.5))
        bezier4Path.addLineToPoint(CGPointMake(14.5, 0))
        bezier4Path.addLineToPoint(CGPointMake(29, 14.5))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = stroke
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(19, 1))
        bezier6Path.addLineToPoint(CGPointMake(24, 1))
        bezier6Path.addLineToPoint(CGPointMake(24, 6))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = stroke
        bezier6Path.stroke()
        
        
        
        CGContextRestoreGState(context)

    }
}