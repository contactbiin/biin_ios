//  BNIcon_PricingBig.swift
//  biin
//  Created by Esteban Padilla on 5/10/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_PricingBig:BNIcon {
    
    var text:String?
    var size:CGFloat = 0
    var textWidth:CGFloat = 0
    var textSize:CGFloat = 0
    
    override init() {
        super.init()
    }
    
    convenience init(color:UIColor, position:CGPoint){
        self.init()
        self.color = color
        self.position = position
    }
    
    convenience init(color:UIColor, position:CGPoint, text:String){
        self.init()
        self.color = color
        self.position = position
        self.text = text
    }
    
    convenience init(color:UIColor, position:CGPoint, text:String, size:CGFloat, textSize:CGFloat){
        self.init()
        self.color = color
        self.position = position
        self.text = text
        self.size = size
        self.textWidth = sqrt((size * size) + (size * size));
        self.textSize = textSize
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(size, 0))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.addLineToPoint(CGPointMake(size, size))
        bezierPath.addLineToPoint(CGPointMake(size, 0))
        bezierPath.closePath()
        color!.setFill()
        bezierPath.fill()
        
        //// Text Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 12, -12)
        CGContextRotateCTM(context, 45 * CGFloat(M_PI) / 180)
        
        let textRect = CGRectMake(0, 5.66, textWidth, 12)
        let textTextContent = NSString(string:self.text!)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "Lato-Regular", size: self.textSize)!, NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        CGContextRestoreGState(context)
    }
}