//  BNIcon_Percentage.swift
//  biin
//  Created by Esteban Padilla on 9/22/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Percentage:BNIcon {
    
    var text:String?
    var size:CGFloat = 0
    var textWidth:CGFloat = 0
    var textSize:CGFloat = 0
    var textPosition:CGPoint?
    var textcolor:UIColor?
    
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
    
    convenience init(color:UIColor, position:CGPoint, text:String, textcolor:UIColor, size:CGFloat, textSize:CGFloat, textPosition:CGPoint){
        self.init()
        self.color = color
        self.position = position
        self.text = text
        self.size = size
        self.textWidth = sqrt((size * size) + (size * size));
        self.textSize = textSize
        self.textPosition = textPosition
        self.textcolor = textcolor
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
        CGContextTranslateCTM(context, textPosition!.x, textPosition!.y)
        CGContextRotateCTM(context, 45 * CGFloat(M_PI) / 180)
        
        let textRect = CGRectMake(0, -15.02, textWidth, 29.68)
        let textTextContent = NSString(string:self.text!)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "Lato-Black", size: self.textSize)!, NSForegroundColorAttributeName: self.textcolor!, NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        CGContextRestoreGState(context)
    }
}
