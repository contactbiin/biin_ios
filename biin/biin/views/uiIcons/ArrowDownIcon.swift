//  ArrowDownIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/12/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class ArrowDownIcon:BNIcon {
    
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
        bezier1Path.moveToPoint(CGPointMake(7, 7))
        bezier1Path.addLineToPoint(CGPointMake(0, 0))
        bezier1Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier1Path.lineWidth = stroke
        bezier1Path.stroke()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(7, 7))
        bezierPath.addLineToPoint(CGPointMake(14, 0))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }

}