//  LoginView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoginView:UIView, UITextFieldDelegate {
    
    var delegate:LoginView_Delegate?
    var biinLogo:BNUIBiinView?
    var biinLogoImage:UIImageView?
    var welcomeLbl:UILabel?
    var emailTxt:BNUITexfield_Top?
    var passwordTxt:BNUITexfield_Bottom?
    var loginBtn:BNUIButton_Loging?
    var singupBtn:BNUIButton_Loging?
    var signupLbl:UILabel?
    var isKeyboardUp = false
    
    var testBtn:UIButton?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
//        self.layer.cornerRadius = 5
//        self.layer.masksToBounds = true
//        self.becomeFirstResponder()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var ypos:CGFloat = 100
        
        biinLogo = BNUIBiinView(frame: CGRectMake(((screenWidth - 110) / 2), ypos, 110, 65))
        self.addSubview(biinLogo!)
        
        biinLogoImage = UIImageView(image: UIImage(named: "biinLogoLS"))
        biinLogoImage!.frame = CGRectMake(10, -50, 300, 300)
        self.addSubview(biinLogoImage!)
        
        ypos += (10 + biinLogo!.frame.height)
        welcomeLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 23))
        welcomeLbl!.text = NSLocalizedString("Wellcome", comment: "Wellcome")
        welcomeLbl!.textAlignment = NSTextAlignment.Center
        welcomeLbl!.textColor = UIColor.appTextColor()
        welcomeLbl!.font = UIFont(name: "Lato-Black", size: 20)
        self.addSubview(welcomeLbl!)

        ypos += (30 + welcomeLbl!.frame.height)
        emailTxt = BNUITexfield_Top(frame: CGRectMake(0, ypos, screenWidth, 55), placeHolderText:NSLocalizedString("Email", comment: "Email"))
        emailTxt!.textField!.delegate = self
        emailTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        self.addSubview(emailTxt!)
        //emailTxt!.setNeedsDisplay()
        
        ypos += (1 + emailTxt!.frame.height)
        passwordTxt = BNUITexfield_Bottom(frame: CGRectMake(0, ypos, screenWidth, 55), placeHolderText:NSLocalizedString("Password", comment: "Password"))
        passwordTxt!.textField!.delegate = self
        passwordTxt!.textField!.secureTextEntry = true
        passwordTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        self.addSubview(passwordTxt!)
        
        ypos += (5 + passwordTxt!.frame.height)
        //loginBtn = BNUIButton_Loging(frame: CGRect(x:((screenWidth - 195) / 2), y: ypos, width: 195, height: 65), color:UIColor.bnGreen(), text:NSLocalizedString("Login", comment: "Login"))
        
        loginBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:frame.width, height: 65), color:UIColor.biinColor(), text:NSLocalizedString("Login", comment: "Login"), textColor:UIColor.whiteColor())
        loginBtn!.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(loginBtn!)

        ypos = (frame.height - 65)
