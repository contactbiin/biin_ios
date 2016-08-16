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
        
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 3.4, width: 3.8, height: 3.8))
        color!.setFill()
        ovalPath.fill()
        color!.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRect(x: 25.2, y: 3.4, width: 3.8, height: 3.8))
        color!.setFill()
        oval2Path.fill()
        color!.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 4.49, y: 23.5))
        bezierPath.addLineToPoint(CGPoint(x: 24.5, y: 23.5))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 4.5, y: 21.51))
        bezier2Path.addLineToPoint(CGPoint(x: 2.03, y: 7.26))
        bezier2Path.addCurveToPoint(CGPoint(x: 8.56, y: 13.67), controlPoint1: CGPoint(x: 2.03, y: 7.26), controlPoint2: CGPoint(x: 3.48, y: 13.67))
        bezier2Path.addCurveToPoint(CGPoint(x: 14.5, y: 4.84), controlPoint1: CGPoint(x: 13.63, y: 13.67), controlPoint2: CGPoint(x: 14.5, y: 4.84))
        bezier2Path.addCurveToPoint(CGPoint(x: 21.03, y: 13.67), controlPoint1: CGPoint(x: 14.5, y: 4.84), controlPoint2: CGPoint(x: 15.95, y: 13.67))
        bezier2Path.addCurveToPoint(CGPoint(x: 26.97, y: 7.26), controlPoint1: CGPoint(x: 26.1, y: 13.67), controlPoint2: CGPoint(x: 26.97, y: 7.26))
        bezier2Path.addLineToPoint(CGPoint(x: 24.51, y: 21.51))
        bezier2Path.addLineToPoint(CGPoint(x: 4.5, y: 21.51))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalInRect: CGRect(x: 12.3, y: 0, width: 4.4, height: 4.4))
        color!.setFill()
        oval3Path.fill()
        color!.setStroke()
        oval3Path.lineWidth = 1
        oval3Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

