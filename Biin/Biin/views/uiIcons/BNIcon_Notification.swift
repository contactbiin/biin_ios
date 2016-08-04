//  BNIcon_NotificationMedium.swift
//  biin
//  Created by Esteban Padilla on 1/21/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Notification:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group 2
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 19.83, y: 15.69))
        bezierPath.addLineToPoint(CGPoint(x: 19.83, y: 10.27))
        bezierPath.addCurveToPoint(CGPoint(x: 14.47, y: 2.48), controlPoint1: CGPoint(x: 19.83, y: 6.7), controlPoint2: CGPoint(x: 17.69, y: 3.68))
        bezierPath.addCurveToPoint(CGPoint(x: 11.5, y: 0), controlPoint1: CGPoint(x: 14.24, y: 1.08), controlPoint2: CGPoint(x: 13.01, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 8.53, y: 2.48), controlPoint1: CGPoint(x: 9.99, y: 0), controlPoint2: CGPoint(x: 8.76, y: 1.08))
        bezierPath.addCurveToPoint(CGPoint(x: 3.17, y: 10.27), controlPoint1: CGPoint(x: 5.31, y: 3.64), controlPoint2: CGPoint(x: 3.17, y: 6.7))
        bezierPath.addLineToPoint(CGPoint(x: 3.17, y: 15.69))
        bezierPath.addCurveToPoint(CGPoint(x: 0, y: 18.4), controlPoint1: CGPoint(x: 3.17, y: 17.32), controlPoint2: CGPoint(x: 1.59, y: 18.01))
        bezierPath.addLineToPoint(CGPoint(x: 23, y: 18.4))
        bezierPath.addCurveToPoint(CGPoint(x: 19.83, y: 15.69), controlPoint1: CGPoint(x: 21.41, y: 18.01), controlPoint2: CGPoint(x: 19.83, y: 17.32))
        bezierPath.closePath()
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 14.28, y: 18.4))
        bezier2Path.addCurveToPoint(CGPoint(x: 11.5, y: 21.5), controlPoint1: CGPoint(x: 14.28, y: 20.03), controlPoint2: CGPoint(x: 13.17, y: 21.5))
        bezier2Path.addCurveToPoint(CGPoint(x: 8.72, y: 18.4), controlPoint1: CGPoint(x: 9.83, y: 21.5), controlPoint2: CGPoint(x: 8.72, y: 20.03))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
