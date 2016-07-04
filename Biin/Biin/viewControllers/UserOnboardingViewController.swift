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
        UIApplication.sharedApplication().statusBarHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
//        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight

        var xpos:CGFloat = ((screenHeight - screenWidth) / 2) * -1
        //var ypos:CGFloat = ((screenHeight - (330 + SharedUIManager.instance.signupView_spacer + SharedUIManager.instance.signupView_spacer )) / 2)
        
//        let image = UIImageView(image: UIImage(named: "landing.jpg"))
//        image.frame = CGRectMake(xpos, 0, screenHeight, screenHeight)
//        self.view.addSubview(image)
        
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
//        visualEffectView.alpha = 1
//        visualEffectView.frame = self.view.bounds
//        self.view.addSubview(visualEffectView)
        
        
        xpos = 0
        scroll = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scroll!.layer.masksToBounds = true
        scroll!.pagingEnabled = true
        scroll!.bounces = false
        scroll!.backgroundColor = UIColor.clearColor()
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        self.view.addSubview(scroll!)
        
        slide1 = UserOnboardingView_Slide(frame: CGRectMake(xpos, 0, screenWidth, screenHeight), title:NSLocalizedString("OnboardingTitle1", comment: "OnboardingTitle1"), text:NSLocalizedString("OnboardingText1", comment: "OnboardingText1"), imageString:"onbordingImage1.jpg")
        scroll!.addSubview(slide1!)
        xpos += screenWidth
        
        slide2 = UserOnboardingView_Slide(frame: CGRectMake(xpos, 0, screenWidth, screenHeight), title:NSLocalizedString("OnboardingTitle2", comment: "OnboardingTitle2"), text:NSLocalizedString("OnboardingText2", comment: "OnboardingText2"), imageString:"onbordingImage2.jpg")
        scroll!.addSubview(slide2!)
        xpos += screenWidth
        
        slide3 = UserOnboardingView_Slide(frame: CGRectMake(xpos, 0, screenWidth, screenHeight), title:NSLocalizedString("OnboardingTitle3", comment: "OnboardingTitle3"), text:NSLocalizedString("OnboardingText3", comment: "OnboardingText3"), imageString:"onbordingImage3.jpg")
        scroll!.addSubview(slide3!)
        xpos += screenWidth
        
        categoriesView = UserOnboardingView_Categories(frame:CGRectMake(xpos, 0, screenWidth, screenHeight))
        scroll!.addSubview(categoriesView!)
        categoriesView!.delegate = self
        xpos += screenWidth
        
        scroll!.contentSize = CGSize(width: xpos, height: (screenHeight - 25))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initViewController(frame:CGRect){
        
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController ) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    //BNNetworkManagerDelegate Methods
    func didReceivedAllInitialData() { }
    
    func showProgress(view: UIView) {
        if (alert?.isOn != nil) {
            alert!.hide()
        }
        
        showProgressView()
    }
    
    func showProgressView(){
        alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait )
        self.view.addSubview(alert!)
        alert!.show()
    }
    
    func showSelectCategories(view: UIView) {
        
    }
    
    func startOnBiin(view: UIView) {

        let vc = LoadingViewController()
        //                    BNAppSharedManager.instance.dataManager.requestBiinieInitialData()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
    func manager(manager: BNNetworkManager!, didReceivedCategoriesSavedConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    let vc = LoadingViewController()
//                    BNAppSharedManager.instance.dataManager.requestBiinieInitialData()
                    vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
            
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials )
                    self.view.addSubview(self.alert!)
                    self.alert!.showAndHide()
                })
            }
        }
    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        
    }
}