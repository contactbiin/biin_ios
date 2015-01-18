//  BookmarkIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/19/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BookmarkIcon:BNIcon {
    
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
        
        //// Bezier 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(13.5, 15.5))
        bezierPath.addLineToPoint(CGPointMake(6.75, 10.78))
        bezierPath.addLineToPoint(CGPointMake(0, 15.5))
        bezierPath.addLineToPoint(CGPointMake(0.13, 0))
        bezierPath.addLineToPoint(CGPointMake(13.37, 0))
        bezierPath.addLineToPoint(CGPointMake(13.5, 15.5))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;


        
        if isFilled {
            color!.setFill()
            bezierPath.fill()
        }
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
        
    }
}
