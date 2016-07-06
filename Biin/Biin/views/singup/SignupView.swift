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
    
    var singupBtn:UIButton?
    var signupLbl:UILabel?
    
    var isKeyboardUp = false
    
    var femaleBtn:BNUIButton_Gender?
    var maleBtn:BNUIButton_Gender?
    var genderStr:String?
    
    var newUser:Biinie?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
//        visualEffectView.frame = self.bounds
//        self.addSubview(visualEffectView)
        
        
        let screenWidth = SharedUIManager.instance.screenWidth
        
        let line = UIView(frame: CGRectMake(0, 35, screenWidth, 1))
        line.backgroundColor = UIColor.appButtonColor_Disable()
//        line.layer.shadowColor = UIColor.blackColor().CGColor
//        line.layer.shadowOffset = CGSize(width: 0, height: 5)
//        line.layer.shadowOpacity = 0.15
        self.addSubview(line)
        
        var ypos:CGFloat = 10
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        let titleText = NSLocalizedString("SignUpTitle", comment: "SignUpTitle").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.darkGrayColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()
//        backBtn!.layer.borderColor = UIColor.whiteColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.biinOrange().CGColor
//        backBtn!.layer.cornerRadius  = 17.5
//        backBtn!.layer.borderWidth = 1
        backBtn!.layer.masksToBounds = true
        self.addSubview(backBtn!)
        
        ypos += SharedUIManager.instance.loginView_ypos_1

        firstNameTxt = BNUITexfield_Top(frame: CGRectMake(5, ypos, (screenWidth - 10), 45), placeHolderText:NSLocalizedString("Name", comment: "Name"))
        firstNameTxt!.textField!.delegate = self
        firstNameTxt!.textField!.keyboardType = UIKeyboardType.Default
        //emailTxt!.textField!.becomeFirstResponder()
        self.addSubview(firstNameTxt!)
        
        ypos += (1 + firstNameTxt!.frame.height)
        lastNameTxt = BNUITexfield_Center(frame: CGRectMake(5, ypos, (screenWidth - 10), 45), placeHolderText:NSLocalizedString("Lastname", comment: "Lastname"))
        lastNameTxt!.textField!.delegate = self
        lastNameTxt!.textField!.keyboardType = UIKeyboardType.Default
        self.addSubview(lastNameTxt!)
        
        ypos += (1 + lastNameTxt!.frame.height)
        emailTxt = BNUITexfield_Center(frame: CGRectMake(5, ypos, (screenWidth - 10), 45), placeHolderText:NSLocalizedString("Email", comment: "Email"))
        emailTxt!.textField!.delegate = self
        emailTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        emailTxt!.textField!.keyboardType = UIKeyboardType.EmailAddress
        self.addSubview(emailTxt!)
        
        
        ypos += (1 + emailTxt!.frame.height)
        passwordTxt = BNUITexfield_Bottom(frame: CGRectMake(5, ypos, (screenWidth - 10), 45), placeHolderText:NSLocalizedString("Password", comment: "Password"))
        passwordTxt!.textField!.delegate = self
        passwordTxt!.textField!.secureTextEntry = true
        passwordTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        passwordTxt!.textField!.keyboardType = UIKeyboardType.Default
        self.addSubview(passwordTxt!)
        
        ypos += (5 + passwordTxt!.frame.height)
        let optionalLbl = UILabel(frame: CGRectMake(10, ypos, (screenWidth - 20), 16))
        optionalLbl.text = NSLocalizedString("Optionales", comment: "Optionales")
        optionalLbl.textAlignment = NSTextAlignment.Left
        optionalLbl.textColor = UIColor.darkGrayColor()
        optionalLbl.numberOfLines = 0
        optionalLbl.font = UIFont(name: "Lato-Light", size: 13)
        optionalLbl.sizeToFit()
        self.addSubview(optionalLbl)
        
        ypos += (5 + optionalLbl.frame.height)
        genderTxt = BNUITexfield_Center(frame: CGRectMake(5, ypos, (screenWidth - 10), 45), placeHolderText:NSLocalizedString("Gender", comment: "Gender"))
        genderTxt!.textField!.enabled = false
        genderTxt!.textField!.delegate = self
        self.addSubview(genderTxt!)
        
        femaleBtn = BNUIButton_Gender(frame: CGRectMake(genderTxt!.frame.width - 73, 8, 30, 30), iconType: BNIconType.femaleSmall)
        femaleBtn!.addTarget(self, action: #selector(self.femaleBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        genderTxt!.addSubview(femaleBtn!)
        genderStr = "none"
//        genderTxt!.backgroundColor = UIColor.bnGrayLight()
//        genderTxt!.point!.backgroundColor = UIColor.bnGrayLight()
        
        maleBtn = BNUIButton_Gender(frame: CGRectMake(genderTxt!.frame.width - 38, 8, 30, 30), iconType: BNIconType.maleSmall)
        maleBtn!.addTarget(self, action: #selector(self.maleBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        genderTxt!.addSubview(maleBtn!)
        
        ypos += (1 + genderTxt!.frame.height)
        birthDateTxt = BNUITexfield_Center(frame: CGRectMake(5, ypos, (screenWidth - 10), 45), placeHolderText:NSLocalizedString("EnterYourBirthDate", comment: "EnterYourBirthDate"))
        birthDateTxt!.textField!.delegate = self
//        birthDateTxt!.backgroundColor = UIColor.bnGrayLight()
//        birthDateTxt!.point!.backgroundColor = UIColor.bnGrayLight()
        birthDateTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        birthDateTxt!.textField!.keyboardType = UIKeyboardType.EmailAddress
        self.addSubview(birthDateTxt!)
        
        ypos += (5 + birthDateTxt!.frame.height)
//        singupBtn = BNUIButton_Loging(frame: CGRect(x:0, y: ypos, width:screenWidth, height: 65), color:UIColor.biinOrange(), text:NSLocalizedString("LetsGetStarted", comment: "LetsGetStarted"), textColor:UIColor.whiteColor())
//        singupBtn!.addTarget(self, action: "singup:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(singupBtn!)
        
        singupBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 60))
        singupBtn!.backgroundColor = UIColor.biinOrange()
        singupBtn!.layer.cornerRadius = 2
