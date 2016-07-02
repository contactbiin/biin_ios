//  LoyaltiesView.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoyaltiesView: BNView {
    
    var delegate:LoyaltiesView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
//    var fade:UIView?
    
    var biinieAvatar:BNUIImageView?
    var biinieNameLbl:UILabel?
    var biinieUserNameLbl:UILabel?
    
    var scroll:UIScrollView?
    
    var loyalties = Array<LoyaltiesMiniView>()
    
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
        title!.text = NSLocalizedString("Loyalty", comment: "Loyalty")
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 10, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
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
        
//        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
//        fade!.backgroundColor = UIColor.blackColor()
//        fade!.alpha = 0
//        self.addSubview(fade!)
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
        delegate!.hideLoyaltiesView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
    
    func updateLoyaltiesMiniViews(){
        
        if loyalties.count > 0 {
            for value in loyalties {
                value.removeFromSuperview()
            }
            
            loyalties.removeAll(keepCapacity: false)
        }
        
        var ypos:CGFloat = 5
        let height:CGFloat = 100
        
        for (_, organization) in BNAppSharedManager.instance.dataManager.organizations {

            let loyaltiesMiniView = LoyaltiesMiniView(frame: CGRectMake(5, ypos, (SharedUIManager.instance.screenWidth - 10), height), father: self, organization: organization)
            self.scroll!.addSubview(loyaltiesMiniView)
            self.loyalties.append(loyaltiesMiniView)
            
            ypos += height
            ypos += 5
            //}
        }
        
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
    }
    

    
    
}

@objc protocol LoyaltiesView_Delegate:NSObjectProtocol {
    optional func hideLoyaltiesView(view:LoyaltiesView)
}

