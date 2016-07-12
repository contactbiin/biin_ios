//  SiteView_Survey.swift
//  biin
//  Created by Esteban Padilla on 5/20/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Survey: BNView, UITextViewDelegate {
    
    var title:UILabel?
    var spacer:CGFloat = 1

    var surveyQuestionLbl:UILabel?

    var rating:Int = 5
    var continueBtn:UIButton?
    
    var commentTxt:UITextView?
    var isSurveyDone = false
    
    var not_likely:UILabel?
    var likely:UILabel?
    
    weak var site:BNSite?
    var previousButton:UIButton?
    var buttons = Array<UIButton>()
    var isKeyboardUp = false
    var keyboardHeight:CGFloat = 0
    
    override init(frame: CGRect, father:BNView?) {
        
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.bnSitesColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        
        var ypos:CGFloat = 25
        
        title = UILabel(frame: CGRectMake(15, ypos, screenWidth, 16))
        let titleText = NSLocalizedString("SurveyTitle", comment: "SurveyTitle").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.whiteColor()
        self.addSubview(title!)
        
        ypos = 80

        surveyQuestionLbl = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 28))
        surveyQuestionLbl!.text = NSLocalizedString("SurveyQuestion_4", comment: "SurveyQuestion_4")
        surveyQuestionLbl!.textColor = UIColor.whiteColor()
        surveyQuestionLbl!.font = UIFont(name: "Lato-Black", size: 15)
        surveyQuestionLbl!.numberOfLines = 0
        surveyQuestionLbl!.textAlignment = NSTextAlignment.Center
        surveyQuestionLbl!.sizeToFit()
        surveyQuestionLbl!.frame.origin.x = ((self.frame.width - surveyQuestionLbl!.frame.width) / 2 )

        self.addSubview(surveyQuestionLbl!)
