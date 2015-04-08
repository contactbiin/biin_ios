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
    
    var animatedCircle:BNUICircle?
    var circleIcon:BNUICompletedGameIconView?
    var biinItLbl:UILabel?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        animatedCircle = BNUICircle(fullFrame:CGRectMake(0, 0, 1024, 1024), emptyFrame: CGRectMake((self.frame.width / 2), (self.frame.height / 2), 2, 2), color:UIColor.biinColor(), isFilled: false)
        self.addSubview(animatedCircle!)
        animatedCircle!.alpha = 0

        println("w: \(frame.width) , h:\(frame.height)")
        
        var x:CGFloat = ((frame.width - 86) / 2 )
        var y:CGFloat = ((frame.height - 86 ) / 2 )
        circleIcon = BNUICompletedGameIconView(frame: CGRectMake(x, y, 86, 86), father: nil, color: UIColor.whiteColor())
        circleIcon!.alpha = 0
        self.addSubview(circleIcon!)
        
        y += 90
        
        biinItLbl = UILabel(frame: CGRectMake(0, y, frame.width, 20))
        biinItLbl!.font = UIFont(name: "Lato-Light", size: 18)
        biinItLbl!.text = "Biined!"
        biinItLbl!.textAlignment = NSTextAlignment.Center
        biinItLbl!.textColor = UIColor.whiteColor()
        biinItLbl!.alpha = 0
        self.addSubview(biinItLbl!)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate(){
        self.alpha = 1
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "animateCircle:", userInfo: nil, repeats: false)
    }
    
    func animateOut(){
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "animateCircleOut:", userInfo: nil, repeats: false)
    }
    
    func animateCircle(sender:NSTimer){
        
        self.animatedCircle!.alpha = 1
        self.animatedCircle!.animateIn()
        
        UIView.animateWithDuration(0.2, animations: {()->Void in
            
            self.circleIcon!.alpha = 1
            self.biinItLbl!.alpha = 1
            
            }, completion: {(completed:Bool)-> Void in
                self.animateOut()
        })
    }
    
    
    func animateCircleOut(sender:NSTimer){
        
        self.animatedCircle!.animateOut()

        UIView.animateWithDuration(0.35, animations: {()->Void in
            
            self.circleIcon!.alpha = 0
            self.biinItLbl!.alpha = 0
            
            }, completion: {(completed:Bool)-> Void in
                
                self.alpha = 0
        })
    }
    
    

}