//  SignupView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SignupView:UIView, UITextFieldDelegate {
    
    var delegate:SignupView_Delegate?
    
    var title:UILabel?
    var backBtn:BNUIButton_Back?

    var firstNameTxt:BNUITexfield_Top?
    var lastNameTxt:BNUITexfield_Center?
    var genderTxt:BNUITexfield_Center?
    var birthDateTxt:BNUITexfield_Center?
    var emailTxt:BNUITexfield_Center?
    var passwordTxt:BNUITexfield_Bottom?
    
    var singupBtn:BNUIButton_Loging?
    var signupLbl:UILabel?
    
    var isKeyboardUp = false
    
    var femaleBtn:BNUIButton_Gender?
    var maleBtn:BNUIButton_Gender?
    var genderStr:String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
        
        
        let screenWidth = SharedUIManager.instance.screenWidth
        
        var ypos:CGFloat = 20
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        let titleText = NSLocalizedString("SignUpTitle", comment: "SignUpTitle").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.whiteColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(10, 10, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.darkGrayColor()
        backBtn!.layer.borderColor = UIColor.whiteColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.addSubview(backBtn!)
        
        ypos += SharedUIManager.instance.loginView_ypos_1

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
        birthDateTxt = BNUITexfield_Center(frame: CGRectMake(0, ypos, screenWidth, 45), placeHolderText:NSLocalizedString("EnterYourBirthDate", comment: "EnterYourBirthDate"))
        birthDateTxt!.textField!.delegate = self

        birthDateTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        birthDateTxt!.textField!.keyboardType = UIKeyboardType.EmailAddress
        self.addSubview(birthDateTxt!)
        
        ypos += (1 + birthDateTxt!.frame.height)
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
        singupBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:screenWidth, height: 65), color:UIColor.whiteColor().colorWithAlphaComponent(0.25), text:NSLocalizedString("LetsGetStarted", comment: "LetsGetStarted"), textColor:UIColor.whiteColor())
        singupBtn!.addTarget(self, action: "singup:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(singupBtn!)
    
        
        ypos = SharedUIManager.instance.screenHeight - 70
        signupLbl = UILabel(frame: CGRectMake(10, ypos, (screenWidth - 20), 16))
        signupLbl!.text = NSLocalizedString("DontForget", comment: "DontForget")
        signupLbl!.textAlignment = NSTextAlignment.Left
        signupLbl!.textColor = UIColor.whiteColor()
        signupLbl!.numberOfLines = 0
        signupLbl!.font = UIFont(name: "Lato-Light", size: 13)
        signupLbl!.sizeToFit()
        self.addSubview(signupLbl!)
    
        
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
            passwordTxt!.isValid() &&
            birthDateTxt!.isValid() {
                
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
            
            BNAppSharedManager.instance.dataManager.bnUser!.identifier = emailTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.bnUser!.firstName = firstNameTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.bnUser!.lastName = lastNameTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.bnUser!.email = emailTxt!.textField!.text
            BNAppSharedManager.instance.dataManager.bnUser!.gender = genderStr
            BNAppSharedManager.instance.dataManager.bnUser!.password = passwordTxt!.textField!.text
            BNAppSharedManager.instance.networkManager.register(BNAppSharedManager.instance.dataManager.bnUser!)
            
            delegate!.showProgress!(self)
            self.endEditing(true)
        }
    }
    
    func backBtnAction(sender:BNUIButton_Back){
        self.endEditing(true)
        delegate!.hideSignUpView!()
        clean()
    }
    
    func clean(){
        firstNameTxt!.textField!.text = ""
        lastNameTxt!.textField!.text = ""
        genderTxt!.textField!.text = ""
        birthDateTxt!.textField!.text = ""
        emailTxt!.textField!.text = ""
        passwordTxt!.textField!.text = ""
    }
    
    func keyboardDidShow() {

        if !isKeyboardUp {
            isKeyboardUp = true
        }
    }
    
    func keyboardDidHide() {
        
        if isKeyboardUp {
            isKeyboardUp = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }// return NO to disallow editing.
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing")
        
        if textField.placeholder == "Enter your birthDate" {
            let datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
            
        }
    }// became first responder
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
 
        return true
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing")

    }// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("textField")
        
        textField.textColor = UIColor.appTextColor()
        
        if !textField.text!.isEmpty {
            
            textField.text = SharedUIManager.instance.removeSpecielCharacter(textField.text!)
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
    
    func handleDatePicker(sender: UIDatePicker) {
        birthDateTxt!.textField!.text = sender.date.bnDisplayDateFormatt()
        BNAppSharedManager.instance.dataManager.bnUser!.birthDate = sender.date
    }
}

@objc protocol SignupView_Delegate:NSObjectProtocol {
    optional func showProgress(view:UIView)
    optional func hideSignUpView()
}