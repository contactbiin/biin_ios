//
//  BiinItAnimationView.swift
//  biin
//
//  Created by Esteban Padilla on 4/7/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class BiinItAnimationView:UIView {
    
    //var animatedCircle:BNUICircle?
    //var circleIcon:BNUICompletedGameIconView?
    var label:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    var isRunning = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
//        animatedCircle = BNUICircle(fullFrame:CGRectMake(0, 0, 1024, 1024), emptyFrame: CGRectMake((self.frame.width / 2), (self.frame.height / 2), 2, 2), color:UIColor.biinColor(), isFilled: false)
//        self.addSubview(animatedCircle!)
//        animatedCircle!.alpha = 0

        //println("w: \(frame.width) , h:\(frame.height)")
        
//        let x:CGFloat = ((frame.width - 86) / 2 )
//        var y:CGFloat = ((frame.height - 86 ) / 2 )
//        circleIcon = BNUICompletedGameIconView(frame: CGRectMake(x, y, 86, 86), father: nil, color: UIColor.biinColor())
//        circleIcon!.alpha = 1
//        self.addSubview(circleIcon!)
//        
//        y += 90
        
        label = UILabel(frame: CGRectMake(0, 15, frame.width, 20))
        label!.font = UIFont(name: "Lato-Light", size: 18)
        label!.text = ""// NSLocalizedString("Collected", comment: "Collected")
        label!.textAlignment = NSTextAlignment.Center
        label!.textColor = UIColor.whiteColor()
        label!.alpha = 0
        self.addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate(value:Bool){

        
        if !isRunning {
            isRunning = true
            if value {
                label!.text = NSLocalizedString("Collected", comment: "Collected")
            } else {
                label!.text = NSLocalizedString("Uncollected", comment: "Uncollected")
            }
            
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "animateCircle:", userInfo: nil, repeats: false)
        }
    }
    
    func animateWithText(text:String){
        
        if !isRunning {
            isRunning = true
            label!.text = text
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "animateCircle:", userInfo: nil, repeats: false)
        }
    }
    
    func animateOut(){
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "animateCircleOut:", userInfo: nil, repeats: false)
    }
    
    func animateCircle(sender:NSTimer){
        
        //self.animatedCircle!.alpha = 0.35
        //self.animatedCircle!.animateIn()
        
        UIView.animateWithDuration(0.2, animations: {()->Void in
            
//            self.circleIcon!.alpha = 1
//            self.biinItLbl!.alpha = 1
            self.label!.alpha = 1
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, -50)
            
            }, completion: {(completed:Bool)-> Void in
                self.animateOut()
        })
    }
    
    
    func animateCircleOut(sender:NSTimer){
        
        //self.animatedCircle!.animateOut()

        UIView.animateWithDuration(0.35, animations: {()->Void in
            
            
//            self.frame.origin.y = SharedUIManager.instance.screenWidth
            self.frame = CGRectMake(self.frame.origin.x, SharedUIManager.instance.screenWidth, self.frame.width, 0)
//            self.circleIcon!.alpha = 0
//            self.biinItLbl!.alpha = 0
            
            }, completion: {(completed:Bool)-> Void in
            self.label!.alpha = 0
                self.isRunning = false
        })
    }
    
    func updateAnimationView(backgroundColor:UIColor?, textColor:UIColor?){
        self.backgroundColor = backgroundColor!
        self.label!.textColor = textColor!
    }
    
    func clean(){
        print("BiinItAnimationView clean()")
        label?.removeFromSuperview()
    }

}