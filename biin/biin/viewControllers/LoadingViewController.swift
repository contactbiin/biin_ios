//  LoadingViewController.swift
//  biin
//  Created by Esteban Padilla on 1/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import UIKit

class LoadingViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {

    var loadingView:LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //NSLog("LoadingViewController()")
        
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        self.view.backgroundColor = UIColor.clearColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        self.setNeedsStatusBarAppearanceUpdate()
        
        //self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight

        loadingView = LoadingView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.view.addSubview(loadingView!)
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
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
        
        
        print("FLOW 6")
        //BNAppSharedManager.instance.dataManager.addHighlights()
     
        //NSLog("BIIN - didReceivedAllInitialData()")
        //NSLog("BIIN - \(BNAppSharedManager.instance.dataManager.sites_ordered.count)")
        //checkAppState()
        
        
//        if BNAppSharedManager.instance.IS_DEVELOPMENT_BUILD {
//            loadingView!.hideProgressView()
//            let developmentView = DevelopmentView(frame:CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), viewController:self)
//            self.view.addSubview(developmentView)
//        } else  {
            loadingView!.hideProgressView()
            let vc = MainViewController()
            vc.initViewController(self.view.frame)
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            self.presentViewController(vc, animated: true, completion: nil)
//        }
    }
    
//    func checkAppState(){
//        switch  UIApplication.sharedApplication().applicationState {
//        case .Active:
//            NSLog("BIIN - didFinishLaunchingWithOptions - ACTIVE")
//            BNAppSharedManager.instance.IS_APP_UP = true
//            BNAppSharedManager.instance.IS_APP_DOWN = false
//            break
//        case .Background, .Inactive:
//            NSLog("BIIN - didFinishLaunchingWithOptions - BACKGROUND")
//            BNAppSharedManager.instance.IS_APP_UP = false
//            BNAppSharedManager.instance.IS_APP_DOWN = true
//            break
//
////        default:
////            NSLog("BIIN - didFinishLaunchingWithOptions - DEFAULT")
////            break
//        }
//    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        loadingView!.updateProgressView(value)
    }
}

