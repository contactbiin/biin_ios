//  BNIcon_ReadQRCode.swift
//  Biin
//  Created by Esteban Padilla on 8/3/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ReadQRCode:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// qrCode.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 3, y: 3, width: 11, height: 11))
        color!.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 5.5, y: 5.5, width: 6, height: 6))
        color!.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        
        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(rect: CGRect(x: 16, y: 3, width: 11, height: 11))
        color!.setStroke()
        rectangle3Path.lineWidth = 1
        rectangle3Path.stroke()
        
        
        //// Rectangle 4 Drawing
        let rectangle4Path = UIBezierPath(rect: CGRect(x: 20, y: 7, width: 3, height: 3))
        color!.setFill()
        rectangle4Path.fill()
        color!.setStroke()
        rectangle4Path.lineWidth = 1
        rectangle4Path.stroke()
        
        
        //// Rectangle 5 Drawing
        let rectangle5Path = UIBezierPath(rect: CGRect(x: 3, y: 16, width: 11, height: 11))
        color!.setStroke()
        rectangle5Path.lineWidth = 1
        rectangle5Path.stroke()
        
        
        //// Rectangle 6 Drawing
        let rectangle6Path = UIBezierPath(rect: CGRect(x: 5.5, y: 18.5, width: 6, height: 6))
        color!.setFill()
        rectangle6Path.fill()
        color!.setStroke()
        rectangle6Path.lineWidth = 1
        rectangle6Path.stroke()
        
        
        //// Rectangle 7 Drawing
        let rectangle7Path = UIBezierPath(rect: CGRect(x: 16, y: 16, width: 11, height: 11))
        color!.setStroke()
        rectangle7Path.lineWidth = 1
        rectangle7Path.stroke()
        
        
        //// Rectangle 8 Drawing
        let rectangle8Path = UIBezierPath(rect: CGRect(x: 20, y: 20, width: 3, height: 3))
        color!.setStroke()
        rectangle8Path.lineWidth = 1
        rectangle8Path.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 0, y: 10.59))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 10.59, y: 0))
        bezierPath.lineCapStyle = .Round;
        
        bezierPath.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPoint(x: 19.41, y: 0))
        bezier2Path.addLineToPoint(CGPoint(x: 30, y: 0))
        bezier2Path.addLineToPoint(CGPoint(x: 30, y: 10.59))
        bezier2Path.lineCapStyle = .Round;
        
        bezier2Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPoint(x: 30, y: 19.41))
        bezier3Path.addLineToPoint(CGPoint(x: 30, y: 30))
        bezier3Path.addLineToPoint(CGPoint(x: 19.41, y: 30))
        bezier3Path.lineCapStyle = .Round;
        
        bezier3Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 2
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPoint(x: 10.59, y: 30))
        bezier4Path.addLineToPoint(CGPoint(x: 0, y: 30))
        bezier4Path.addLineToPoint(CGPoint(x: 0, y: 19.41))
        bezier4Path.lineCapStyle = .Round;
        
        bezier4Path.lineJoinStyle = .Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()

        CGContextRestoreGState(context)
    }
}