//        singupBtn = BNUIButton_Loging(frame: CGRect(x:((screenWidth - 195) / 2), y: ypos, width: 195, height: 65), color:UIColor.bnYellow(), text:NSLocalizedString("ImNewHere", comment: "ImNewHere"))
        singupBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:frame.width, height: 65), color:UIColor.clearColor(), text:NSLocalizedString("ImNewHere", comment: "ImNewHere"), textColor:UIColor.biinColor())
        singupBtn!.addTarget(self, action: "signup:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(singupBtn!)
        
        /*
        ypos += (10 + singupBtn!.frame.height)
        signupLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 18))
        signupLbl!.text = NSLocalizedString("SignUpMsj", comment: "SignUpMsj")
        signupLbl!.textAlignment = NSTextAlignment.Center
        signupLbl!.textColor = UIColor.appTextColor()
        signupLbl!.font = UIFont(name: "Lato-Light", size: 16)
        self.addSubview(signupLbl!)
        */
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow", name: UIKeyboardDidShowNotification , object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide", name: UIKeyboardDidHideNotification, object: nil)
        
        /*
        //TODO: remove after testing
        testBtn = UIButton(frame: CGRectMake(10, (SharedUIManager.instance.screenHeight - 40), 80, 30))
        testBtn!.titleLabel!.text = "TEST"
        //testBtn!.titleLabel!.textColor = UIColor.whiteColor()
        testBtn!.backgroundColor = UIColor.bnOrange()
        testBtn!.addTarget(self, action: "test:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(testBtn!)
        */
    }
    
    func test(sender:UIButton){
        delegate!.test!(self)
    }
    
    func keyboardDidShow() {
        
        if !isKeyboardUp {
            
            isKeyboardUp = true
            println("keyboardDidShow")
            
            UIView.animateWithDuration(0.1, animations: {() -> Void in
                if SharedUIManager.instance.loginView_isAnimatingLogo {
                    //self.biinLogo!.frame.origin.y -= SharedUIManager.instance.loginView_ypos_1
                    //self.welcomeLbl!.frame.origin.y -= SharedUIManager.instance.loginView_ypos_1
                    self.biinLogo!.alpha = 0
                    self.welcomeLbl!.alpha = 0
                    self.biinLogoImage!.alpha = 0
                } else {
                    self.biinLogo!.alpha = 0
                    self.welcomeLbl!.alpha = 0
                    self.biinLogoImage!.alpha = 0
                }
            })
            
            UIView.animateWithDuration(0.25, animations: {() -> Void in
                
                self.emailTxt!.frame.origin.y -= SharedUIManager.instance.loginView_ypos_1
                self.passwordTxt!.frame.origin.y -= SharedUIManager.instance.loginView_ypos_1
                self.loginBtn!.frame.origin.y -= SharedUIManager.instance.loginView_ypos_1
                self.singupBtn!.frame.origin.y -= SharedUIManager.instance.loginView_ypos_2
                //self.signupLbl!.alpha = 0
            })
        }
    }
    
    func keyboardDidHide() {
        
        if isKeyboardUp {
            isKeyboardUp = false
            println("keyboardDidShow")
            UIView.animateWithDuration(0.5, animations: {() -> Void in
                
                if SharedUIManager.instance.loginView_isAnimatingLogo {
//                    self.biinLogo!.frame.origin.y += SharedUIManager.instance.loginView_ypos_1
//                    self.welcomeLbl!.frame.origin.y += SharedUIManager.instance.loginView_ypos_1
                    self.biinLogo!.alpha = 1
                    self.welcomeLbl!.alpha = 1
                    self.biinLogoImage!.alpha = 1
                } else {
                    self.biinLogo!.alpha = 1
                    self.welcomeLbl!.alpha = 1
                    self.biinLogoImage!.alpha = 1
                }
            })
            
            UIView.animateWithDuration(0.25, animations: {() -> Void in
                
                self.emailTxt!.frame.origin.y += SharedUIManager.instance.loginView_ypos_1
                self.passwordTxt!.frame.origin.y += SharedUIManager.instance.loginView_ypos_1
                self.loginBtn!.frame.origin.y += SharedUIManager.instance.loginView_ypos_1
                self.singupBtn!.frame.origin.y += SharedUIManager.instance.loginView_ypos_2
                //self.signupLbl!.alpha = 0
            })
        }
    }
    
    func login(sender:BNUIButton_Loging){
        
        var ready = false
        
        if  emailTxt!.isValid() &&
            passwordTxt!.isValid() {
            
            if SharedUIManager.instance.isValidEmail(emailTxt!.textField!.text) {
                ready = true
            }else{
                emailTxt!.showError()
            }
        }

        if ready {
            
            var password = passwordTxt!.textField!.text.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var email = emailTxt!.textField!.text.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            BNAppSharedManager.instance.networkManager.login(email, password: password)
            
            delegate!.showProgress!(self)
            self.endEditing(true)
            loginBtn!.showDisable()
        }
    }
    
    func clean(){
        //emailTxt!.textField!.text = ""
        //passwordTxt!.textField!.text = ""
        loginBtn!.showEnable()
    }
    
    func signup(sender:BNUIButton_Loging) {
        delegate!.showSignupView!(self)
    }
    
    //override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    //    self.endEditing(true)
    //}
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.endEditing(true)
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        println("textFieldShouldBeginEditing")
        
        return true
    }// return NO to disallow editing.
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        println("textFieldDidBeginEditing")
        
    }// became first responder
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println("textFieldShouldEndEditing")
        
        return true
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("textFieldDidEndEditing")

        
    }// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        textField.textColor = UIColor.appTextColor()
        
        if !textField.text.isEmpty {
            
            textField.text = SharedUIManager.instance.removeSpecielCharacter(textField.text)
            
        }
        
        return true
    }// return NO to not change text
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        println("textFieldShouldClear")

        return false
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("textFieldShouldReturn")
        
        return false
    }// called when 'return' key pressed. return NO to ignore.
}

@objc protocol LoginView_Delegate:NSObjectProtocol {
    optional func showSignupView(view:UIView)
    optional func showProgress(view:UIView)
    optional func test(view:UIView)
}
