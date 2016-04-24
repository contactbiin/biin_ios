//  BNActivityIndicator.swift
//  biin
//  Created by Esteban Padilla on 2/28/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNActivityIndicator: UIView {
    
    var rectShape:CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rectShape = CAShapeLayer()
        rectShape!.bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        rectShape!.position = CGPoint(x:(frame.width / 2), y: (frame.height / 2))
        rectShape!.path = UIBezierPath(ovalInRect: rectShape!.bounds).CGPath
        rectShape!.lineWidth = 3.0
        rectShape!.lineCap = kCALineCapRound
        rectShape!.strokeColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
        rectShape!.fillColor = UIColor.clearColor().CGColor
        rectShape!.strokeEnd = 0
        rectShape!.strokeStart = 0
        
        self.layer.addSublayer(rectShape!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    var toValue:CGFloat = 0
    var fromValue:CGFloat = 0
    var isStarted = false
    
    func changeAnimationValues(){
        toValue = CGFloat.random(0, max: 0.5)
        fromValue = CGFloat.random(0.5, max: 1.0)
    }
    
    func stop(){
        isStarted = false
    }
    
    func start(){
        if !isStarted {
            run()
            isStarted = true
        }
    }
    
    private func run(){
        
        
        changeAnimationValues()
        
        // We want to animate the strokeEnd property of the circleLayer
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.setValue("ani1", forKey:"animationID")
        strokeStart.delegate = self
        // Set the animation duration appropriately
        strokeStart.duration = 0.5
        
        // Animate from 0 (no circle) to 1 (full circle)
        strokeStart.fromValue = 0
        strokeStart.toValue = toValue
        strokeStart.repeatCount = 0
        // Do a linear animation (i.e. the speed of the animation stays the same)
        strokeStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        //        rectShape!.strokeStart = 0.25
        //        rectShape!.strokeEnd = 1
        
        // Do the actual animation
        self.rectShape!.addAnimation(strokeStart, forKey: "strokeStart")
        
        // We want to animate the strokeEnd property of the circleLayer
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        strokeEnd.duration = 0.5
        
        // Animate from 0 (no circle) to 1 (full circle)
        strokeEnd.fromValue = 0
        strokeEnd.toValue = fromValue
        strokeEnd.repeatCount = 0
        // Do a linear animation (i.e. the speed of the animation stays the same)
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        //        rectShape!.strokeStart = 0.25
        //        rectShape!.strokeEnd = 1
        
        // Do the actual animation
        self.rectShape!.addAnimation(strokeEnd, forKey: "animateCircle")
        
    }
    
    private func continueAnimation(){
        
        // We want to animate the strokeEnd property of the circleLayer
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.setValue("ani2", forKey:"animationID")
        strokeStart.delegate = self
        // Set the animation duration appropriately
        strokeStart.duration = 1
        
        // Animate from 0 (no circle) to 1 (full circle)
        strokeStart.fromValue = toValue
        strokeStart.toValue = 1
        strokeStart.repeatCount = 0
        // Do a linear animation (i.e. the speed of the animation stays the same)
        strokeStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        //        rectShape!.strokeStart = 0.25
        //        rectShape!.strokeEnd = 1
        
        // Do the actual animation
        self.rectShape!.addAnimation(strokeStart, forKey: "strokeStart")
        
        // We want to animate the strokeEnd property of the circleLayer
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        strokeEnd.duration = 1
        
        // Animate from 0 (no circle) to 1 (full circle)
        strokeEnd.fromValue = fromValue
        strokeEnd.toValue = 1
        strokeEnd.repeatCount = 0
        // Do a linear animation (i.e. the speed of the animation stays the same)
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        //        rectShape!.strokeStart = 0.25
        //        rectShape!.strokeEnd = 1
        
        // Do the actual animation
        self.rectShape!.addAnimation(strokeEnd, forKey: "animateCircle")
        
    }
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if isStarted {
            if let animationID: AnyObject = anim.valueForKey("animationID") {
                if animationID as! String == "ani1" {
                    continueAnimation()
                } else if animationID as! String == "ani2" {
                    run()
                }
            }
        }
    }
}

public extension Float {
    
    public static var random:Float {
        get {
            return Float(arc4random()) / 0xFFFFFFFF
        }
    }
    
    public static func random(min min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}


public extension CGFloat {
    
    public static var randomSign:CGFloat {
        get {
            return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
        }
    }
    
    public static var random:CGFloat {
        get {
            return CGFloat(Float.random)
        }
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}