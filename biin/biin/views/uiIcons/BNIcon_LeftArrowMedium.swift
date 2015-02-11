//  BNIcon_LeftArrowMedium.swift
//  biin
//  Created by Esteban Padilla on 2/10/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_LeftArrowMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(10, 20))
        bezier2Path.addLineToPoint(CGPointMake(0, 10))
        bezier2Path.addLineToPoint(CGPointMake(0, 10))
        bezier2Path.addLineToPoint(CGPointMake(10, 0))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
