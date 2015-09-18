//  BNIcon_SearchMedium.swift
//  biin
//  Created by Esteban Padilla on 1/21/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SearchMedium:BNIcon {
    
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
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 19, 18))
        color!.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(15.98, 15.92))
        bezier2Path.addLineToPoint(CGPointMake(24, 23.7))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
