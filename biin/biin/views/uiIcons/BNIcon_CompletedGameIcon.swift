//  CompletedCircleIcon.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CompletedGameIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let colorWhite = UIColor.whiteColor()
        //let color0 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(39.56, 66.6))
        bezier2Path.addLineToPoint(CGPointMake(26.93, 66.6))
        bezier2Path.addCurveToPoint(CGPointMake(0, 39.67), controlPoint1: CGPointMake(12.07, 66.6), controlPoint2: CGPointMake(0, 54.53))
        bezier2Path.addLineToPoint(CGPointMake(0, 26.93))
        bezier2Path.addCurveToPoint(CGPointMake(26.93, 0), controlPoint1: CGPointMake(0, 12.07), controlPoint2: CGPointMake(12.07, 0))
        bezier2Path.addLineToPoint(CGPointMake(39.67, 0))
        bezier2Path.addCurveToPoint(CGPointMake(66.6, 26.93), controlPoint1: CGPointMake(54.53, 0), controlPoint2: CGPointMake(66.6, 12.07))
        bezier2Path.addLineToPoint(CGPointMake(66.6, 39.67))
        bezier2Path.addCurveToPoint(CGPointMake(39.56, 66.6), controlPoint1: CGPointMake(66.49, 54.53), controlPoint2: CGPointMake(54.49, 66.6))
        bezier2Path.closePath()
        color!.setFill()
        bezier2Path.fill()
        colorWhite.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(45.1, 18.67))
        bezier4Path.addLineToPoint(CGPointMake(27.83, 35.94))
        bezier4Path.addLineToPoint(CGPointMake(23, 31.11))
        bezier4Path.addLineToPoint(CGPointMake(18.14, 35.94))
        bezier4Path.addLineToPoint(CGPointMake(27.83, 45.59))
        bezier4Path.addLineToPoint(CGPointMake(49.93, 23.49))
        bezier4Path.addLineToPoint(CGPointMake(45.1, 18.67))
        bezier4Path.closePath()
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        colorWhite.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
