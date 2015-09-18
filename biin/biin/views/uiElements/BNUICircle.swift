//  BNUICircle.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class BNUICircle:UIView {
    
    var pathFull:CGPathRef?
    var pathEmpty:CGPathRef?
    var mask:CAShapeLayer?
    var isFilled = false
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(fullFrame: CGRect, emptyFrame:CGRect, color:UIColor, isFilled:Bool) {
        self.init(frame: fullFrame)
        
        pathFull = UIBezierPath(roundedRect:CGRectMake(-352, -352, fullFrame.width, fullFrame.height) , byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(fullFrame.width, fullFrame.height)).CGPath
        
        pathEmpty = UIBezierPath(roundedRect: emptyFrame, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake((emptyFrame.width / 2), (emptyFrame.height / 2))).CGPath
        
        mask = CAShapeLayer()
        self.backgroundColor = color
        
        self.isFilled = isFilled
        
        if isFilled {
            mask!.path = pathFull
        } else {
            mask!.path = pathEmpty
        }
        self.layer.mask = mask!
    }
    
    convenience init(frame: CGRect, color:UIColor, isFilled:Bool) {
        self.init(frame: frame)
        
        pathFull = UIBezierPath(roundedRect: frame, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake((frame.width / 2), (frame.height / 2)) ).CGPath
        
        pathEmpty = UIBezierPath(roundedRect: CGRectMake((self.frame.width / 2), (self.frame.height / 2), 0, 0), byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(10, 10)).CGPath
        
        mask = CAShapeLayer()
        self.backgroundColor = color
        
        self.isFilled = isFilled
        
        if isFilled {
            mask!.path = pathFull
        } else {
            mask!.path = pathEmpty
        }
        self.layer.mask = mask!
    }
    
    func animateIn(){
        
        if self.isFilled { return }
        
        self.isFilled = true
        
        CATransaction.begin()
        let circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn )
        circleAnimation.fromValue = pathEmpty
        circleAnimation.toValue = pathFull
        circleAnimation.removedOnCompletion = true
        circleAnimation.duration = 0.25
        circleAnimation.fillMode = kCAFillModeForwards
        mask!.addAnimation(circleAnimation, forKey:nil )
        
        CATransaction.setCompletionBlock({()->Void in
            self.mask!.path = self.pathFull
            self.layer.mask = self.mask!
        })
        
        CATransaction.commit()
    }
    
    
    func animateInWithCallback(completed:Bool, callback:() -> Void){
        self.isFilled = true
        
        CATransaction.begin()
        let circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn )
        circleAnimation.fromValue = pathEmpty
        circleAnimation.toValue = pathFull
        circleAnimation.removedOnCompletion = true
        circleAnimation.duration = 2.2
        circleAnimation.fillMode = kCAFillModeForwards
        mask!.addAnimation(circleAnimation, forKey:nil )
        
        CATransaction.setCompletionBlock({()->Void in
            self.mask!.path = self.pathFull
            self.layer.mask = self.mask!
            callback()
        })
        
        CATransaction.commit()
    }
    
    
    
    func animateOut(){
        
        if !self.isFilled { return }
        
        self.isFilled = false
        
        CATransaction.begin()
        let circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn )
        circleAnimation.fromValue = pathFull
        circleAnimation.toValue = pathEmpty
        circleAnimation.removedOnCompletion = true
        circleAnimation.duration = 0.3
        circleAnimation.fillMode = kCAFillModeForwards
        mask!.addAnimation(circleAnimation, forKey:nil )
        
        CATransaction.setCompletionBlock({()->Void in
            self.mask!.path = self.pathEmpty
            self.layer.mask = self.mask!
        })
        
        CATransaction.commit()
    }
}