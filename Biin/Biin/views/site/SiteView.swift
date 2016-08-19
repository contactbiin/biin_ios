//  SiteView.swift
//  biin
//  Created by Esteban Padilla on 1/30/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MessageUI

class SiteView:BNView, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
 
    var delegate:SiteView_Delegate?
    weak var site:BNSite?
    var backBtn:BNUIButton_Back?
    var backBtn_Bg:UIView?

    var imagesScrollView:BNUIScrollView?
    var header:SiteView_Header?
    var scroll:UIScrollView?
    var showcases:Array<SiteView_Showcase>?
    var otherSitesView:SiteView_OtherSites?
    var locationView:SiteView_Location?
    var surverView:SiteView_Survey?
    
    var likeItButton:BNUIButton_LikeIt?
    var shareItButton:BNUIButton_ShareIt?

    var panIndex = 0

    var showcaseHeight:CGFloat = 0
    var decorationColor:UIColor?
    var iconColor:UIColor?
    var textColor:UIColor?
    
    var animationView:BiinItAnimationView?
    
    var shareView:ShareItView?
    
    var isShowingOtherSites = true
    
    var mapView:SiteView_Map?
    
    var buttonContainer:UIView?
    var isShowingLocation = false
    var locationBtn:BNUIButton_SiteLocation?
    var phoneBtn:BNUIButton_SitePhone?
    var emailBtn:BNUIButton_SiteEmail?
    
    var coverForSurveyView:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.bnSitesColor()

        showcases = Array<SiteView_Showcase>()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        let scrollHeight:CGFloat = (screenHeight - (SharedUIManager.instance.mainView_StatusBarHeight + SharedUIManager.instance.mainView_HeaderSize))
        
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.mainView_HeaderSize, screenWidth, scrollHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.bnSitesColor()
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        coverForSurveyView = UIView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        coverForSurveyView!.backgroundColor = UIColor.blackColor()
        self.scroll!.addSubview(coverForSurveyView!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, SharedUIManager.instance.mainView_HeaderSize, screenWidth, 0))
        self.addSubview(animationView!)
        
        header = SiteView_Header(frame: CGRectMake(0, (screenWidth), screenWidth, SharedUIManager.instance.siteView_headerHeight), father: self)
        scroll!.addSubview(header!)
        
        backBtn_Bg = UIView(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.mainView_HeaderSize))
        backBtn_Bg!.backgroundColor = UIColor.appBackground()
        self.addSubview(backBtn_Bg!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(backBtn!)

        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        locationView = SiteView_Location(frame: CGRectMake(5, screenHeight, (screenWidth - 10), (screenHeight / 2)), father: self)
        locationView!.layer.cornerRadius = 2
        self.addSubview(locationView!)
        locationView!.isInSiteView = true
        
        var buttonSpace:CGFloat = 65
        let ypos:CGFloat = 25

        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(buttonSpace, ypos, 40, 40), isBig: true)
        likeItButton!.addTarget(self, action: #selector(self.likeit(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(likeItButton!)
        
        //Share button
        buttonSpace += 65
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake( buttonSpace, ypos, 40, 40))
        shareItButton!.addTarget(self, action: #selector(self.shareit(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(shareItButton!)
        
        let backGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.backGestureAction(_:)))
        backGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(backGesture)

        let buttonWidth:CGFloat = 40
        
        buttonContainer = UIView(frame: CGRectMake(0, 0, 25, 35))
        buttonContainer!.backgroundColor = UIColor.clearColor()
        backBtn_Bg!.addSubview(buttonContainer!)

        var xpos:CGFloat = 0
        
        //Location button
        locationBtn = BNUIButton_SiteLocation(frame: CGRectMake(xpos, 0, buttonWidth, 35))
        locationBtn!.setTitleColor(UIColor.bnUber(), forState: UIControlState.Normal)
        locationBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 8)
        locationBtn!.addTarget(self, action: #selector(self.locationBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        buttonContainer!.addSubview(locationBtn!)
        
        //Phone
        xpos += (buttonWidth + 1)
        phoneBtn = BNUIButton_SitePhone(frame: CGRectMake(xpos, 0, buttonWidth, 35))
        phoneBtn!.setTitleColor(UIColor.bnUber(), forState: UIControlState.Normal)
        phoneBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 8)
        phoneBtn!.addTarget(self, action: #selector(self.call(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        buttonContainer!.addSubview(phoneBtn!)

        //Email
        xpos += (buttonWidth + 1)
        emailBtn = BNUIButton_SiteEmail(frame: CGRectMake(xpos, 0, buttonWidth, 35))
        emailBtn!.setTitleColor(UIColor.bnUber(), forState: UIControlState.Normal)
        emailBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 8)
        emailBtn!.addTarget(self, action: #selector(self.sendMail(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        buttonContainer!.addSubview(emailBtn!)
        
        let buttonContainerWidth:CGFloat = (xpos + buttonWidth)
        buttonContainer!.frame = CGRectMake((screenWidth - buttonContainerWidth), 22, buttonContainerWidth, 35)
        
        surverView = SiteView_Survey(frame: CGRectMake(0, 0, screenWidth, 300), father: self)
        self.scroll!.addSubview(surverView!)
        addFade()

    }
    
    func backGestureAction(sender:UISwipeGestureRecognizer) {

        delegate!.hideSiteView!()
    }
    
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    override func transitionIn() {
    
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state?.action()
        
        if state!.stateType == BNStateType.MainViewContainerState ||
            state!.stateType == BNStateType.AllSitesState ||
            state!.stateType == BNStateType.AllFavoriteSites ||
            state!.stateType == BNStateType.ElementState ||
//            state!.stateType == BNStateType.SurveyState ||
            state!.stateType == BNStateType.SiteState {
//
            UIView.animateWithDuration(0.3, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
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
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        surverView?.commentTxt!.resignFirstResponder()
        delegate!.hideSiteView!()
        BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.EXIT_SITE_VIEW, to:site!.identifier!, by:site!.identifier!)
    }
    
    func isSameSite(site:BNSite?)->Bool {
        if self.site != nil {
            if site!.identifier! == self.site!.identifier {
                return true
            }
        }
        
        self.site = site
        return false
    }
    
    func updateSiteData(site:BNSite?) {

        if !isSameSite(site) {

            textColor = site!.organization!.secondaryColor
            iconColor = site!.organization!.secondaryColor
            decorationColor = site!.organization!.primaryColor
            
            animationView!.updateAnimationView(decorationColor, textColor: textColor)
            
            header!.updateForSite(site)
            
            imagesScrollView!.updateImages(site!.media, isElement:false)
            updateShowcasesAndLocation(site)

//            backBtn!.icon!.color = iconColor
//            backBtn!.layer.borderColor = decorationColor!.CGColor
//            backBtn!.layer.backgroundColor = decorationColor!.CGColor
//            backBtn!.setNeedsDisplay()
            
           // shareItButton!.icon!.color = UIColor.grayColor()
            //shareItButton!.setNeedsDisplay()

            if site!.organization!.hasNPS {
                surverView!.updateSiteData(self.site)
            }
            
            updateLikeItBtn()
            
            if self.site!.email! != "" {
                emailBtn!.enabled = true
            } else {
                emailBtn!.enabled = false
            }
            
            if shareView != nil {
                shareView!.clean()
                shareView!.removeFromSuperview()
                shareView = nil
            }
            
            shareView  = ShareItView(frame: CGRectMake(0, 0, 320, 450), site:self.site!)
            
        }
    }
    
    func locationBtnAction(sender:UIButton){
        
        
        
        if !isShowingLocation {
            isShowingLocation = true
            showFade()
            UIView.animateWithDuration(0.3, animations: {()-> Void in
                self.locationView!.frame.origin.y = (SharedUIManager.instance.screenHeight - (self.locationView!.frame.height + 25))
            })
        } else {
            isShowingLocation = false
            hideFade()
            UIView.animateWithDuration(0.4, animations: {()-> Void in
                self.locationView!.frame.origin.y = SharedUIManager.instance.screenHeight
                self.fade!.alpha = 0
            })
        }
        
        self.bringSubviewToFront(locationView!)
    }

    func updateShowcasesAndLocation(site:BNSite?){
        
        //clean()
        
        if showcases?.count > 0 {
            
            for view in scroll!.subviews {
                
                if view is SiteView_Showcase {
                    (view as! SiteView_Showcase).transitionOut(nil)
                    (view as! SiteView_Showcase).removeFromSuperview()
                }
            }
            
            showcases!.removeAll(keepCapacity: false)
        }
        
        showcaseHeight = SharedUIManager.instance.siteView_showcaseHeaderHeight + SharedUIManager.instance.miniView_height_showcase + 1

        var ypos:CGFloat = SharedUIManager.instance.screenWidth + SharedUIManager.instance.siteView_headerHeight
        
        var colorIndex:Int = 0
        

        for showcase_identifier in site!.showcases {
            
            if let showcase = BNAppSharedManager.instance.dataManager.showcases[showcase_identifier] {
            
                showcase.site = self.site
                let showcaseView = SiteView_Showcase(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, showcaseHeight), father: self, showcase:showcase, site:site, colorIndex:colorIndex )
                scroll!.addSubview(showcaseView)
                showcases!.append(showcaseView)
                ypos += showcaseHeight
                //ypos += 2
                colorIndex += 1
                if colorIndex  > 1 {
                    colorIndex = 0
                }
            }
        }
        
        locationView!.updateForSite(site)
        
        if otherSitesView != nil {
            otherSitesView!.removeFromSuperview()
            otherSitesView = nil
        }
        
        if isShowingOtherSites {
            if site!.organization!.sites.count > 1 {
                if otherSitesView == nil {
                    let height:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.sitesContainer_headerHeight + SharedUIManager.instance.siteMiniView_headerHeight// + 1
                    
                    //            for i in (0..<site!.organization!.sites.count) {
                    otherSitesView = SiteView_OtherSites(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, height), father: self, site:site, colorIndex:colorIndex )
                    scroll!.addSubview(otherSitesView!)
                    ypos += height
                    //ypos += 2
                    colorIndex += 1
                    if colorIndex  > 1 {
                        colorIndex = 0
                    }
                }
            }
        }
        
        coverForSurveyView!.alpha = 0
        coverForSurveyView!.frame = CGRectMake(0, 0, SharedUIManager.instance.screenWidth, ypos)
        self.scroll!.bringSubviewToFront(coverForSurveyView!)
        
        if self.site!.organization!.hasNPS {
            surverView!.alpha = 1
            surverView!.frame.origin.y = ypos
            ypos += surverView!.frame.height
        } else {
            
            surverView!.alpha = 0
        }
        
        
        scroll!.contentSize = CGSizeMake(0, ypos)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.pagingEnabled = false
        
        if showcases!.count > 0 {
            showcases![0].getToWork()
        }
        

    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let imagesHeight = SharedUIManager.instance.screenWidth
        var page:Int = 0
        let ypos:CGFloat = floor(scrollView.contentOffset.y)
        
        if (ypos - imagesHeight) > 0 {
            page = Int(floor(ypos / showcaseHeight))
            
            if page != panIndex {
                panIndex = page
                
                for showcase in showcases! {
                    showcase.getToRest()
                }
                
                if panIndex < showcases!.count {
                    showcases![panIndex].getToWork()
                }
            }
            
        }
    }// called when scroll view grinds to a halt
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }// any offset changes
    
    override func clean(){

        delegate = nil
        site = nil
        backBtn?.removeFromSuperview()
        header?.clean()

        if showcases != nil {
            for view in showcases! {
                view.clean()
                view.removeFromSuperview()
            }
        }
        
        showcases?.removeAll()
        
        imagesScrollView?.clean()
        imagesScrollView?.removeFromSuperview()
        
        locationView?.clean()
        locationView?.removeFromSuperview()
        
        fade?.removeFromSuperview()

        likeItButton?.removeFromSuperview()
        shareItButton?.removeFromSuperview()

        decorationColor = nil
        iconColor = nil
        textColor = nil
        animationView?.clean()
        animationView?.removeFromSuperview()
        
        shareView?.clean()
        shareView?.removeFromSuperview()

        scroll?.removeFromSuperview()

    }
    
    func updateLoyaltyPoints() { }
    
    func likeit(sender:BNUIButton_BiinIt){
        site!.userLiked = !site!.userLiked
        
        if self.site!.userLiked {
            BNAppSharedManager.instance.dataManager.addFavoriteSite(site!.identifier!)
            animationView!.animateWithText(NSLocalizedString("LikeTxt", comment: "LikeTxt"))
            BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.LIKE_SITE, to:site!.identifier!, by:site!.identifier!)
            SharedAnswersManager.instance.logLike_Site(site)

        } else {
            BNAppSharedManager.instance.dataManager.removeFavoriteSite(site!.identifier!)
            animationView!.animateWithText(NSLocalizedString("NotLikeTxt", comment: "NotLikeTxt"))
            BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.UNLIKE_SITE, to:site!.identifier!, by:site!.identifier!)
            SharedAnswersManager.instance.logUnLike_Site(site)

        }
        
        BNAppSharedManager.instance.likeSite(self.site)
        
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        likeItButton!.changedIcon(site!.userLiked)
//        likeItButton!.icon!.color = UIColor.grayColor()
        likeItButton!.setNeedsDisplay()
        
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareSite(self.site, shareView: shareView)
        BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.SHARE_SITE, to:site!.identifier!, by: site!.identifier!)
        SharedAnswersManager.instance.logShare_Site(site)
    }
    
    func sendMail(sender: UIButton) {
        
        let picker = MFMailComposeViewController()
        let toRecipents = [self.site!.email!]
        picker.setToRecipients(toRecipents)
        picker.mailComposeDelegate = self
        picker.setSubject(NSLocalizedString("EmailMsj", comment: "EmailMsj"))
        picker.setMessageBody("", isHTML: true)
        
        if MFMailComposeViewController.canSendMail() {
            BNAppSharedManager.instance.mainViewController!.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        (father! as? MainView)?.rootViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func call(sender:UIButton){    
        if self.site!.phoneNumber! != "" {
            let url:NSURL = NSURL(string:"tel://\(self.site!.phoneNumber!)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func enableScrolls(value:Bool){
        self.scroll!.scrollEnabled = value
        
        if value {
            UIView.animateWithDuration(0.2, animations: {()-> Void in
                self.coverForSurveyView!.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0.2, animations: {()-> Void in
                self.coverForSurveyView!.alpha = 0.75
            })
        }
        
    }
    
    
    
}

@objc protocol SiteView_Delegate:NSObjectProtocol {
    optional func hideSiteView()
    optional func hideBrotherSiteView()
}