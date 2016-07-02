//
//  BNIcon_MaleSmall.swift
//  biin
//
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class BNIcon_MaleSmall:BNIcon {
    
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
        let headPath = UIBezierPath(ovalInRect: CGRectMake(2, 0, 5.8, 5.8))
        color!.setStroke()
        headPath.lineWidth = 1.5
        headPath.stroke()
        
        
        //// body Drawing
        let bodyPath = UIBezierPath()
        bodyPath.moveToPoint(CGPointMake(9.8, 6.77))
        bodyPath.addLineToPoint(CGPointMake(0, 6.77))
        bodyPath.addCurveToPoint(CGPointMake(3.15, 12.82), controlPoint1: CGPointMake(0, 10.16), controlPoint2: CGPointMake(1.46, 12))
        bodyPath.addLineToPoint(CGPointMake(3.15, 17.9))
        bodyPath.addLineToPoint(CGPointMake(6.65, 17.9))
        bodyPath.addLineToPoint(CGPointMake(6.65, 12.82))
        bodyPath.addCurveToPoint(CGPointMake(9.8, 6.77), controlPoint1: CGPointMake(8.46, 12), controlPoint2: CGPointMake(9.8, 10.16))
        bodyPath.closePath()
        color!.setStroke()
        bodyPath.lineWidth = 1.5
        bodyPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
