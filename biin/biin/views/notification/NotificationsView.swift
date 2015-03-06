//  NotificationsView.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class NotificationsView: BNView {
    
    var delegate:NotificationsView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var fade:UIView?
    
    var biinieAvatar:BNUIImageView?
    var biinieNameLbl:UILabel?
    var biinieUserNameLbl:UILabel?
    
    var scroll:UIScrollView?
    
    
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        title = UILabel(frame: CGRectMake(0, 3, screenWidth, 12))
        title!.text = "Profile"
        title!.textColor = UIColor.appTextColor()
        title!.font = UIFont(name: "Lato-Light", size: 10)
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(2, 5, 30, 15))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        
        var headerWidth = screenWidth - 60
        var xpos:CGFloat = (screenWidth - headerWidth) / 2
        var ypos:CGFloat = 25
        
        var biinieAvatarView = UIView(frame: CGRectMake(xpos, ypos, 92, 92))
        biinieAvatarView.layer.cornerRadius = 35
        biinieAvatarView.layer.borderColor = UIColor.appBackground().CGColor
        biinieAvatarView.layer.borderWidth = 6
        biinieAvatarView.layer.masksToBounds = true
        self.addSubview(biinieAvatarView)
        
        if BNAppSharedManager.instance.dataManager.bnUser!.imgUrl != "" {
            biinieAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
            biinieAvatar!.alpha = 0
            biinieAvatar!.layer.cornerRadius = 30
            biinieAvatar!.layer.masksToBounds = true
            biinieAvatarView.addSubview(biinieAvatar!)
            BNAppSharedManager.instance.networkManager.requestImageData(BNAppSharedManager.instance.dataManager.bnUser!.imgUrl!, image: biinieAvatar)
        } else  {
            var initials = UILabel(frame: CGRectMake(0, 25, 90, 40))
            initials.font = UIFont(name: "Lato-Light", size: 38)
            initials.textColor = UIColor.appMainColor()
            initials.textAlignment = NSTextAlignment.Center
            initials.text = "\(first(BNAppSharedManager.instance.dataManager.bnUser!.firstName!)!)\(first(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)!)"
            biinieAvatarView.addSubview(initials)
            biinieAvatarView.backgroundColor = UIColor.biinColor()
        }
        
        biinieNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 30), (headerWidth - 95), 20))
        biinieNameLbl!.font = UIFont(name: "Lato-Regular", size: 22)
        biinieNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.firstName!) \(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)"
        biinieNameLbl!.textColor = UIColor.biinColor()
        self.addSubview(biinieNameLbl!)
        
        biinieUserNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 50), (headerWidth - 95), 14))
        biinieUserNameLbl!.font = UIFont(name: "Lato-Light", size: 12)
        biinieUserNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.biinName!)"
        biinieUserNameLbl!.textColor = UIColor.appTextColor()
        self.addSubview(biinieUserNameLbl!)
        
        ypos += 100
        var line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - ypos)))
        scroll!.backgroundColor = UIColor.appBackground()
        self.addSubview(scroll!)
        self.addSubview(line)

        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        println("trasition in on NotificationsView")
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on NotificationsView")
        state!.action()
        
        if state!.stateType == BNStateType.BiinieCategoriesState
            || state!.stateType == BNStateType.SiteState {
                
                UIView.animateWithDuration(0.25, animations: {()-> Void in
                    self.frame.origin.x = SharedUIManager.instance.screenWidth
                })
        } else {
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "hideView:", userInfo: nil, repeats: false)
        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: NotificationsView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: NotificationsView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.hideNotificationsView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
    
    func showNotifications(){
        
    }
}

@objc protocol NotificationsView_Delegate:NSObjectProtocol {
    optional func hideNotificationsView(view:NotificationsView)
}
