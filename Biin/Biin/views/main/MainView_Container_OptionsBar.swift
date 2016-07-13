//  MainView_Container_OptionsBar.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainView_Container_OptionsBar: BNView {

    var showMenuBtn:BNUIButton_OptionBar?
    var showGiftsBtn:BNUIButton_OptionBar?
    var showGiftsBtn_Badge:BNBadgeView?
    
    var showNotificationsBtn:BNUIButton_OptionBar?
    var showNotificationsBtn_Badge:BNBadgeView?
//    var testBtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
//        self.layer.masksToBounds = true
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)

        addButtons()
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
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
    func addButtons(){
        
        var xpos:CGFloat = 15
        let ypos:CGFloat = 7
        showMenuBtn = BNUIButton_OptionBar(frame: CGRectMake(xpos, ypos, 30, 30), text: "Menu", iconType: BNIconType.menuMedium)
        showMenuBtn!.addTarget(father, action:#selector((father as! MainView_Container_All).showMenuBtnActon(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(showMenuBtn!)

        xpos += 75
        showGiftsBtn = BNUIButton_OptionBar(frame: CGRectMake(xpos, ypos, 30, 30), text: "Gifts", iconType: BNIconType.gift)
        showGiftsBtn!.addTarget(father, action:#selector((father as! MainView_Container_All).showGiftsBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(showGiftsBtn!)
        
        showGiftsBtn_Badge = BNBadgeView(position: CGPoint(x:15, y: -2), size: 20)
        showGiftsBtn!.addSubview(showGiftsBtn_Badge!)
        showGiftsBtn_Badge!.update(BNAppSharedManager.instance.dataManager!.biinie!.newGiftCounter)
        showGiftsBtn_Badge!.resignFirstResponder()
        
        xpos += 75
        showNotificationsBtn = BNUIButton_OptionBar(frame: CGRectMake(xpos, ypos, 30, 30), text: "Notifications", iconType: BNIconType.notification)
        showNotificationsBtn!.addTarget(father, action:#selector((father as! MainView_Container_All).showGiftsBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(showNotificationsBtn!)
        
        showNotificationsBtn_Badge = BNBadgeView(position: CGPoint(x:15, y: -2), size: 20)
        showNotificationsBtn!.addSubview(showNotificationsBtn_Badge!)
        showNotificationsBtn_Badge!.update(0)
    }
    
    override func clean(){
        showMenuBtn?.removeFromSuperview()
        showMenuBtn = nil
        showGiftsBtn?.removeFromSuperview()
        showGiftsBtn = nil
        showNotificationsBtn?.removeFromSuperview()
        showNotificationsBtn = nil
    }
    
    func updateGiftCounter(value:Int) {
        showGiftsBtn_Badge!.update(value)
    }
    
    func updateNotificationCounter(value:Int) {
        showNotificationsBtn_Badge!.update(value)
    }
}

@objc protocol MainView_Container_OptionsBar_Delegate:NSObjectProtocol {
    optional func updateCategoryStatus(view:MainView_Container_OptionsBar,  position:CGFloat)
}
