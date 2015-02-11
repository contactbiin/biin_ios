//  BNUIAlertView.swift
//  biin
//  Created by Esteban Padilla on 2/11/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class BNUIAlertView:UIView {
    
    var header:BNUIAlertView_Header?
    var isOn = false
    var fade:UIView?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, type:BNUIAlertView_Type?, text:String?) {
        self.init(frame:frame)
        
        fade = UIView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        self.header = BNUIAlertView_Header(frame: CGRectMake(0, -110, frame.width, 100), type: type, text: text, father: self)
        self.addSubview(header!)
    }
    
    override func drawRect(rect:CGRect){

    }
    
    func show(){
        isOn = true
        UIView.animateWithDuration(0.25, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.TransitionNone, animations: {()->Void in
                self.header!.frame = CGRectMake(self.frame.origin.x, -50, self.frame.width, self.frame.height)
                self.fade!.alpha = 0.15
            }, completion: {(completed:Bool)-> Void in
        
        })
    }
    
    func hide(){
        isOn = false
        UIView.animateWithDuration(0.2, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.TransitionNone, animations: {()->Void in
                self.header!.frame = CGRectMake(self.frame.origin.x, -110, self.frame.width, self.frame.height)
                self.fade!.alpha = 0
            }, completion: {(completed:Bool)-> Void in
                self.removeFromSuperview()
        })
    }
    
    func hideWithCallback(callback:() -> Void) {
        isOn = false
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
                self.header!.frame = CGRectMake(self.frame.origin.x, -110, self.frame.width, self.frame.height)
            }, completion: {(completed:Bool)->Void in
                callback()
                self.removeFromSuperview()
        })
    }
    
    func closeBtnAction(sender:BNUIButton_CloseAlert){
        hide()
    }
}

enum BNUIAlertView_Type {
    case Bad_credentials
    case Please_wait
}
