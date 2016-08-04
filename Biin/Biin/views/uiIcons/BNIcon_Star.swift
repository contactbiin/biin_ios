//  BNIcon_Star.swift
//  Biin
//  Created by Esteban Padilla on 7/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Star:BNIcon {
    

    
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
        bezierPath.moveToPoint(CGPoint(x: 18.5, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 24.34, y: 11.31))
        bezierPath.addLineToPoint(CGPoint(x: 37, y: 13.37))
        bezierPath.addLineToPoint(CGPoint(x: 27.26, y: 22.63))
        bezierPath.addLineToPoint(CGPoint(x: 29.99, y: 36))
        bezierPath.addLineToPoint(CGPoint(x: 18.5, y: 29.83))
        bezierPath.addLineToPoint(CGPoint(x: 6.82, y: 36))
        bezierPath.addLineToPoint(CGPoint(x: 9.74, y: 22.63))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 13.37))
        bezierPath.addLineToPoint(CGPoint(x: 12.66, y: 11.31))
        bezierPath.addLineToPoint(CGPoint(x: 18.5, y: 0))
        bezierPath.closePath()
        color!.setFill()
        bezierPath.fill()
        
        CGContextRestoreGState(context)
    }
}