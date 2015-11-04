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
    
    
    
    var biinLogo:BNUIBiinView?
    var welcomeLbl:UILabel?
    var welcomeDescLbl:UILabel?
    
    var loginBtn:BNUIButton_Loging?
    var singupBtn:BNUIButton_Loging?
    
    var fade:UIView?

    
    var signupView:SignupView?
    var loginView:LoginView?
    //var fadeView:UIView?
    
    var alert:BNUIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.setNeedsStatusBarAppearanceUpdate()
    
        self.becomeFirstResponder()
        
        self.view.backgroundColor = UIColor.clearColor()

        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        let xpos:CGFloat = ((screenHeight - screenWidth) / 2) * -1
        var ypos:CGFloat = ((screenHeight - (330 + SharedUIManager.instance.signupView_spacer + SharedUIManager.instance.signupView_spacer )) / 2)

        let image = UIImageView(image: UIImage(named: "landing.jpg"))
        image.frame = CGRectMake(xpos, 0, screenHeight, screenHeight)
        self.view.addSubview(image)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.alpha = 0.75
        visualEffectView.frame = self.view.bounds
        self.view.addSubview(visualEffectView)

        
        biinLogo = BNUIBiinView(position:CGPoint(x:0, y:ypos), scale:SharedUIManager.instance.signupView_logoSize)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
        self.view.addSubview(biinLogo!)
        biinLogo!.setNeedsDisplay()
        
        ypos += (SharedUIManager.instance.signupView_spacer + biinLogo!.frame.height)
        let textBg = UIView(frame: CGRectMake(0, ypos, screenWidth, 150))
        textBg.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        self.view.addSubview(textBg)

        welcomeLbl = UILabel(frame: CGRectMake(0, 20, screenWidth, 28))
        welcomeLbl!.text = NSLocalizedString("Wellcome", comment: "Wellcome")
        welcomeLbl!.textAlignment = NSTextAlignment.Center
        welcomeLbl!.textColor = UIColor.whiteColor()
        welcomeLbl!.font = UIFont(name: "Lato-Regular", size: 25)
        textBg.addSubview(welcomeLbl!)
        
//        ypos += (25 + welcomeLbl!.frame.height)
        welcomeDescLbl = UILabel(frame: CGRectMake(20, (25 + welcomeLbl!.frame.height), (screenWidth - 40), 0))
        welcomeDescLbl!.text = NSLocalizedString("WelcomeDesc", comment: "WelcomeDesc")
        welcomeDescLbl!.textColor = UIColor.whiteColor()
        welcomeDescLbl!.font = UIFont(name: "Lato-Light", size: 18)
        welcomeDescLbl!.textAlignment = NSTextAlignment.Center
        welcomeDescLbl!.numberOfLines = 4
        welcomeDescLbl!.sizeToFit()
        textBg.addSubview(welcomeDescLbl!)
        
         ypos += 155//(SharedUIManager.instance.signupView_spacer + welcomeDescLbl!.frame.height)
        loginBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:screenWidth, height: 60), color:UIColor.whiteColor().colorWithAlphaComponent(0.25), text:NSLocalizedString("Login", comment: "Login"), textColor:UIColor.whiteColor())
        loginBtn!.addTarget(self, action: "showLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginBtn!)
        
        ypos += (5 + loginBtn!.frame.height)//        singupBtn = BNUIButton_Loging(frame: CGRect(x:((screenWidth - 195) / 2), y: ypos, width: 195, height: 65), color:UIColor.bnYellow(), text:NSLocalizedString("ImNewHere", comment: "ImNewHere"))
        singupBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:screenWidth, height: 60), color:UIColor.whiteColor().colorWithAlphaComponent(0.25), text:NSLocalizedString("ImNewHere", comment: "ImNewHere"), textColor:UIColor.whiteColor())
        singupBtn!.addTarget(self, action: "showSignUp:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(singupBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.view.addSubview(fade!)

        
        loginView = LoginView(frame:CGRectMake(screenWidth, 0, self.view.frame.width, screenHeight))
        //loginView!.layer.cornerRadius = 5
        //loginView!.layer.masksToBounds = true
        loginView!.delegate = self
        self.view.addSubview(loginView!)
        
//        fadeView = UIView(frame:CGRectMake(0, 25, self.view.frame.width, (self.view.frame.height - 25)))
//        fadeView!.backgroundColor = UIColor.blackColor()
//        fadeView!.alpha = 0
//        self.view.addSubview(fadeView!)
//        fadeView!.frame.origin.x = SharedUIManager.instance.screenWidth
        
        signupView = SignupView(frame:CGRectMake(0, 0, self.view.frame.width, screenHeight))
        //signupView!.layer.cornerRadius = 5
        //signupView!.layer.masksToBounds = true
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
        //fadeView!.frame.origin.x = 0
        UIView.animateWithDuration(0.4, animations: {() -> Void in
//            self.fadeView!.alpha = 0.5
            self.signupView!.frame.origin.x = 0
        })
    }
    
    func showLoginView(view: UIView) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.3, animations: {()-> Void in
//                self.fadeView!.alpha = 0
                self.signupView!.frame.origin.x = SharedUIManager.instance.screenWidth
            }, completion: {(completed:Bool)->Void in
//                self.fadeView!.frame.origin.x = SharedUIManager.instance.screenWidth
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
    
    func showLogin(sender:BNUIButton_Loging){
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.loginView!.frame.origin.x = 0
            self.fade!.alpha = 0.5
        })
    }
    
    func hideLoginView() {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.loginView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
        })
    }
    
    func showSignUp(sender:BNUIButton_Loging){
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.signupView!.frame.origin.x = 0
            self.fade!.alpha = 0.5
        })
    }
    
    func hideSignUpView() {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.signupView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
        })
    }
}
