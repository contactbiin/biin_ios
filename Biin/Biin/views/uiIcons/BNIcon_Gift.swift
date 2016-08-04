//  BNIcon_Gift.swift
//  Biin
//  Created by Esteban Padilla on 7/13/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Gift:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// gift.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 8.17, width: 20.8, height: 5))
        color!.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 1.4, y: 13.17, width: 17.9, height: 12))
        color!.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 8.46, y: 8.12))
        bezierPath.addLineToPoint(CGPoint(x: 8.46, y: 25.17))
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 12.34, y: 25.17))
        bezier2Path.addLineToPoint(CGPoint(x: 12.34, y: 8.12))
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 17.3, y: 5.46))
        bezier3Path.addCurveToPoint(CGPoint(x: 10.35, y: 8.12), controlPoint1: CGPoint(x: 16.09, y: 6.71), controlPoint2: CGPoint(x: 10.35, y: 8.12))
        bezier3Path.addCurveToPoint(CGPoint(x: 12.93, y: 0.94), controlPoint1: CGPoint(x: 10.35, y: 8.12), controlPoint2: CGPoint(x: 11.76, y: 2.2))
        bezier3Path.addCurveToPoint(CGPoint(x: 17.25, y: 0.94), controlPoint1: CGPoint(x: 14.14, y: -0.31), controlPoint2: CGPoint(x: 16.09, y: -0.31))
        bezier3Path.addCurveToPoint(CGPoint(x: 17.3, y: 5.46), controlPoint1: CGPoint(x: 18.52, y: 2.2), controlPoint2: CGPoint(x: 18.52, y: 4.2))
        bezier3Path.closePath()
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPoint(x: 3.45, y: 5.46))
        bezier4Path.addCurveToPoint(CGPoint(x: 10.4, y: 8.12), controlPoint1: CGPoint(x: 4.67, y: 6.71), controlPoint2: CGPoint(x: 10.4, y: 8.12))
        bezier4Path.addCurveToPoint(CGPoint(x: 7.82, y: 0.94), controlPoint1: CGPoint(x: 10.4, y: 8.12), controlPoint2: CGPoint(x: 8.99, y: 2.2))
        bezier4Path.addCurveToPoint(CGPoint(x: 3.5, y: 0.94), controlPoint1: CGPoint(x: 6.61, y: -0.31), controlPoint2: CGPoint(x: 4.67, y: -0.31))
        bezier4Path.addCurveToPoint(CGPoint(x: 3.45, y: 5.46), controlPoint1: CGPoint(x: 2.28, y: 2.2), controlPoint2: CGPoint(x: 2.28, y: 4.2))
        bezier4Path.closePath()
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        CGContextRestoreGState(context)
        
    }
}
