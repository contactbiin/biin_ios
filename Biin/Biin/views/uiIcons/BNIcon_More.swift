//  BNIcon_More.swift
//  biin
//  Created by Esteban Padilla on 2/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_More:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        //let color = UIColor(red: 0.573, green: 0.580, blue: 0.592, alpha: 1.000)
        
        //// Group 2
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, (position.x - 0.0177121771218), position.y)
        
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0, 11.6))
        bezier2Path.addLineToPoint(CGPointMake(6.02, 5.8))
        bezier2Path.addLineToPoint(CGPointMake(6.02, 5.8))
        bezier2Path.addLineToPoint(CGPointMake(0, 0))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

