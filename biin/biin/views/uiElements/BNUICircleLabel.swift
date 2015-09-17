//  BNUICircleLabel.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUICircleLabel:UIView {
    
    var label:UILabel?
    var circle:BNUICircle?
    var color:UIColor?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame:CGRect, color:UIColor, text:String, textSize:CGFloat, isFilled:Bool) {
        
        self.init(frame: frame)
        
        self.color = color
        
        circle = BNUICircle(frame: CGRectMake(0, 0, frame.width, frame.width), color:color, isFilled:isFilled)
        self.addSubview(circle!)
        
        label = UILabel(frame: CGRectMake(0, -1, frame.width, frame.width))
        label!.font = UIFont(name: "Lato-Light", size:textSize)
        label!.textAlignment = NSTextAlignment.Center
        label!.textColor = UIColor.bnGrayDark()
        label!.text = text
        self.addSubview(label!)
        
        self.layer.cornerRadius  = frame.width / 2
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = 1
//        self.layer.backgroundColor = UIColor.appButtonColor().CGColor
        
    }
    
    func animateCircleIn(){
        label!.textColor = UIColor.whiteColor()
        self.layer.borderWidth = 0
        circle!.animateIn()
    }
    
    func animateCircleOut(){
        //label!.textColor = borderColor!
        circle!.animateOut()
    }
}
