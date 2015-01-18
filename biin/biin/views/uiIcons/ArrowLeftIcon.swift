//  ArrowLeftIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class ArrowLeftIcon:BNIcon {
    
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
        
        
        
        //// Bezier1 Drawing
        var bezier1Path = UIBezierPath()
        bezier1Path.moveToPoint(CGPointMake(0, 8.1))
        bezier1Path.addLineToPoint(CGPointMake(7.6, 0))
        bezier1Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier1Path.lineWidth = stroke
        bezier1Path.stroke()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 8.1))
        bezierPath.addLineToPoint(CGPointMake(7.6, 16.2))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        
        
        CGContextRestoreGState(context)

    }
    
}