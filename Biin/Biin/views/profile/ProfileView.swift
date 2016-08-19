//
//  ProfileView.swift
//  biin
//
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class ProfileView: BNView, UITextFieldDelegate {
    
    var delegate:ProfileView_Delegate?
    var delegateFather:ProfileView_Delegate?
    
    var title:UILabel?
    var backBtn:BNUIButton_Back?
//    var fade:UIView?

    var biinieAvatar:BNUIImageView?
    var biinieNameLbl:UILabel?
    var biinieUserNameLbl:UILabel?
    
//    var nameTitleLbl:UILabel?
//    var lastNameTitleLbl:UILabel?
    
    var femaleBtn:BNUIButton_Gender?
    var maleBtn:BNUIButton_Gender?
    var genderStr:String?
    var genderLbl:UILabel?
    
    var nameTxt:BNUITexfield?
    var lastNameTxt:BNUITexfield?
    var usernameTxt:BNUITexfield?
    var emailTxt:BNUITexfield?
    var emailVerifyTxt:BNUITexfield?
    var birthDateTxt:BNUITexfield?
    
    var saveBtn:UIButton?
    var areCategoriesChanged = false
    var categoriesTitle:UILabel?
    var categoriesSelected = Dictionary<String, String>()
    
    //var scroll:UIScrollView?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
//        visualEffectView.frame = self.bounds
//        self.addSubview(visualEffectView)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
//        title = UILabel(frame: CGRectMake(0, 25, screenWidth, (SharedUIManager.instance.siteView_titleSize + 2)))
//        title!.text = NSLocalizedString("Profile", comment: "title")
//        title!.textColor = UIColor.appTextColor()
//        title!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_titleSize )
//        title!.textAlignment = NSTextAlignment.Center
//        self.addSubview(title!)
        
        var ypos:CGFloat = 27
        
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.mainView_TitleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.mainView_TitleSize)
        let titleText = NSLocalizedString("Profile", comment: "title").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textAlignment = NSTextAlignment.Center
        title!.textColor = UIColor.whiteColor()
        self.addSubview(title!)
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
//        backBtn!.layer.borderColor = UIColor.darkGrayColor().CGColor
//        backBtn!.layer.backgroundColor = UIColor.darkGrayColor().CGColor