//        singupBtn!.layer.shadowColor = UIColor.blackColor().CGColor
//        singupBtn!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        singupBtn!.layer.shadowOpacity = 0.25
        singupBtn!.setTitle(NSLocalizedString("LetsGetStarted", comment: "LetsGetStarted"), forState: UIControlState.Normal)
        singupBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
        singupBtn!.addTarget(self, action: #selector(self.singup(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(singupBtn!)
        

        signupLbl = UILabel(frame: CGRectMake(10, 0, (screenWidth - 20), 16))
        signupLbl!.text = NSLocalizedString("DontForget", comment: "DontForget")
        signupLbl!.textAlignment = NSTextAlignment.Left
        signupLbl!.textColor = UIColor.darkGrayColor()
        signupLbl!.numberOfLines = 0
        signupLbl!.font = UIFont(name: "Lato-Light", size: 13)
        signupLbl!.sizeToFit()
        self.addSubview(signupLbl!)
        
        signupLbl!.frame.origin.y = SharedUIManager.instance.screenHeight - (signupLbl!.frame.height + 5)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow), name: UIKeyboardDidShowNotification , object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidHide), name: UIKeyboardDidHideNotification, object: nil)
        
        newUser = Biinie()

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
                
            //if genderStr!.isEmpty {
                //genderTxt!.showError()
            //}
                
            if SharedUIManager.instance.isValidEmail(emailTxt!.textField!.text!) {
                ready = true
            }else{
                emailTxt!.showError()
            }
        }
        
        
        if ready {
            
            let firstName = firstNameTxt!.textField!.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let lastName = lastNameTxt!.textField!.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let email = emailTxt!.textField!.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            
            newUser!.identifier = emailTxt!.textField!.text!
            newUser!.firstName = firstName
            newUser!.lastName = lastName
            newUser!.email = email
            newUser!.gender = genderStr
            newUser!.password = passwordTxt!.textField!.text
            
            newUser!.token = BNAppSharedManager.instance.dataManager.biinie!.token
            newUser!.needsTokenUpdate = BNAppSharedManager.instance.dataManager.biinie!.needsTokenUpdate
            
            BNAppSharedManager.instance.dataManager.biinie = newUser
            
            BNAppSharedManager.instance.networkManager.register(BNAppSharedManager.instance.dataManager.biinie!)
            delegate!.showProgress!(self)
            self.endEditing(true)
            SharedAnswersManager.instance.logSignUp("Email")
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

        return true
    }// return NO to disallow editing.
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        
        if textField.placeholder == NSLocalizedString("EnterYourBirthDate", comment: "EnterYourBirthDate") {
            let datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(self.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
            
        }
    }// became first responder
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
 
        return true
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(textField: UITextField) {
        

    }// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        textField.textColor = UIColor.appTextColor()
        
        if !textField.text!.isEmpty {
            
            textField.text = SharedUIManager.instance.removeSpecielCharacter(textField.text!)
        }
        
        return true
    }// return NO to not change text
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        //singupBtn!.showDisable()
        return false
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
    
        return false
    }// called when 'return' key pressed. return NO to ignore.
    
    func handleDatePicker(sender: UIDatePicker) {
        birthDateTxt!.textField!.text = sender.date.bnDisplayDateFormatt()
        newUser!.birthDate = sender.date
//        BNAppSharedManager.instance.dataManager.bnUser!.birthDate = sender.date
    }
}

@objc protocol SignupView_Delegate:NSObjectProtocol {
    optional func showProgress(view:UIView)
    optional func hideSignUpView()
}