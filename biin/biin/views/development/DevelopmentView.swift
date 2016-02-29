//  DevelopmentView.swift
//  biin
//  Created by Esteban Padilla on 8/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class DevelopmentView:UIView {
    
    var viewController:UIViewController?

    var developmentLbl:UILabel?

    ///Switches
    var isProductionBD:UISwitch?
    var isDemoBD:UISwitch?
    var isQABD:UISwitch?
    var isDevelopmentBD:UISwitch?
    
    ///Buttons
    var clearUserBtn:UIButton?
    var enterBtn:UIButton?
    var addActionBtn:UIButton?
    var resetNotification:UIButton?
    
    var didSomethingChanged = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, viewController:UIViewController) {
        self.init(frame: frame)
        
        self.viewController = viewController
        self.backgroundColor = UIColor.appMainColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        let screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight

        var ypos:CGFloat = 10
//        let xpos:CGFloat = 10
        
//        developmentLbl = UILabel(frame: CGRect(x:xpos, y:ypos, width:frame.width, height:20))
//        developmentLbl!.font = UIFont(name: "Lato-Black", size: 17)
//        developmentLbl!.textColor = UIColor.appTextColor()
//        developmentLbl!.textAlignment = NSTextAlignment.Left
//        developmentLbl!.numberOfLines = 0
//        developmentLbl!.text = "Development Build"
//        self.addSubview(developmentLbl!)
//        ypos += 50
        
        //Switch buttons
//        isProductionBD = UISwitch(frame: CGRectMake(10, (ypos - 7), screenWidth, 30))
//        isProductionBD!.setOn(BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE, animated: false)
//        isProductionBD!.addTarget(self, action: "isProductionBDAction:", forControlEvents: UIControlEvents.ValueChanged)
//        self.addSubview(isProductionBD!)

//        var label = UILabel(frame: CGRect(x:70, y:ypos, width:frame.width, height:15))
//        label.font = UIFont(name: "Lato-Light", size: 14)
//        label.textColor = UIColor.appTextColor()
//        label.textAlignment = NSTextAlignment.Left
//        label.numberOfLines = 0
//        label.text = "Use production database."
//        self.addSubview(label)
//        ypos += 35
//        
//        isDemoBD = UISwitch(frame: CGRectMake(10, (ypos - 7), screenWidth, 30))
//        isDemoBD!.setOn(BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE, animated: false)
//        isDemoBD!.addTarget(self, action: "isDemoBDAction:", forControlEvents: UIControlEvents.ValueChanged)
//        self.addSubview(isDemoBD!)
        
//        label = UILabel(frame: CGRect(x:70, y:ypos, width:frame.width, height:15))
//        label.font = UIFont(name: "Lato-Light", size: 14)
//        label.textColor = UIColor.appTextColor()
//        label.textAlignment = NSTextAlignment.Left
//        label.numberOfLines = 0
//        label.text = "Use demo data base."
//        self.addSubview(label)
//        ypos += 35
        
//        isQABD = UISwitch(frame: CGRectMake(10, (ypos - 7), screenWidth, 30))
//        isQABD!.setOn(BNAppSharedManager.instance.settings!.IS_QA_DATABASE, animated: false)
//        isQABD!.addTarget(self, action: "isQABDAction:", forControlEvents: UIControlEvents.ValueChanged)
//        self.addSubview(isQABD!)
//        
//        label = UILabel(frame: CGRect(x:70, y:ypos, width:frame.width, height:15))
//        label.font = UIFont(name: "Lato-Light", size: 14)
//        label.textColor = UIColor.appTextColor()
//        label.textAlignment = NSTextAlignment.Left
//        label.numberOfLines = 0
//        label.text = "Use QA database."
//        self.addSubview(label)
//        ypos += 35
//        
//        isDevelopmentBD = UISwitch(frame: CGRectMake(10, (ypos - 7), screenWidth, 30))
//        isDevelopmentBD!.setOn(BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE, animated: false)
//        isDevelopmentBD!.addTarget(self, action: "isDevelopmentBDAction:", forControlEvents: UIControlEvents.ValueChanged)
//        self.addSubview(isDevelopmentBD!)
//        
//        label = UILabel(frame: CGRect(x:70, y:ypos, width:frame.width, height:15))
//        label.font = UIFont(name: "Lato-Light", size: 14)
//        label.textColor = UIColor.appTextColor()
//        label.textAlignment = NSTextAlignment.Left
//        label.numberOfLines = 0
//        label.text = "Use development database."
//        self.addSubview(label)
//        ypos += 35
        
//        let isUsingCache = UISwitch(frame: CGRectMake(10, (ypos - 7), screenWidth, 30))
//        isUsingCache.setOn(BNAppSharedManager.instance.settings!.IS_USING_CACHE, animated: false)
//        isUsingCache.addTarget(self, action: "isUsingCacheAction:", forControlEvents: UIControlEvents.ValueChanged)
//        self.addSubview(isUsingCache)
//        
//        label = UILabel(frame: CGRect(x:70, y:ypos, width:frame.width, height:15))
//        label.font = UIFont(name: "Lato-Light", size: 14)
//        label.textColor = UIColor.appTextColor()
//        label.textAlignment = NSTextAlignment.Left
//        label.numberOfLines = 0
//        label.text = "Use cache for downloaded data."
//        self.addSubview(label)
//        ypos += 50

        enterBtn = UIButton(frame: CGRectMake(0, ypos, screenWidth, 60))
        enterBtn!.backgroundColor = UIColor.appBackground()
        enterBtn!.setTitle("Start", forState: UIControlState.Normal)
        enterBtn!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        enterBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 20)
