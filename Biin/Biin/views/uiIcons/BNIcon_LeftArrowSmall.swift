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
        
        //// Group 2
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 13.02, y: 23.6))
        bezier2Path.addLineToPoint(CGPoint(x: 0, y: 11.8))
        bezier2Path.addLineToPoint(CGPoint(x: 0, y: 11.8))
        bezier2Path.addLineToPoint(CGPoint(x: 13.02, y: 0))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        self.color!.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
    }
}