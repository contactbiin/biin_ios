//  SurveyView.swift
//  biin
//  Created by Esteban Padilla on 1/14/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SurveyView: BNView, UITextViewDelegate {
    
    var delegate:SurveyView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var siteAvatar:BNUIImageView?
    var organizationName:UILabel?

    var spacer:CGFloat = 1
    
//    var fade:UIView?
    
    //Rating section
//    var brandNameLbl:UILabel?
//    var brandGreetingsLbl:UILabel?
    var surveyQuestionLbl:UILabel?
//    var surveyAnswerLbl:UILabel?
    var rating:Int = 5
//    var slider:UISlider?
    var continueBtn:UIButton?

    //Comment section
    var textFieldView:UIView?
    var commentTxt:UITextView?
    var isSurveyDone = false
    
    var not_likely:UILabel?
    var likely:UILabel?
    
    weak var site:BNSite?
    var previousButton:UIButton?
    var buttons = Array<UIButton>()
    var isKeyboardUp = false
    
    override init(frame: CGRect, father:BNView?) {
        
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        var siteAvatarSize:CGFloat = 120//(SharedUIManager.instance.siteView_headerHeight)
        
        
        if SharedUIManager.instance.deviceType == BNDeviceType.iphone4s || SharedUIManager.instance.deviceType == BNDeviceType.iphone5 {
            siteAvatarSize = 80
        }
        
        var ypos:CGFloat = 27
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.mainView_TitleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.mainView_TitleSize)
        let titleText = NSLocalizedString("SurveyTitle", comment: "SurveyTitle").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()
        self.addSubview(backBtn!)
        
        
        ypos = SharedUIManager.instance.mainView_HeaderSize
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 1))
        line.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(line)
        
//        brandNameLbl = UILabel(frame: CGRectMake(10, ypos, (screenWidth - 20), 40))
//        self.addSubview(brandNameLbl!)
        
//        ypos += brandNameLbl!.frame.height + 10
//        brandGreetingsLbl = UILabel(frame: CGRectMake(20, ypos, (screenWidth - 40), 17))
//        self.addSubview(brandGreetingsLbl!)
        
//        ypos += brandGreetingsLbl!.frame.height + 50
        
        
        
        siteAvatar = BNUIImageView(frame: CGRectMake(((screenWidth - siteAvatarSize) / 2), ypos, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        siteAvatar!.layer.cornerRadius = 3
        siteAvatar!.layer.masksToBounds = true
        self.addSubview(siteAvatar!)

        ypos += (siteAvatarSize + 5)
        organizationName = UILabel(frame: CGRectMake(0, ypos, screenWidth, 30))
        organizationName!.text = "Org name here"
        organizationName!.font = UIFont(name:"Lato-Regular", size:28)
        organizationName!.textColor = UIColor.whiteColor()
        organizationName!.textAlignment = NSTextAlignment.Center
        self.addSubview(organizationName!)
        
        ypos += (organizationName!.frame.height + 10)
        surveyQuestionLbl = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 28))
        surveyQuestionLbl!.textColor = UIColor.whiteColor()
        self.addSubview(surveyQuestionLbl!)
        
//        surveyQuestionLbl!.sizeToFit()
        
//        ypos += surveyQuestionLbl!.frame.height + 10
//        surveyAnswerLbl = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 20))
//        surveyAnswerLbl!.text = "Definitivamente"
//        surveyAnswerLbl!.font = UIFont(name: "Lato-Black", size: 18)
//        surveyAnswerLbl!.numberOfLines = 0
//        surveyAnswerLbl!.textAlignment = NSTextAlignment.Center
//        self.addSubview(surveyAnswerLbl!)
        
        textFieldView = UIView(frame: CGRectMake(5, 0, (screenWidth - 10), 90))
        textFieldView!.backgroundColor = UIColor.appBackground()
        textFieldView!.layer.borderWidth = 1
        textFieldView!.layer.borderColor = UIColor.bnGray().CGColor
        self.addSubview(textFieldView!)
        
        commentTxt = UITextView(frame: CGRectMake(10, 10, (screenWidth - 30), 70))
        commentTxt!.font = UIFont(name: "Lato-Light", size:15)
        commentTxt!.text = NSLocalizedString("Optional", comment: "Optional")
        commentTxt!.textColor = UIColor.whiteColor()
        commentTxt!.backgroundColor = UIColor.appBackground()
        commentTxt!.keyboardAppearance = UIKeyboardAppearance.Light
        commentTxt!.returnKeyType = UIReturnKeyType.Done
        commentTxt!.delegate = self
        textFieldView!.addSubview(commentTxt!)
        textFieldView!.alpha = 0
        
