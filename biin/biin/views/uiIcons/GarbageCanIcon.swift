//  GarbageCanIcon.swift
//  Biin
//  Created by Esteban Padilla on 9/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class GarbageCanIcon:BNIcon {
    
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
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(1.52, 2.5, 13.71, 14.25))
        color!.setStroke()
        rectangle2Path.lineWidth = stroke
        rectangle2Path.stroke()
        
        //// Rectangle 1 Drawing
        let rectangle1Path = UIBezierPath(rect: CGRectMake(5.16, 0, 6.42, 1.52))
        color!.setStroke()
        rectangle1Path.lineWidth = stroke
        rectangle1Path.stroke()
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(5.2, 5.49))
        bezier4Path.addLineToPoint(CGPointMake(5.2, 13.57))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = stroke
        bezier4Path.stroke()
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(0, 2.31))
        bezier3Path.addLineToPoint(CGPointMake(16.75, 2.31))
        bezier3Path.lineCapStyle = kCGLineCapRound;
        
        bezier3Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier3Path.lineWidth = stroke
        bezier3Path.stroke()
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(8.38, 5.49))
        bezier2Path.addLineToPoint(CGPointMake(8.38, 13.57))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        //// Bezier 1 Drawing
        var bezier1Path = UIBezierPath()
        bezier1Path.moveToPoint(CGPointMake(11.55, 5.49))
        bezier1Path.addLineToPoint(CGPointMake(11.55, 13.57))
        bezier1Path.lineCapStyle = kCGLineCapRound;
        
        bezier1Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier1Path.lineWidth = stroke
        bezier1Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
