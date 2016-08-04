//  BNIcon_GiftStores.swift
//  Biin
//  Created by Esteban Padilla on 7/18/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_GiftStores:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// giftStores.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 22.7, y: 18.6))
        bezierPath.addLineToPoint(CGPoint(x: 22.7, y: 28.4))
        bezierPath.addLineToPoint(CGPoint(x: 2.6, y: 28.4))
        bezierPath.addLineToPoint(CGPoint(x: 2.6, y: 15.3))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 4.4, y: 18.8, width: 8.7, height: 6.1))
        color!.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 15.7, y: 18.8, width: 5.2, height: 9.6))
        color!.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 6.1, y: 14.4))
        bezier2Path.addLineToPoint(CGPoint(x: 6.1, y: 10.9))
        bezier2Path.addLineToPoint(CGPoint(x: 7.4, y: 6.5))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 12.2, y: 14.8))
        bezier3Path.addLineToPoint(CGPoint(x: 12.2, y: 10.8))
        bezier3Path.addLineToPoint(CGPoint(x: 12.2, y: 6.5))
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPoint(x: 16.4, y: 10.9))
        bezier5Path.addLineToPoint(CGPoint(x: 0, y: 10.9))
        bezier5Path.addLineToPoint(CGPoint(x: 0, y: 11.8))
        bezier5Path.addCurveToPoint(CGPoint(x: 3.1, y: 15.3), controlPoint1: CGPoint(x: 0, y: 13.6), controlPoint2: CGPoint(x: 1.2, y: 15.3))
        bezier5Path.addCurveToPoint(CGPoint(x: 6.2, y: 14.4), controlPoint1: CGPoint(x: 4, y: 15.3), controlPoint2: CGPoint(x: 5.6, y: 15))
        bezier5Path.addCurveToPoint(CGPoint(x: 9.3, y: 16.1), controlPoint1: CGPoint(x: 7, y: 15.6), controlPoint2: CGPoint(x: 7.7, y: 16.1))
        bezier5Path.addCurveToPoint(CGPoint(x: 12.4, y: 14.8), controlPoint1: CGPoint(x: 10.6, y: 16.1), controlPoint2: CGPoint(x: 11.6, y: 15.7))
        bezier5Path.addCurveToPoint(CGPoint(x: 15.9, y: 16.1), controlPoint1: CGPoint(x: 13.2, y: 15.7), controlPoint2: CGPoint(x: 14.6, y: 16.1))
        bezier5Path.addCurveToPoint(CGPoint(x: 19, y: 14.9), controlPoint1: CGPoint(x: 17.2, y: 16.1), controlPoint2: CGPoint(x: 18.2, y: 15.7))
        bezier5Path.addCurveToPoint(CGPoint(x: 16.4, y: 10.9), controlPoint1: CGPoint(x: 17.9, y: 13.8), controlPoint2: CGPoint(x: 17, y: 12.4))
        bezier5Path.closePath()
        bezier5Path.lineCapStyle = .Round;
        
        bezier5Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier5Path.lineWidth = 1
        bezier5Path.stroke()
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 18.5, y: 2.9, width: 8.4, height: 8.4))
        color!.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPoint(x: 15.6, y: 7.1))
        bezier6Path.addCurveToPoint(CGPoint(x: 15.6, y: 6.5), controlPoint1: CGPoint(x: 15.6, y: 6.9), controlPoint2: CGPoint(x: 15.6, y: 6.7))
        bezier6Path.addLineToPoint(CGPoint(x: 2.6, y: 6.5))
        bezier6Path.addLineToPoint(CGPoint(x: 0, y: 10.9))
        bezier6Path.addLineToPoint(CGPoint(x: 16.4, y: 10.9))
        bezier6Path.addCurveToPoint(CGPoint(x: 15.6, y: 7.1), controlPoint1: CGPoint(x: 15.9, y: 9.7), controlPoint2: CGPoint(x: 15.6, y: 8.4))
        bezier6Path.closePath()
        bezier6Path.lineCapStyle = .Round;
        
        bezier6Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.moveToPoint(CGPoint(x: 29.8, y: 7.1))
        bezier7Path.addCurveToPoint(CGPoint(x: 22.7, y: 18.8), controlPoint1: CGPoint(x: 29.8, y: 13.6), controlPoint2: CGPoint(x: 22.7, y: 18.8))
        bezier7Path.addCurveToPoint(CGPoint(x: 15.6, y: 7.1), controlPoint1: CGPoint(x: 22.7, y: 18.8), controlPoint2: CGPoint(x: 15.6, y: 13.6))
        bezier7Path.addCurveToPoint(CGPoint(x: 22.7, y: 0), controlPoint1: CGPoint(x: 15.6, y: 3.2), controlPoint2: CGPoint(x: 19, y: 0))
        bezier7Path.addCurveToPoint(CGPoint(x: 29.8, y: 7.1), controlPoint1: CGPoint(x: 26.5, y: -0.1), controlPoint2: CGPoint(x: 29.8, y: 3.1))
        bezier7Path.closePath()
        bezier7Path.lineCapStyle = .Round;
        
        bezier7Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier7Path.lineWidth = 1
        bezier7Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
