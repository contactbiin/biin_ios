//  LoadingViewController.swift
//  biin
//  Created by Esteban Padilla on 1/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import UIKit

class LoadingViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {

    var loadingView:LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        println("LoadingViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        BNAppSharedManager.instance.IS_APP_ON_MAIN_VIEW = false
//        BNAppSharedManager.instance.dataManager.requestInitialData()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

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
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }

    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
        
        
        if BNAppSharedManager.instance.IS_DEVELOPMENT_BUILD {
            
            var developmentView = DevelopmentView(frame:CGRectMake(0, 20, SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight - 20)), viewController:self)
            self.view.addSubview(developmentView)
            
//            if value {
//
//                UIView.animateWithDuration(0.5, animations: {()-> Void in
//                    self.loadingView!.loadingLbl!.alpha = 0
//                    self.enterBtn!.alpha = 1
//                    self.addActionBtn!.alpha = 1
//                    self.addSiteNeighbors!.alpha = 1
//                    self.addLocalNotification!.alpha = 1
//                    self.removeLocalNotification!.alpha = 1
//                })
//            } else {
//                self.enterBtn!.alpha = 0
//                self.addActionBtn!.alpha = 0
//            }
        } else  {
            var vc = MainViewController()
            vc.initViewController(self.view.frame)
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        loadingView!.progressView!.setProgress(value, animated: true)
    }

}

