//
//  BNIcon_RedX.swift
//  biin
//
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class BNIcon_RedX:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, width, 1)
        
        
        
        //// line2 Drawing
        var line2Path = UIBezierPath()
        line2Path.moveToPoint(CGPointMake(0.1, 7.42))
        line2Path.addLineToPoint(CGPointMake(23.28, 0))
        line2Path.miterLimit = 4;
        
        line2Path.lineCapStyle = kCGLineCapRound;
        
        line2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        line2Path.lineWidth = 2
        line2Path.stroke()
        
        
        //// line1 Drawing
        var line1Path = UIBezierPath()
        line1Path.moveToPoint(CGPointMake(0, 0.4))
        line1Path.addLineToPoint(CGPointMake(23.38, 7.02))
        line1Path.miterLimit = 4;
        
        line1Path.lineCapStyle = kCGLineCapRound;
        
        line1Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        line1Path.lineWidth = 2
        line1Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
