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
        
        //// line1 Drawing
        let line1Path = UIBezierPath()
        line1Path.moveToPoint(CGPoint(x: 0, y: 0))
        line1Path.addLineToPoint(CGPoint(x: 17.76, y: 0))
        line1Path.lineCapStyle = .Round;
        
        color!.setStroke()
        line1Path.lineWidth = 1.5
        line1Path.stroke()
        
        
        //// line2 Drawing
        let line2Path = UIBezierPath()
        line2Path.moveToPoint(CGPoint(x: 0, y: 6.38))
        line2Path.addLineToPoint(CGPoint(x: 17.76, y: 6.38))
        line2Path.lineCapStyle = .Round;
        
        color!.setStroke()
        line2Path.lineWidth = 1.5
        line2Path.stroke()
        
        
        //// line3 Drawing
        let line3Path = UIBezierPath()
        line3Path.moveToPoint(CGPoint(x: 0, y: 12.75))
        line3Path.addLineToPoint(CGPoint(x: 17.76, y: 12.75))
        line3Path.lineCapStyle = .Round;
        
        color!.setStroke()
        line3Path.lineWidth = 1.5
        line3Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