//        
//        textFieldView = UIView(frame: CGRectMake(5, 0, (screenWidth - 10), 90))
//        textFieldView!.layer.borderWidth = 1
//        textFieldView!.layer.borderColor = UIColor.bnGray().CGColor
//        self.addSubview(textFieldView!)
        
        commentTxt = UITextView(frame: CGRectMake(5, 5, (screenWidth - 10), 100))
        commentTxt!.font = UIFont(name: "Lato-Light", size:15)
        commentTxt!.text = NSLocalizedString("Optional", comment: "Optional")
        commentTxt!.textColor = UIColor.whiteColor()
        commentTxt!.backgroundColor = UIColor.bnSitesColor()
        commentTxt!.layer.borderColor = UIColor.whiteColor().CGColor
        commentTxt!.layer.borderWidth = 1
        commentTxt!.keyboardAppearance = UIKeyboardAppearance.Light
        commentTxt!.returnKeyType = UIReturnKeyType.Done
        commentTxt!.delegate = self
        self.addSubview(commentTxt!)


        continueBtn = UIButton(frame:CGRectMake(5, 0, (screenWidth - 10), 50))
        continueBtn!.setTitle(NSLocalizedString("Continue", comment: "Continue"), forState: UIControlState.Normal)
        continueBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 18)
        continueBtn!.setTitleColor(UIColor.bnGray(), forState: UIControlState.Disabled)
        continueBtn!.addTarget(self, action: #selector(self.continueBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        continueBtn!.layer.cornerRadius = 2
        self.addSubview(continueBtn!)
        
        let buttonWidth:CGFloat = ((screenWidth - 38 ) / 10)
        var x:CGFloat = 10
        var i:Int = 1
        
        while i < 11 {
            
            let color = getButtonColor(CGFloat(i))
            let button = UIButton(frame: CGRectMake(x, 0, buttonWidth, buttonWidth))
            button.setTitle("\(i)", forState: UIControlState.Normal)
            button.setTitleColor(color, forState: UIControlState.Normal)
            button.titleLabel!.font = UIFont(name: "Lato-Black", size: 10)
            button.layer.borderColor = UIColor.whiteColor().CGColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = buttonWidth / 2
            button.backgroundColor = UIColor.bnSitesColor()
            button.addTarget(self, action: #selector(self.surveyAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            buttons.append(button)
            self.addSubview(button)
            x += buttonWidth + 2
            i += 1
        }
        
        not_likely = UILabel(frame: CGRectMake(10, 0, screenWidth, 20))
        not_likely!.text = NSLocalizedString("not_likely", comment: "not_likely")
        not_likely!.font = UIFont(name:"Lato-Black", size:15)
        not_likely!.textColor = UIColor.whiteColor()
        not_likely!.textAlignment = NSTextAlignment.Left
        self.addSubview(not_likely!)
        
        likely = UILabel(frame: CGRectMake(0, 0, (screenWidth - 10), 20))
        likely!.text = NSLocalizedString("likely", comment: "likely")
        likely!.font = UIFont(name:"Lato-Black", size:15)
        likely!.textColor = UIColor.whiteColor()
        likely!.textAlignment = NSTextAlignment.Right
        self.addSubview(likely!)
        
        self.alpha = 1
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        keyboardHeight = keyboardRectangle.height
        
        if !isKeyboardUp {
            isKeyboardUp = true
            
            (self.father as! SiteView).enableScrolls(false)
            
            UIView.animateWithDuration(0.25, animations: {() -> Void in
                (self.father as! SiteView).scroll!.frame.origin.y -= self.keyboardHeight
                self.surveyQuestionLbl!.alpha = 1
            })
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {

        
        
        if isKeyboardUp {
            isKeyboardUp = false
            
            (self.father as! SiteView).enableScrolls(true)
            
            UIView.animateWithDuration(0.25, animations: {() -> Void in
                (self.father as! SiteView).scroll!.frame.origin.y += self.keyboardHeight
                self.surveyQuestionLbl!.alpha = 1
            })
        }
        
    }
    
    func getButtonColor(n:CGFloat) -> UIColor {
        let hue:CGFloat = (((n - 1) / 10 ) / 3)
        return UIColor(hue:hue, saturation: 0.9, brightness: 0.9, alpha: 1)
    }
    
    func surveyAction(sender:UIButton) {
        

        self.rating = Int(sender.titleForState(UIControlState.Normal)!)!
        let color = getButtonColor(CGFloat(self.rating))
        sender.backgroundColor = color
        sender.layer.borderColor = color.CGColor
        sender.setTitleColor(UIColor.bnSitesColor(), forState: UIControlState.Normal)
        continueBtn!.enabled = true
        
        if previousButton != nil {
            previousButton!.layer.borderColor = UIColor.whiteColor().CGColor
            previousButton!.backgroundColor = UIColor.bnSitesColor()
            previousButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            previousButton = sender
        } else {
            previousButton = sender
        }
    }
    
    func updateSiteData(site:BNSite?){
        
        
        if !site!.surveyCompleted {

            self.site = site
            isSurveyDone = false

            surveyQuestionLbl!.frame = CGRectMake(30, 80, (SharedUIManager.instance.screenWidth - 60), 28)
            surveyQuestionLbl!.text = NSLocalizedString("SurveyQuestion_4", comment: "SurveyQuestion_4")
            surveyQuestionLbl!.sizeToFit()
            surveyQuestionLbl!.frame.origin.x = ((self.frame.width - surveyQuestionLbl!.frame.width) / 2 )

            commentTxt!.text = NSLocalizedString("Optional", comment: "Optional")
            commentTxt!.alpha = 0
            
            for i in (0..<buttons.count){
                buttons[i].alpha = 1
                previousButton = nil
                buttons[i].frame.origin.y = surveyQuestionLbl!.frame.origin.y + surveyQuestionLbl!.frame.height + 20
                buttons[i].backgroundColor = UIColor.bnSitesColor()
                buttons[i].layer.borderColor = UIColor.whiteColor().CGColor
                buttons[i].setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            }
            
            not_likely!.alpha = 1
            not_likely!.frame.origin.y = buttons[0].frame.origin.y + 40
            likely!.alpha = 1
            likely!.frame.origin.y = not_likely!.frame.origin.y
            
            self.rating = 8
            
            continueBtn!.enabled = false
            continueBtn!.alpha = 1
            continueBtn!.frame.origin.y = (self.frame.height - 55)
            continueBtn!.setTitle(NSLocalizedString("Continue", comment: "Continue"), forState: UIControlState.Normal)
            continueBtn!.backgroundColor = UIColor.bnGrayLight()
            continueBtn!.setTitleColor(UIColor.bnSitesColor(), forState: UIControlState.Disabled)
            
            
        } else {
            
            isSurveyDone = site!.surveyCompleted
            showCompletedSurvey()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.25, delay: 0.75, options: UIViewAnimationOptions.CurveEaseIn, animations: {()->Void in
            self.frame.origin.x = 0
            }, completion: {(completed:Bool)->Void in
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.frame.origin.x = SharedUIManager.instance.screenWidth
            }, completion: {(completed:Bool)->Void in
                
        })
        
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
        
    }
    
    func showCompletedSurvey() {
        surveyQuestionLbl!.frame = CGRectMake(20, surveyQuestionLbl!.frame.origin.y, (SharedUIManager.instance.screenWidth - 40), 28)
        surveyQuestionLbl!.text = NSLocalizedString("SurveyQuestion_5", comment: "SurveyQuestion_5")
        surveyQuestionLbl!.numberOfLines = 0
        surveyQuestionLbl!.textAlignment = NSTextAlignment.Center
        surveyQuestionLbl!.sizeToFit()
        surveyQuestionLbl!.frame.origin.x = ((SharedUIManager.instance.screenWidth - surveyQuestionLbl!.frame.width) / 2)
        surveyQuestionLbl!.frame.origin.y = ((self.frame.height - surveyQuestionLbl!.frame.height) / 2)
        
        commentTxt!.alpha = 0
        commentTxt!.resignFirstResponder()
        
        continueBtn!.enabled = false
        continueBtn!.alpha = 0
        
        for i in (0..<buttons.count) {
            buttons[i].alpha = 0
        }
        not_likely!.alpha = 0
        likely!.alpha = 0
    }
    
    func continueBtnAction(sender:BNUIButton_Loging){
        
        if isSurveyDone {
            
            var comment = ""
            if self.commentTxt!.text != "" || self.commentTxt!.text != "Opcional" {
                comment = self.commentTxt!.text
            }
            
            showCompletedSurvey()
            
            self.site!.surveyCompleted = true
            SharedAnswersManager.instance.logCompletedNPS(self.site)
            BNAppSharedManager.instance.networkManager.sendSurvey(BNAppSharedManager.instance.dataManager.biinie , site: self.site, rating: self.rating, comment:comment)
            BNAppSharedManager.instance.notificationManager.add_surveyedSite(site!.identifier)
            NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.hide(_:)), userInfo: nil, repeats: false)
            
            
        } else {
            
        
            isSurveyDone = true
            continueBtn!.setTitle(NSLocalizedString("Send", comment: "Send"), forState: UIControlState.Normal)
            
            surveyQuestionLbl!.frame = CGRectMake(20, surveyQuestionLbl!.frame.origin.y, (SharedUIManager.instance.screenWidth - 40), 28)
            surveyQuestionLbl!.text = NSLocalizedString("SurveyQuestion_3", comment: "SurveyQuestion_3")
            surveyQuestionLbl!.numberOfLines = 0
            surveyQuestionLbl!.textAlignment = NSTextAlignment.Center
            surveyQuestionLbl!.sizeToFit()
            surveyQuestionLbl!.frame.origin.x = ((SharedUIManager.instance.screenWidth - surveyQuestionLbl!.frame.width) / 2)
            commentTxt!.alpha = 1
            commentTxt!.frame.origin.y = (continueBtn!.frame.origin.y - ( commentTxt!.frame.height + 5))
            
            for i in (0..<buttons.count) {
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
        
    }
    
    override func clean() {
        
        title?.removeFromSuperview()
        
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
    
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        

        
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
