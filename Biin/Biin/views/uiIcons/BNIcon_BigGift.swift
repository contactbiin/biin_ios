//  BNIcon_BigGift.swift
//  Biin
//  Created by Esteban Padilla on 8/9/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BigGift:BNIcon {
    
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
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 36.18, width: 90.8, height: 23))
        color!.setStroke()
        rectanglePath.lineWidth = 4
        rectanglePath.stroke()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 6.4, y: 59.18, width: 77.9, height: 53))
        color!.setStroke()
        rectangle2Path.lineWidth = 4
        rectangle2Path.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 36.91, y: 36.16))
        bezierPath.addLineToPoint(CGPoint(x: 36.91, y: 112.17))
        color!.setStroke()
        bezierPath.lineWidth = 4
        bezierPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 53.89, y: 112.17))
        bezier2Path.addLineToPoint(CGPoint(x: 53.89, y: 36.16))
        color!.setStroke()
        bezier2Path.lineWidth = 4
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 75.53, y: 24.31))
        bezier3Path.addCurveToPoint(CGPoint(x: 45.19, y: 36.16), controlPoint1: CGPoint(x: 70.22, y: 29.9), controlPoint2: CGPoint(x: 45.19, y: 36.16))
        bezier3Path.addCurveToPoint(CGPoint(x: 56.43, y: 4.19), controlPoint1: CGPoint(x: 45.19, y: 36.16), controlPoint2: CGPoint(x: 51.34, y: 9.78))
        bezier3Path.addCurveToPoint(CGPoint(x: 75.31, y: 4.19), controlPoint1: CGPoint(x: 61.74, y: -1.4), controlPoint2: CGPoint(x: 70.22, y: -1.4))
        bezier3Path.addCurveToPoint(CGPoint(x: 75.53, y: 24.31), controlPoint1: CGPoint(x: 80.83, y: 9.78), controlPoint2: CGPoint(x: 80.83, y: 18.72))
        bezier3Path.closePath()
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 4
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPoint(x: 15.06, y: 24.31))
        bezier4Path.addCurveToPoint(CGPoint(x: 45.4, y: 36.16), controlPoint1: CGPoint(x: 20.37, y: 29.9), controlPoint2: CGPoint(x: 45.4, y: 36.16))
        bezier4Path.addCurveToPoint(CGPoint(x: 34.16, y: 4.19), controlPoint1: CGPoint(x: 45.4, y: 36.16), controlPoint2: CGPoint(x: 39.25, y: 9.78))
        bezier4Path.addCurveToPoint(CGPoint(x: 15.27, y: 4.19), controlPoint1: CGPoint(x: 28.85, y: -1.4), controlPoint2: CGPoint(x: 20.37, y: -1.4))
        bezier4Path.addCurveToPoint(CGPoint(x: 15.06, y: 24.31), controlPoint1: CGPoint(x: 9.97, y: 9.78), controlPoint2: CGPoint(x: 9.97, y: 18.72))
        bezier4Path.closePath()
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 4
        bezier4Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
