//  BNIcon_ShareGift.swift
//  Biin
//  Created by Esteban Padilla on 7/18/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShareGift:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// share.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 11.9, y: 7.12))
        bezierPath.addLineToPoint(CGPoint(x: 11.9, y: 22.12))
        color!.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 4.4, y: 7.12, width: 18.7, height: 4.4))
        color!.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 15.5, y: 22.03))
        bezier2Path.addLineToPoint(CGPoint(x: 15.5, y: 7.12))
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 20, y: 4.82))
        bezier3Path.addCurveToPoint(CGPoint(x: 13.7, y: 7.12), controlPoint1: CGPoint(x: 18.9, y: 5.92), controlPoint2: CGPoint(x: 13.7, y: 7.12))
        bezier3Path.addCurveToPoint(CGPoint(x: 16, y: 0.82), controlPoint1: CGPoint(x: 13.7, y: 7.12), controlPoint2: CGPoint(x: 15, y: 1.92))
        bezier3Path.addCurveToPoint(CGPoint(x: 19.9, y: 0.82), controlPoint1: CGPoint(x: 17.1, y: -0.27), controlPoint2: CGPoint(x: 18.8, y: -0.27))
        bezier3Path.addCurveToPoint(CGPoint(x: 20, y: 4.82), controlPoint1: CGPoint(x: 21.1, y: 1.92), controlPoint2: CGPoint(x: 21.1, y: 3.72))
        bezier3Path.closePath()
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPoint(x: 7.5, y: 4.82))
        bezier4Path.addCurveToPoint(CGPoint(x: 13.8, y: 7.12), controlPoint1: CGPoint(x: 8.6, y: 5.92), controlPoint2: CGPoint(x: 13.8, y: 7.12))
        bezier4Path.addCurveToPoint(CGPoint(x: 11.5, y: 0.82), controlPoint1: CGPoint(x: 13.8, y: 7.12), controlPoint2: CGPoint(x: 12.5, y: 1.92))
        bezier4Path.addCurveToPoint(CGPoint(x: 7.6, y: 0.82), controlPoint1: CGPoint(x: 10.4, y: -0.27), controlPoint2: CGPoint(x: 8.7, y: -0.27))
        bezier4Path.addCurveToPoint(CGPoint(x: 7.5, y: 4.82), controlPoint1: CGPoint(x: 6.5, y: 1.92), controlPoint2: CGPoint(x: 6.5, y: 3.72))
        bezier4Path.closePath()
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPoint(x: 5, y: 11.52))
        bezier5Path.addLineToPoint(CGPoint(x: 5, y: 15.12))
        bezier5Path.addCurveToPoint(CGPoint(x: 7.2, y: 15.12), controlPoint1: CGPoint(x: 5.8, y: 15.12), controlPoint2: CGPoint(x: 6.8, y: 15.12))
        bezier5Path.addCurveToPoint(CGPoint(x: 8.8, y: 16.42), controlPoint1: CGPoint(x: 8, y: 15.12), controlPoint2: CGPoint(x: 8.8, y: 15.62))
        bezier5Path.addLineToPoint(CGPoint(x: 8.8, y: 17.02))
        bezier5Path.addCurveToPoint(CGPoint(x: 7.2, y: 18.32), controlPoint1: CGPoint(x: 8.8, y: 17.82), controlPoint2: CGPoint(x: 8, y: 18.32))
        bezier5Path.addLineToPoint(CGPoint(x: 5.6, y: 18.32))
        bezier5Path.addCurveToPoint(CGPoint(x: 4.9, y: 19.52), controlPoint1: CGPoint(x: 5.6, y: 18.32), controlPoint2: CGPoint(x: 5.4, y: 18.92))
        bezier5Path.addLineToPoint(CGPoint(x: 4.9, y: 22.02))
        bezier5Path.addLineToPoint(CGPoint(x: 22.4, y: 22.02))
        bezier5Path.addLineToPoint(CGPoint(x: 22.4, y: 11.52))
        bezier5Path.addLineToPoint(CGPoint(x: 5, y: 11.52))
        bezier5Path.closePath()
        color!.setStroke()
        bezier5Path.lineWidth = 1
        bezier5Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPoint(x: 7.9, y: 21.92))
        bezier6Path.addLineToPoint(CGPoint(x: 13.2, y: 21.92))
        bezier6Path.addCurveToPoint(CGPoint(x: 14.5, y: 23.22), controlPoint1: CGPoint(x: 13.9, y: 21.92), controlPoint2: CGPoint(x: 14.5, y: 22.52))
        bezier6Path.addCurveToPoint(CGPoint(x: 13.2, y: 24.53), controlPoint1: CGPoint(x: 14.5, y: 23.92), controlPoint2: CGPoint(x: 13.9, y: 24.53))
        bezier6Path.addLineToPoint(CGPoint(x: 10.1, y: 24.53))
        bezier6Path.lineCapStyle = .Round;
        
        bezier6Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.moveToPoint(CGPoint(x: 7.9, y: 24.52))
        bezier7Path.addLineToPoint(CGPoint(x: 10, y: 24.52))
        bezier7Path.addCurveToPoint(CGPoint(x: 11.1, y: 25.82), controlPoint1: CGPoint(x: 10.7, y: 24.52), controlPoint2: CGPoint(x: 11.1, y: 25.12))
        bezier7Path.addCurveToPoint(CGPoint(x: 10, y: 27.12), controlPoint1: CGPoint(x: 11.1, y: 26.52), controlPoint2: CGPoint(x: 10.7, y: 27.12))
        bezier7Path.addLineToPoint(CGPoint(x: 8.9, y: 27.12))
        bezier7Path.lineCapStyle = .Round;
        
        bezier7Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier7Path.lineWidth = 1
        bezier7Path.stroke()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPoint(x: 10.1, y: 27.02))
        bezier8Path.addLineToPoint(CGPoint(x: 4.1, y: 27.02))
        bezier8Path.addCurveToPoint(CGPoint(x: 0, y: 22.92), controlPoint1: CGPoint(x: 1.9, y: 27.02), controlPoint2: CGPoint(x: 0, y: 25.12))
        bezier8Path.addLineToPoint(CGPoint(x: 0, y: 20.42))
        bezier8Path.addCurveToPoint(CGPoint(x: 4.7, y: 15.12), controlPoint1: CGPoint(x: 0, y: 15.92), controlPoint2: CGPoint(x: 3.1, y: 15.12))
        bezier8Path.addCurveToPoint(CGPoint(x: 7.2, y: 15.12), controlPoint1: CGPoint(x: 5.5, y: 15.12), controlPoint2: CGPoint(x: 6.7, y: 15.12))
        bezier8Path.addCurveToPoint(CGPoint(x: 8.8, y: 16.42), controlPoint1: CGPoint(x: 8, y: 15.12), controlPoint2: CGPoint(x: 8.8, y: 15.62))
        bezier8Path.addLineToPoint(CGPoint(x: 8.8, y: 17.02))
        bezier8Path.addCurveToPoint(CGPoint(x: 7.2, y: 18.32), controlPoint1: CGPoint(x: 8.8, y: 17.82), controlPoint2: CGPoint(x: 8, y: 18.32))
        bezier8Path.addLineToPoint(CGPoint(x: 5.6, y: 18.32))
        bezier8Path.addCurveToPoint(CGPoint(x: 3.1, y: 20.82), controlPoint1: CGPoint(x: 5.6, y: 18.32), controlPoint2: CGPoint(x: 4.7, y: 20.82))
        bezier8Path.lineCapStyle = .Round;
        
        bezier8Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        CGContextRestoreGState(context)
    }
}