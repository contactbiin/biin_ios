//  BNIcon_ShareItButton.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShareItButton:BNIcon {
    
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
        bezierPath.moveToPoint(CGPoint(x: 8.32, y: 15))
        bezierPath.addLineToPoint(CGPoint(x: 17.38, y: 19.09))
        color!.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 17.25, y: 6.27))
        bezier2Path.addLineToPoint(CGPoint(x: 8.32, y: 10.77))
        color!.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 8.4, width: 9, height: 9))
        color!.setFill()
        ovalPath.fill()
        color!.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRect(x: 16.7, y: 0, width: 9, height: 9))
        color!.setFill()
        oval2Path.fill()
        color!.setStroke()
        oval2Path.lineWidth = 3
        oval2Path.stroke()
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalInRect: CGRect(x: 16.7, y: 16.7, width: 9, height: 9))
        color!.setFill()
        oval3Path.fill()
        color!.setStroke()
        oval3Path.lineWidth = 3
        oval3Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

