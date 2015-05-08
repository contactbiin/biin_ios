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
        
        //// Color Declarations
//        let fillColor = UIColor(red: 0.278, green: 0.776, blue: 0.949, alpha: 1.000)
        let blueColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        //let blueColor = UIColor(red:63/255, green: 169/255, blue: 245/199, alpha: 1)
        
        //// shareButton.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)

        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(24, 35))
        bezierPath.addLineToPoint(CGPointMake(11, 35))
        bezierPath.addCurveToPoint(CGPointMake(0, 24), controlPoint1: CGPointMake(4.9, 35), controlPoint2: CGPointMake(0, 30.1))
        bezierPath.addLineToPoint(CGPointMake(0, 11))
        bezierPath.addCurveToPoint(CGPointMake(11, 0), controlPoint1: CGPointMake(0, 4.9), controlPoint2: CGPointMake(4.9, 0))
        bezierPath.addLineToPoint(CGPointMake(24, 0))
        bezierPath.addCurveToPoint(CGPointMake(35, 11), controlPoint1: CGPointMake(30.1, 0), controlPoint2: CGPointMake(35, 4.9))
        bezierPath.addLineToPoint(CGPointMake(35, 24))
        bezierPath.addCurveToPoint(CGPointMake(24, 35), controlPoint1: CGPointMake(35, 30.1), controlPoint2: CGPointMake(30.1, 35))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color!.setFill()
        bezierPath.fill()
        
        //// Group 2
        //// Oval Drawing
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(19.6, 20, 6, 6))
        blueColor.setFill()
        ovalPath.fill()
        blueColor.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(19.6, 8.6, 6, 6))
        blueColor.setFill()
        oval2Path.fill()
        blueColor.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        //// Oval 3 Drawing
        var oval3Path = UIBezierPath(ovalInRect: CGRectMake(8.2, 14.3, 6, 6))
        blueColor.setFill()
        oval3Path.fill()
        blueColor.setStroke()
        oval3Path.lineWidth = 2
        oval3Path.stroke()
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(13.9, 18.6))
        bezier2Path.addLineToPoint(CGPointMake(19.9, 21.6))
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        blueColor.setFill()
        bezier2Path.fill()
        blueColor.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(13.9, 16))
        bezier3Path.addLineToPoint(CGPointMake(19.9, 13))
        bezier3Path.lineJoinStyle = kCGLineJoinRound;
        
        blueColor.setFill()
        bezier3Path.fill()
        blueColor.setStroke()
        bezier3Path.lineWidth = 2
        bezier3Path.stroke()

        CGContextRestoreGState(context)
    }
}

