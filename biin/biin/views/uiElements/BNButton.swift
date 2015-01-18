//  BNButton.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNButton:UIButton {
    
    var icon:BNIcon?
    var iconLayer:CAShapeLayer! = CAShapeLayer()
    var textLabel:UILabel?
    var isSelected = false
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, icon:BNIcon, text:String) {

        super.init(frame: frame)
        self.icon = icon
        textLabel = UILabel(frame: CGRectMake(0, 55, frame.width, 20))
        textLabel!.text = text
        textLabel!.textColor = UIColor.whiteColor()
        textLabel!.font = UIFont(name: "Lato-Light", size: 13)
        textLabel!.textAlignment = NSTextAlignment.Center
        self.addSubview(textLabel!)
        
//        self.iconLayer.path = icon.iconPath().CGPath
//        self.iconLayer.fillColor = nil
//        self.iconLayer.strokeColor = icon.color!.CGColor
//        self.iconLayer.lineWidth = icon.stroke
//        self.iconLayer.miterLimit = 4
//        self.iconLayer.lineCap = kCALineCapRound
        
//        let strokingPath = CGPathCreateCopyByStrokingPath(self.iconLayer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4)
//        self.iconLayer.bounds = CGPathGetBoundingBox(strokingPath)
        
//        self.layer.addSublayer(self.iconLayer)
//        self.iconLayer.position = icon.position
//        self.iconLayer.strokeStart = 0.0
//        self.iconLayer.strokeEnd = 0.0
//        self.transform = CGAffineTransformMakeScale(icon.scale, icon.scale)
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
    func setButtonSelected(isSelected:Bool){

        self.isSelected = isSelected
        
        if isSelected {
            textLabel!.textColor = UIColor.bnGray()
            icon!.color = UIColor.bnGray()
            self.enabled = false
        }   else {
            textLabel!.textColor = UIColor.whiteColor()
            icon!.color = UIColor.whiteColor()
            self.enabled = true
        }
        
        setNeedsDisplay()
    }
}