//        slider = UISlider(frame: CGRectMake(30, (screenHeight - 150), (screenWidth - 60), 20))
//        slider!.maximumValue = 10
//        slider!.continuous = true
//        slider!.minimumValue = 1;
//        slider!.value = 5
//        self.rating = 5
//        slider!.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
//        slider!.minimumTrackTintColor = UIColor.bnGrayDark()
//        slider!.thumbTintColor = UIColor.bnRed()
//        self.addSubview(slider!)
        
//        let zero = UILabel(frame: CGRectMake(-10, 0, 20, 20))
//        zero.text = "0"
//        zero.font = UIFont(name: "Lato-Light", size: 12)
//        zero.textColor = UIColor.bnGrayDark()
//        slider!.addSubview(zero)
//
//        let ten = UILabel(frame: CGRectMake((screenWidth - 55), 0, 20, 20))
//        ten.text = "10"
//        ten.font = UIFont(name: "Lato-Light", size: 12)
//        ten.textColor = UIColor.bnGrayDark()
//        slider!.addSubview(ten)
        
        continueBtn = UIButton(frame:CGRectMake(5, (screenHeight - 75), (screenWidth - 10), 50))
//            BNUIButton_Loging(frame: CGRectMake(5, (screenHeight - 75), (screenWidth - 10), 50), color: UIColor.darkGrayColor(), text:NSLocalizedString("Continue", comment: "Continue").uppercaseString, textColor:UIColor.whiteColor())
        continueBtn!.setTitle(NSLocalizedString("Continue", comment: "Continue"), forState: UIControlState.Normal)
        continueBtn!.addTarget(self, action: #selector(self.continueBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(continueBtn!)
        
        let buttonWidth:CGFloat = ((screenWidth - 38 ) / 10)
        var x:CGFloat = 10
        var i:Int = 1
        
        while i < 11 {
//        for var i = 1; i <= 10; i++ {

            let color = getButtonColor(CGFloat(i))
            let button = UIButton(frame: CGRectMake(x, 0, buttonWidth, buttonWidth))
            button.setTitle("\(i)", forState: UIControlState.Normal)
            button.setTitleColor(color, forState: UIControlState.Normal)
            button.titleLabel!.font = UIFont(name: "Lato-Black", size: 12)
            button.layer.borderColor = color.CGColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = buttonWidth / 2
            button.backgroundColor = UIColor.appBackground()
            button.addTarget(self, action: #selector(self.surveyAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            buttons.append(button)
            self.addSubview(button)
            x += buttonWidth + 2
            i += 1
        }
        
        not_likely = UILabel(frame: CGRectMake(10, 0, screenWidth, 20))
        not_likely!.text = NSLocalizedString("not_likely", comment: "not_likely")
        not_likely!.font = UIFont(name:"Lato-Regular", size:13)
        not_likely!.textColor = UIColor.whiteColor()
        not_likely!.textAlignment = NSTextAlignment.Left
        self.addSubview(not_likely!)

        likely = UILabel(frame: CGRectMake(0, 0, (screenWidth - 10), 20))
        likely!.text = NSLocalizedString("likely", comment: "likely")
        likely!.font = UIFont(name:"Lato-Regular", size:13)
        likely!.textColor = UIColor.whiteColor()
        likely!.textAlignment = NSTextAlignment.Right
        self.addSubview(likely!)
        
        
//        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
//        fade!.backgroundColor = UIColor.blackColor()
//        fade!.alpha = 0
//        self.addSubview(fade!)
        
        self.alpha = 1
        addFade()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow", name: UIKeyboardDidShowNotification , object: nil)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide", name: UIKeyboardDidHideNotification, object: nil)
    }
    
