//  BNIcon_StarSmall.swift
//  Biin
//  Created by Esteban Padilla on 7/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_StarSmall:BNIcon {
    
    
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
        bezierPath.moveToPoint(CGPoint(x: 7.5, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 9.87, y: 4.4))
        bezierPath.addLineToPoint(CGPoint(x: 15, y: 5.2))
        bezierPath.addLineToPoint(CGPoint(x: 11.05, y: 8.8))
        bezierPath.addLineToPoint(CGPoint(x: 12.16, y: 14))
        bezierPath.addLineToPoint(CGPoint(x: 7.5, y: 11.6))
        bezierPath.addLineToPoint(CGPoint(x: 2.76, y: 14))
        bezierPath.addLineToPoint(CGPoint(x: 3.95, y: 8.8))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 5.2))
        bezierPath.addLineToPoint(CGPoint(x: 5.13, y: 4.4))
        bezierPath.addLineToPoint(CGPoint(x: 7.5, y: 0))
        bezierPath.closePath()
        self.color!.setFill()
        bezierPath.fill()
        
        CGContextRestoreGState(context)
    }
}