//  BNIcon_FashionSmall.swift
//  biin
//  Created by Esteban Padilla on 3/10/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import QuartzCore
import UIKit

class BNIcon_FashionSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color0 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(11.01, 6.59))
        bezier2Path.addLineToPoint(CGPointMake(0.34, 12.35))
        bezier2Path.addCurveToPoint(CGPointMake(0.75, 14), controlPoint1: CGPointMake(-0.27, 12.81), controlPoint2: CGPointMake(-0.02, 14))
        bezier2Path.addLineToPoint(CGPointMake(21.24, 14))
        bezier2Path.addCurveToPoint(CGPointMake(21.64, 12.35), controlPoint1: CGPointMake(22.01, 14), controlPoint2: CGPointMake(22.26, 12.81))
        bezier2Path.addLineToPoint(CGPointMake(11.01, 6.59))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(8.57, 2.47))
        bezier4Path.addCurveToPoint(CGPointMake(11.01, 0), controlPoint1: CGPointMake(8.57, 1.11), controlPoint2: CGPointMake(9.67, 0))
        bezier4Path.addCurveToPoint(CGPointMake(13.46, 2.47), controlPoint1: CGPointMake(12.36, 0), controlPoint2: CGPointMake(13.46, 1.11))
        bezier4Path.addCurveToPoint(CGPointMake(11.42, 4.94), controlPoint1: CGPointMake(13.46, 4.12), controlPoint2: CGPointMake(12.52, 4.41))
        bezier4Path.addCurveToPoint(CGPointMake(11.01, 6.59), controlPoint1: CGPointMake(11.01, 5.15), controlPoint2: CGPointMake(11.01, 6.14))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}


