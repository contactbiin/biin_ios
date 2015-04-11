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
        
        println("SingupViewController - viewDidLoad()")
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        self.becomeFirstResponder()
        
        loginView = LoginView(frame: self.view.frame)
        loginView!.delegate = self
        self.view.addSubview(loginView!)
        
        fadeView = UIView(frame:self.view.frame)
        fadeView!.backgroundColor = UIColor.blackColor()
        fadeView!.alpha = 0
        self.view.addSubview(fadeView!)
        fadeView!.frame.origin.x = SharedUIManager.instance.screenWidth
        
        signupView = SignupView(frame: self.view.frame)
        signupView!.delegate = self
        self.view.addSubview(signupView!)
        signupView!.frame.origin.x = SharedUIManager.instance.screenWidth
        
        //[snippet caption="Creating Notifications in Swift"]
//        var localNotification: UILocalNotification = UILocalNotification()
//        localNotification.alertAction = "Testing notifications on iOS8"
//        //localNotification.alertBody = "Woww it works!!”
//        localNotification.alertBody = "Testing"
//        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
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
    
    func enterBtnAction(sender: UIButton!){
        var vc = UserOnboardingViewController()
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
        //UIView.animateWithDuration(0.5, animations: {()-> Void in
            //self.loadingView!.alpha = 0
            //self.enterBtn!.alpha = 1
        //})
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
//        var vc = LoadingViewController()
//        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func test(view: UIView) {
        var vc = UserOnboardingViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func enableSignup(view: UIView) {
        var vc = UserOnboardingViewController()
        vc.initViewController(self.view.frame)
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //BNNetworkManagerDelegate Methods
//    func manager(manager: BNNetworkManager!, didReceivedAllInitialData value: Bool) {
//        
//    }
    
    func manager(manager: BNNetworkManager!, didReceivedLoginValidation response: BNResponse?) {

        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    var vc = LoadingViewController()
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
                    self.loginView!.clean()
                })
            }
        }
    }
    
    func manager(manager: BNNetworkManager!, didReceivedRegisterConfirmation response: BNResponse?) {
        if response!.code == 0 {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    var vc = UserOnboardingViewController()
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
}
