//  SingupViewController.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import FBSDKLoginKit

class SingupViewController:UIViewController, UIPopoverPresentationControllerDelegate, LoginView_Delegate, SignupView_Delegate, PrivacyPolicyView_Delegate, BNNetworkManagerDelegate, FBSDKLoginButtonDelegate {
   
    var biinLogo:BNUIBiinView?
    var welcomeLbl:UILabel?
    var welcomeDescLbl:UILabel?
    var loginBtn:UIButton?
    var singupBtn:UIButton?
    var fade:UIView?
    var signupView:SignupView?
    var loginView:LoginView?
    
    var privacyPolicyView:PrivacyPolicyView?
    
    var alert:BNUIAlertView?
    var isBiinieAlreadyInFacebook = false
    var isSigningUpWithFacebook = false
    
    var facebookBtn:FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BNAppSharedManager.instance.networkManager.delegateVC = self
        BNAppSharedManager.instance.errorManager.currentViewController = self
        //BNAppSharedManager.instance.networkManager.requestToS(self)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.setNeedsStatusBarAppearanceUpdate()
    
        self.becomeFirstResponder()
        
        self.view.backgroundColor = UIColor.whiteColor()

        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        var ypos:CGFloat = 0

//        let image = UIImageView(image: UIImage(named: "loading1.jpg"))
//        image.frame = CGRectMake(xpos, 0, screenHeight, screenHeight)
//        self.view.addSubview(image)
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
//        visualEffectView.alpha = 1
//        visualEffectView.frame = self.view.bounds
//        self.view.addSubview(visualEffectView)

        biinLogo = BNUIBiinView(position:CGPoint(x:0, y:ypos), scale:SharedUIManager.instance.signupView_logoSize)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
        biinLogo!.icon!.color = UIColor.blackColor()
        self.view.addSubview(biinLogo!)
        biinLogo!.setNeedsDisplay()
        
