//  BNUISquareLabel.swift
//  Biin
//  Created by Esteban Padilla on 11/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUISquareLabel:UIView {
    
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
    
    convenience init(frame: CGRect, color:UIColor, textColor:UIColor, text:String, isFilled:Bool, borderColor:UIColor) {
        
        self.init(frame: frame)
        
        self.color = color
        self.borderColor = borderColor
        
        circle = BNUICircle(frame: CGRectMake(0, 0, frame.width, frame.width), color: color, isFilled:isFilled)
        self.addSubview(circle!)
        
        label = UILabel(frame: CGRectMake(0, -1, frame.width, frame.width))
        label!.font = UIFont(name: "Lato-Black", size: 18)
        label!.textAlignment = NSTextAlignment.Center
        label!.textColor = textColor
        label!.text = text
        self.addSubview(label!)
        
//        self.layer.cornerRadius  = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = self.borderColor!.CGColor
        
    }
    
    func animateCircleIn(){
        label!.textColor = UIColor.whiteColor()
        self.layer.borderWidth = 0
        circle!.animateIn()
    }
    
    func animateCircleOut(){
        label!.textColor = borderColor!
        self.layer.borderWidth = 1
        circle!.animateOut()
    }
}