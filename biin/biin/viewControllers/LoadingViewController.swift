//  LoadingViewController.swift
//  biin
//  Created by Esteban Padilla on 1/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import UIKit

class LoadingViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {

    var loadingView:LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NSLog("BIIN - LoadingViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
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
        
//        var bgView = UIView(frame:CGRectMake(0, 20, screenWidth, screenHeight))
//        bgView.backgroundColor = UIColor.whiteColor()
//        self.view.addSubview(bgView)
        
        loadingView = LoadingView(frame: CGRectMake(0, 20, screenWidth, screenHeight))
        self.view.addSubview(loadingView!)
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
            

            loadingView!.hideProgressView()
            
//            UIView.animateWithDuration(0.1, animations: {() -> Void in
//                self.loadingView!.alpha = 0
//
//                }, completion: {(completed:Bool)-> Void in
            
                    var developmentView = DevelopmentView(frame:CGRectMake(0, 20, SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight - 20)), viewController:self)
                    self.view.addSubview(developmentView)
                    
//            })
            
            
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
            
//            UIView.animateWithDuration(0.1, animations: {() -> Void in
//                    self.loadingView!.alpha = 0
//                
//                }, completion: {(completed:Bool)-> Void in

                    loadingView!.hideProgressView()
                    var vc = MainViewController()
                    vc.initViewController(self.view.frame)
                    vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    self.presentViewController(vc, animated: true, completion: nil)
                    
//            })

        }
    }
    
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        loadingView!.progressView!.setProgress(value, animated: true)
    }

}

