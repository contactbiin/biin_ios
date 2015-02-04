//  BNIcon_LeftArrowSmall.swift
//  biin
//  Created by Esteban Padilla on 2/2/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LeftArrowSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        

        //// Bezier 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(5, 10))
        bezier2Path.addLineToPoint(CGPointMake(0, 5))
        bezier2Path.addLineToPoint(CGPointMake(0, 5))
        bezier2Path.addLineToPoint(CGPointMake(5, 0))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
    }
}