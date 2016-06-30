//  BNIcon_CollectionsMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CollectionsMedium:BNIcon {
    
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
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 12, 12))
        color!.setStroke()
        rectangle2Path.lineWidth = 2
        rectangle2Path.stroke()
        
        
        //// Rectangle 4 Drawing
        let rectangle4Path = UIBezierPath(rect: CGRectMake(15, 0, 12, 12))
        color!.setStroke()
        rectangle4Path.lineWidth = 2
        rectangle4Path.stroke()
        
        
        //// Rectangle 6 Drawing
        let rectangle6Path = UIBezierPath(rect: CGRectMake(0, 15, 12, 12))
        color!.setStroke()
        rectangle6Path.lineWidth = 2
        rectangle6Path.stroke()
        
        
        //// Rectangle 8 Drawing
        let rectangle8Path = UIBezierPath(rect: CGRectMake(15, 15, 12, 12))
        color!.setStroke()
        rectangle8Path.lineWidth = 2
        rectangle8Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

