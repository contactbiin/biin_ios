//  BNUISquare.swift
//  Biin
//  Created by Esteban Padilla on 11/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class BNUISquare:UIView {
    
    var pathFull:CGPathRef?
    var pathEmpty:CGPathRef?
    var mask:CAShapeLayer?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, color:UIColor, isFilled:Bool) {
        self.init(frame: frame)
        
        pathFull = UIBezierPath(roundedRect: frame, byRoundingCorners: UIRectCorner.allZeros, cornerRadii: CGSizeMake(frame.width, frame.height) ).CGPath
        
        pathEmpty = UIBezierPath(roundedRect: CGRectMake((self.frame.width / 2), (self.frame.height / 2), 0, 0), byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(10, 10)).CGPath
        
        mask = CAShapeLayer()
        self.backgroundColor = color
        
        if isFilled {
            mask!.path = pathFull
        } else {
            mask!.path = pathEmpty
        }
        self.layer.mask = mask!
    }
    
    func animateIn(){
        
        CATransaction.begin()
        var circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn )
        circleAnimation.fromValue = pathEmpty
        circleAnimation.toValue = pathFull
        circleAnimation.removedOnCompletion = true
        circleAnimation.duration = 0.2
        circleAnimation.fillMode = kCAFillModeForwards
        mask!.addAnimation(circleAnimation, forKey:nil )
        
        CATransaction.setCompletionBlock({()->Void in
            self.mask!.path = self.pathFull
            self.layer.mask = self.mask!
        })
        
        CATransaction.commit()
    }
    
    func animateOut(){
        CATransaction.begin()
        var circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn )
        circleAnimation.fromValue = pathFull
        circleAnimation.toValue = pathEmpty
        circleAnimation.removedOnCompletion = true
        circleAnimation.duration = 0.2
        circleAnimation.fillMode = kCAFillModeForwards
        mask!.addAnimation(circleAnimation, forKey:nil )
        
        CATransaction.setCompletionBlock({()->Void in
            self.mask!.path = self.pathEmpty
            self.layer.mask = self.mask!
        })
        
        CATransaction.commit()
    }
}