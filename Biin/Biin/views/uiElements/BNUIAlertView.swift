//  BNUIAlertView.swift
//  biin
//  Created by Esteban Padilla on 2/11/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class BNUIAlertView:UIView {
    
    var header:BNUIAlertView_Header?
    var isOn = false
    var text:String = ""
    var type:BNUIAlertView_Type = BNUIAlertView_Type.None
    var fade:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, type:BNUIAlertView_Type) {
        self.init(frame:frame)
        
        self.type = type
        addText()
        
        fade = UIView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
    
        self.header = BNUIAlertView_Header(frame: CGRectMake(0, -120, frame.width, 120), type:type, text:self.text, father: self)
        self.addSubview(header!)
    }
    
    override func drawRect(rect:CGRect){

    }
    
    func show(){
        isOn = true
        UIView.animateWithDuration(0.2, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.TransitionNone, animations: {()->Void in
                self.header!.frame = CGRectMake(self.frame.origin.x, -60, self.frame.width, self.frame.height)
                self.fade!.alpha = 0.5
            }, completion: {(completed:Bool)-> Void in
        
        })
    }
    
    func showAndHide(){
        isOn = true
        UIView.animateWithDuration(0.2, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.TransitionNone, animations: {()->Void in
            self.header!.frame = CGRectMake(self.frame.origin.x, -60, self.frame.width, self.frame.height)
            self.fade!.alpha = 0.5
            }, completion: {(completed:Bool)-> Void in

                self.isOn = false
                UIView.animateWithDuration(0.2, delay: 1.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.TransitionNone, animations: {()->Void in
                    self.header!.frame = CGRectMake(self.frame.origin.x, -120, self.frame.width, self.frame.height)
                    self.fade!.alpha = 0
                    }, completion: {(completed:Bool)-> Void in
                        self.removeFromSuperview()
                })
                
        })
    }
    
    func hide(){
        isOn = false
        UIView.animateWithDuration(0.2, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.TransitionNone, animations: {()->Void in
                self.header!.frame = CGRectMake(self.frame.origin.x, -120, self.frame.width, self.frame.height)
                self.fade!.alpha = 0
            }, completion: {(completed:Bool)-> Void in
                self.removeFromSuperview()
        })
    }
    
    func hideWithCallback(callback:() -> Void) {
        isOn = false
        
        UIView.animateWithDuration(0.2, delay: 1.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
                self.header!.frame = CGRectMake(self.frame.origin.x, -120, self.frame.width, self.frame.height)
            }, completion: {(completed:Bool)->Void in
                callback()
                self.removeFromSuperview()
        })
    }
    
    func closeBtnAction(sender:BNUIButton_CloseAlert){
        hide()
    }
    
    func addText(){
        switch self.type {
        case .Cool:
            self.text = NSLocalizedString("Cool", comment: "Cool")
            break
        case .Bad_credentials:
            self.text = NSLocalizedString("BadEmail", comment: "BadEmail")
            break
        case .NotInternet:
            self.text = NSLocalizedString("NotInternet", comment: "NotInternet")
            break
        case .Please_wait:
            self.text = NSLocalizedString("PleaseWait", comment: "PleaseWait")
            break
        case .FacebookError:
            self.text = "Error on Facebook!"
            break
        default:
            self.text = NSLocalizedString("Cool", comment: "Cool")
            break
        }
    }

}

enum BNUIAlertView_Type {
    case None
    case Bad_credentials
    case Please_wait
    case Cool
    case Saved
    case NotInternet
    case FacebookError
}
