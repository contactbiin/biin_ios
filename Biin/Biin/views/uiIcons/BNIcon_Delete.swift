//  BNIcon_Delete.swift
//  Biin
//  Created by Esteban Padilla on 7/18/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Delete:BNIcon {
    
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
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 2.6, y: 2.6, width: 13.7, height: 16.3))
        color!.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 5.9, y: 0, width: 7.2, height: 2.6))
        color!.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 0, y: 2.6))
        bezierPath.addLineToPoint(CGPoint(x: 18.9, y: 2.6))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 5.9, y: 6.2))
        bezier2Path.addLineToPoint(CGPoint(x: 5.9, y: 15.3))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 9.5, y: 6.2))
        bezier3Path.addLineToPoint(CGPoint(x: 9.5, y: 15.3))
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPoint(x: 13.1, y: 6.2))
        bezier4Path.addLineToPoint(CGPoint(x: 13.1, y: 15.3))
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
