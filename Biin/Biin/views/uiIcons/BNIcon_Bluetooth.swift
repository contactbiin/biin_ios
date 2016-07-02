//  BNIcon_Bluetooth.swift
//  biin
//  Created by Esteban Padilla on 12/14/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Bluetooth:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    convenience init(color:UIColor, position:CGPoint, scale:CGFloat) {
        self.init(color:color, position:position)
        self.scale = scale
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        
        //// bluetooth.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        
        
        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(34.5, 38.5))
        bezierPath.addLineToPoint(CGPointMake(61.4, 65.4))
        bezierPath.addLineToPoint(CGPointMake(43.4, 83.4))
        bezierPath.addLineToPoint(CGPointMake(43.4, 55.4))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 4
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(34.5, 57.2))
        bezier2Path.addLineToPoint(CGPointMake(61.4, 30.4))
        bezier2Path.addLineToPoint(CGPointMake(43.4, 12.4))
        bezier2Path.addLineToPoint(CGPointMake(43.4, 41.1))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 4
        bezier2Path.stroke()
        
        
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 95.8, 95.8))
        color!.setStroke()
        ovalPath.lineWidth = 4
        ovalPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
