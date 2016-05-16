//  SiteView_Showcase_Game.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Showcase_Game:BNView {
    
    var circles:Array<BNUICircleLabel> = Array<BNUICircleLabel>()
    var youSeenTitleLbl:UILabel?
    var youSeenLbl:UILabel?
    
    var animatedCircle:BNUICircle?
    var circleIcon:BNUICompletedGameIconView?
    
    deinit {
        circles.removeAll(keepCapacity: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, showcase:BNShowcase, animatedCircleColor:UIColor) {
        
        self.init(frame:frame, father:father)
        
        self.backgroundColor = UIColor.appMainColor()
        //self.layer.borderWidth = 1
        //self.layer.cornerRadius = 5
        //self.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        //self.layer.masksToBounds = true
        
        //var textColor:UIColor?
        //var borderColor:UIColor?
        //var titlesBackgroundColor:UIColor?
        
        //self.animatedCircleColor = animatedCircleColor
        //animatedCircle = BNUICircle(fullFrame:CGRectMake(0, 0, 1024, 1024), emptyFrame: CGRectMake((self.frame.width / 2), (self.frame.height / 2), 35, 35), color:showcase.titleColor!, isFilled: true)
        //self.addSubview(animatedCircle!)
        
        youSeenTitleLbl = UILabel(frame: CGRectMake(0, (frame.height * 0.44), frame.width, 16))
        youSeenTitleLbl!.font = UIFont(name: "Lato-Regular", size: 14)
        youSeenTitleLbl!.textColor = UIColor.appTextColor()
        youSeenTitleLbl!.text = NSLocalizedString("YouSeen", comment: "YouSeen")
        youSeenTitleLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(youSeenTitleLbl!)
        
        youSeenLbl = UILabel(frame: CGRectMake(0, (frame.height * 0.52), frame.width, 22))
        youSeenLbl!.font = UIFont(name: "Lato-Light", size: 20)
        youSeenLbl!.textColor = UIColor.appTextColor()
        youSeenLbl!.text = ""
        youSeenLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(youSeenLbl!)
        
        //circleIcon = BNUICompletedGameIconView(frame: CGRectMake(((frame.width / 2) - 43 ), (frame.height * 0.2 ), 86, 86), father: self, color:showcase.titleColor!)
        //circleIcon!.alpha = 0
        //self.addSubview(circleIcon!)
        
        if !showcase.isShowcaseGameCompleted {
            
            //var xSpace:CGFloat = (SharedUIManager.instance.screenWidth / 2) - 17
            //var ySpace:CGFloat = 40
            
            //let quantity = Double(showcase.elements.count)
            //var angle = Double(360.0 / quantity)
           
            
            var xpos:CGFloat = 10.0
            var ypos:CGFloat = 30.0
            
            var i:Int = 0
            for _ in showcase.elements {
//            for (var i = 0; i < showcase.elements.count; i++ ){
            
                //weak var element = BNAppSharedManager.instance.dataManager.elements[showcase.elements[i]._id!]
                
                //let circle = BNUICircleLabel(frame: CGRectMake(xpos, ypos, 30, 30), color:element!.color!, text: "\(i + 1)", textSize:15, isFilled:element!.userViewed)
                //self.circles.append(circle)
                //self.addSubview(circle)
                
                xpos += 10.0
                ypos += 30.0
                i += 1
            }
            /*
            for (var i = 0; i < showcase.elements.count; i++ ){
                
                var value = (angle * Double(i) + 270)
                var cosine:CGFloat = cos(DegreesToRadians(value))
                var xpos = CGFloat(cosine * 80)
                xpos += xSpace
                
                
                var sine:CGFloat = sin(DegreesToRadians(value))
                var ypos = CGFloat(sine * 40)
                ypos += ySpace
                
                weak var element = BNAppSharedManager.instance.dataManager.elements[showcase.elements[i]._id!]
                
                var circle = BNUICircleLabel(frame: CGRectMake(xpos, ypos, 30, 30), color:element!.color!, text: "\(i + 1)", textSize:15, isFilled:element!.userViewed)
                self.circles.append(circle)
                self.addSubview(circle)
            }
            */
            animatedCircle!.alpha = 0
            
        }else {
            self.youSeenTitleLbl!.frame.origin.y = self.frame.height * 0.7
            self.youSeenLbl!.frame.origin.y = self.frame.height * 0.6
            self.youSeenLbl!.text = NSLocalizedString("Done", comment: "title")
            self.youSeenTitleLbl!.text = NSLocalizedString("ThankYouStop", comment: "title")
            self.circleIcon!.alpha = 1
        }
    }
    
    func DegreesToRadians (value:Double) -> CGFloat {
        let r:Double = value * M_PI
        let result:CGFloat = CGFloat(r)
        let returnValue:CGFloat = result / 180
        return returnValue
    }
    
    func turnCircleOn(index:Int) {
        if !circles[index].circle!.isFilled {
            circles[index].animateCircleIn()
        }
    }
    
    //func updatePointLbl(text:String) {
        //pointsLbl!.text = text
    //}
    
    func updateYouSeenLbl(text:String){
        youSeenLbl!.text = text
    }
    
    func setCirclesOnShowcaseGameComplete(){
        for circle in circles {
            circle.animateCircleIn()
        }
    }
    
    func startToAnimateCirclesOnCompleted(){
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "animateCirclesOnCompleted:", userInfo: nil, repeats: false)
    }
    
    func animateCirclesOnCompleted(sender:NSTimer){
        
        youSeenTitleLbl!.alpha = 0
        youSeenLbl!.alpha = 0
        
        //TODO: Check this animation in the for seems wrong
        for circle in circles {
            
            circle.layer.borderWidth = 0
            
            UIView.animateWithDuration(0.2, animations: {()->Void in
                circle.frame = CGRectMake(((self.frame.width * 0.5) - 20), ((self.frame.height * 0.5) - 20), 35, 35)
                circle.label!.alpha = 0
                circle.circle!.backgroundColor = UIColor.biinColor()
                }, completion: {(completed:Bool)->Void in
                    
                    circle.removeFromSuperview()
            })
        }
        
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(self.animateEndCircle(_:)), userInfo: nil, repeats: false)
    }
    
    func animateEndCircle(sender:NSTimer){
        
        self.animatedCircle!.alpha = 1
        self.animatedCircle!.animateIn()
        self.youSeenTitleLbl!.frame.origin.y = self.frame.height * 0.7
        self.youSeenLbl!.frame.origin.y = self.frame.height * 0.6
        self.youSeenLbl!.text = NSLocalizedString("Done", comment: "title")
        self.youSeenTitleLbl!.text = NSLocalizedString("ThankYouStop", comment: "title")
        
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.youSeenTitleLbl!.alpha = 1
            self.youSeenLbl!.alpha = 1
            self.circleIcon!.alpha = 1
        })
    }
    
    /* Overide methods from BNView */
    override func transitionIn() {

        
    }
    
    override func transitionOut( state:BNState? ) {

    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func changeJoinBtnText(text: String) {
        self.father!.changeJoinBtnText(text)
    }
    
}
