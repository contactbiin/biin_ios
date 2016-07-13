//  BNIcon_Menu.swift
//  biin
//  Created by Esteban Padilla on 4/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Menu:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// menu.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 7.24, y: 2.13))
        bezierPath.addLineToPoint(CGPoint(x: 21, y: 2.13))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 7.24, y: 8.5))
        bezier2Path.addLineToPoint(CGPoint(x: 21, y: 8.5))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 7.24, y: 14.88))
        bezier3Path.addLineToPoint(CGPoint(x: 21, y: 14.88))
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 4, height: 4))
        color!.setFill()
        ovalPath.fill()
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 6, width: 4, height: 5))
        color!.setFill()
        oval2Path.fill()
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 13, width: 4, height: 4))
        color!.setFill()
        oval3Path.fill()
        
        CGContextRestoreGState(context)
    }
}
