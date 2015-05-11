//
//  BNIcon_Pricing.swift
//  biin
//
//  Created by Esteban Padilla on 5/10/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class BNIcon_Pricing:BNIcon {
    
    var text:String?
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    init(color:UIColor, position:CGPoint, text:String){
        super.init()
        super.color = color
        super.position = position
        self.text = text
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color = UIColor(red: 1.000, green: 0.488, blue: 0.000, alpha: 1.000)
        let color2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 94, 43.94))
        color2.setFill()
        rectanglePath.fill()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 0))
        bezierPath.addLineToPoint(CGPointMake(43, 0))
        bezierPath.addLineToPoint(CGPointMake(0, 43))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.closePath()
        color.setFill()
        bezierPath.fill()
        
        
        //// Text Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 1, 20.09)
        CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)
        
        let textRect = CGRectMake(0, 0, 27, 21)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(6), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = NSString(string: self.text!).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: self.text!).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        CGContextRestoreGState(context)
        
        
        
        CGContextRestoreGState(context)
    }
}
