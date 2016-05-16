//  NotBiinieErrorView.swift
//  biin
//  Created by Esteban Padilla on 10/29/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class NotBiinieErrorView: BNView {
    
    var delegate:NotBiinieErrorView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    //    var fade:UIView?
    var warningLogo:BNUIWarningView?
    var errorViewController:ErrorViewController?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        //        self.layer.borderColor = UIColor.clearColor().CGColor
        //        self.layer.borderWidth = 1
        //        self.layer.cornerRadius = 5
        //        self.layer.masksToBounds = true
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 8
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.errorView_title + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.errorView_title)
        title!.textColor = UIColor.appTextColor()
        title!.textAlignment = NSTextAlignment.Center
        title!.text = NSLocalizedString("NotBiinieErrorTitle", comment: "NotBiinieErrorTitle")
        self.addSubview(title!)
        
        //        var headerWidth = screenWidth - 60
        //        var xpos:CGFloat = (screenWidth - headerWidth) / 2
        
        ypos = SharedUIManager.instance.errorView_headerHeoght
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        self.addSubview(line)
        
        //        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        //        fade!.backgroundColor = UIColor.blackColor()
        //        fade!.alpha = 0
        //        self.addSubview(fade!)
        
        ypos = (screenHeight - 300) / 2
        warningLogo = BNUIWarningView(position:CGPoint(x:((screenWidth - 110) / 2), y:ypos), scale:2.0)
        warningLogo!.frame.origin.x = ((screenWidth - warningLogo!.frame.width) / 2)
        self.addSubview(warningLogo!)
        warningLogo!.setNeedsDisplay()
        
        ypos += (warningLogo!.frame.height + 10)
        
        let text = UILabel(frame: CGRectMake(40, ypos, (screenWidth - 80), (SharedUIManager.instance.errorView_text + 3)))
        text.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.errorView_text)
        text.textColor = UIColor.appTextColor()
        text.textAlignment = NSTextAlignment.Center
        text.text = NSLocalizedString("NotBiinieErrorText", comment: "NotBiinieErrorText")
        text.numberOfLines = 0
        text.sizeToFit()
        self.addSubview(text)
        
//        ypos = (screenHeight - 100)
        let tryAgainBtn =  UIButton(frame: CGRectMake(5, (screenHeight - 60), (screenWidth - 10), 55))
        tryAgainBtn.setTitle(NSLocalizedString("NotBiinieErrorButton", comment: "NotBiinieErrorButton"), forState: UIControlState.Normal)
        tryAgainBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tryAgainBtn.backgroundColor = UIColor.darkGrayColor()
        tryAgainBtn.titleLabel!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.errorView_button)
        tryAgainBtn.addTarget(self, action: #selector(self.tryAgainAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(tryAgainBtn)
    }
    
    func tryAgainAction(sender:UILabel) {
        //        delegate!.hideErrorView!(self)
        BNAppSharedManager.instance.errorManager.isAlertOn = false
        let vc = SingupViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        BNAppSharedManager.instance.errorManager.currentViewController!.presentViewController(vc, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        if state!.stateType == BNStateType.BiinieCategoriesState
            || state!.stateType == BNStateType.SiteState {
                
                UIView.animateWithDuration(0.25, animations: {()-> Void in
                    self.frame.origin.x = SharedUIManager.instance.screenWidth
                })
        } else {
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.hideView(_:)), userInfo: nil, repeats: false)
        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.hideErrorView!(self)
    }
}

@objc protocol NotBiinieErrorView_Delegate:NSObjectProtocol {
    optional func hideErrorView(view:NotBiinieErrorView)
}
