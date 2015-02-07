//  LoginView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoginView:UIView, UITextFieldDelegate {

    var emailTxt:BNUITexfield_Top?
    var passwordTxt:BNUITexfield_Bottom?
    var logingBtn:BNUILogingButton?
    var singupBtn:BNUILogingButton?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.biinColor()
//        self.layer.cornerRadius = 5
//        self.layer.masksToBounds = true
//        self.becomeFirstResponder()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var ypos:CGFloat = 60
        var biinLogo = BNUIBiinView(frame: CGRectMake(((screenWidth - 110) / 2), ypos, 110, 65))
        self.addSubview(biinLogo)
        biinLogo.setNeedsDisplay()
        
        ypos += (10 + biinLogo.frame.height)
        var welcomeLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 18))
        welcomeLbl.text = "Well comeback, we miss you!"
        welcomeLbl.textAlignment = NSTextAlignment.Center
        welcomeLbl.textColor = UIColor.appMainColor()
        welcomeLbl.font = UIFont(name: "Lato-Light", size: 16)
        self.addSubview(welcomeLbl)

        ypos += (20 + welcomeLbl.frame.height)
        emailTxt = BNUITexfield_Top(frame: CGRectMake(20, ypos, (screenWidth - 40), 40), placeHolderText:"Email")
        emailTxt!.textField!.delegate = self
        //emailTxt!.textField!.becomeFirstResponder()
        self.addSubview(emailTxt!)
        //emailTxt!.setNeedsDisplay()
        
        ypos += (2 + emailTxt!.frame.height)
        passwordTxt = BNUITexfield_Bottom(frame: CGRectMake(20, ypos, (screenWidth - 40), 40), placeHolderText:"Password")
        passwordTxt!.textField!.delegate = self
        passwordTxt!.textField!.secureTextEntry = true
        self.addSubview(passwordTxt!)
        
        
        ypos += (60 + passwordTxt!.frame.height)
        logingBtn = BNUILogingButton(frame: CGRect(x:((screenWidth - 195) / 2), y: ypos, width: 195, height: 65), color:UIColor.bnGreen(), text:"Log in")
        self.addSubview(logingBtn!)

        ypos += (10 + logingBtn!.frame.height)
        singupBtn = BNUILogingButton(frame: CGRect(x:((screenWidth - 195) / 2), y: ypos, width: 195, height: 65), color:UIColor.bnYellow(), text:"I’m new here!")
        self.addSubview(singupBtn!)
        
        ypos += (10 + singupBtn!.frame.height)
        var signupLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 18))
        signupLbl.text = "Sign up using your email address."
        signupLbl.textAlignment = NSTextAlignment.Center
        signupLbl.textColor = UIColor.appMainColor()
        signupLbl.font = UIFont(name: "Lato-Light", size: 16)
        self.addSubview(signupLbl)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
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
        println("textField")
        
        textField.textColor = UIColor.appTextColor()
        
        if !textField.text.isEmpty {
            

            if emailTxt!.isShowingError {
                if textField.placeholder == "Email" {
                    emailTxt!.hideError()
                }
            }
            
            if passwordTxt!.isShowingError {
                if textField.placeholder == "Password" {
                    passwordTxt!.hideError()
                }
            }
        }
        
        
        return true
    }// return NO to not change text
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        println("textFieldShouldClear")
        return true
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("textFieldShouldReturn")
        
        if emailTxt!.isValid() {
        
        }
        
        if passwordTxt!.isValid() {
            self.endEditing(true)
        }
        
        return false
    }// called when 'return' key pressed. return NO to ignore.
}
