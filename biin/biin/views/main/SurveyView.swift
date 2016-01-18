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
    
    var spacer:CGFloat = 1
    
    var fade:UIView?
    
    //Rating section
    var brandNameLbl:UILabel?
    var brandGreetingsLbl:UILabel?
    var surveyQuestionLbl:UILabel?
    var surveyAnswerLbl:UILabel?
    var rating:Int = 5
    var slider:UISlider?
    var continueBtn:BNUIButton_Loging?

    //Comment section
    var textFieldView:UIView?
    var commentTxt:UITextView?
    var isSurveyDone = false
    
    override init(frame: CGRect, father:BNView?) {
        
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.whiteColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 20
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        let titleText = NSLocalizedString("SurveyTitle", comment: "SurveyTitle").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.blackColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(10, 10, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = UIColor.darkGrayColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        self.addSubview(backBtn!)
        
        ypos = 75
        brandNameLbl = UILabel(frame: CGRectMake(10, ypos, (screenWidth - 20), 40))
        brandNameLbl!.text = "Flexy"
        brandNameLbl!.font = UIFont(name: "Lato-Black", size: 35)
        brandNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(brandNameLbl!)
        
        ypos += brandNameLbl!.frame.height + 10
        brandGreetingsLbl = UILabel(frame: CGRectMake(20, ypos, (screenWidth - 40), 20))
        brandGreetingsLbl!.text = "Muchas gracias por visitar Flexy en gracias por visitar Flexy en Multiplaza muchas gracias por visitar Flexy en Multiplaza."
        brandGreetingsLbl!.font = UIFont(name: "Lato-Light", size: 18)
        brandGreetingsLbl!.numberOfLines = 0
        brandGreetingsLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(brandGreetingsLbl!)
        brandGreetingsLbl!.sizeToFit()
        
        
        ypos += brandGreetingsLbl!.frame.height + 30
        surveyQuestionLbl = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 20))
        surveyQuestionLbl!.text = "Recomendarias a Flexy basado en tu tu tu experiencia de hoy?"
        surveyQuestionLbl!.font = UIFont(name: "Lato-Light", size: 18)
        surveyQuestionLbl!.numberOfLines = 0
        surveyQuestionLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(surveyQuestionLbl!)
        surveyQuestionLbl!.sizeToFit()
        
        ypos += surveyQuestionLbl!.frame.height + 10
        surveyAnswerLbl = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 20))
        surveyAnswerLbl!.text = "Definitivamente"
        surveyAnswerLbl!.font = UIFont(name: "Lato-Black", size: 18)
        surveyAnswerLbl!.numberOfLines = 0
        surveyAnswerLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(surveyAnswerLbl!)
        
        textFieldView = UIView(frame: CGRectMake(5, 0, (screenWidth - 10), 90))
        textFieldView!.layer.borderWidth = 1
        textFieldView!.layer.borderColor = UIColor.bnGray().CGColor
        self.addSubview(textFieldView!)
        
        commentTxt = UITextView(frame: CGRectMake(10, 10, (screenWidth - 30), 70))
        commentTxt!.font = UIFont(name: "Lato-Light", size:15)
        commentTxt!.text = NSLocalizedString("Optional", comment: "Optional")
        commentTxt!.textColor = UIColor.lightGrayColor()
        commentTxt!.returnKeyType = UIReturnKeyType.Go
        commentTxt!.keyboardAppearance = UIKeyboardAppearance.Light
        commentTxt!.delegate = self
        textFieldView!.addSubview(commentTxt!)
        textFieldView!.alpha = 0
        
        
        
        slider = UISlider(frame: CGRectMake(30, (screenHeight - 150), (screenWidth - 60), 20))
        slider!.maximumValue = 10
        slider!.continuous = true
        slider!.minimumValue = 1;
        slider!.value = 5
        self.rating = 5
        slider!.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        slider!.minimumTrackTintColor = UIColor.bnGrayDark()
        slider!.thumbTintColor = UIColor.bnRed()
        self.addSubview(slider!)
        
        let zero = UILabel(frame: CGRectMake(-10, 0, 20, 20))
        zero.text = "0"
        zero.font = UIFont(name: "Lato-Light", size: 12)
        zero.textColor = UIColor.bnGrayDark()
        slider!.addSubview(zero)

        let ten = UILabel(frame: CGRectMake((screenWidth - 55), 0, 20, 20))
        ten.text = "10"
        ten.font = UIFont(name: "Lato-Light", size: 12)
        ten.textColor = UIColor.bnGrayDark()
        slider!.addSubview(ten)
        
        continueBtn = BNUIButton_Loging(frame: CGRectMake(5, (screenHeight - 75), (screenWidth - 10), 50), color: UIColor.darkGrayColor(), text:NSLocalizedString("Continue", comment: "Continue").uppercaseString, textColor:UIColor.whiteColor())
        continueBtn!.addTarget(self, action: "continueBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(continueBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        self.alpha = 1
    }
    
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
    
    func updateSiteData(site:BNSite?){
        isSurveyDone = false
        continueBtn!.label!.text = NSLocalizedString("Continue", comment: "Continue").uppercaseString
        surveyQuestionLbl!.text = "Dejanos tu comentario para saber que te gusto o que podemos mejorar."
        surveyAnswerLbl!.alpha = 1
        slider!.alpha = 1
        textFieldView!.alpha = 0
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        if state!.stateType != BNStateType.SiteState {
            UIView.animateWithDuration(0.3, animations: {()->Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
                }, completion: {(completed:Bool)->Void in
                    self.updateSiteData(nil)
            })
        }
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
    
    func continueBtnAction(sender:BNUIButton_Loging){
        
        if isSurveyDone {
            delegate!.hideSurveyView!()
        } else {
            isSurveyDone = true
            continueBtn!.label!.text = "DONE"
            surveyQuestionLbl!.text = "Dejanos tu comentario para saber que te gusto o que podemos mejorar."
            surveyAnswerLbl!.alpha = 0
            slider!.alpha = 0
            textFieldView!.alpha = 1
            textFieldView!.frame.origin.y = surveyAnswerLbl!.frame.origin.y + surveyAnswerLbl!.frame.height
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        //delegate!.hideElementView!(self.element!)
//        delegate!.hideAllSitesView!()
        delegate!.hideSurveyView!()
    }

    func showFade(){
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.fade!.alpha = 0.5
        })
    }
    
    func hideFade(){
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.fade!.alpha = 0
        })
    }
    
    func clean() {
        
        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()
        fade?.removeFromSuperview()
        
    }
    
    func show() {
        
    }
    
    override func refresh() {

    }
    
    override func request() {
        BNAppSharedManager.instance.dataManager.requestSites(self)
    }
    
    override func requestCompleted() {

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