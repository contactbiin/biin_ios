//  BNIcon_FemaleSmall.swift
//  biin
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_FemaleSmall:BNIcon {
    
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
        
        
        
        //// head Drawing
        let headPath = UIBezierPath(ovalInRect: CGRectMake(2, -0, 5.6, 5.6))
        color!.setStroke()
        headPath.lineWidth = 1.5
        headPath.stroke()
        
        
        //// body Drawing
        let bodyPath = UIBezierPath()
        bodyPath.moveToPoint(CGPointMake(4.35, 7.03))
        bodyPath.addCurveToPoint(CGPointMake(0, 14.21), controlPoint1: CGPointMake(1.94, 7.03), controlPoint2: CGPointMake(0, 10))
        bodyPath.addLineToPoint(CGPointMake(2.83, 14.21))
        bodyPath.addLineToPoint(CGPointMake(2.83, 17.9))
        bodyPath.addLineToPoint(CGPointMake(5.97, 17.9))
        bodyPath.addLineToPoint(CGPointMake(5.97, 14.21))
        bodyPath.addLineToPoint(CGPointMake(8.8, 14.21))
        bodyPath.addCurveToPoint(CGPointMake(4.35, 7.03), controlPoint1: CGPointMake(8.8, 10), controlPoint2: CGPointMake(6.76, 7.03))
        bodyPath.closePath()
        color!.setStroke()
        bodyPath.lineWidth = 1.5
        bodyPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