//    func keyboardDidShow() {
//        
//        if !isKeyboardUp {
//            
//            isKeyboardUp = true
//            
//        }
//    }
//    
//    func keyboardDidHide() {
//        
//        if isKeyboardUp {
//            isKeyboardUp = false
//            
//        }
//    }
    
    func getButtonColor(n:CGFloat) -> UIColor {
        let hue:CGFloat = (((n - 1) / 10 ) / 3)
        return UIColor(hue:hue, saturation: 0.9, brightness: 0.9, alpha: 1)
    }
    
    func surveyAction(sender:UIButton) {
        
        //let previous_color = getButtonColor(CGFloat(self.rating))
        self.rating = Int(sender.titleForState(UIControlState.Normal)!)!
        let color = getButtonColor(CGFloat(self.rating))
        sender.backgroundColor = color
        sender.setTitleColor(UIColor.appBackground(), forState: UIControlState.Normal)
        continueBtn!.enabled = true
        
        if previousButton != nil {
            previousButton!.backgroundColor = UIColor.appBackground()
            previousButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            previousButton = sender
        } else {
            previousButton = sender
        }
    }
    
    /*
    func sliderValueDidChange(sender:UISlider!) {
        
        let value:Int = Int(sender.value)

        if value != rating {
            
            rating = value
            
            print("number:\(Int(sender.value))")
            switch rating {
            case 1:
                surveyAnswerLbl!.text = "Definitivamente no 1"
                break
            case 2:
                surveyAnswerLbl!.text = "Definitivamente no 2"
                break
            case 3:
                surveyAnswerLbl!.text = "Definitivamente no 3"
                break
            case 4:
                surveyAnswerLbl!.text = "Definitivamente no 4"
                break
            case 5:
                surveyAnswerLbl!.text = "Tal vez si , tal vez no 5"
                break
            case 6:
                surveyAnswerLbl!.text = "Tal vez si , tal vez no 6"
                break
            case 7:
                surveyAnswerLbl!.text = "Tal vez si , tal vez no 7"
                break
            case 8:
                surveyAnswerLbl!.text = "Tal vez si , tal vez no 8"
                break
            case 9:
                surveyAnswerLbl!.text = "Tal vez si , tal vez no 9"
                break
            case 10:
                surveyAnswerLbl!.text = "Definitivamente si 10"
                break
            default:
                break
            }

        }
        
    }
    */
    func updateSiteData(site:BNSite?){

        backBtn!.alpha = 1
        
        continueBtn!.enabled = false
        continueBtn!.alpha = 1
        
        
        if let organization = site!.organization {
            
            organizationName!.frame = CGRectMake(0, 0, SharedUIManager.instance.screenWidth, 30)
            organizationName!.alpha = 1
            organizationName!.text = site!.organization!.brand!
            organizationName!.numberOfLines = 0
            organizationName!.textAlignment = NSTextAlignment.Center
            organizationName!.sizeToFit()
            organizationName!.frame.origin.x = ((SharedUIManager.instance.screenWidth - organizationName!.frame.width) / 2)
            
            if organization.media.count > 0 {
                BNAppSharedManager.instance.networkManager.requestImageData(site!.organization!.media[0].url!, image: siteAvatar)
                siteAvatar!.cover!.backgroundColor = site!.organization!.media[0].vibrantColor!
                
                
            } else {
                siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
                siteAvatar!.showAfterDownload()
            }
        } else  {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
            organizationName!.text = ""
        }
    
        
        if SharedUIManager.instance.deviceType == BNDeviceType.iphone4s {
            siteAvatar!.alpha = 0
        } else {
            siteAvatar!.alpha = 1
        }
        
        commentTxt!.text = NSLocalizedString("Optional", comment: "Optional")
        commentTxt!.textColor = UIColor.whiteColor()
//        commentTxt!.becomeFirstResponder()
        
        self.site = site
        isSurveyDone = false
        continueBtn!.setTitle(NSLocalizedString("Continue", comment: "Continue").uppercaseString, forState: UIControlState.Normal)
        continueBtn!.backgroundColor = site!.media[0].vibrantDarkColor
        continueBtn!.setTitleColor(UIColor.lightGrayColor() , forState: UIControlState.Disabled)
//        continueBtn!.color = site!.media[0].vibrantDarkColor

//        brandNameLbl!.text = site!.title!
//        brandNameLbl!.font = UIFont(name: "Lato-Black", size: 35)
//        brandNameLbl!.textAlignment = NSTextAlignment.Center
        
//        brandGreetingsLbl!.frame.origin.y = brandNameLbl!.frame.origin.y + brandNameLbl!.frame.height + 10
//        brandGreetingsLbl!.text = NSLocalizedString("BrandGreetings", comment: "BrandGreetings")
//        brandGreetingsLbl!.font = UIFont(name: "Lato-Light", size: 15)
//        brandGreetingsLbl!.numberOfLines = 0
//        brandGreetingsLbl!.textAlignment = NSTextAlignment.Center
//        brandGreetingsLbl!.sizeToFit()
        
        
        
        
        var question = NSLocalizedString("SurveyQuestion_1", comment: "SurveyQuestion_1")
        question += site!.title!
        question += NSLocalizedString("SurveyQuestion_2", comment: "SurveyQuestion_2")
        surveyQuestionLbl!.frame = CGRectMake(30, surveyQuestionLbl!.frame.origin.y, (SharedUIManager.instance.screenWidth - 60), 28)
        surveyQuestionLbl!.text = question
        surveyQuestionLbl!.font = UIFont(name: "Lato-Light", size: 20)
        surveyQuestionLbl!.numberOfLines = 0
        surveyQuestionLbl!.textAlignment = NSTextAlignment.Center
        surveyQuestionLbl!.sizeToFit()
        surveyQuestionLbl!.frame.origin.y = (SharedUIManager.instance.screenHeight / 2) - surveyQuestionLbl!.frame.height
        surveyQuestionLbl!.frame.origin.x = ((SharedUIManager.instance.screenWidth - surveyQuestionLbl!.frame.width) / 2)
        
        organizationName!.frame.origin.y = (surveyQuestionLbl!.frame.origin.y - 70)
        siteAvatar!.frame.origin.y = (organizationName!.frame.origin.y - (siteAvatar!.frame.height))
        
        for i in (0..<buttons.count){
//        for var i = 0; i < buttons.count; i++ {
            //let color = getButtonColor(CGFloat(i))
            buttons[i].alpha = 1
            previousButton = nil
            buttons[i].frame.origin.y = surveyQuestionLbl!.frame.origin.y + surveyQuestionLbl!.frame.height + 20
            buttons[i].backgroundColor = UIColor.appBackground()
            buttons[i].setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        
        not_likely!.alpha = 1
        not_likely!.frame.origin.y = surveyQuestionLbl!.frame.origin.y + surveyQuestionLbl!.frame.height + buttons[0].frame.height + 25
        likely!.alpha = 1
        likely!.frame.origin.y = surveyQuestionLbl!.frame.origin.y + surveyQuestionLbl!.frame.height + buttons[0].frame.height + 25
        
        textFieldView!.alpha = 0
        self.rating = 8
//        self.slider!.value = Float(self.rating)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.25, delay: 0.75, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
                self.frame.origin.x = 0
            }, completion: {(completed:Bool)->Void in
        })
