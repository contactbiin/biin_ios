//  CollectionsIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class CollectionsIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Oval 1 Drawing
        var oval1Path = UIBezierPath(ovalInRect: CGRectMake(13.1, 7.1, 3.8, 4))
        color!.setStroke()
        oval1Path.lineWidth = stroke
        oval1Path.stroke()
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(13.1, 13, 3.8, 4))
        color!.setStroke()
        oval2Path.lineWidth = stroke
        oval2Path.stroke()
        
        
        //// Oval 3 Drawing
        var oval3Path = UIBezierPath(ovalInRect: CGRectMake(13.1, 18.7, 3.8, 4))
        color!.setStroke()
        oval3Path.lineWidth = stroke
        oval3Path.stroke()
        
        
        //// Oval Outside Drawing
        var ovalOutsidePath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 30, 30))
        color!.setStroke()
        ovalOutsidePath.lineWidth = stroke
        ovalOutsidePath.stroke()
        
        
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(19.6, 7.1, 3.8, 4))
        color!.setStroke()
        oval4Path.lineWidth = stroke
        oval4Path.stroke()
        
        
        //// Oval 5 Drawing
        var oval5Path = UIBezierPath(ovalInRect: CGRectMake(19.6, 13, 3.8, 4))
        color!.setStroke()
        oval5Path.lineWidth = stroke
        oval5Path.stroke()
        
        
        //// Oval 6 Drawing
        var oval6Path = UIBezierPath(ovalInRect: CGRectMake(19.6, 18.7, 3.8, 4))
        color!.setStroke()
        oval6Path.lineWidth = stroke
        oval6Path.stroke()
        
        
        //// Oval 7 Drawing
        var oval7Path = UIBezierPath(ovalInRect: CGRectMake(7, 7.1, 3.8, 4))
        color!.setStroke()
        oval7Path.lineWidth = stroke
        oval7Path.stroke()
        
        
        //// Oval 8 Drawing
        var oval8Path = UIBezierPath(ovalInRect: CGRectMake(7, 13, 3.8, 4))
        color!.setStroke()
        oval8Path.lineWidth = stroke
        oval8Path.stroke()
        
        
        //// Oval 9 Drawing
        var oval9Path = UIBezierPath(ovalInRect: CGRectMake(7, 18.7, 3.8, 4))
        color!.setStroke()
        oval9Path.lineWidth = stroke
        oval9Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
