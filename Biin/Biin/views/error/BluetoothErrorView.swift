//  BluetoothErrorView.swift
//  biin
//  Created by Esteban Padilla on 7/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BluetoothErrorView: BNView {
    
    var delegate:BluetoothErrorView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
//    var fade:UIView?
    var warningLogo:BNUIBluetoothView?
    var errorViewController:ErrorViewController?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.whiteColor()
//        self.layer.borderColor = UIColor.clearColor().CGColor
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = 5
//        self.layer.masksToBounds = true
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 0
//        title = UILabel(frame: CGRectMake(5, ypos, (screenWidth - 10), (SharedUIManager.instance.errorView_title + 3)))
//        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.errorView_title)
//        title!.textColor = UIColor.whiteColor()
//        title!.textAlignment = NSTextAlignment.Center
//        title!.numberOfLines = 0
//        title!.text = NSLocalizedString("BluetoothErrorTitle", comment: "BluetoothErrorTitle")
//        title!.sizeToFit()
//        self.addSubview(title!)
//        
        //        var headerWidth = screenWidth - 60
        //        var xpos:CGFloat = (screenWidth - headerWidth) / 2
        
//        ypos = SharedUIManager.instance.errorView_headerHeoght
//        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
//        line.backgroundColor = UIColor.appButtonColor()
//        self.addSubview(line)
        
//        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
//        fade!.backgroundColor = UIColor.blackColor()
//        fade!.alpha = 0
//        self.addSubview(fade!)
        
        ypos = (screenHeight - 350) / 2
        warningLogo = BNUIBluetoothView(position:CGPoint(x:((screenWidth - 100) / 2), y:ypos), scale:1.25)
        warningLogo!.frame.origin.x = ((screenWidth - warningLogo!.frame.width) / 2)
        self.addSubview(warningLogo!)
        warningLogo!.icon!.color = UIColor.bnBlueDark()
        warningLogo!.setNeedsDisplay()
        
        ypos += (warningLogo!.frame.height + 10)
        
        let text = UILabel(frame: CGRectMake(20, ypos, (screenWidth - 40), (SharedUIManager.instance.errorView_text + 3)))
        text.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.errorView_text)
        text.textColor = UIColor.blackColor()
        text.textAlignment = NSTextAlignment.Center
        text.text = NSLocalizedString("BluetoothErrorText", comment: "BluetoothErrorText")
        text.numberOfLines = 0
        text.sizeToFit()
        self.addSubview(text)
        text.frame.origin.x = ((screenWidth - text.frame.width) / 2)

        
//        ypos += (screenHeight - 100)
        
        title = UILabel(frame: CGRectMake(0, (screenHeight - 110), screenWidth, (SharedUIManager.instance.errorView_title + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.errorView_title)
        title!.textColor = UIColor.bnBlueDark()
        title!.textAlignment = NSTextAlignment.Center
        title!.text = NSLocalizedString("BluetoothErrorTitle", comment: "BluetoothErrorTitle")
        title!.numberOfLines = 0
        title!.sizeToFit()
        
        title!.frame.origin.x = ((screenWidth - title!.frame.width) / 2)
        
        self.addSubview(title!)
        
//        ypos = (screenHeight - 100)
        let siteUrl = UIButton(frame: CGRectMake(5, (screenHeight - 60), (screenWidth - 10), 55))
        siteUrl.setTitle(NSLocalizedString("BluetoothErrorButton", comment: "BluetoothErrorButton"), forState: UIControlState.Normal)
        siteUrl.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        siteUrl.backgroundColor = UIColor.darkGrayColor()
        siteUrl.titleLabel!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.errorView_button)
        siteUrl.addTarget(self, action: #selector(self.tryAgainAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(siteUrl)
    }
    
    func tryAgainAction(sender:UILabel) {
        
        
        
        //UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        BNAppSharedManager.instance.errorManager.isAlertOn = false
        
        
        let vc = LoadingViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        BNAppSharedManager.instance.errorManager.currentViewController!.presentViewController(vc, animated: true, completion: nil)
        
        //BNAppSharedManager.instance.continueAfterIntialChecking()


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

@objc protocol BluetoothErrorView_Delegate:NSObjectProtocol {
    optional func hideErrorView(view:BluetoothErrorView)
}
