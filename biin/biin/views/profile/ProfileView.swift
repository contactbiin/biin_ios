//
//  ProfileView.swift
//  biin
//
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: BNView, UITextFieldDelegate {
    
    var delegate:ProfileView_Delegate?
    var delegateFather:ProfileView_Delegate?
    
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var fade:UIView?

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
    
    var saveBtn:BNUIButton_Loging?
    var areCategoriesChanged = false
    var categoriesTitle:UILabel?
    var categoriesSelected = Dictionary<String, String>()
    
    var scroll:UIScrollView?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        title = UILabel(frame: CGRectMake(0, 25, screenWidth, (SharedUIManager.instance.siteView_titleSize + 2)))
        title!.text = NSLocalizedString("Profile", comment: "title")
        title!.textColor = UIColor.appTextColor()
        title!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_titleSize )
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(2, 25, 40, 20))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)

        var headerWidth = screenWidth - 60
        var xpos:CGFloat = (screenWidth - headerWidth) / 2
        var ypos:CGFloat = 15
        
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
        
        ypos += 40
        var line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - ypos)))
        self.addSubview(scroll!)
        self.addSubview(line)
        
        ypos = 5
        var nameLbl = UILabel(frame: CGRectMake(-10, (ypos + 8), (screenWidth / 2), 14))
        nameLbl.font = UIFont(name: "Lato-Light", size: 12)
        nameLbl.text = NSLocalizedString("Name", comment: "name")
        nameLbl.textColor = UIColor.biinColor()
        nameLbl.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(nameLbl)
        
        nameTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) - 10), (ypos + 8), (screenWidth / 2), 14),placeHolderText:NSLocalizedString("Name", comment: "name"))
        nameTxt!.textField!.delegate = self
        nameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.bnUser!.firstName!
        nameTxt!.textField!.textColor = UIColor.appTextColor()
        scroll!.addSubview(nameTxt!)

        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)

        var lastNameLbl = UILabel(frame: CGRectMake(-10, (ypos + 8), (screenWidth / 2), 14))
        lastNameLbl.font = UIFont(name: "Lato-Light", size: 12)
        lastNameLbl.text = NSLocalizedString("Lastname", comment: "Lastname")
        lastNameLbl.textColor = UIColor.biinColor()
        lastNameLbl.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(lastNameLbl)
        
        lastNameTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) - 10), (ypos + 8), (screenWidth / 2), 14),placeHolderText:NSLocalizedString("Lastname", comment: "Lastname"))
        lastNameTxt!.textField!.delegate = self
        lastNameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.bnUser!.lastName!
        lastNameTxt!.textField!.textColor = UIColor.appTextColor()
        scroll!.addSubview(lastNameTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)
        
        var userNameLbl = UILabel(frame: CGRectMake(-10, (ypos + 8), (screenWidth / 2), 14))
        userNameLbl.font = UIFont(name: "Lato-Light", size: 12)
        userNameLbl.text = NSLocalizedString("Username", comment: "Username")
        userNameLbl.textColor = UIColor.biinColor()
        userNameLbl.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(userNameLbl)
        
        usernameTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) - 10), (ypos + 8), (screenWidth / 2), 14),placeHolderText:NSLocalizedString("Username", comment: "Username"))
        usernameTxt!.textField!.delegate = self
        usernameTxt!.textField!.text = BNAppSharedManager.instance.dataManager.bnUser!.biinName!
        usernameTxt!.textField!.textColor = UIColor.appTextColor()
        usernameTxt!.textField!.enabled = false
        scroll!.addSubview(usernameTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)
        
        var emailLbl = UILabel(frame: CGRectMake(-10, (ypos + 8), (screenWidth / 2), 14))
        emailLbl.font = UIFont(name: "Lato-Light", size: 12)
        emailLbl.text = NSLocalizedString("Email", comment: "Email")
        emailLbl.textColor = UIColor.biinColor()
        emailLbl.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(emailLbl)
        
        emailTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) - 10), (ypos + 8), (screenWidth / 2), 14),placeHolderText:NSLocalizedString("Email", comment: "Email"))
        emailTxt!.textField!.delegate = self
        emailTxt!.textField!.text = BNAppSharedManager.instance.dataManager.bnUser!.email!
        emailTxt!.textField!.textColor = UIColor.appTextColor()
        scroll!.addSubview(emailTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)
        
        var emailVerifyLbl = UILabel(frame: CGRectMake(-10, (ypos + 8), (screenWidth / 2), 14))
        emailVerifyLbl.font = UIFont(name: "Lato-Light", size: 12)
        emailVerifyLbl.text = NSLocalizedString("IsEmailVerified", comment: "IsEmailVerified")
        emailVerifyLbl.textColor = UIColor.biinColor()
        emailVerifyLbl.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(emailVerifyLbl)
        
        emailVerifyTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) - 10), (ypos + 8), (screenWidth / 2), 14),placeHolderText:"")
        emailVerifyTxt!.textField!.delegate = self
        
        if BNAppSharedManager.instance.dataManager.bnUser!.isEmailVerified! {
            emailVerifyTxt!.textField!.text = NSLocalizedString("Yes", comment: "yes")
        emailVerifyTxt!.textField!.textColor = UIColor.appTextColor()
        }else {
            emailVerifyTxt!.textField!.text = NSLocalizedString("No", comment: "no")
            emailVerifyTxt!.textField!.textColor = UIColor.bnRed()
        }
        
        scroll!.addSubview(emailVerifyTxt!)
        emailVerifyTxt!.textField!.enabled = false
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)
        
        var birthDateLbl = UILabel(frame: CGRectMake(-10, (ypos + 8), (screenWidth / 2), 14))
        birthDateLbl.font = UIFont(name: "Lato-Light", size: 12)
        birthDateLbl.text = NSLocalizedString("Birthdate", comment: "Birthdate")
        birthDateLbl.textColor = UIColor.biinColor()
        birthDateLbl.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(birthDateLbl)
        
        birthDateTxt = BNUITexfield(frame: CGRectMake(((screenWidth / 2) - 10), (ypos + 8), (screenWidth / 2), 14),placeHolderText:NSLocalizedString("EnterYourBirthDate", comment: "EnterYourBirthDate"))
        birthDateTxt!.textField!.delegate = self
        if BNAppSharedManager.instance.dataManager.bnUser!.birthDate != nil {
            birthDateTxt!.textField!.text = BNAppSharedManager.instance.dataManager.bnUser!.birthDate!.bnDisplayDateFormatt()
        }
        birthDateTxt!.textField!.textColor = UIColor.appTextColor()
        scroll!.addSubview(birthDateTxt!)
        
        ypos += 30
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)
        
        genderLbl = UILabel(frame: CGRectMake(-10, (ypos + 13), (screenWidth / 2), 14))
        genderLbl!.font = UIFont(name: "Lato-Light", size: 12)
        genderStr = BNAppSharedManager.instance.dataManager.bnUser!.gender!
        
        if genderStr == "male"  {
            genderLbl!.text = NSLocalizedString("GenderMale", comment: "GenderMale")
        } else  {
            genderLbl!.text = NSLocalizedString("GenderFemale", comment: "GenderFemale")
        }

        genderLbl!.textColor = UIColor.biinColor()
        genderLbl!.textAlignment = NSTextAlignment.Right
        scroll!.addSubview(genderLbl!)
        
        femaleBtn = BNUIButton_Gender(frame: CGRectMake(((screenWidth / 2) + 10), (ypos + 5), 30, 30), iconType: BNIconType.femaleSmall)
        femaleBtn!.addTarget(self, action: "femaleBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(femaleBtn!)
        
        maleBtn = BNUIButton_Gender(frame: CGRectMake(((screenWidth / 2) + 45), (ypos + 5), 30, 30), iconType: BNIconType.maleSmall)
        maleBtn!.addTarget(self, action: "maleBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(maleBtn!)
        
        if genderStr! == "male" {
            maleBtn!.showSelected()
            femaleBtn!.showEnable()
        } else {
            femaleBtn!.showSelected()
            maleBtn!.showEnable()
        }
        
        ypos += 40
        line = UIView(frame: CGRectMake(5, (ypos), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        scroll!.addSubview(line)
        
        
        //Birthdate
        
        
//        ypos += 10
//        categoriesBtn = BNUIButton_Loging(frame: CGRectMake(((screenWidth - 150) / 2), ypos, 150, 60), color: UIColor.biinColor(), text: "Categories")
//        self.addSubview(categoriesBtn!)
        
        ypos += 20
        categoriesTitle = UILabel(frame:CGRectMake(0, ypos, (screenWidth / 2), 45))
        categoriesTitle!.textColor = UIColor.appTextColor()
        categoriesTitle!.font = UIFont(name: "Lato-Light", size: 16)
        categoriesTitle!.text = NSLocalizedString("WhatAreYouInterest", comment: "WhatAreYouInterest")
        categoriesTitle!.numberOfLines = 2
        categoriesTitle!.textAlignment  = NSTextAlignment.Center
        categoriesTitle!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        categoriesTitle!.sizeToFit()
        scroll!.addSubview(categoriesTitle!)
        
        xpos = (screenWidth - categoriesTitle!.frame.width) / 2
        categoriesTitle!.frame.origin.x = xpos
        
        var buttonCounter:Int = 1
        xpos = (screenWidth - 295) / 2
        ypos += 50
        var space:CGFloat = 5
        
        
        for category in BNAppSharedManager.instance.dataManager.categories! {
            
            var button = BNUIButton_Category(frame: CGRectMake(xpos, ypos, 70, 70), categoryIdentifier:category.identifier!, iconType: BNIconType.burgerSmall, text:category.name!, selectedColor:UIColor.biinColor(), unSelectedColor:UIColor.appButtonColor())
            button.addTarget(self, action: "categoryBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
            scroll!.addSubview(button)
            buttonCounter++
            
            for userCategory in BNAppSharedManager.instance.dataManager.bnUser!.categories {
                if userCategory.identifier! == category.identifier! {
                    button.showSelected()
                    categoriesSelected[button.categoryIdentifier!] = button.categoryIdentifier!
                }
            }
            
            if buttonCounter <= 4 {
                xpos += 75
            } else {
                xpos = (screenWidth - 295) / 2
                ypos += 75
                buttonCounter = 1
            }
        }
        
        ypos += 10
        saveBtn = BNUIButton_Loging(frame: CGRectMake(((screenWidth - 150) / 2), ypos, 150, 60), color: UIColor.biinColor(), text:NSLocalizedString("Save", comment: "Save") )
        saveBtn!.addTarget(self, action: "saveBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        saveBtn!.layer.borderColor = UIColor.appButtonColor().CGColor
        scroll!.addSubview(saveBtn!)
        
        ypos += 75
        scroll!.contentSize = CGSizeMake(screenWidth, ypos)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        var tap = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(tap)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        println("trasition in on ProfileView")
        
        UIView.animateWithDuration(0.2, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on ProfileView")
        state!.action()
        
        if state!.stateType == BNStateType.BiinieCategoriesState
            || state!.stateType == BNStateType.SiteState {
        
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            })
        } else {
           
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.fade!.alpha = 0.25
            })
            
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "hideView:", userInfo: nil, repeats: false)
  
            
        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
        self.fade!.alpha = 0
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: ElementView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: ElementView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegateFather!.hideProfileView!(self)
        scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    func femaleBtnAction(sender:BNUIButton_Gender){
        //genderStr = "female"
        genderLbl!.text = NSLocalizedString("GenderFemale", comment: "GenderFemale")//"I'm a \(genderStr!)"
        femaleBtn!.showSelected()
        maleBtn!.showEnable()
    }
    
    func maleBtnAction(sender:BNUIButton_Gender){
        //genderStr = "male"
        genderLbl!.text = NSLocalizedString("GenderMale", comment: "GenderMale")//"I'm a \(genderStr!)"
        maleBtn!.showSelected()
        femaleBtn!.showEnable()
    }
    
    func saveBtnAction(sender:BNUIButton_Loging){
        var ready = false
        
        if nameTxt!.isValid() &&
            lastNameTxt!.isValid() &&
            emailTxt!.isValid() {
            
            if SharedUIManager.instance.isValidEmail(emailTxt!.textField!.text) {
                ready = true
            }else{
                emailTxt!.showError()
            }
        }
        
        
        if ready {
            
            BNAppSharedManager.instance.dataManager.bnUser!.firstName = nameTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.bnUser!.lastName = lastNameTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.bnUser!.email = emailTxt!.textField!.text!
            BNAppSharedManager.instance.dataManager.bnUser!.gender = genderStr!
            
            BNAppSharedManager.instance.networkManager.sendBiinie(BNAppSharedManager.instance.dataManager.bnUser!)
            
            /*
            var user = BNUser(identifier:emailTxt!.textField!.text, firstName: nameTxt!.textField!.text, lastName: lastNameTxt!.textField!.text, email: emailTxt!.textField!.text, gender:genderStr!)
            user.password = passwordTxt!.textField!.text
            BNAppSharedManager.instance.networkManager.register(user)
            
            self.endEditing(true)
            //singupBtn!.showDisable()
            */
            
            if areCategoriesChanged {
                //Save categories for user
                areCategoriesChanged = false
                BNAppSharedManager.instance.networkManager.sendBiinieCategories(BNAppSharedManager.instance.dataManager.bnUser!, categories: categoriesSelected)
            }
            
            delegate!.showProgress!(self)
        }

    }

    func categoryBtnAction(sender:BNUIButton_Category){
        
        sender.showSelected()
        areCategoriesChanged = true
        
        if categoriesSelected[sender.categoryIdentifier!] == nil {
            categoriesSelected[sender.categoryIdentifier!] = sender.categoryIdentifier!
        } else {
            categoriesSelected[sender.categoryIdentifier!] = nil
        }
    }
    
    func tapped(sender:UIGestureRecognizer){
        endEditing(true)
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        println("textFieldShouldBeginEditing")
        
        return true
    }// return NO to disallow editing.
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        println("textFieldDidBeginEditing")
        
        if textField.placeholder == "Enter your birthDate" {
            var datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)

        }
        
    }// became first responder
    
    func handleDatePicker(sender: UIDatePicker) {
        birthDateTxt!.textField!.text = sender.date.bnDisplayDateFormatt()
        BNAppSharedManager.instance.dataManager.bnUser!.birthDate = sender.date
        println("\(sender.date.bnDisplayDateFormatt())")
        println("\(sender.date.bnDateFormatt())")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println("textFieldShouldEndEditing")
        return true
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("textFieldDidEndEditing")
        
        if textField.placeholder == "Name" || textField.placeholder == "Lastname" {
            biinieNameLbl!.text = "\(nameTxt!.textField!.text) \(lastNameTxt!.textField!.text)"
        }
        
        if textField.placeholder == "Email" {
            biinieUserNameLbl!.text = "\(emailTxt!.textField!.text)"
        }
    }// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {        
        return true
    }// return NO to not change text
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        println("textFieldShouldClear")
        
        return false
    }// called when clear button pressed. return NO to ignore (no notifications)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("textFieldShouldReturn")
        var uuu = ""
        return false
    }// called when 'return' key pressed. return NO to ignore.
}

@objc protocol ProfileView_Delegate:NSObjectProtocol {
    optional func hideProfileView(view:ProfileView)
    optional func showProgress(view:UIView)
}

extension String
{
    subscript(integerIndex: Int) -> Character
        {
            let index = advance(startIndex, integerIndex)
            return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String
        {
            let start = advance(startIndex, integerRange.startIndex)
            let end = advance(startIndex, integerRange.endIndex)
            let range = start..<end
            return self[range]
    }
}
