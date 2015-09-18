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
        //let color = UIColor.biinColor()
        let color2 = UIColor.clearColor()//UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 94, 43.94))
        color2.setFill()
        rectanglePath.fill()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 0))
        bezierPath.addLineToPoint(CGPointMake(46, 0))
        bezierPath.addLineToPoint(CGPointMake(0, 46))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.closePath()
        color!.setFill()
        bezierPath.fill()
        
        
        //// Text Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 5.95, 25.05)
        CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)
        
        let textRect = CGRectMake(0, 0, 27, 9.75)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(8), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = NSString(string: self.text!).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: self.text!).drawInRect(CGRectMake(textRect.minX, textRect.minY + textRect.height - textTextHeight, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        CGContextRestoreGState(context)
        
        
        
        CGContextRestoreGState(context)
    }
}
