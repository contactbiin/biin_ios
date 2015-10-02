//  BNIcon_MenuMedium.swift
//  biin
//  Created by Esteban Padilla on 4/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_MenuMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let strokeColor = UIColor(red: 0.255, green: 0.251, blue: 0.259, alpha: 1.000)
        
        //// menu.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 6.3))
        bezierPath.addLineToPoint(CGPointMake(16.5, 6.3))
        bezierPath.lineCapStyle = CGLineCap.Round;
        
        strokeColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0, 0))
        bezier2Path.addLineToPoint(CGPointMake(16.5, 0))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        strokeColor.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(0, 12.6))
        bezier3Path.addLineToPoint(CGPointMake(16.5, 12.6))
        bezier3Path.lineCapStyle = CGLineCap.Round;
        
        strokeColor.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
