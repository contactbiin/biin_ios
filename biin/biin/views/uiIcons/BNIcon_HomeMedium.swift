//  BNIcon_HomeMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_HomeMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(3.86, 14.44))
        bezier2Path.addLineToPoint(CGPointMake(3.86, 26))
        bezier2Path.addLineToPoint(CGPointMake(10.62, 26))
        bezier2Path.addLineToPoint(CGPointMake(10.62, 17.33))
        bezier2Path.addLineToPoint(CGPointMake(17.38, 17.33))
        bezier2Path.addLineToPoint(CGPointMake(17.38, 26))
        bezier2Path.addLineToPoint(CGPointMake(24.14, 26))
        bezier2Path.addLineToPoint(CGPointMake(24.14, 14.44))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(0, 13.96))
        bezier4Path.addLineToPoint(CGPointMake(14, 0))
        bezier4Path.addLineToPoint(CGPointMake(28, 13.96))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(18.34, 0.96))
        bezier6Path.addLineToPoint(CGPointMake(23.17, 0.96))
        bezier6Path.addLineToPoint(CGPointMake(23.17, 5.78))
        bezier6Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier6Path.lineWidth = 2
        bezier6Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
