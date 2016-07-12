//  BNIcon_CloseSmall.swift
//  biin
//  Created by Esteban Padilla on 2/11/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CloseSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: -0, y: 12))
        bezier2Path.addLineToPoint(CGPoint(x: 12, y: 0))
        self.color!.setStroke()
        bezier2Path.lineWidth = 5
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 12, y: 12))
        bezierPath.addLineToPoint(CGPoint(x: -0, y: 0))
        self.color!.setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}
