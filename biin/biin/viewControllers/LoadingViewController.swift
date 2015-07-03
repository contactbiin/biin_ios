//  LoadingViewController.swift
//  biin
//  Created by Esteban Padilla on 1/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import UIKit

class LoadingViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {

    var enterBtn:UIButton?
    var loadingView:LoadingView?
    
    var clearUserBtn:UIButton?

    var addActionBtn:UIButton?
    
    var addSiteNeighbors:UIButton?

    var addLocalNotification:UIButton?
    var removeLocalNotification:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        println("LoadingViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
//        BNAppSharedManager.instance.dataManager.requestInitialData()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        loadingView = LoadingView(frame: CGRectMake(0, 20, screenWidth, screenHeight))
        self.view.addSubview(loadingView!)
        
        var version = UILabel(frame: CGRectMake(0, (screenHeight - 40), screenWidth, 20))
        version.font = UIFont(name: "Lato-Light", size: 18)
        version.textColor = UIColor.appTextColor()
        version.textAlignment = NSTextAlignment.Center
        var versionTxt = NSLocalizedString("Version", comment: "the version title")
        version.text = "\( versionTxt ) \(BNAppSharedManager.instance.version)"
        self.view.addSubview(version)
        
        enterBtn = UIButton(frame: CGRectMake(0, (screenHeight - 115), screenWidth, 60))
        enterBtn!.backgroundColor = UIColor.appButtonColor_Disable()
        enterBtn!.setTitle(NSLocalizedString("Start", comment: "the Start button title"), forState: UIControlState.Normal)
        enterBtn!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        enterBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 20)
        enterBtn!.addTarget(self, action: "enterBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        enterBtn!.alpha = 0
        self.view.addSubview(enterBtn!)

        clearUserBtn = UIButton(frame: CGRectMake(0, (screenHeight - 110), screenWidth, 60))
        clearUserBtn!.backgroundColor = UIColor.whiteColor()
        clearUserBtn!.setTitle(NSLocalizedString("DeleteUser", comment: "the DeleteUser button title"), forState: UIControlState.Normal)
        clearUserBtn!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        clearUserBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 20)
        clearUserBtn!.addTarget(self, action: "clearUserBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        clearUserBtn!.alpha = 1
        //self.view.addSubview(clearUserBtn!)

        addActionBtn = UIButton(frame: CGRectMake(10, 30, 150, 50))
        addActionBtn!.backgroundColor = UIColor.bnRed()
        addActionBtn!.setTitle(NSLocalizedString("AddAction", comment: "the AddAction button title"), forState: UIControlState.Normal)
        addActionBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 14)
        addActionBtn!.addTarget(self, action: "addActionBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addActionBtn!.alpha = 0
        self.view.addSubview(addActionBtn!)
        
        addSiteNeighbors = UIButton(frame: CGRectMake(10, 30, 170, 50))
        addSiteNeighbors!.backgroundColor = UIColor.biinColor()
        addSiteNeighbors!.setTitle("Start Site Monitoring", forState: UIControlState.Normal)
        addSiteNeighbors!.titleLabel!.font = UIFont(name: "Lato-Black", size: 14)
        addSiteNeighbors!.addTarget(self, action: "addSiteNeighborsAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addSiteNeighbors!.alpha = 0
        //self.view.addSubview(addSiteNeighbors!)
        
        addLocalNotification = UIButton(frame: CGRectMake(10, 90, 170, 50))
        addLocalNotification!.backgroundColor = UIColor.bnGreen()
        addLocalNotification!.setTitle("Send Biinie Actions", forState: UIControlState.Normal)
        addLocalNotification!.titleLabel!.font = UIFont(name: "Lato-Black", size: 14)
        addLocalNotification!.addTarget(self, action: "addLocalNotificationAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addLocalNotification!.alpha = 0
        self.view.addSubview(addLocalNotification!)

        removeLocalNotification = UIButton(frame: CGRectMake(190, 90, 100, 50))
        removeLocalNotification!.backgroundColor = UIColor.bnRed()
        removeLocalNotification!.setTitle("Remove all", forState: UIControlState.Normal)
        removeLocalNotification!.titleLabel!.font = UIFont(name: "Lato-Black", size: 14)
        removeLocalNotification!.addTarget(self, action: "removeLocalNotificationAction:", forControlEvents: UIControlEvents.TouchUpInside)
        removeLocalNotification!.alpha = 0
        //self.view.addSubview(removeLocalNotification!)

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearUserBtnAction(sender:UIButton){
        BNAppSharedManager.instance.dataManager.bnUser!.clear()
    }
    
    func enterBtnAction(sender: UIButton!){
        
        var vc = MainViewController()
        vc.initViewController(self.view.frame)
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func addActionBtnAction(sender: UIButton!){
        
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN_REGION, to: "04eb8e15-2ded-4081-b92f-cf745cfc1e60")
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN_REGION, to: "04eb8e15-2ded-4081-b92f-cf745cfc1e60")
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.EXIT_BIIN_REGION, to: "04eb8e15-2ded-4081-b92f-cf745cfc1e60")
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN, to: "04eb8e15-2ded-4081-b92f-cf745cfc1e60")

        BNAppSharedManager.instance.dataManager.bnUser!.save()
        
        //BNAppSharedManager.instance.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
    }
    
    func addSiteNeighborsAction(sender:UIButton){
        //BNAppSharedManager.instance.dataManager.setSiteNeighbors()
        //BNAppSharedManager.instance.dataManager.startCommercialBiinMonitoring()
    }
    
    
    var notificationCounter = 0
    func addLocalNotificationAction(sender:UIButton){
//        notificationCounter++
//        BNAppSharedManager.instance.notificationManager.addLocalNotification("\(notificationCounter)", text: "Just a local notification number: \(notificationCounter)")
        BNAppSharedManager.instance.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
    }
    
    func removeLocalNotificationAction(sender:UIButton){
        notificationCounter = 0
        BNAppSharedManager.instance.notificationManager.clearLocalNotifications()
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }

    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
        
        if value {
            UIView.animateWithDuration(0.5, animations: {()-> Void in
                self.loadingView!.loadingLbl!.alpha = 0
                self.enterBtn!.alpha = 1
                self.addActionBtn!.alpha = 1
                self.addSiteNeighbors!.alpha = 1
                self.addLocalNotification!.alpha = 1
                self.removeLocalNotification!.alpha = 1
            })
        } else {
            self.enterBtn!.alpha = 0
            self.addActionBtn!.alpha = 0
        }
    }
    
    

}

