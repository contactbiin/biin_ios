//  VersionCheckViewController.swift
//  biin
//  Created by Esteban Padilla on 6/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.


import UIKit

class VersionCheckViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {
    
    var loadingView:LoadingView?
    
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
        
        
//        let screenWidth = SharedUIManager.instance.screenWidth
//        let screenHeight = SharedUIManager.instance.screenHeight
        
//        loadingView = LoadingView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
//        self.view.addSubview(loadingView!)
    }
    
    
    
    func continueAfterVersionCheck() {
        if BNAppSharedManager.instance.dataManager.isUserLoaded {
            let vc = LoadingViewController()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            self.presentViewController(vc, animated: true, completion: nil)
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
    func manager(manager: BNNetworkManager!, didReceivedVersionStatus needsUpdate: Bool) {
        continueAfterVersionCheck()
    }
    
    
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
//        loadingView!.hideProgressView()
//        let vc = MainViewController()
//        vc.initViewController(self.view.frame)
//        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
     
    }
    
}

