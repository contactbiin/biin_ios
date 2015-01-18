//  BNUiCircleLabel.swift
//  Biin
//  Created by Esteban Padilla on 8/20/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUiCircleLabel:UIView {
    
    var label:UILabel?
    var circle:BNUICircle?
    var color:UIColor?
    var borderColor:UIColor?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame:CGRect, color:UIColor, borderColor:UIColor, text:String, isFilled:Bool) {
        
        self.init(frame: frame)
        
        self.color = color
        self.borderColor = borderColor
        
        circle = BNUICircle(frame: CGRectMake(0, 0, frame.width, frame.width), color: color, isFilled:isFilled)
        self.addSubview(circle!)
        
        label = UILabel(frame: CGRectMake(0, -1, frame.width, frame.width))
        label!.font = UIFont(name: "Lato-Black", size:22)
        label!.textAlignment = NSTextAlignment.Center
        label!.textColor = borderColor
        label!.text = text
        self.addSubview(label!)
        
        self.layer.cornerRadius  = frame.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.CGColor

    }
    
    func animateCircleIn(){
        label!.textColor = UIColor.whiteColor()
        circle!.animateIn()
    }
    
    func animateCircleOut(){
        label!.textColor = borderColor!
        circle!.animateOut()
    }
}