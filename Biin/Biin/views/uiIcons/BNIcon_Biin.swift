//  BNIcon_Biin.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Biin:BNIcon {
    
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
        //let strokeColor = UIColor(red: 0.103, green: 0.092, blue: 0.095, alpha: 1.000)
        
        //// biinLogo.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(21.3, 34.8))
        bezierPath.addCurveToPoint(CGPointMake(39.4, 30.4), controlPoint1: CGPointMake(26.8, 32), controlPoint2: CGPointMake(32.9, 30.4))
        bezierPath.addCurveToPoint(CGPointMake(78.6, 69.6), controlPoint1: CGPointMake(61.1, 30.4), controlPoint2: CGPointMake(78.6, 47.9))
        bezierPath.addCurveToPoint(CGPointMake(39.4, 108.8), controlPoint1: CGPointMake(78.6, 91.3), controlPoint2: CGPointMake(61.1, 108.8))
        bezierPath.addCurveToPoint(CGPointMake(0, 69.6), controlPoint1: CGPointMake(17.7, 108.8), controlPoint2: CGPointMake(0, 91.3))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 8
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(101.8, 108.8))
        bezier2Path.addLineToPoint(CGPointMake(101.8, 46.9))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 8
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(125.7, 108.8))
        bezier3Path.addLineToPoint(CGPointMake(125.7, 46.9))
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 8
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(212, 108.8))
        bezier4Path.addLineToPoint(CGPointMake(212, 61.8))
        bezier4Path.addCurveToPoint(CGPointMake(180.6, 30.4), controlPoint1: CGPointMake(212, 44.5), controlPoint2: CGPointMake(197.9, 30.4))
        bezier4Path.addCurveToPoint(CGPointMake(149.2, 61.8), controlPoint1: CGPointMake(163.3, 30.4), controlPoint2: CGPointMake(149.2, 44.5))
        bezier4Path.addLineToPoint(CGPointMake(149.2, 108.8))
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 8
        bezier4Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPointMake(101.8, 30.8))
        bezier5Path.addLineToPoint(CGPointMake(101.8, 29.9))
        bezier5Path.lineCapStyle = .Round;
        
        bezier5Path.lineJoinStyle = .Round;
        
        UIColor.biinOrange().setStroke()
        //color!.setStroke()
        bezier5Path.lineWidth = 8
        bezier5Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(125.7, 30.8))
        bezier6Path.addLineToPoint(CGPointMake(125.7, 29.9))
        bezier6Path.lineCapStyle = .Round;
        
        bezier6Path.lineJoinStyle = .Round;
        
        UIColor.biinOrange().setStroke()
//        color!.setStroke()
        bezier6Path.lineWidth = 8
        bezier6Path.stroke()
        
        
        
        CGContextRestoreGState(context)

    }
}