//        
//        UIView.animateWithDuration(0.25, animations: {()->Void in
//            self.frame.origin.x = 0
//        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
//        if state!.stateType != BNStateType.SiteState {
            UIView.animateWithDuration(0.3, animations: {()->Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
                }, completion: {(completed:Bool)->Void in

            })
//        }
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
    
    func hide(sender:NSTimer){
        self.delegate!.hideSurveyView!()
    }
    
    func continueBtnAction(sender:BNUIButton_Loging){
        
        if isSurveyDone {
            
            var comment = ""
            if self.commentTxt!.text != "" || self.commentTxt!.text != "Opcional" {
                comment = self.commentTxt!.text
            }
            
            BNAppSharedManager.instance.networkManager.sendSurvey(BNAppSharedManager.instance.dataManager.biinie , site: self.site, rating: self.rating, comment:comment)

            surveyQuestionLbl!.frame = CGRectMake(30, surveyQuestionLbl!.frame.origin.y, (SharedUIManager.instance.screenWidth - 60), 20)
            surveyQuestionLbl!.text = NSLocalizedString("Thankyou", comment: "Thankyou")
            textFieldView!.alpha = 0
            continueBtn!.alpha = 0
            
            SharedAnswersManager.instance.logCompletedNPS(site)
            
            BNAppSharedManager.instance.notificationManager.add_surveyedSite(site!.identifier)
            
            NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.hide(_:)), userInfo: nil, repeats: false)
            
            
        } else {
            
            backBtn!.alpha = 0
            isSurveyDone = true
            continueBtn!.setTitle(NSLocalizedString("Done", comment: "Done").uppercaseString, forState: UIControlState.Normal)
//            continueBtn!.label!.text = NSLocalizedString("Done", comment: "Done").capitalizedString
            
            surveyQuestionLbl!.frame = CGRectMake(20, surveyQuestionLbl!.frame.origin.y, (SharedUIManager.instance.screenWidth - 40), 28)
            surveyQuestionLbl!.text = NSLocalizedString("SurveyQuestion_3", comment: "SurveyQuestion_3")
            surveyQuestionLbl!.font = UIFont(name: "Lato-Light", size: 20)
            surveyQuestionLbl!.numberOfLines = 0
            surveyQuestionLbl!.textAlignment = NSTextAlignment.Center
            surveyQuestionLbl!.sizeToFit()
            surveyQuestionLbl!.frame.origin.x = ((SharedUIManager.instance.screenWidth - surveyQuestionLbl!.frame.width) / 2)
            textFieldView!.alpha = 1
            textFieldView!.frame.origin.y = surveyQuestionLbl!.frame.origin.y + surveyQuestionLbl!.frame.height + 10

            for i in (0..<buttons.count) {
//            for var i = 0; i < buttons.count; i++ {
                buttons[i].alpha = 0
            }
            
            not_likely!.alpha = 0
            likely!.alpha = 0
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        SharedAnswersManager.instance.logNotCompletedNPS(site)
        commentTxt!.resignFirstResponder()
        delegate!.hideSurveyView!()
    }

    override func clean() {
        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()
    }
    
    func show() {
        
    }
    
    override func refresh() {

    }
    
    override func request() {

    }
    
    override func requestCompleted() {

    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if !isKeyboardUp {
            isKeyboardUp = true
            self.siteAvatar!.alpha = 0
            self.organizationName!.alpha = 0
            if SharedUIManager.instance.deviceType == BNDeviceType.iphone4s {
                UIView.animateWithDuration(0.25, animations: {() -> Void in
                    self.textFieldView!.frame.origin.y -= 140
                    self.surveyQuestionLbl!.alpha = 0
                })
            } else {
                UIView.animateWithDuration(0.25, animations: {() -> Void in
                    self.textFieldView!.frame.origin.y -= 120
                    self.surveyQuestionLbl!.frame.origin.y -= 120
                })
            }
        }
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {


        
        if isKeyboardUp {
            isKeyboardUp = false
            
            if SharedUIManager.instance.deviceType == BNDeviceType.iphone4s {
//                UIView.animateWithDuration(0.25, animations: {() -> Void in
//                    self.textFieldView!.frame.origin.y += 140
//                    self.surveyQuestionLbl!.alpha = 1
//
//                })
                
                UIView.animateWithDuration(0.25, animations: {()->Void in
                    self.textFieldView!.frame.origin.y += 140
                    self.surveyQuestionLbl!.alpha = 1
                    }, completion: {(completed:Bool) -> Void in
                        self.siteAvatar!.alpha = 1
                        self.organizationName!.alpha = 1
                })
                
            } else {
//                UIView.animateWithDuration(0.25, animations: {() -> Void in
//                    self.textFieldView!.frame.origin.y += 120
//                    self.surveyQuestionLbl!.frame.origin.y += 120
//                })
                
                UIView.animateWithDuration(0.25, animations: {()->Void in
                    self.textFieldView!.frame.origin.y += 120
                    self.surveyQuestionLbl!.frame.origin.y += 120
                    }, completion: {(completed:Bool) -> Void in
                        self.siteAvatar!.alpha = 1
                        self.organizationName!.alpha = 1
                })
            }
        }
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NSLocalizedString("Optional", comment: "Optional")
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}

@objc protocol SurveyView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func hideSurveyView()
}