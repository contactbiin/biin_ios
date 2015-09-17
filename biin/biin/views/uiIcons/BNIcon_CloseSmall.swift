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

        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)

        //// back Drawing
        let backPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 28, 28))
        UIColor.appMainColor().setFill()
        backPath.fill()
        
        //// line2 Drawing
        let line2Path = UIBezierPath()
        line2Path.moveToPoint(CGPointMake(8.01, 19.79))
        line2Path.addLineToPoint(CGPointMake(19.31, 8.5))
        line2Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        line2Path.lineWidth = 0.5
        line2Path.stroke()
        
        //// line1 Drawing
        let line1Path = UIBezierPath()
        line1Path.moveToPoint(CGPointMake(19.31, 19.79))
        line1Path.addLineToPoint(CGPointMake(8.01, 8.5))
        line1Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        line1Path.lineWidth = 0.5
        line1Path.stroke()
       
        CGContextRestoreGState(context)
    }
}
