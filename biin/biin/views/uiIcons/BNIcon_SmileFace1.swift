//  BNIcon_SmileFace1.swift
//  biin
//  Created by Esteban Padilla on 2/11/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SmileFace1:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
    
        
        //// head Drawing
        var headPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 28, 28))
        color!.setStroke()
        headPath.lineWidth = 2
        headPath.stroke()
        
        
        //// mouth Drawing
        var mouthPath = UIBezierPath()
        mouthPath.moveToPoint(CGPointMake(23.17, 14.97))
        mouthPath.addCurveToPoint(CGPointMake(14, 24.33), controlPoint1: CGPointMake(23.17, 19.99), controlPoint2: CGPointMake(19.02, 24.33))
        mouthPath.addCurveToPoint(CGPointMake(4.83, 14.97), controlPoint1: CGPointMake(8.98, 24.33), controlPoint2: CGPointMake(4.83, 19.99))
        mouthPath.lineCapStyle = kCGLineCapRound;
        
        mouthPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        mouthPath.lineWidth = 2
        mouthPath.stroke()
        
        //// eye2 Drawing
        var eye2Path = UIBezierPath()
        eye2Path.moveToPoint(CGPointMake(21.72, 11.59))
        eye2Path.addCurveToPoint(CGPointMake(16.9, 11.59), controlPoint1: CGPointMake(21.72, 10.23), controlPoint2: CGPointMake(16.9, 10.23))
        eye2Path.lineCapStyle = kCGLineCapRound;
        
        eye2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        eye2Path.lineWidth = 2
        eye2Path.stroke()
        
        
        //// eye1 Drawing
        var eye1Path = UIBezierPath(ovalInRect: CGRectMake(7, 9, 4, 4))
        color!.setStroke()
        eye1Path.lineWidth = 2
        eye1Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
