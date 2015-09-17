//  SignupView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SignupView:UIView, UITextFieldDelegate {
    
    var delegate:SignupView_Delegate?
    
    var biinLogo:BNUIBiinView?
    //var biinLogoImage:UIImageView?
    var backBtn:BNUIButton_Loging?
    
    var firstNameTxt:BNUITexfield_Top?
    var lastNameTxt:BNUITexfield_Center?
    var genderTxt:BNUITexfield_Center?
    var emailTxt:BNUITexfield_Center?
    var passwordTxt:BNUITexfield_Bottom?
    
    var singupBtn:BNUIButton_Loging?
    var signupLbl:UILabel?
    //var welcomeLbl:UILabel?
    
    var isKeyboardUp = false
    
    var femaleBtn:BNUIButton_Gender?
    var maleBtn:BNUIButton_Gender?
    var genderStr:String?
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        //        self.layer.cornerRadius = 5
        //        self.layer.masksToBounds = true
        //        self.becomeFirstResponder()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        var ypos:CGFloat = 20

        
        biinLogo = BNUIBiinView(position:CGPoint(x:((screenWidth - 110) / 2), y:ypos), scale:4.0)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
        
        if SharedUIManager.instance.signupView_showLogo {
            self.addSubview(biinLogo!)
            biinLogo!.setNeedsDisplay()
            ypos +=  (20 + biinLogo!.frame.height)
        }
//        biinLogoImage = UIImageView(image: UIImage(named: "biinLogoLS"))
//        biinLogoImage!.frame = CGRectMake(60, -35, SharedUIManager.instance.signupView_logoSize, SharedUIManager.instance.signupView_logoSize)
//        self.addSubview(biinLogoImage!)
        
