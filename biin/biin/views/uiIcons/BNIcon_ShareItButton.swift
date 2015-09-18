//  BNIcon_ShareItButton.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShareItButton:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// shareMInimal.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(5.14, 5.33))
        bezierPath.addLineToPoint(CGPointMake(3.21, 5.33))
        bezierPath.addCurveToPoint(CGPointMake(0, 7.43), controlPoint1: CGPointMake(1.45, 5.33), controlPoint2: CGPointMake(0, 6.27))
        bezierPath.addLineToPoint(CGPointMake(0, 13))
        bezierPath.addCurveToPoint(CGPointMake(3.21, 15.1), controlPoint1: CGPointMake(0, 14.16), controlPoint2: CGPointMake(1.45, 15.1))
        bezierPath.addLineToPoint(CGPointMake(11.79, 15.1))
        bezierPath.addCurveToPoint(CGPointMake(15, 13), controlPoint1: CGPointMake(13.55, 15.1), controlPoint2: CGPointMake(15, 14.16))
        bezierPath.addLineToPoint(CGPointMake(15, 7.43))
        bezierPath.addCurveToPoint(CGPointMake(11.79, 5.33), controlPoint1: CGPointMake(15, 6.27), controlPoint2: CGPointMake(13.55, 5.33))
        bezierPath.addLineToPoint(CGPointMake(9.86, 5.33))
        bezierPath.lineCapStyle = CGLineCap.Round
        
        bezierPath.lineJoinStyle = CGLineJoin.Round
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Group 2
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(7.47, 0))
        bezier2Path.addLineToPoint(CGPointMake(7.47, 8.8))
        bezier2Path.lineCapStyle = CGLineCap.Round
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(4, 3.76))
        bezier3Path.addLineToPoint(CGPointMake(7.47, 0))
        bezier3Path.addLineToPoint(CGPointMake(11, 3.76))
        bezier3Path.lineCapStyle = CGLineCap.Round
        
        bezier3Path.lineJoinStyle = CGLineJoin.Round
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()

        CGContextRestoreGState(context)
    }
}