        ypos += (biinLogo!.frame.height + 20)
        welcomeLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 23))
        welcomeLbl!.text = NSLocalizedString("Wellcome", comment: "Wellcome")
        welcomeLbl!.textAlignment = NSTextAlignment.Center
        welcomeLbl!.textColor = UIColor.darkGrayColor()
        welcomeLbl!.font = UIFont(name: "Lato-Light", size: 20)
        self.view.addSubview(welcomeLbl!)
        
        ypos += (welcomeLbl!.frame.height + 5)
        welcomeDescLbl = UILabel(frame: CGRectMake(20, ypos, (screenWidth - 40), 0))
        welcomeDescLbl!.text = NSLocalizedString("WelcomeDesc", comment: "WelcomeDesc")
        welcomeDescLbl!.textColor = UIColor.darkGrayColor()
        welcomeDescLbl!.font = UIFont(name: "Lato-Light", size: 14)
        welcomeDescLbl!.textAlignment = NSTextAlignment.Center
        welcomeDescLbl!.numberOfLines = 4
        welcomeDescLbl!.sizeToFit()
        self.view.addSubview(welcomeDescLbl!)
        
        ypos += (welcomeDescLbl!.frame.height + 30)
        
        
        
        FBSDKApplicationDelegate.sharedInstance().application(nil, didFinishLaunchingWithOptions: nil)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            print("alredy in facebook")
            isBiinieAlreadyInFacebook = true
            returnUserData()
        } else {
            facebookBtn = FBSDKLoginButton()
            self.view.addSubview(facebookBtn!)
            facebookBtn!.frame = CGRectMake(5, ypos, (screenWidth - 10), 60)
            facebookBtn!.readPermissions = ["public_profile", "email", "user_friends", "user_birthday"]
            facebookBtn!.layer.cornerRadius = 2
            facebookBtn!.delegate = self
            facebookBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
            ypos += 65
        }
        
        
        singupBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 60))
        singupBtn!.backgroundColor = UIColor.biinOrange()
        singupBtn!.layer.cornerRadius = 2
        singupBtn!.setTitle(NSLocalizedString("ImNewHere", comment: "ImNewHere"), forState: UIControlState.Normal)
        singupBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
        singupBtn!.addTarget(self, action: #selector(self.showSignUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(singupBtn!)
        
        ypos += (singupBtn!.frame.height + 5)
        loginBtn = UIButton(frame: CGRectMake(5, (screenHeight - 30), (screenWidth - 10), 30))
        loginBtn!.backgroundColor = UIColor.clearColor()
        loginBtn!.setTitle(NSLocalizedString("Login", comment: "Login"), forState: UIControlState.Normal)
        loginBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 15)
        loginBtn!.addTarget(self, action: #selector(self.showLogin(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        loginBtn!.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.view.addSubview(loginBtn!)

        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.view.addSubview(fade!)
        
        if isBiinieAlreadyInFacebook {
            showProgressView()
        }

        loginView = LoginView(frame:CGRectMake(screenWidth, 0, screenWidth, screenHeight))
        loginView!.delegate = self
        self.view.addSubview(loginView!)
        
        signupView = SignupView(frame:CGRectMake(screenWidth, 0, screenWidth, screenHeight))
        signupView!.delegate = self
        self.view.addSubview(signupView!)
        
        privacyPolicyView = PrivacyPolicyView(frame:CGRectMake(screenWidth, 0, screenWidth, screenHeight))
        privacyPolicyView!.delegate = self
        self.view.addSubview(privacyPolicyView!)

        ypos = (screenHeight - ypos ) / 2
        biinLogo!.frame.origin.y = ypos
        ypos += (biinLogo!.frame.height + 20)
        welcomeLbl!.frame.origin.y = ypos
        ypos += (welcomeLbl!.frame.height + 5)
        welcomeDescLbl!.frame.origin.y = ypos
        
        ypos += (welcomeDescLbl!.frame.height + 30)
        if facebookBtn != nil {
            facebookBtn!.frame.origin.y = ypos
            ypos += (facebookBtn!.frame.height + 5)

        }
        
        singupBtn!.frame.origin.y = ypos
        
        //BNAppSharedManager.instance.addPositionManager()
        
        //self.view.layerGradient()
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
    func didReceivedAllInitialData() { }
    
    func loadToS_webViews(){
        privacyPolicyView!.loadWebView()
    }
    
    func hidePrivacyPolicyView() {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.privacyPolicyView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
        })
    }
    
    func acceptPrivacyPolicy() {
//        UIView.animateWithDuration(0.3, animations: { ()-> Void in
//            
//            self.privacyPolicyView!.frame.origin.x = SharedUIManager.instance.screenWidth
//            self.fade!.alpha = 0.5
//            
//            }, completion: {(completed:Bool)->Void in
//                UIView.animateWithDuration(0.3, animations: {()->Void in
//                    self.termOfServiceView!.frame.origin.x = 0
//                    self.fade!.alpha = 0
//                })
//        })
        
        if self.isSigningUpWithFacebook {
            self.showProgressView()
            BNAppSharedManager.instance.networkManager.sendBiinie(BNAppSharedManager.instance.dataManager.biinie!)
            SharedAnswersManager.instance.logSignUp("Facebook")
        } else {
            
            UIView.animateWithDuration(0.3, animations: { ()-> Void in
                
//                self.termOfServiceView!.frame.origin.x = SharedUIManager.instance.screenWidth
                self.privacyPolicyView!.frame.origin.x = SharedUIManager.instance.screenWidth
//                self.fade!.alpha = 0.5
                
                
                }, completion: {(completed:Bool)->Void in
                    
                    UIView.animateWithDuration(0.3, animations: {()->Void in
                        self.signupView!.frame.origin.x = 0
                        self.fade!.alpha = 0.5
                    })
            })
        }
        
        
    }
    
    
    func showSignupView(view: UIView) {
        self.view.endEditing(true)
        self.isSigningUpWithFacebook = false
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
    
    func hideProgressView(){
        if (alert?.isOn != nil) {
            alert!.hideWithCallback({() -> Void in
                self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.FacebookError )
                self.view.addSubview(self.alert!)
                self.alert!.showAndHide()
                self.loginView!.clean()
            })
        }
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
    func didReceivedLoginValidation(isValidated: Bool) {

        if isValidated {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    //BNAppSharedManager.instance.dataManager.requestBiinieInitialData()
                    let vc = LoadingViewController()
                    vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
 
        } else {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials)
                    self.view.addSubview(self.alert!)
                    self.alert!.showAndHide()
                    self.loginView!.clean()
                })
            }
        }
    }
    
    func didReceivedRegisterConfirmation(registered:Bool) {
        if registered {
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
                    self.alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Bad_credentials)
                    self.view.addSubview(self.alert!)
                    self.alert!.showAndHide()
                    self.loginView!.clean()
                })
            }
        }
    }
    
    
    //BNNetworkManagerDelegate Methods
    func didReceivedFacebookLoginValidation(isValidated:Bool) {
//    func manager(manager: BNNetworkManager!, didReceivedFacebookLoginValidation response: BNResponse?) {
        
        if isValidated {
            if (alert?.isOn != nil) {
                alert!.hideWithCallback({() -> Void in
                    //BNAppSharedManager.instance.dataManager.requestBiinieInitialData()
                    let vc = LoadingViewController()
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
                    self.loginView!.clean()
                })
            }
        }
    }
    
    
    func showProgressView(){
        if self.alert == nil {
            alert = BNUIAlertView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), type: BNUIAlertView_Type.Please_wait )
        
            self.view.addSubview(alert!)
            alert!.show()
        } else {
            alert!.show()
        }
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
//            self.signupView!.frame.origin.x = 0
            self.privacyPolicyView!.frame.origin.x = 0
            self.fade!.alpha = 0.5
        })
    }
    
    func hideSignUpView() {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.signupView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
        })
    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        

        
        if ((error) != nil) {
            // Process error
            self.hideProgressView()
        }  else if result.isCancelled {
            // Handle cancellations
            self.hideProgressView()
        }  else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                //self.showProgress(self.view)
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData() {
        
        self.isSigningUpWithFacebook = true
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"me", parameters:["fields":"id,first_name,last_name,gender,picture,email,birthday,friends"])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                //print("fetched user: \(result)")
                let user = Biinie()
                user.identifier = "none"
                if let first_name = result.valueForKey("first_name") {
                    user.firstName = first_name as? String
                }

                if let last_name = result.valueForKey("last_name") {
                    user.lastName = last_name as? String
                }
                
                if let userEmail = result.valueForKey("email") {
                    user.email = userEmail as? String
                    user.biinName = userEmail as? String
                }
                
                if let birthday = result.valueForKey("birthday") {
                    let bd = NSDate(dateStringMMddyyyy: (birthday as! String))
                    user.birthDate = bd
                }
                
                if let gender = result.valueForKey("gender") {
                    user.gender = gender as? String
                }
                
                if let facebook_id = result.valueForKey("id") {
                    user.facebook_id = facebook_id as? String
                } 
            
                if let friends = result["friends"] as? NSDictionary {
                    if let data = friends["data"] as? NSArray {
                        for friend in data {
                            if let facebook_id = friend.valueForKey("id") {
                                let biinie = Biinie()
                                biinie.facebook_id = facebook_id as? String
                                user.friends.append(biinie)
                            }
                        }
                    }
                }
                
                if let picture = result["picture"] as? NSDictionary {
                    if let data = picture["data"] as? NSDictionary {
                        
                        if let picture_url = data.valueForKey("url") as? String {
                            user.facebookAvatarUrl = picture_url
                        }
                    }
                }
                
                user.token = BNAppSharedManager.instance.dataManager.biinie!.token
                user.needsTokenUpdate = BNAppSharedManager.instance.dataManager.biinie!.needsTokenUpdate
                user.isEmailVerified = true
                user.password = ""

                BNAppSharedManager.instance.dataManager.biinie = user

                
                if self.isBiinieAlreadyInFacebook {
                    BNAppSharedManager.instance.networkManager.login_Facebook(user.email!)
                    SharedAnswersManager.instance.logSignUp("Facebook")
                } else {
                    
                    if (self.alert?.isOn != nil) {
                        self.alert!.hide()
                    }
                    
                    UIView.animateWithDuration(0.3, animations: {()->Void in
                        self.privacyPolicyView!.frame.origin.x = 0
                        self.fade!.alpha = 0.5
                    })
                }
            }
        })
    }
}
