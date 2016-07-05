//  AboutView.swift
//  biin
//  Created by Esteban Padilla on 7/9/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class AboutView: BNView {
    
    var delegate:AboutView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
//    var fade:UIView?
    var biinLogo:BNUIBiinView?

    var visualEffectView:UIVisualEffectView?
    var scroll:UIScrollView?
    
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 27
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.mainView_TitleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.mainView_TitleSize)
        let titleText = NSLocalizedString("About", comment: "About").uppercaseString
        var attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.whiteColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        ypos = SharedUIManager.instance.mainView_HeaderSize
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.lightGrayColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - ypos)))
        scroll!.backgroundColor = UIColor.clearColor()
        self.addSubview(scroll!)
        self.addSubview(line)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        ypos = 50
        biinLogo = BNUIBiinView(position:CGPoint(x:((screenWidth - 110) / 2), y:ypos), scale:0.75)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
        biinLogo!.icon!.color = UIColor.blackColor()
        scroll!.addSubview(biinLogo!)
        biinLogo!.setNeedsDisplay()
        
        ypos += (biinLogo!.frame.height + 30)
        let aboutTitle = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.siteView_showcase_titleSize + 3)))
        aboutTitle.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        aboutTitle.textColor = UIColor.whiteColor()
        aboutTitle.textAlignment = NSTextAlignment.Center
        let abouttitleText = NSLocalizedString("AboutTitle", comment: "AboutTitle").uppercaseString
        attributedString = NSMutableAttributedString(string:abouttitleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(abouttitleText.characters.count)))
        aboutTitle.attributedText = attributedString
        
        
        scroll!.addSubview(aboutTitle)
        
        ypos += (aboutTitle.frame.height + 10)
        let aboutText = UILabel(frame: CGRectMake(40, ypos, (screenWidth - 80), (SharedUIManager.instance.siteView_subTittleSize + 3)))
        aboutText.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        aboutText.textColor = UIColor.whiteColor()
        aboutText.textAlignment = NSTextAlignment.Center
        aboutText.text = NSLocalizedString("AboutText", comment: "AboutText")
        aboutText.numberOfLines = 0
        aboutText.sizeToFit()
        scroll!.addSubview(aboutText)

        
        ypos += (aboutText.frame.height + 10)
        let versionText = UILabel(frame: CGRectMake(40, ypos, (screenWidth - 80), (SharedUIManager.instance.siteView_subTittleSize + 3)))
        versionText.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        versionText.textColor = UIColor.whiteColor()
        versionText.text = "\(NSLocalizedString("Version", comment: "Version")) \(BNAppSharedManager.instance.version)"
        versionText.textAlignment = NSTextAlignment.Center
        versionText.numberOfLines = 0
//        versionText.sizeToFit()
        scroll!.addSubview(versionText)
        
        ypos = (self.frame.height - 50)
        let siteUrl =  UIButton(frame: CGRectMake(0, ypos, screenWidth, SharedUIManager.instance.siteView_subTittleSize))
        siteUrl.setTitle("www.biin.io", forState: UIControlState.Normal)
        siteUrl.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        siteUrl.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Selected)
        siteUrl.titleLabel!.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        siteUrl.addTarget(self, action: #selector(self.openUrl(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(siteUrl)
        
        //addFade()
    }
    
    func openUrl(sender:UILabel) {
        let targetURL = NSURL(string:"http://www.biin.io")
        let application = UIApplication.sharedApplication()
        application.openURL(targetURL!)
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
        
//        if state!.stateType == BNStateType.MainViewContainerState
//            || state!.stateType == BNStateType.SiteState {
        
                UIView.animateWithDuration(0.25, animations: {()-> Void in
                    self.frame.origin.x = SharedUIManager.instance.screenWidth
                })
//        } else {
        
//            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.hideView(_:)), userInfo: nil, repeats: false)
//        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
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
        delegate!.hideAboutView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
    
    override func clean() {
        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()
        fade?.removeFromSuperview()
        biinLogo?.removeFromSuperview()
        visualEffectView?.removeFromSuperview()
        scroll?.removeFromSuperview()
    }
    
    func show() {
        
    }
}

@objc protocol AboutView_Delegate:NSObjectProtocol {
    optional func hideAboutView(view:AboutView)
}
