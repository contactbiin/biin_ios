//
//  SingupViewController.swift
//  biin
//
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class SingupViewController:UIViewController, UIPopoverPresentationControllerDelegate, LoginView_Delegate, SignupView_Delegate, BNNetworkManagerDelegate {
    
    var signupView:SignupView?
    var loginView:LoginView?
    var fadeView:UIView?
    
    var alert:BNUIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SingupViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.setNeedsStatusBarAppearanceUpdate()
    
        self.becomeFirstResponder()
        
        loginView = LoginView(frame:CGRectMake(0, 25, self.view.frame.width, (self.view.frame.height - 25)))
        loginView!.layer.cornerRadius = 5
        loginView!.layer.masksToBounds = true
        loginView!.delegate = self
        self.view.addSubview(loginView!)
        
        fadeView = UIView(frame:CGRectMake(0, 25, self.view.frame.width, (self.view.frame.height - 25)))
        fadeView!.backgroundColor = UIColor.blackColor()
        fadeView!.alpha = 0
        self.view.addSubview(fadeView!)
        fadeView!.frame.origin.x = SharedUIManager.instance.screenWidth
        
        signupView = SignupView(frame:CGRectMake(0, 25, self.view.frame.width, (self.view.frame.height - 25)))
        signupView!.layer.cornerRadius = 5
        signupView!.layer.masksToBounds = true
        signupView!.delegate = self
        
        self.view.addSubview(signupView!)
        signupView!.frame.origin.x = SharedUIManager.instance.screenWidth
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initViewController(frame:CGRect){

    }
    
    func enterBtnAction(sender: UIButton!){
        let vc = UserOnboardingViewController()
        vc.initViewController(self.view.frame)
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {

    }
    
    func showSignupView(view: UIView) {
        self.view.endEditing(true)
        fadeView!.frame.origin.x = 0
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.fadeView!.alpha = 0.5
            self.signupView!.frame.origin.x = 0
        })
    }
    
    func showLoginView(view: UIView) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.3, animations: {()-> Void in
                self.fadeView!.alpha = 0
                self.signupView!.frame.origin.x = SharedUIManager.instance.screenWidth
            }, completion: {(completed:Bool)->Void in
                self.fadeView!.frame.origin.x = SharedUIManager.instance.screenWidth
        })
    }
    
    func showProgress(view: UIView) {
        
        if (alert?.isOn != nil) {
            alert!.hide()
        }
        
        showProgressView()
    }
    
    func test(view: UIView) {
        let vc = UserOnboardingViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func enableSignup(view: UIView) {
        let vc = UserOnboardingViewController()
        vc.initViewController(self.view.frame)
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //BNNetworkManagerDelegate Methods
    func manager(manager: BNNetworkManager!, didReceivedLoginValidation response: BNResponse?) {

        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    BNAppSharedManager.instance.dataManager.requestBiinieInitialData()
                    let vc = LoadingViewController()
                    vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
 
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials, text:response!.responseDescription!)
                    self.view.addSubview(self.alert!)
                    self.alert!.showAndHide()
                    self.loginView!.clean()
                })
            }
        }
    }
    
    func manager(manager: BNNetworkManager!, didReceivedRegisterConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    let vc = UserOnboardingViewController()
                    vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
            
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials, text:response!.responseDescription!)
                    self.view.addSubview(self.alert!)
                    self.alert!.showAndHide()
                    self.loginView!.clean()
                })
            }
        }
    }
    
    func showProgressView(){
        alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait, text:"Please wait a moment!")
        self.view.addSubview(alert!)
        alert!.show()
    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        
    }
}
