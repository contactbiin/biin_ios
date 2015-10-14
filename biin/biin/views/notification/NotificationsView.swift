//  NotificationsView.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class NotificationsView: BNView, NotificationsView_Notification_Delegate {
    
    var delegate:NotificationsView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var fade:UIView?
    
    var biinieAvatar:BNUIImageView?
    var biinieNameLbl:UILabel?
    var biinieUserNameLbl:UILabel?
    
    var scroll:UIScrollView?
    
    var notifications = Array<NotificationsView_Notification>()

    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 12
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.appTextColor()
        title!.textAlignment = NSTextAlignment.Center
        title!.text = NSLocalizedString("Notifications", comment: "title")
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 10, 50, 50))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        //let headerWidth = screenWidth - 60
        //var xpos:CGFloat = (screenWidth - headerWidth) / 2
        
        /*
        var biinieAvatarView = UIView(frame: CGRectMake(xpos, ypos, 92, 92))
        biinieAvatarView.layer.cornerRadius = 35
        biinieAvatarView.layer.borderColor = UIColor.appBackground().CGColor
        biinieAvatarView.layer.borderWidth = 6
        biinieAvatarView.layer.masksToBounds = true
        self.addSubview(biinieAvatarView)
        
        if BNAppSharedManager.instance.dataManager.bnUser!.imgUrl != "" {
        biinieAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
        //biinieAvatar!.alpha = 0
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

        
        
        //        biinieNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 30), (headerWidth - 95), 20))
        biinieNameLbl = UILabel(frame: CGRectMake(6, 25, (screenWidth - 20), 20))
        biinieNameLbl!.font = UIFont(name: "Lato-Regular", size: 22)
        biinieNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.firstName!) \(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)"
        biinieNameLbl!.textColor = UIColor.biinColor()
        biinieNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(biinieNameLbl!)
        
        //biinieUserNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 50), (headerWidth - 95), 14))
        biinieUserNameLbl = UILabel(frame: CGRectMake(6, 45, (screenWidth - 20), 14))
        biinieUserNameLbl!.font = UIFont(name: "Lato-Light", size: 12)
        biinieUserNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.biinName!)"
        biinieUserNameLbl!.textColor = UIColor.appTextColor()
        biinieUserNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(biinieUserNameLbl!)
        */
        
        ypos = SharedUIManager.instance.siteView_headerHeight
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
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
        
        if state!.stateType == BNStateType.MainViewContainerState
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
        delegate!.hideNotificationsView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
    
    func addNotifications(){
        /*
        if notifications.count > 0 {
            for value in notifications {
                value.removeFromSuperview()
            }
            
            notifications.removeAll(keepCapacity: false)
        }

        var ypos:CGFloat = 5
        var height:CGFloat = 60
        
        BNAppSharedManager.instance.notificationManager.notifications = sorted(BNAppSharedManager.instance.notificationManager.notifications){ $0.identifier > $1.identifier }
        
        
        for value in BNAppSharedManager.instance.notificationManager.notifications {
            
            //if notifications[key] == nil {
                var notification = NotificationsView_Notification(frame: CGRectMake(5, ypos, (SharedUIManager.instance.screenWidth - 10), height), father: self, notification: value)
                notification.delegate = self
                self.scroll!.addSubview(notification)
                self.notifications.append(notification)
                
                ypos += height
                ypos += 5
            //}
        }
        
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
*/
    }
    
    
    func resizeScrollOnRemoved(identifier: Int) {
        
        //BNAppSharedManager.instance.notificationManager.removeNotification(identifier)
        
        var startPosition = 0
        for var i = 0; i < notifications.count; i++ {
            if notifications[i].notification!.identifier == identifier {
                startPosition = i
                notifications[i].removeFromSuperview()
                notifications.removeAtIndex(i)
            }
        }
        
        //var width:CGFloat = (SharedUIManager.instance.screenWidth - 10)
        let height:CGFloat = 65
        var ypos:CGFloat = (height * CGFloat(startPosition)) + 5
        
        for var i = startPosition; i < notifications.count; i++ {
            UIView.animateWithDuration(0.2, animations: {()->Void in
                self.notifications[i].frame.origin.y = ypos
            })
            
            ypos += height
        }
        
        ypos += 5
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)

    }
    
    
    //func resizeScrollOnRemoved(identifier:Int) {
       /*
        var startPosition = 0
        
        for var i = 0; i < elements!.count; i++ {
            if elements![i].header!.elementPosition! == view.header!.elementPosition! {
                startPosition = i
                elements!.removeAtIndex(i)
            }
        }
        
        var width:CGFloat = (SharedUIManager.instance.miniView_width + spacer)
        var xpos:CGFloat = (width * CGFloat(startPosition)) + spacer
        
        for var i = startPosition; i < elements!.count; i++ {
            UIView.animateWithDuration(0.2, animations: {()->Void in
                self.elements![i].frame.origin.x = xpos
            })
            
            xpos += SharedUIManager.instance.miniView_width + spacer
        }
        
        xpos += spacer
        */
        //        if site!.loyalty!.isSubscribed {
        //            //Add game view
        //            gameView = SiteView_Showcase_Game(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height + 10), father: self, showcase: showcase!, animatedCircleColor: UIColor.biinColor())
        //            scroll!.addSubview(gameView!)
        //            xpos += SharedUIManager.instance.screenWidth
        //        } else  {
        //            joinView = SiteView_Showcase_Join(frame: CGRectMake(xpos, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.miniView_height + 10), father: self, showcase: showcase!)
        //            scroll!.addSubview(joinView!)
        //            xpos += SharedUIManager.instance.screenWidth
        //        }
        
//        scroll!.contentSize = CGSizeMake(xpos, 0)

        
    //}

    
}

@objc protocol NotificationsView_Delegate:NSObjectProtocol {
    optional func hideNotificationsView(view:NotificationsView)
}
