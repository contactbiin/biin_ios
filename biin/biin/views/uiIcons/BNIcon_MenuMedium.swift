//  BNIcon_MenuMedium.swift
//  biin
//  Created by Esteban Padilla on 4/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_MenuMedium:BNIcon {
    
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
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 0))
        bezierPath.addCurveToPoint(CGPointMake(14.28, 0), controlPoint1: CGPointMake(20.3, 0), controlPoint2: CGPointMake(14.28, 0))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0, 5))
        bezier2Path.addCurveToPoint(CGPointMake(14.28, 5), controlPoint1: CGPointMake(20.3, 5), controlPoint2: CGPointMake(14.28, 5))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(0, 10))
        bezier3Path.addCurveToPoint(CGPointMake(14.28, 10), controlPoint1: CGPointMake(20.3, 10), controlPoint2: CGPointMake(14.28, 10))
        bezier3Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier3Path.lineWidth = 2
        bezier3Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
