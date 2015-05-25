//  UserOnboardingViewController.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingViewController:UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate, UserOnboardingView_Categories_Delegate {
    
    var slide1:UserOnboardingView_Slide?
    var slide2:UserOnboardingView_Slide?
    var slide3:UserOnboardingView_Slide?
    var categoriesView:UserOnboardingView_Categories?
    var scroll:UIScrollView?
    var fadeView:UIView?
    
    var alert:BNUIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        var xpos:CGFloat = 0
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight

        scroll = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scroll!.pagingEnabled = true
        scroll!.bounces = false
        self.view.addSubview(scroll!)
        
        slide1 = UserOnboardingView_Slide(frame: CGRectMake(xpos, 0, screenWidth, screenHeight), title: "PAGE 1")
        scroll!.addSubview(slide1!)
        xpos += screenWidth
        
        slide2 = UserOnboardingView_Slide(frame: CGRectMake(xpos, 0, screenWidth, screenHeight), title: "PAGE 2")
        scroll!.addSubview(slide2!)
        xpos += screenWidth
        
        slide3 = UserOnboardingView_Slide(frame: CGRectMake(xpos, 0, screenWidth, screenHeight), title: "PAGE 3")
        scroll!.addSubview(slide3!)
        xpos += screenWidth
        
        categoriesView = UserOnboardingView_Categories(frame:CGRectMake(xpos, 0, screenWidth, screenHeight))
        scroll!.addSubview(categoriesView!)
        categoriesView!.delegate = self
        xpos += screenWidth
        
        scroll!.contentSize = CGSize(width: xpos, height: screenHeight)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewController(frame:CGRect){
        
        //        mainView = MainView(frame: frame, father:nil, rootViewController: self)
        //        mainView!.delegate = self
        //        self.view.addSubview(self.mainView!)
        //
        //        fadeView = UIView(frame: frame)
        //        fadeView!.backgroundColor = UIColor.blackColor()
        //        fadeView!.alpha = 0
        //        fadeView!.userInteractionEnabled = false
        //        self.view.addSubview(fadeView!)
        //
        //        menuView = MenuView(frame: CGRectMake(-140, 0, 140, frame.height))
        //        menuView!.delegate = self
        //        self.view.addSubview(menuView!)
        //
        //        var hideMenuSwipe = UISwipeGestureRecognizer(target: self, action: "hideMenu:")
        //        hideMenuSwipe.direction = UISwipeGestureRecognizerDirection.Left
        //        menuView!.addGestureRecognizer(hideMenuSwipe)
        //
        //        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        //        showMenuSwipe!.edges = UIRectEdge.Bottom
        //        self.view.addGestureRecognizer(showMenuSwipe!)
        
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController ) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {

    }
    
    func showProgress(view: UIView) {
        if (alert?.isOn != nil) {
            alert!.hide()
        }
        
        showProgressView()
    }
    
    func showProgressView(){
        alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait, text:"Please wait a moment!")
        self.view.addSubview(alert!)
        alert!.show()
    }
    
    func showSelectCategories(view: UIView) {
        
    }
    
    func startOnBiin(view: UIView) {
//        var vc = MainViewController()
//        vc.initViewController(self.view.frame)
//        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func manager(manager: BNNetworkManager!, didReceivedCategoriesSavedConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    var vc = LoadingViewController()
                    BNAppSharedManager.instance.dataManager.requestInitialData()
                    vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
            
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials, text:response!.responseDescription!)
                    self.view.addSubview(self.alert!)
                    self.alert!.show()
                })
            }
        }

    }

}