//        backBtn!.layer.cornerRadius  = 17.5
//        backBtn!.layer.borderWidth = 1
//        backBtn!.layer.masksToBounds = true
        
        self.addSubview(backBtn!)
        
        
        //let headerWidth = screenWidth - 50
        //var xpos:CGFloat = (screenWidth - headerWidth) / 2
        //ypos = 15
        
        /*
        var biinieAvatarView = UIView(frame: CGRectMake(xpos, ypos, 92, 92))
        biinieAvatarView.layer.cornerRadius = 35
        biinieAvatarView.layer.borderColor = UIColor.appBackground().CGColor
        biinieAvatarView.layer.borderWidth = 6
        biinieAvatarView.layer.masksToBounds = true
        self.addSubview(biinieAvatarView)
        
        if BNAppSharedManager.instance.dataManager.bnUser!.imgUrl != "" {
            biinieAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
            //biinieAvatar!.alpha = 0
            biinieAvatar!.layer.cornerRadius = 30
            biinieAvatar!.layer.masksToBounds = true
            biinieAvatarView.addSubview(biinieAvatar!)
            BNAppSharedManager.instance.networkManager.requestImageData(BNAppSharedManager.instance.dataManager.bnUser!.imgUrl!, image: biinieAvatar)
        } else  {
            var initials = UILabel(frame: CGRectMake(0, 25, 90, 40))
            initials.font = UIFont(name: "Lato-Light", size: 38)
            initials.textColor = UIColor.appMainColor()
            initials.textAlignment = NSTextAlignment.Center
            initials.text = "\(first(BNAppSharedManager.instance.dataManager.bnUser!.firstName!)!)\(first(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)!)"
            biinieAvatarView.addSubview(initials)
            biinieAvatarView.backgroundColor = UIColor.biinColor()
        }

        
        
//        biinieNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 30), (headerWidth - 95), 20))
        biinieNameLbl = UILabel(frame: CGRectMake(6, 25, (screenWidth - 20), 20))
        biinieNameLbl!.font = UIFont(name: "Lato-Regular", size: 22)
        biinieNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.firstName!) \(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)"
        biinieNameLbl!.textColor = UIColor.biinColor()
        biinieNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(biinieNameLbl!)
        
        //biinieUserNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 50), (headerWidth - 95), 14))
        biinieUserNameLbl = UILabel(frame: CGRectMake(6, 45, (screenWidth - 20), 14))
        biinieUserNameLbl!.font = UIFont(name: "Lato-Light", size: 12)
        biinieUserNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.biinName!)"
        biinieUserNameLbl!.textColor = UIColor.appTextColor()
        biinieUserNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(biinieUserNameLbl!)
        */
        
        ypos = SharedUIManager.instance.mainView_HeaderSize
        var line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.darkGrayColor()
        
        //scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - ypos)))
        //scroll!.backgroundColor = UIColor.clearColor()
        //self.addSubview(scroll!)
        self.addSubview(line)

        let fontSize:CGFloat = 13
        let labelHeight:CGFloat = fontSize + 3
        
        ypos += 25
        let nameLbl = UILabel(frame: CGRectMake(0, (ypos + 8), ((screenWidth / 2 ) + 10), labelHeight))
        nameLbl.font = UIFont(name: "Lato-Regular", size: fontSize)
        nameLbl.text = NSLocalizedString("Name", comment: "name").uppercaseString
        nameLbl.textColor = UIColor.whiteColor()
        nameLbl.textAlignment = NSTextAlignment.Right
        self.addSubview(nameLbl)
        
        nameTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 8), (screenWidth / 2), labelHeight),placeHolderText:NSLocalizedString("Name", comment: "name"))
        nameTxt!.textField!.delegate = self
        nameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.firstName!
        nameTxt!.textField!.textColor = UIColor.whiteColor()
        self.addSubview(nameTxt!)

        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)

        let lastNameLbl = UILabel(frame: CGRectMake(0, (ypos + 8), ((screenWidth / 2) + 10), labelHeight))
        lastNameLbl.font = UIFont(name: "Lato-Regular", size: fontSize)
        lastNameLbl.text = NSLocalizedString("Lastname", comment: "Lastname").uppercaseString
        lastNameLbl.textColor = UIColor.whiteColor()
        lastNameLbl.textAlignment = NSTextAlignment.Right
        self.addSubview(lastNameLbl)
        
        lastNameTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 8), (screenWidth / 2), labelHeight),placeHolderText:NSLocalizedString("Lastname", comment: "Lastname"))
        lastNameTxt!.textField!.delegate = self
        lastNameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.lastName!
        lastNameTxt!.textField!.textColor = UIColor.whiteColor()
        self.addSubview(lastNameTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)
        
        let userNameLbl = UILabel(frame: CGRectMake(0, (ypos + 8), ((screenWidth / 2) + 10), labelHeight))
        userNameLbl.font = UIFont(name: "Lato-Regular", size: fontSize)
        userNameLbl.text = NSLocalizedString("Username", comment: "Username").uppercaseString
        userNameLbl.textColor = UIColor.whiteColor()
        userNameLbl.textAlignment = NSTextAlignment.Right
        self.addSubview(userNameLbl)
        
        usernameTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 8), (screenWidth / 2), labelHeight),placeHolderText:NSLocalizedString("Username", comment: "Username"))
        usernameTxt!.textField!.delegate = self
        usernameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.biinName!
        usernameTxt!.textField!.textColor = UIColor.whiteColor()
        usernameTxt!.textField!.enabled = false
        self.addSubview(usernameTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)
        
        let emailLbl = UILabel(frame: CGRectMake(0, (ypos + 8), ((screenWidth / 2) + 10), labelHeight))
        emailLbl.font = UIFont(name: "Lato-Regular", size: fontSize)
        emailLbl.text = NSLocalizedString("Email", comment: "Email").uppercaseString
        emailLbl.textColor = UIColor.whiteColor()
        emailLbl.textAlignment = NSTextAlignment.Right
        self.addSubview(emailLbl)
        
        emailTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 8), (screenWidth / 2), labelHeight),placeHolderText:NSLocalizedString("Email", comment: "Email"))
        emailTxt!.textField!.delegate = self
        emailTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.email!
        emailTxt!.textField!.textColor = UIColor.whiteColor()
        self.addSubview(emailTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)
        
        let emailVerifyLbl = UILabel(frame: CGRectMake(0, (ypos + 8), ((screenWidth / 2) + 10), labelHeight))
        emailVerifyLbl.font = UIFont(name: "Lato-Regular", size: fontSize)
        emailVerifyLbl.text = NSLocalizedString("IsEmailVerified", comment: "IsEmailVerified").uppercaseString
        emailVerifyLbl.textColor = UIColor.whiteColor()
        emailVerifyLbl.textAlignment = NSTextAlignment.Right
        self.addSubview(emailVerifyLbl)
        
        emailVerifyTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 8), (screenWidth / 2), labelHeight),placeHolderText:"")
        emailVerifyTxt!.textField!.delegate = self
        
        if BNAppSharedManager.instance.dataManager.biinie!.isEmailVerified! {
            emailVerifyTxt!.textField!.text = NSLocalizedString("Yes", comment: "yes")
        emailVerifyTxt!.textField!.textColor = UIColor.whiteColor()
        }else {
            emailVerifyTxt!.textField!.text = NSLocalizedString("No", comment: "no")
            emailVerifyTxt!.textField!.textColor = UIColor.biinOrange()
        }
        
        self.addSubview(emailVerifyTxt!)
        emailVerifyTxt!.textField!.enabled = false
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)
        
        let birthDateLbl = UILabel(frame: CGRectMake(0, (ypos + 8), ((screenWidth / 2) + 10), labelHeight))
        birthDateLbl.font = UIFont(name: "Lato-Regular", size: fontSize)
        birthDateLbl.text = NSLocalizedString("Birthdate", comment: "Birthdate").uppercaseString
        birthDateLbl.textColor = UIColor.whiteColor()
        birthDateLbl.textAlignment = NSTextAlignment.Right
        self.addSubview(birthDateLbl)
        
        birthDateTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 8), (screenWidth / 2), labelHeight),placeHolderText:NSLocalizedString("EnterYourBirthDate", comment: "EnterYourBirthDate"))
        birthDateTxt!.textField!.delegate = self
        if BNAppSharedManager.instance.dataManager.biinie!.birthDate != nil {
            birthDateTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.birthDate!.bnDisplayDateFormatt()
        }
        birthDateTxt!.textField!.textColor = UIColor.whiteColor()
        self.addSubview(birthDateTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)
        
        genderLbl = UILabel(frame: CGRectMake(0, (ypos + 13), ((screenWidth / 2) + 10), labelHeight))
        genderLbl!.font = UIFont(name: "Lato-Regular", size: fontSize)
        genderStr = BNAppSharedManager.instance.dataManager.biinie!.gender!
        
        if genderStr == "none" {
            genderLbl!.text = NSLocalizedString("GenderSelect", comment: "GenderSelect").uppercaseString
        } else if genderStr == "male" {
            genderLbl!.text = NSLocalizedString("GenderMale", comment: "GenderMale").uppercaseString
        } else  {
            genderLbl!.text = NSLocalizedString("GenderFemale", comment: "GenderFemale").uppercaseString
        }

        genderLbl!.textColor = UIColor.whiteColor()
        genderLbl!.textAlignment = NSTextAlignment.Right
        self.addSubview(genderLbl!)
        
        femaleBtn = BNUIButton_Gender(frame: CGRectMake(((screenWidth / 2) + 20), (ypos + 5), 30, 30), iconType: BNIconType.femaleSmall)
        femaleBtn!.addTarget(self, action: #selector(self.femaleBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(femaleBtn!)
        
        maleBtn = BNUIButton_Gender(frame: CGRectMake(((screenWidth / 2) + 55), (ypos + 5), 30, 30), iconType: BNIconType.maleSmall)
        maleBtn!.addTarget(self, action: #selector(self.maleBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(maleBtn!)
        
        if genderStr == "none" {
            femaleBtn!.showEnable()
            maleBtn!.showEnable()
        } else if genderStr! == "male" {
            maleBtn!.showSelected()
            femaleBtn!.showEnable()
        } else {
            femaleBtn!.showSelected()
            maleBtn!.showEnable()
        }
        
        //ypos += 40
//        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
//        line.backgroundColor = UIColor.appBackground()
//        scroll!.addSubview(line)
        
        
        //Birthdate
        
        
//        ypos += 10
//        categoriesBtn = BNUIButton_Loging(frame: CGRectMake(((screenWidth - 150) / 2), ypos, 150, 60), color: UIColor.biinColor(), text: "Categories")
//        self.addSubview(categoriesBtn!)
        
        
        /*
        ypos += 70
        categoriesTitle = UILabel(frame:CGRectMake(10, ypos, screenWidth, 16))
        categoriesTitle!.textColor = UIColor.blackColor()
        categoriesTitle!.font = UIFont(name: "Lato-Regular", size: 13)
        categoriesTitle!.text = NSLocalizedString("WhatAreYouInterest", comment: "WhatAreYouInterest").uppercaseString
        categoriesTitle!.textAlignment  = NSTextAlignment.Left
        scroll!.addSubview(categoriesTitle!)
    
        
        //var buttonCounter:Int = 1
        //xpos = (screenWidth - 295) / 2
        //var space:CGFloat = 5
        
        var doNextButton = false
        var textWidth_Prev:CGFloat = 0
        ypos += (categoriesTitle!.frame.height - 30)
        xpos = 10
        
        for var i:Int = 0; i < BNAppSharedManager.instance.dataManager.categories!.count; i++ {
        
//        for category in BNAppSharedManager.instance.dataManager.categories! {
            
            
            let text = NSLocalizedString(BNAppSharedManager.instance.dataManager.categories![i].identifier!, comment:BNAppSharedManager.instance.dataManager.categories![i].identifier!)
            var textWidth:CGFloat = 0
            
            if !doNextButton {
                xpos = 1
                textWidth = SharedUIManager.instance.getStringLength(text, fontName: "Lato-Regular", fontSize: 12)
                textWidth += 60
                
                if textWidth > (screenWidth / 2) {
                    textWidth = (screenWidth / 2)
                }
                
                textWidth_Prev = textWidth
                doNextButton = true
                ypos += 36
            } else {
                textWidth = (screenWidth - (textWidth_Prev + 3))
                xpos = textWidth_Prev + 2
                doNextButton = false
                
            }
            
            if i == (BNAppSharedManager.instance.dataManager.categories!.count - 1) {
                textWidth = (screenWidth - 2)
                xpos = 1
            }
                        
            let button = BNUIButton_Category(frame: CGRectMake(xpos, ypos, textWidth, 35), categoryIdentifier:BNAppSharedManager.instance.dataManager.categories![i].identifier!, iconType: BNIconType.burgerSmall, text:text, selectedColor:UIColor.biinColor(), unSelectedColor:UIColor.appBackground())
            button.addTarget(self, action: "categoryBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
            scroll!.addSubview(button)
            //buttonCounter++
            
            for userCategory in BNAppSharedManager.instance.dataManager.bnUser!.categories {
                if userCategory.identifier! == BNAppSharedManager.instance.dataManager.categories![i].identifier! {
                    //button.showSelected()
                    categoriesSelected[BNAppSharedManager.instance.dataManager.categories![i].identifier!] = BNAppSharedManager.instance.dataManager.categories![i].identifier!
                }
            }

            
//            
//            if buttonCounter <= 4 {
//                xpos += 75
//            } else {
//                xpos = (screenWidth - 295) / 2
//                ypos += 75
//                buttonCounter = 1
//            }
        }
        */
        
        
        ypos += 36
        
        FBSDKApplicationDelegate.sharedInstance().application(nil, didFinishLaunchingWithOptions: nil)

//        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
//        } else {
        
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.addSubview(loginView)
            //            loginView.center = self.view.center
            loginView.frame = CGRectMake(5, (self.frame.height - 140), (screenWidth - 10), 60)
            loginView.readPermissions = ["public_profile", "email", "user_friends", "user_birthday"]
            loginView.layer.cornerRadius = 2
//            loginView.layer.shadowColor = UIColor.blackColor().CGColor
//            loginView.layer.shadowOffset = CGSize(width: 0, height: 0)
//            loginView.layer.shadowOpacity = 0.25
            loginView.delegate = (self.father as! MainView).rootViewController!
            loginView
//        }
        
        saveBtn = UIButton(frame: CGRectMake(5, (self.frame.height - 75), (screenWidth - 10), 50))
        saveBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 16)
        saveBtn!.setTitle(NSLocalizedString("Save", comment: "Save"), forState: UIControlState.Normal)
        saveBtn!.backgroundColor = UIColor.biinOrange()
        saveBtn!.layer.cornerRadius = 2
//        saveBtn!.layer.shadowColor = UIColor.blackColor().CGColor
//        saveBtn!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        saveBtn!.layer.shadowOpacity = 0.25
        
        saveBtn!.addTarget(self, action: #selector(self.saveBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(saveBtn!)
        
        //ypos += 200
        //scroll!.contentSize = CGSizeMake(screenWidth, ypos)
        //scroll!.userInteractionEnabled = false
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {

        
        UIView.animateWithDuration(0.2, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        
        state!.action()
        
        if state!.stateType == BNStateType.MainViewContainerState
            || state!.stateType == BNStateType.SiteState {
        
            UIView.animateWithDuration(0.35, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            })
        } else {
           
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.fade!.alpha = 0.25
            })
            
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.hideView(_:)), userInfo: nil, repeats: false)
  
            
        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
        self.fade!.alpha = 0
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegateFather!.hideProfileView!(self)
        //scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    func femaleBtnAction(sender:BNUIButton_Gender){
        genderStr = "female"
        genderLbl!.text = NSLocalizedString("GenderFemale", comment: "GenderFemale").uppercaseString//"I'm a \(genderStr!)"
        femaleBtn!.showSelected()
        maleBtn!.showEnable()
    }
    
    func maleBtnAction(sender:BNUIButton_Gender){
        genderStr = "male"
        genderLbl!.text = NSLocalizedString("GenderMale", comment: "GenderMale").uppercaseString//"I'm a \(genderStr!)"
        maleBtn!.showSelected()
        femaleBtn!.showEnable()
    }
    
    func saveBtnAction(sender:BNUIButton_Loging){
        var ready = false
        
        if nameTxt!.isValid() &&
            lastNameTxt!.isValid() &&
            emailTxt!.isValid() {
            
            if SharedUIManager.instance.isValidEmail(emailTxt!.textField!.text!) {
                ready = true
            }else{
                emailTxt!.showError()
            }
        }
        
        
        if ready {
            
            BNAppSharedManager.instance.dataManager.biinie!.firstName = nameTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.biinie!.lastName = lastNameTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.biinie!.email = emailTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.biinie!.gender = genderStr!
            BNAppSharedManager.instance.dataManager.biinie!.save()
            BNAppSharedManager.instance.networkManager.sendBiinie(BNAppSharedManager.instance.dataManager.biinie)
            
            /*
            var user = BNUser(identifier:emailTxt!.textField!.text, firstName: nameTxt!.textField!.text, lastName: lastNameTxt!.textField!.text, email: emailTxt!.textField!.text, gender:genderStr!)
            user.password = passwordTxt!.textField!.text
            BNAppSharedManager.instance.networkManager.register(user)
            
            self.endEditing(true)
            //singupBtn!.showDisable()
            */
            
//            if areCategoriesChanged {
//                //Save categories for user
//                areCategoriesChanged = false
//                BNAppSharedManager.instance.networkManager.sendBiinieCategories(BNAppSharedManager.instance.dataManager.bnUser!, categories: categoriesSelected)
//                //(father as! MainView).refresh()
//                
//            }
            
            delegate!.showProgress!(self)
        }

    }

