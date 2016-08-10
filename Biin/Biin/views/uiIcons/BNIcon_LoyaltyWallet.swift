//  BNIcon_LoyaltyWallet.swift
//  Biin
//  Created by Esteban Padilla on 8/10/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LoyaltyWallet:BNIcon {
    
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
        bezierPath.moveToPoint(CGPoint(x: 0.24, y: 1.04))
        bezierPath.addLineToPoint(CGPoint(x: 12.45, y: 4.29))
        bezierPath.addCurveToPoint(CGPoint(x: 14.45, y: 6.88), controlPoint1: CGPoint(x: 13.55, y: 4.6), controlPoint2: CGPoint(x: 14.45, y: 5.74))
        bezierPath.addLineToPoint(CGPoint(x: 14.45, y: 18.42))
        bezierPath.addCurveToPoint(CGPoint(x: 12.45, y: 20.01), controlPoint1: CGPoint(x: 14.45, y: 19.56), controlPoint2: CGPoint(x: 13.55, y: 20.29))
        bezierPath.addLineToPoint(CGPoint(x: 2, y: 17.49))
        bezierPath.addCurveToPoint(CGPoint(x: 0, y: 14.93), controlPoint1: CGPoint(x: 0.9, y: 17.21), controlPoint2: CGPoint(x: 0, y: 16.07))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 2.07))
        bezierPath.addCurveToPoint(CGPoint(x: 2.07, y: 0), controlPoint1: CGPoint(x: 0, y: 0.93), controlPoint2: CGPoint(x: 0.93, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 17.93, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 20, y: 2.07), controlPoint1: CGPoint(x: 19.07, y: 0), controlPoint2: CGPoint(x: 20, y: 0.93))
        bezierPath.addLineToPoint(CGPoint(x: 20, y: 13.13))
        bezierPath.addCurveToPoint(CGPoint(x: 17.93, y: 15.21), controlPoint1: CGPoint(x: 20, y: 14.27), controlPoint2: CGPoint(x: 19.07, y: 15.21))
        bezierPath.addLineToPoint(CGPoint(x: 14.48, y: 15.21))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 6.76, y: 2.77))
        bezier2Path.addLineToPoint(CGPoint(x: 16.48, y: 2.77))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 9.9, y: 10, width: 3, height: 3))
        color!.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 14.45, y: 7.6))
        bezier3Path.addLineToPoint(CGPoint(x: 16.48, y: 7.6))
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        CGContextRestoreGState(context)
    }
}

