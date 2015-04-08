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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("LoadingViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.dataManager.requestInitialData()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.biinColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var version = UILabel(frame: CGRectMake(0, (screenHeight - 40), screenWidth, 20))
        version.font = UIFont(name: "Lato-Light", size: 18)
        version.textColor = UIColor.whiteColor()
        version.textAlignment = NSTextAlignment.Center
        version.text = "Version \(BNAppSharedManager.instance.version)"
        self.view.addSubview(version)
        
        enterBtn = UIButton(frame: CGRectMake(0, (screenHeight - 175), screenWidth, 60))
        enterBtn!.backgroundColor = UIColor.whiteColor()
        enterBtn!.setTitle("Enter", forState: UIControlState.Normal)
        enterBtn!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        enterBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 20)
        enterBtn!.addTarget(self, action: "enterBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        enterBtn!.alpha = 0
        self.view.addSubview(enterBtn!)
        
        
        clearUserBtn = UIButton(frame: CGRectMake(0, (screenHeight - 110), screenWidth, 60))
        clearUserBtn!.backgroundColor = UIColor.whiteColor()
        clearUserBtn!.setTitle("Clear user", forState: UIControlState.Normal)
        clearUserBtn!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        clearUserBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 20)
        clearUserBtn!.addTarget(self, action: "clearUserBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        clearUserBtn!.alpha = 1
        self.view.addSubview(clearUserBtn!)

        addActionBtn = UIButton(frame: CGRectMake(0, (screenHeight - 240), screenWidth, 60))
        addActionBtn!.backgroundColor = UIColor.whiteColor()
        addActionBtn!.setTitle("Add Action", forState: UIControlState.Normal)
        addActionBtn!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        addActionBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 20)
        addActionBtn!.addTarget(self, action: "addActionBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addActionBtn!.alpha = 0
        self.view.addSubview(addActionBtn!)
        
        
        loadingView = LoadingView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.view.addSubview(loadingView!)
        
        

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
        
        var action1 = BiinieAction(at: NSDate(), did: 1, to: "identifier1", toType: "1")
        var action2 = BiinieAction(at: NSDate(), did: 2, to: "identifier2", toType: "2")
        var action3 = BiinieAction(at: NSDate(), did: 3, to: "identifier3", toType: "3")
        var action4 = BiinieAction(at: NSDate(), did: 4, to: "identifier4", toType: "4")
        var action5 = BiinieAction(at: NSDate(), did: 5, to: "identifier5", toType: "5")
        var action6 = BiinieAction(at: NSDate(), did: 6, to: "identifier6", toType: "6")
        
        BNAppSharedManager.instance.dataManager.bnUser!.actions.append(action1)
        BNAppSharedManager.instance.dataManager.bnUser!.actions.append(action2)
        BNAppSharedManager.instance.dataManager.bnUser!.actions.append(action3)
        BNAppSharedManager.instance.dataManager.bnUser!.actions.append(action4)
        BNAppSharedManager.instance.dataManager.bnUser!.actions.append(action5)
        BNAppSharedManager.instance.dataManager.bnUser!.actions.append(action6)
        
        BNAppSharedManager.instance.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }

    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
        
        if value {
            UIView.animateWithDuration(0.5, animations: {()-> Void in
                self.loadingView!.alpha = 0
                self.enterBtn!.alpha = 1
                self.addActionBtn!.alpha = 1
            })
        } else {
            self.enterBtn!.alpha = 0
            self.addActionBtn!.alpha = 0
        }
    }
    
    

}