//        welcomeLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 23))
//        welcomeLbl!.text = NSLocalizedString("Wellcome", comment: "Wellcome")
//        welcomeLbl!.textAlignment = NSTextAlignment.Center
//        welcomeLbl!.textColor = UIColor.appTextColor()
//        welcomeLbl!.font = UIFont(name: "Lato-Black", size: 20)
//        //self.addSubview(welcomeLbl!)
        
        //ypos += (20 + welcomeLbl!.frame.height)
        firstNameTxt = BNUITexfield_Top(frame: CGRectMake(0, ypos, screenWidth, 45), placeHolderText:NSLocalizedString("Name", comment: "Name"))
        firstNameTxt!.textField!.delegate = self
        firstNameTxt!.textField!.keyboardType = UIKeyboardType.Default
        //emailTxt!.textField!.becomeFirstResponder()
        self.addSubview(firstNameTxt!)
        
        ypos += (1 + firstNameTxt!.frame.height)
        lastNameTxt = BNUITexfield_Center(frame: CGRectMake(0, ypos, screenWidth, 45), placeHolderText:NSLocalizedString("Lastname", comment: "Lastname"))
        lastNameTxt!.textField!.delegate = self
        lastNameTxt!.textField!.keyboardType = UIKeyboardType.Default
        self.addSubview(lastNameTxt!)
        
        ypos += (1 + lastNameTxt!.frame.height)
        genderTxt = BNUITexfield_Center(frame: CGRectMake(0, ypos, screenWidth, 45), placeHolderText:NSLocalizedString("Gender", comment: "Gender"))
        genderTxt!.textField!.enabled = false
        genderTxt!.textField!.delegate = self
        self.addSubview(genderTxt!)
        
        femaleBtn = BNUIButton_Gender(frame: CGRectMake(genderTxt!.frame.width - 90, 8, 30, 30), iconType: BNIconType.femaleSmall)
        femaleBtn!.addTarget(self, action: "femaleBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        genderTxt!.addSubview(femaleBtn!)
        genderStr = ""
        
        maleBtn = BNUIButton_Gender(frame: CGRectMake(genderTxt!.frame.width - 55, 8, 30, 30), iconType: BNIconType.maleSmall)
        maleBtn!.addTarget(self, action: "maleBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        genderTxt!.addSubview(maleBtn!)
        
        ypos += (1 + genderTxt!.frame.height)
        emailTxt = BNUITexfield_Center(frame: CGRectMake(0, ypos, screenWidth, 45), placeHolderText:NSLocalizedString("Email", comment: "Email"))
        emailTxt!.textField!.delegate = self
        emailTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        emailTxt!.textField!.keyboardType = UIKeyboardType.EmailAddress
        self.addSubview(emailTxt!)
        
        
        ypos += (1 + emailTxt!.frame.height)
        passwordTxt = BNUITexfield_Bottom(frame: CGRectMake(0, ypos, screenWidth, 45), placeHolderText:NSLocalizedString("Password", comment: "Password"))
        passwordTxt!.textField!.delegate = self
        passwordTxt!.textField!.secureTextEntry = true
        passwordTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        passwordTxt!.textField!.keyboardType = UIKeyboardType.Default
        self.addSubview(passwordTxt!)
        

        ypos += (5 + passwordTxt!.frame.height)
        singupBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:screenWidth, height: 65), color:UIColor.biinColor(), text:NSLocalizedString("LetsGetStarted", comment: "LetsGetStarted"), textColor:UIColor.whiteColor())
        singupBtn!.addTarget(self, action: "singup:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(singupBtn!)
        
        
        ypos += singupBtn!.frame.height + 10
        backBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:frame.width, height: 20), color:UIColor.clearColor(), text:NSLocalizedString("Calcel", comment: "Calcel"), textColor:UIColor.bnOrange())
        backBtn!.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        ypos = SharedUIManager.instance.screenHeight - 70
        signupLbl = UILabel(frame: CGRectMake(10, ypos, (screenWidth - 20), 16))
        signupLbl!.text = NSLocalizedString("DontForget", comment: "DontForget")
        signupLbl!.textAlignment = NSTextAlignment.Left
        signupLbl!.textColor = UIColor.appTextColor()
        signupLbl!.numberOfLines = 0
        signupLbl!.font = UIFont(name: "Lato-Light", size: 13)
        signupLbl!.sizeToFit()
        self.addSubview(signupLbl!)
        
        //backBtn = BNUIButton_Back_SignupView(frame: CGRect(x: 10, y: 10, width: 40, height: 20))
        //backBtn!.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.addSubview(backBtn!)
        

        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow", name: UIKeyboardDidShowNotification , object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide", name: UIKeyboardDidHideNotification, object: nil)

    }
    

    
    func femaleBtnAction(sender:BNUIButton_Gender){
        genderTxt!.textField!.text = NSLocalizedString("GenderFemale", comment: "GenderFemale")
        genderTxt!.textField!.textColor = UIColor.appTextColor()
        genderStr = "female"
        femaleBtn!.showSelected()
        maleBtn!.showEnable()
        genderTxt!.hideError()
    }

    func maleBtnAction(sender:BNUIButton_Gender){
        genderTxt!.textField!.text = NSLocalizedString("GenderMale", comment: "GenderMale")
        genderTxt!.textField!.textColor = UIColor.appTextColor()
        genderStr = "male"
        maleBtn!.showSelected()
        femaleBtn!.showEnable()
        genderTxt!.hideError()
    }
    
    func singup(sender:BNUIButton_Loging){
        //1. show progress
        //2. disable buttons
        //3. send request
        
        
        var ready = false
        
        if firstNameTxt!.isValid() &&
           lastNameTxt!.isValid() &&
            emailTxt!.isValid() &&
            passwordTxt!.isValid() {
                
            if genderStr!.isEmpty {
                genderTxt!.showError()
            }
                
            if SharedUIManager.instance.isValidEmail(emailTxt!.textField!.text!) {
                ready = true
            }else{
                emailTxt!.showError()
            }
        }
        
        
        if ready {
            let user = Biinie(identifier:emailTxt!.textField!.text!, firstName: firstNameTxt!.textField!.text!, lastName: lastNameTxt!.textField!.text!, email: emailTxt!.textField!.text!, gender:genderStr!)
            user.password = passwordTxt!.textField!.text
            BNAppSharedManager.instance.dataManager.bnUser = user
            BNAppSharedManager.instance.networkManager.register(user)
            
            delegate!.showProgress!(self)
            self.endEditing(true)
            //singupBtn!.showDisable()
        }
    }
    
    func back(sender:BNUIButton_Back_SignupView){
        delegate!.showLoginView!(self)
    }
    
    func keyboardDidShow() {

        if !isKeyboardUp {
            isKeyboardUp = true
            print("keyboardDidShow")
            
            UIView.animateWithDuration(0.1, animations: {() -> Void in
                //self.biinLogoImage!.alpha = 0
                self.backBtn!.alpha = 0
                self.biinLogo!.alpha = 0
                //self.welcomeLbl!.alpha = 0
                self.signupLbl!.alpha = 0
            })

            
            UIView.animateWithDuration(0.35, animations: {() -> Void in
                self.firstNameTxt!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
                self.lastNameTxt!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
                self.genderTxt!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
                self.emailTxt!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
                self.passwordTxt!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
                self.singupBtn!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
//                self.signupLbl!.frame.origin.y -= SharedUIManager.instance.signupView_ypos_1
            })
        }
    }
    
    func keyboardDidHide() {
        
        if isKeyboardUp {
            isKeyboardUp = false
            print("keyboardDidShow")
            UIView.animateWithDuration(0.1, animations: {() -> Void in
                self.firstNameTxt!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1
                self.lastNameTxt!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1
                self.genderTxt!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1
                self.emailTxt!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1
                self.passwordTxt!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1
                self.singupBtn!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1
//                self.signupLbl!.frame.origin.y += SharedUIManager.instance.signupView_ypos_1

            })
            
            UIView.animateWithDuration(0.25, animations: {() -> Void in
                //self.biinLogoImage!.alpha = 1
                self.backBtn!.alpha = 1
                self.biinLogo!.alpha = 1
                //self.welcomeLbl!.alpha = 1
                self.signupLbl!.alpha = 1
            })
        }
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.endEditing(true)
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        
//        if !isKeyboardUp {
//            
//            isKeyboardUp = true
//            
//            UIView.animateWithDuration(0.35, animations: {() -> Void in
//                self.nameTxt!.frame.origin.y -= 150
//                self.lastNameTxt!.frame.origin.y -= 150
//                self.genderTxt!.frame.origin.y -= 150
//                self.emailTxt!.frame.origin.y -= 150
//                self.passwordTxt!.frame.origin.y -= 150
//                self.singupBtn!.frame.origin.y -= 175
//                self.signupLbl!.frame.origin.y -= 175
//                
//                self.biinLogo!.alpha = 0
//                self.welcomeLbl!.alpha = 0
//            })
//        }
        
        return true
    }// return NO to disallow editing.
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing")
    }// became first responder
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        
//        if textField.placeholder == "Password" {
//            if countElements(textField.text) <= 7 {
//                passwordTxt!.showError()
//            }
//        }
        
        return true
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing")
        