//    func categoryBtnAction(sender:BNUIButton_Category){
//        
//        sender.showSelected()
//        areCategoriesChanged = true
//        
//        if categoriesSelected[sender.categoryIdentifier!] == nil {
//            categoriesSelected[sender.categoryIdentifier!] = sender.categoryIdentifier!
//        } else {
//            categoriesSelected[sender.categoryIdentifier!] = nil
//        }
//    }
    
    func tapped(sender:UIGestureRecognizer){
        endEditing(true)
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
    
    func handleDatePicker(sender: UIDatePicker) {
        birthDateTxt!.textField!.text = sender.date.bnDisplayDateFormatt()
        BNAppSharedManager.instance.dataManager.biinie!.birthDate = sender.date
        
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        return true
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        
        /*
        if textField.placeholder == "Name" || textField.placeholder == "Lastname" {
            biinieNameLbl!.text = "\(nameTxt!.textField!.text) \(lastNameTxt!.textField!.text)"
        }
        
        if textField.placeholder == "Email" {
            biinieUserNameLbl!.text = "\(emailTxt!.textField!.text)"
        }
        */
    }// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {        
        return true
    }// return NO to not change text
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        
        return false
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //var uuu = ""
        return false
    }// called when 'return' key pressed. return NO to ignore.
    
    override func clean() {
        delegate = nil
        delegateFather = nil
        
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()
        fade?.removeFromSuperview()
        
        biinieAvatar?.removeFromSuperview()
        biinieNameLbl?.removeFromSuperview()
        biinieUserNameLbl?.removeFromSuperview()
        
        femaleBtn?.removeFromSuperview()
        maleBtn?.removeFromSuperview()
        genderLbl?.removeFromSuperview()
        
        nameTxt?.clean()
        nameTxt!.removeFromSuperview()
        
        lastNameTxt?.clean()
        lastNameTxt?.removeFromSuperview()
        
        usernameTxt?.clean()
        usernameTxt?.removeFromSuperview()
        
        emailTxt?.clean()
        emailTxt?.removeFromSuperview()
        
        emailVerifyTxt?.clean()
        emailVerifyTxt?.removeFromSuperview()
        
        birthDateTxt?.clean()
        birthDateTxt?.removeFromSuperview()
        
        saveBtn?.removeFromSuperview()
                
        categoriesTitle?.removeFromSuperview()
        categoriesSelected.removeAll()
        
        //scroll?.removeFromSuperview()
    }
    
    func show() {
        
    }
    
    func update(){
        nameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.firstName!
        lastNameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.lastName!
        emailTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.email!
        usernameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.biinName!
        
        if BNAppSharedManager.instance.dataManager.biinie!.birthDate != nil {
            birthDateTxt!.textField!.text = BNAppSharedManager.instance.dataManager.biinie!.birthDate!.bnDisplayDateFormatt()
        }
        
        if BNAppSharedManager.instance.dataManager.biinie!.isEmailVerified! {
            emailVerifyTxt!.textField!.text = NSLocalizedString("Yes", comment: "yes")
            emailVerifyTxt!.textField!.textColor = UIColor.appTextColor()
        }else {
            emailVerifyTxt!.textField!.text = NSLocalizedString("No", comment: "no")
            emailVerifyTxt!.textField!.textColor = UIColor.biinOrange()
        }
        
        genderStr = BNAppSharedManager.instance.dataManager.biinie!.gender!
        
        if genderStr == "none" {
            genderLbl!.text = NSLocalizedString("GenderSelect", comment: "GenderSelect").uppercaseString
        } else if genderStr == "male" {
            genderLbl!.text = NSLocalizedString("GenderMale", comment: "GenderMale").uppercaseString
        } else  {
            genderLbl!.text = NSLocalizedString("GenderFemale", comment: "GenderFemale").uppercaseString
        }
        
        if genderStr == "none" {
            femaleBtn!.showEnable()
            maleBtn!.showEnable()
        } else if genderStr! == "male" {
            maleBtn!.showSelected()
            femaleBtn!.showEnable()
        } else {
            femaleBtn!.showSelected()
            maleBtn!.showEnable()
        }
    }
}

@objc protocol ProfileView_Delegate:NSObjectProtocol {
    optional func hideProfileView(view:ProfileView)
    optional func showProgress(view:UIView)
}

extension String
{
    subscript(integerIndex: Int) -> Character
        {
            let index = startIndex.advancedBy(integerIndex)
            return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String
        {
            let start = startIndex.advancedBy(integerRange.startIndex)
            let end = startIndex.advancedBy(integerRange.endIndex)
            let range = start..<end
            return self[range]
    }
}
