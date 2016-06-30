//  BNIcon_MusicMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_MusicMedium:BNIcon {
    
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
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0, 23.62))
        bezier2Path.addCurveToPoint(CGPointMake(3.73, 27.5), controlPoint1: CGPointMake(0, 25.88), controlPoint2: CGPointMake(1.59, 27.5))
        bezier2Path.addCurveToPoint(CGPointMake(7.93, 23.8), controlPoint1: CGPointMake(5.97, 27.5), controlPoint2: CGPointMake(7.93, 25.79))
        bezier2Path.addLineToPoint(CGPointMake(7.93, 19.64))
        bezier2Path.addLineToPoint(CGPointMake(3.73, 19.64))
        bezier2Path.addCurveToPoint(CGPointMake(0, 23.62), controlPoint1: CGPointMake(1.59, 19.64), controlPoint2: CGPointMake(0, 21.35))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(7, 5.45))
        bezier4Path.addLineToPoint(CGPointMake(7, 10.4))
        bezier4Path.addLineToPoint(CGPointMake(7, 11.09))
        bezier4Path.addLineToPoint(CGPointMake(7, 19.64))
        bezier4Path.addLineToPoint(CGPointMake(7.93, 19.64))
        bezier4Path.addLineToPoint(CGPointMake(7.93, 10.72))
        bezier4Path.addLineToPoint(CGPointMake(20.07, 6.01))
        bezier4Path.addLineToPoint(CGPointMake(20.07, 15.02))
        bezier4Path.addLineToPoint(CGPointMake(17.27, 15.02))
        bezier4Path.addCurveToPoint(CGPointMake(13.07, 19), controlPoint1: CGPointMake(14.98, 15.02), controlPoint2: CGPointMake(13.07, 16.82))
        bezier4Path.addCurveToPoint(CGPointMake(17.27, 22.88), controlPoint1: CGPointMake(13.07, 21.12), controlPoint2: CGPointMake(14.98, 22.88))
        bezier4Path.addCurveToPoint(CGPointMake(21, 19.18), controlPoint1: CGPointMake(19.41, 22.88), controlPoint2: CGPointMake(21, 21.31))
        bezier4Path.addLineToPoint(CGPointMake(21, 15.48))
        bezier4Path.addLineToPoint(CGPointMake(21, 15.02))
        bezier4Path.addLineToPoint(CGPointMake(21, 5.64))
        bezier4Path.addLineToPoint(CGPointMake(21, 5.32))
        bezier4Path.addLineToPoint(CGPointMake(21, 0))
        bezier4Path.addLineToPoint(CGPointMake(7, 5.45))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        CGContextRestoreGState(context)
    }
}