//        if isKeyboardUp {
//
//            isKeyboardUp = false
//            
//            UIView.animateWithDuration(0.25, animations: {() -> Void in
//                self.nameTxt!.frame.origin.y += 150
//                self.lastNameTxt!.frame.origin.y += 150
//                self.genderTxt!.frame.origin.y += 150
//                self.emailTxt!.frame.origin.y += 150
//                self.passwordTxt!.frame.origin.y += 150
//                self.singupBtn!.frame.origin.y += 175
//                self.signupLbl!.frame.origin.y += 175
//                
//                self.biinLogo!.alpha = 1
//                self.welcomeLbl!.alpha = 1
//            })
//        }
        
    }// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("textField")
        
        textField.textColor = UIColor.appTextColor()
        
        if !textField.text!.isEmpty {
            
            textField.text = SharedUIManager.instance.removeSpecielCharacter(textField.text!)
            
//            if !passwordTxt!.textField!.text.isEmpty {
//                singupBtn!.showEnable()
//            }else{
//                singupBtn!.showDisable()
//            }
        }
        
        return true
    }// return NO to not change text
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("textFieldShouldClear")
        //singupBtn!.showDisable()
        return false
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
    
        return false
    }// called when 'return' key pressed. return NO to ignore.
}

@objc protocol SignupView_Delegate:NSObjectProtocol {
    optional func showLoginView(view:UIView)
    optional func enableSignup(view:UIView)
    optional func showProgress(view:UIView)
}