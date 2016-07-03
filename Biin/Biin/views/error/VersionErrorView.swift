//  VersionErrorView.swift
//  biin
//  Created by Esteban Padilla on 6/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.


import Foundation
import UIKit
import StoreKit

class VersionErrorView: BNView, SKStoreProductViewControllerDelegate {
    
    var delegate:VersionErrorView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var warningLogo:BNUIWarningView?
    var errorViewController:ErrorViewController?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 8
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.errorView_title + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.errorView_title)
        title!.textColor = UIColor.appTextColor()
        title!.textAlignment = NSTextAlignment.Center
        title!.text = NSLocalizedString("VersionErrorTitle", comment: "VersionErrorTitle")
        self.addSubview(title!)
        

        ypos = SharedUIManager.instance.errorView_headerHeoght
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        self.addSubview(line)
        
        ypos = (screenHeight - 300) / 2
        warningLogo = BNUIWarningView(position:CGPoint(x:((screenWidth - 110) / 2), y:ypos), scale:2.0)
        warningLogo!.frame.origin.x = ((screenWidth - warningLogo!.frame.width) / 2)
        self.addSubview(warningLogo!)
        warningLogo!.setNeedsDisplay()
        
        ypos += (warningLogo!.frame.height + 10)
        
        let text = UILabel(frame: CGRectMake(40, ypos, (screenWidth - 80), (SharedUIManager.instance.errorView_text + 3)))
        text.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.errorView_text)
        text.textColor = UIColor.appTextColor()
        text.textAlignment = NSTextAlignment.Center
        text.text = NSLocalizedString("VersionErrorText", comment: "VersionErrorText")
        text.numberOfLines = 0
        text.sizeToFit()
        self.addSubview(text)
        
        ypos = (screenHeight - 100)
        let siteUrl =  UIButton(frame: CGRectMake(0, ypos, screenWidth, 55))
        siteUrl.setTitle(NSLocalizedString("VersionErrorButton", comment: "VersionErrorButton"), forState: UIControlState.Normal)
        siteUrl.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        siteUrl.backgroundColor = UIColor.darkGrayColor()
        siteUrl.titleLabel!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.errorView_button)
        siteUrl.addTarget(self, action: #selector(self.tryAgainAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(siteUrl)
    }
    
    func tryAgainAction(sender:UILabel) {
        let appId = "971157984"
        let url = "itms-apps://itunes.apple.com/app/id\(appId)"
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
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
}

@objc protocol VersionErrorView_Delegate:NSObjectProtocol {
    optional func hideErrorView(view:VersionErrorView)
}