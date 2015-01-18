//
//  ShoopingCarFullIcon.swift
//  Biin
//
//  Created by Esteban Padilla on 12/8/14.
//  Copyright (c) 2014 Biin. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class ShoopingCarFullIcon:BNIcon {
    
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
        CGContextScaleCTM(context, scale, scale)
        
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(4, 29, 6, 5))
        color!.setStroke()
        oval2Path.lineWidth = stroke
        oval2Path.stroke()
        
        
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(22, 29, 5, 5))
        color!.setStroke()
        oval4Path.lineWidth = stroke
        oval4Path.stroke()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(37, 1.92))
        bezier2Path.addLineToPoint(CGPointMake(31.39, 1.92))
        bezier2Path.addLineToPoint(CGPointMake(24.88, 28.87))
        bezier2Path.addLineToPoint(CGPointMake(7.02, 28.87))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(25.52, 26.3))
        bezier4Path.addLineToPoint(CGPointMake(4.85, 26.3))
        bezier4Path.addLineToPoint(CGPointMake(0, 10.91))
        bezier4Path.addLineToPoint(CGPointMake(29.22, 10.91))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = stroke
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(16.59, 10.91))
        bezier6Path.addLineToPoint(CGPointMake(23.35, 4.36))
        bezier6Path.addLineToPoint(CGPointMake(28.71, 10.91))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = stroke
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(8.93, 10.91))
        bezier8Path.addLineToPoint(CGPointMake(4.02, 0))
        bezier8Path.addLineToPoint(CGPointMake(0, 1.92))
        bezier8Path.addLineToPoint(CGPointMake(3.83, 10.91))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier8Path.lineWidth = stroke
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(14.03, 10.91))
        bezier10Path.addLineToPoint(CGPointMake(14.03, 5.77))
        bezier10Path.addLineToPoint(CGPointMake(21.88, 5.77))
        bezier10Path.lineCapStyle = kCGLineCapRound;
        
        bezier10Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier10Path.lineWidth = stroke
        bezier10Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

