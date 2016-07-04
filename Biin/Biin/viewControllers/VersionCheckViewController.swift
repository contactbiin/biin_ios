//  VersionCheckViewController.swift
//  biin
//  Created by Esteban Padilla on 6/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.


import UIKit
import FBSDKLoginKit

class VersionCheckViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {
    
    var versionCheckView:VersionCheckView?
    var facebookBtn:FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSLog("LoadingViewController()")
        
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
//        facebookBtn = FBSDKLoginButton()
//        self.view.addSubview(facebookBtn!)
//        facebookBtn!.center = self.view!.center
//        //facebookBtn!.readPermissions = ["public_profile",  "publish_actions", "email", "user_friends", "user_birthday"]
//        facebookBtn!.layer.cornerRadius = 2
//        //        facebookBtn!.delegate = self
//        facebookBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
//        
//        
//        
//        
        
        versionCheckView = VersionCheckView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.view.addSubview(versionCheckView!)
    }
    
    
    
    func continueAfterVersionCheck() {
        
        if BNAppSharedManager.instance.dataManager.isUserLoaded {
            let vc = LoadingViewController()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            self.presentViewController(vc, animated: false, completion: nil)
        } else {
            let vc = SingupViewController()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    //BNNetworkManagerDelegate Methods
    func didReceivedVersionStatus() {
        continueAfterVersionCheck()
    }
    
    func didReceivedAllInitialData() { }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
     
    }
    
}

