//  LoadingViewController.swift
//  biin
//  Created by Esteban Padilla on 1/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import UIKit

class LoadingViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {

    var enterBtn:UIButton?
    var loadingView:LoadingView?
    
    var clearUserBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("LoadingViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.dataManager.requestInitialData()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var version = UILabel(frame: CGRectMake(0, (screenHeight - 40), screenWidth, 20))
        version.font = UIFont(name: "Lato-Light", size: 18)
        version.textColor = UIColor.blackColor()
        version.textAlignment = NSTextAlignment.Center
        version.text = "Version \(BNAppSharedManager.instance.version)"
        self.view.addSubview(version)
        
        enterBtn = UIButton(frame: CGRectMake(0, (screenHeight - 175), screenWidth, 60))
        enterBtn!.backgroundColor = UIColor.biinColor()
        enterBtn!.setTitle("Enter", forState: UIControlState.Normal)
        enterBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        enterBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 20)
        enterBtn!.addTarget(self, action: "enterBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        enterBtn!.alpha = 0
        self.view.addSubview(enterBtn!)
        
        
        clearUserBtn = UIButton(frame: CGRectMake(0, (screenHeight - 110), screenWidth, 60))
        clearUserBtn!.backgroundColor = UIColor.bnRed()
        clearUserBtn!.setTitle("Clear user", forState: UIControlState.Normal)
        clearUserBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        clearUserBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 20)
        clearUserBtn!.addTarget(self, action: "clearUserBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        clearUserBtn!.alpha = 1
        self.view.addSubview(clearUserBtn!)
        
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
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }

    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.loadingView!.alpha = 0
            self.enterBtn!.alpha = 1
        })
    }
    
    

}

