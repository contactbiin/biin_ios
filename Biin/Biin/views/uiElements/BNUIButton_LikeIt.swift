//  BNUIButton_LikeIt.swift
//  biin
//  Created by Esteban Padilla on 9/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_LikeIt:BNUIButton {
    
    var isBig = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_LikeIt_Big_Empty(color: UIColor.whiteColor(), position: CGPointMake(2, 2))
    }
    
    convenience init(frame: CGRect, isBig:Bool) {
        self.init(frame: frame)
        self.isBig = isBig
        
        if isBig {
            icon = BNIcon_LikeIt_Big_Empty(color: UIColor.whiteColor(), position: CGPointMake(2, 2))
        } 
    }
    
    func changedIcon(value:Bool) {
        let color = icon!.color
        icon = nil
        if isBig {
            if value {
                icon = BNIcon_LikeIt_Big_Full(color: UIColor.whiteColor(), position: CGPointMake(2, 2))
            } else {
                icon = BNIcon_LikeIt_Big_Empty(color: UIColor.whiteColor(), position: CGPointMake(2, 2))
            }
        } else {
            if value {
                icon = BNIcon_LikeIt_Full(color: color!, position: CGPointMake(4, 5))
            } else {
                icon = BNIcon_LikeIt_Empty(color: color!, position: CGPointMake(4, 5))
            }
        }
        setNeedsDisplay()
    }
    
    func addHeartBeatAnimation () {
        let beatLong: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        beatLong.fromValue = NSValue(CGSize: CGSizeMake(1, 1))
        beatLong.toValue = NSValue(CGSize: CGSizeMake(0.8, 0.8))
        beatLong.autoreverses = true
        beatLong.duration = 0.85
        beatLong.beginTime = 0.0
        
        let beatShort: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        beatShort.fromValue = NSValue(CGSize: CGSizeMake(1, 1))
        beatShort.toValue = NSValue(CGSize: CGSizeMake(0.9, 0.9))
        beatShort.autoreverses = true
        beatShort.duration = 0.9
        beatShort.beginTime = beatLong.duration
        beatLong.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn )
        
        let heartBeatAnim: CAAnimationGroup = CAAnimationGroup()
        heartBeatAnim.animations = [beatLong, beatShort]
        heartBeatAnim.duration = beatShort.beginTime + beatShort.duration
        heartBeatAnim.fillMode = kCAFillModeForwards
        heartBeatAnim.removedOnCompletion = false
        heartBeatAnim.repeatCount = FLT_MAX
        self.layer.addAnimation(heartBeatAnim, forKey: nil)
    }

}