//        enterBtn!.addTarget(self, action: "enterBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(enterBtn!)
//        ypos += 65
        
        clearUserBtn = UIButton(frame: CGRectMake(0, ypos, screenWidth, 60))
        clearUserBtn!.backgroundColor = UIColor.appBackground()
        clearUserBtn!.setTitle("Delete User", forState: UIControlState.Normal)
        clearUserBtn!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        clearUserBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 20)
        clearUserBtn!.addTarget(self, action: "clearUserBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(clearUserBtn!)
//        ypos += 65
        
        addActionBtn = UIButton(frame: CGRectMake(0, ypos, screenWidth, 60))
        addActionBtn!.backgroundColor = UIColor.appBackground()
        addActionBtn!.setTitle("Clear Notificacions", forState: UIControlState.Normal)
        addActionBtn!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        addActionBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 20)
        addActionBtn!.addTarget(self, action: "addActionBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(addActionBtn!)
//        ypos += 65
        
        resetNotification = UIButton(frame: CGRectMake(10, ypos, (screenWidth - 20), 60))
        resetNotification!.backgroundColor = UIColor.biinOrange()
        resetNotification!.setTitle("Reset Notification", forState: UIControlState.Normal)
        resetNotification!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        resetNotification!.titleLabel!.font = UIFont(name: "Lato-Black", size: 20)
        resetNotification!.addTarget(self, action: "resetNotificationAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(resetNotification!)
        ypos += 65
        
//        label = UILabel(frame: CGRect(x:25, y:ypos, width:(frame.width - 50), height:30))
//        label.text = "** If you make any changes you will need to relaunch the application."
//        label.font = UIFont(name: "Lato-Light", size: 14)
//        label.textColor = UIColor.bnRed()
//        label.textAlignment = NSTextAlignment.Center
//        label.numberOfLines = 0
//        label.sizeToFit()
//        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func isProductionBDAction(sender:UISwitch) {
        BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE = true
        BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_QA_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE = false
        
        isDemoBD!.setOn(false, animated: true)
        isQABD!.setOn(false, animated: true)
        isDevelopmentBD!.setOn(false, animated: true)
        
        BNAppSharedManager.instance.saveSettings()

    }
    
    func isDemoBDAction(sender:UISwitch) {
        BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE = true
        BNAppSharedManager.instance.settings!.IS_QA_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE = false
        
        isProductionBD!.setOn(false, animated: true)
        isQABD!.setOn(false, animated: true)
        isDevelopmentBD!.setOn(false, animated: true)
        
        BNAppSharedManager.instance.saveSettings()

    }
    
    func isQABDAction(sender:UISwitch) {
        BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_QA_DATABASE = true
        BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE = false
        
        isProductionBD!.setOn(false, animated: true)
        isDemoBD!.setOn(false, animated: true)
        isDevelopmentBD!.setOn(false, animated: true)
        
        BNAppSharedManager.instance.saveSettings()

    }
    
    func isDevelopmentBDAction(sender:UISwitch) {
        BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_QA_DATABASE = false
        BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE = true
        
        isProductionBD!.setOn(false, animated: true)
        isDemoBD!.setOn(false, animated: true)
        isQABD!.setOn(false, animated: true)
        
        BNAppSharedManager.instance.saveSettings()
    }
    
    func isUsingCacheAction(sender:UISwitch) {
//        BNAppSharedManager.instance.settings!.IS_USING_CACHE = sender.on
//        BNAppSharedManager.instance.saveSettings()
    }
    
    
    func clearUserBtnAction(sender:UIButton){
        BNAppSharedManager.instance.dataManager.bnUser!.clear()
        BNAppSharedManager.instance.settings!.clear()
    }
    
    func enterBtnAction(sender: UIButton!){
//        let vc = MainViewController()
//        vc.initViewController(self.frame)
//        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//        self.viewController!.presentViewController(vc, animated: true, completion: nil)
    }
    
    func addActionBtnAction(sender:UIButton!){
        //BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did: BiinieActionType.BIINED_ELEMENT, to: "55db879e2fde320300fb9321")
        
        BNAppSharedManager.instance.notificationManager.clear()
    }
    
    func resetNotificationAction(sender:UIButton){
        BNAppSharedManager.instance.notificationManager.resetAllNotifications()
    }
}
