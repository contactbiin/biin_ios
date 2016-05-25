//  LoginView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoginView:UIView, UITextFieldDelegate {
    
    var delegate:LoginView_Delegate?
    //var biinLogo:BNUIBiinView?
//    var biinLogoImage:UIImageView?
//    var welcomeLbl:UILabel?
    
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    
    var emailTxt:BNUITexfield_Top?
    var passwordTxt:BNUITexfield_Bottom?
    var continueBtn:UIButton?
    //var singupBtn:BNUIButton_Loging?
    var signupLbl:UILabel?
    var isKeyboardUp = false
    
    var testBtn:UIButton?
    
//    override init() {
//        super.init()
//    }
    
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
        let titleText = NSLocalizedString("LoginTitle", comment: "LoginTitle").uppercaseString
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


        
        ypos += SharedUIManager.instance.signupView_ypos_1
  
        let textBg = UIView(frame: CGRectMake(0, ypos, screenWidth, 100))
        textBg.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        self.addSubview(textBg)

        let descLbl = UILabel(frame: CGRectMake(20, 30, (screenWidth - 40), 60))
        descLbl.textColor = UIColor.darkGrayColor()
        descLbl.font = UIFont(name: "Lato-Light", size: 18)
        descLbl.textAlignment = NSTextAlignment.Center
        descLbl.text = NSLocalizedString("LoginDesc", comment: "LoginDesc")
        descLbl.numberOfLines = 2
        descLbl.sizeToFit()
        textBg.addSubview(descLbl)
        
        ypos += 105
        
        emailTxt = BNUITexfield_Top(frame: CGRectMake(5, ypos, (screenWidth - 10), 55), placeHolderText:NSLocalizedString("Email", comment: "Email"))
        emailTxt!.textField!.delegate = self
        emailTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        emailTxt!.textField!.keyboardType = UIKeyboardType.EmailAddress
        self.addSubview(emailTxt!)
        //emailTxt!.setNeedsDisplay()
        
        ypos += (1 + emailTxt!.frame.height)
        passwordTxt = BNUITexfield_Bottom(frame: CGRectMake(5, ypos, (screenWidth - 10), 55), placeHolderText:NSLocalizedString("Password", comment: "Password"))
        passwordTxt!.textField!.delegate = self
        passwordTxt!.textField!.secureTextEntry = true
        passwordTxt!.textField!.autocapitalizationType = UITextAutocapitalizationType.None
        passwordTxt!.textField!.keyboardType = UIKeyboardType.Default
        self.addSubview(passwordTxt!)
        
        ypos += (5 + passwordTxt!.frame.height)
        
//        continueBtn = BNUIButton_Loging(frame: CGRect(x:5, y: ypos, width:frame.width, height: 65), color:UIColor.biinOrange(), text:NSLocalizedString("ContinueBtn", comment: "ContinueBtn"), textColor:UIColor.whiteColor())
//        continueBtn!.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(continueBtn!)

        
        continueBtn = UIButton(frame: CGRectMake(5, ypos, (frame.width - 10), 60))
        continueBtn!.backgroundColor = UIColor.biinOrange()
        continueBtn!.layer.cornerRadius = 2
//        continueBtn!.layer.shadowColor = UIColor.blackColor().CGColor
//        continueBtn!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        continueBtn!.layer.shadowOpacity = 0.25
        continueBtn!.setTitle(NSLocalizedString("ContinueBtn", comment: "ContinueBtn"), forState: UIControlState.Normal)
        continueBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
        continueBtn!.addTarget(self, action: #selector(self.login(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(continueBtn!)

        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow), name: UIKeyboardDidShowNotification , object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidHide), name: UIKeyboardDidHideNotification, object: nil)

        //layerGradient()
    }
    
    func backBtnAction(sender:BNUIButton_Loging){
        self.endEditing(true)
        delegate!.hideLoginView!()
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
    
    func login(sender:BNUIButton_Loging){
        
        var ready = false
        
        if  emailTxt!.isValid() &&
            passwordTxt!.isValid() {
            
            if SharedUIManager.instance.isValidEmail(emailTxt!.textField!.text!) {
                ready = true
            }else{
                emailTxt!.showError()
            }
        }

        if ready {
            
            let password = passwordTxt!.textField!.text!.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let email = emailTxt!.textField!.text!.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            BNAppSharedManager.instance.networkManager.login(email, password: password)
            
            delegate!.showProgress!(self)
            self.endEditing(true)
            SharedAnswersManager.instance.logLogIn("Email")
            //continueBtn!.showDisable()
        }
    }
    
    func clean(){

    }
    
    func signup(sender:BNUIButton_Loging) {
        //delegate!.showSignupView!(self)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }// return NO to disallow editing.
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        
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
        

        return false
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        return false
    }// called when 'return' key pressed. return NO to ignore.
}

@objc protocol LoginView_Delegate:NSObjectProtocol {
    optional func hideLoginView()
    //optional func showSignupView(view:UIView)
    optional func showProgress(view:UIView)
    //optional func test(view:UIView)
}

extension UIView {
    func layerGradient() {
        let gradient:CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor.bnGradientColor1().CGColor, UIColor.bnGradientColor2().CGColor]
        gradient.locations = [0.5 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.insertSublayer(gradient, atIndex: 0)
    }
}
