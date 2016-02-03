//  SiteView.swift
//  biin
//  Created by Esteban Padilla on 1/30/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView:BNView, UIScrollViewDelegate {
 
    var delegate:SiteView_Delegate?
    var site:BNSite?
    var backBtn:BNUIButton_Back?
    var backBtn_Bg:UIVisualEffectView?

    var header:SiteView_Header?
    var bottom:SiteView_Bottom?
    //var buttonsView:SocialButtonsView?
    
    var scroll:UIScrollView?
    var showcases:Array<SiteView_Showcase>?
    
    //var nutshell:UILabel?
    
    var imagesScrollView:BNUIScrollView?
    
    var locationView:SiteView_Location?
    
    var fade:UIView?
    //var informationView:SiteView_Information?
    
    //var elementView:ElementView?
    //var elementMiniView:ElementMiniView?
    //var isShowingElementView = false
    
    var siteLocationButton:BNUIButton_SiteLocation?
    var likeItButton:BNUIButton_LikeIt?
    var shareItButton:BNUIButton_ShareIt?
    var collectItButton:BNUIButton_CollectionIt?
    var followButton:UIButton?
    
    var locationViewHeigh:CGFloat = 280
    var panIndex = 0
    var scrollSpaceForShowcases:CGFloat = 0
    
    var showcaseHeight:CGFloat = 0
    var decorationColor:UIColor?
    var iconColor:UIColor?
    var animationView:BiinItAnimationView?
    
    var shareView:ShareItView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appShowcaseBackground()

        showcases = Array<SiteView_Showcase>()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        let scrollHeight:CGFloat = (screenHeight - (20 + 35))
        //Add here any other heights for site view.
        
        scroll = UIScrollView(frame: CGRectMake(0, 35, screenWidth, scrollHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, screenWidth, screenWidth, 0))
        scroll!.addSubview(animationView!)
        
        header = SiteView_Header(frame: CGRectMake(0, (screenWidth), screenWidth, SharedUIManager.instance.siteView_headerHeight), father: self)
        scroll!.addSubview(header!)
        
        //buttonsView = SocialButtonsView(frame: CGRectMake(0, 5, frame.width, 15), father: self, site: nil, showShareButton:true)
        //scroll!.addSubview(buttonsView!)
        
        
//        nutshell = UILabel(frame: CGRectMake(10, 100, (frame.width - 20), 18))
//        nutshell!.font = UIFont(name:"Lato-Black", size:16)
//        nutshell!.textColor = UIColor.whiteColor()
//        nutshell!.text = ""
////        nutshell!.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
////        nutshell!.shadowOffset = CGSize(width: 1, height: 1)
//        nutshell!.numberOfLines = 0
//        nutshell!.sizeToFit()
////        nutshell!.layer.shadowRadius = 3.0
////        nutshell!.layer.shadowColor = UIColor.blackColor().CGColor
////        nutshell!.layer.shadowOffset = CGSize(width: 2, height: 2)
//        //scroll!.addSubview(nutshell!)
//        
//        nutshell!.frame.origin.y = (imagesScrollView!.frame.height - (nutshell!.frame.height + 10))
        
        backBtn_Bg = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        backBtn_Bg!.frame = CGRectMake(0, 0, screenWidth, 35)
        self.addSubview(backBtn_Bg!)
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(backBtn!)
        
        bottom = SiteView_Bottom(frame: CGRectMake(0, 0, screenWidth, 0), father:self)
        scroll!.addSubview(bottom!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        locationView = SiteView_Location(frame: CGRectMake(0, screenHeight, screenWidth, locationViewHeigh), father: self)
        scroll!.addSubview(locationView!)
        
        //informationView = SiteView_Information(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self)
        //self.addSubview(informationView!)
        
        
        var buttonSpace:CGFloat = 45
        var ypos:CGFloat = 5//screenWidth + 2

        //Site location button
        siteLocationButton = BNUIButton_SiteLocation(frame: CGRectMake(buttonSpace, ypos, 25, 25))
        siteLocationButton!.addTarget(self, action: "showInformationView:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(siteLocationButton!)
        
        //Like button
        buttonSpace += 35
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(buttonSpace, ypos, 25, 25))
        likeItButton!.addTarget(self, action: "likeit:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(likeItButton!)
        
        //Share button
        buttonSpace += 35
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake( buttonSpace, ypos, 25, 25))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(shareItButton!)
        
        //Collect button
        buttonSpace += 35
        collectItButton = BNUIButton_CollectionIt(frame: CGRectMake((screenWidth - buttonSpace), (SharedUIManager.instance.siteView_headerHeight - 27), 25, 25))
        collectItButton!.addTarget(self, action: "collectIt:", forControlEvents: UIControlEvents.TouchUpInside)
        //header!.addSubview(collectItButton!)
        
        ypos = 7
        followButton = UIButton(frame: CGRectMake(0, 0, 90, 35))
        followButton!.setTitle(NSLocalizedString("Follow", comment: "Follow"), forState: UIControlState.Normal)
        followButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        followButton!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 11)
//        followButton!.layer.cornerRadius = 11
//        followButton!.layer.masksToBounds = true
//        followButton!.layer.borderColor = UIColor.blackColor().CGColor
//        followButton!.layer.borderWidth = 1
        followButton!.backgroundColor = UIColor.clearColor()
        followButton!.addTarget(self, action: "followit:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(followButton!)
        
        followButton!.frame.origin.x = (screenWidth - (followButton!.frame.width))
        
        
//        elementView = ElementView(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self, showBiinItBtn:true)
//        elementView!.delegate = self
//        self.addSubview(elementView!)
      

        
        //var showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: father!, action: "showMenu:")
        //showMenuSwipe.edges = UIRectEdge.Left
        //elementView!.scroll!.addGestureRecognizer(showMenuSwipe)
        
        let backGesture = UISwipeGestureRecognizer(target: self, action: "backGestureAction:")
        backGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(backGesture)
    }
    
    func backGestureAction(sender:UISwipeGestureRecognizer) {

        delegate!.hideSiteView!(self)
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
        state!.action()
        
        if state!.stateType == BNStateType.MainViewContainerState || state!.stateType == BNStateType.AllSitesState || state!.stateType == BNStateType.ElementState  {
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
        delegate!.hideSiteView!(self)
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.EXIT_SITE_VIEW, to:site!.identifier!)
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
            var textColor:UIColor?

            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_SITE_VIEW, to:site!.identifier!)
            
            if self.site!.useWhiteText {
                textColor = UIColor.whiteColor()
                iconColor = self.site!.media[0].vibrantDarkColor
                decorationColor = self.site!.media[0].vibrantDarkColor
            } else {
                textColor = UIColor.whiteColor()
                iconColor = self.site!.media[0].vibrantDarkColor
                decorationColor = self.site!.media[0].vibrantDarkColor
            }
            
            scroll!.backgroundColor = self.site!.media[0].vibrantColor!
            
            animationView!.updateAnimationView(decorationColor, textColor: textColor)
            
            header!.updateForSite(site)
            bottom!.updateForSite(site)
            
            imagesScrollView!.updateImages(site!.media, isElement:false)
            updateShowcasesAndLocation(site)

//            self.bringSubviewToFront(self.locationView!)
            
            backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
            backBtn!.layer.borderColor = decorationColor!.CGColor
            backBtn!.layer.backgroundColor = decorationColor!.CGColor
            backBtn!.setNeedsDisplay()
            
            siteLocationButton!.icon!.color = iconColor
            shareItButton!.icon!.color = iconColor
            //likeItButton!.icon!.color = iconColor
            
            siteLocationButton!.setNeedsDisplay()
            shareItButton!.setNeedsDisplay()
//            likeItButton!.setNeedsDisplay()

            updateLikeItBtn()
            
            updateCollectItBtn()
            
            updateFollowBtn()
            
            if shareView != nil {
                shareView = nil
            }
            
            shareView  = ShareItView(frame: CGRectMake(0, 0, 320, 450), site:self.site!)
            //scroll!.addSubview(shareView!)
        }
        
        //scroll!.backgroundColor = decorationColor
//        nutshell!.frame = CGRectMake(10, 0, (SharedUIManager.instance.screenWidth - 20), 18)
//        nutshell!.text = site!.nutshell!
//        nutshell!.numberOfLines = 0
//        nutshell!.sizeToFit()
//        scroll!.addSubview(nutshell!)
//        var ypos:CGFloat = 0
//        
//        if site!.media.count > 1 {
//            ypos = 30
//        } else {
//            ypos = 10
//        }
        
//        nutshell!.frame.origin.y = (self.imagesScrollView!.frame.height - (nutshell!.frame.height + ypos))
        
//        if site!.userBiined {
//            biinItButton!.showDisable()
//        } else {
//            biinItButton!.showEnable()
//        }
    }
    
    func showInformationView(sender:BNUIButton_SiteLocation){
        
        showFade()
        UIView.animateWithDuration(0.3, animations: {()-> Void in
            self.locationView!.frame.origin.y = SharedUIManager.instance.screenHeight - self.locationViewHeigh
        })
    }
    
    func hideInformationView(sender:UIButton){
        hideFade()
        UIView.animateWithDuration(0.4, animations: {()-> Void in
            self.locationView!.frame.origin.y = SharedUIManager.instance.screenHeight
            self.fade!.alpha = 0
        })
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
    
//    func showElementView(element:BNElement){
//
//        elementView!.updateElementData(element)
//        
//        UIView.animateWithDuration(0.3, animations: {()-> Void in
//            self.elementView!.frame.origin.x = 0
//            self.fade!.alpha = 0.25
//        })
//    }
//    
//    
//    
//    func hideElementView(element:BNElement) {
//        
//        UIView.animateWithDuration(0.4, animations: {() -> Void in
//            self.elementView!.frame.origin.x = SharedUIManager.instance.screenWidth
//            self.fade!.alpha = 0
//            }, completion: {(completed:Bool)-> Void in
//                
////                if !view!.element!.userViewed {
////                    view!.userViewedElement()
////                }
//                
//                self.elementView!.clean()
//        })
//    }

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

        //scroll!.addSubview(imagesScrollView!)

        var ypos:CGFloat = SharedUIManager.instance.screenWidth + SharedUIManager.instance.siteView_headerHeight
        scrollSpaceForShowcases = 0
        //ypos += 2
        var colorIndex:Int = 0
        
        if site!.showcases != nil {
            for showcase in site!.showcases! {
                let showcaseView = SiteView_Showcase(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, showcaseHeight), father: self, showcase:showcase, site:site, colorIndex:colorIndex )
                scroll!.addSubview(showcaseView)
                showcases!.append(showcaseView)
                ypos += showcaseHeight
                //ypos += 2
                colorIndex++
                if colorIndex  > 1 {
                    colorIndex = 0
                }
            }
        }

        
        locationView!.updateForSite(site)
        locationView!.frame.origin.y = ypos
        ypos += locationView!.frame.height
        
        scrollSpaceForShowcases = ypos
        bottom!.frame.origin.y = ypos
        ypos += bottom!.frame.height
        //locationView!.frame.origin.y = ypos
        //ypos += locationViewHeigh //200 for location View
        
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
    
    func clean(){

        delegate = nil
        site = nil
        backBtn?.removeFromSuperview()
        header?.clean()
        bottom?.removeFromSuperview()

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

        siteLocationButton?.removeFromSuperview()
        likeItButton?.removeFromSuperview()
        shareItButton?.removeFromSuperview()
        collectItButton?.removeFromSuperview()
        followButton?.removeFromSuperview()
        
        decorationColor = nil
        iconColor = nil
        animationView?.clean()
        animationView?.removeFromSuperview()
        
        shareView?.clean()
        shareView?.removeFromSuperview()

        scroll?.removeFromSuperview()

    }
    
    func updateLoyaltyPoints(){
        bottom!.updateForSite(site)
    }
    
    /*
    func biinit(sender:BNUIButton_BiinIt){
        BNAppSharedManager.instance.collectIt(site!.identifier!, isElement:false)
        header!.updateForSite(site!)
        likeItButton!.showDisable()
        animationView!.animate()
    }
    */
    
    func likeit(sender:BNUIButton_BiinIt){
        site!.userLiked = !site!.userLiked
        
        if self.site!.userLiked {
            animationView!.animateWithText(NSLocalizedString("LikeTxt", comment: "LikeTxt"))
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.LIKE_SITE, to:site!.identifier!)
        } else {
            animationView!.animateWithText(NSLocalizedString("NotLikeTxt", comment: "NotLikeTxt"))
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.UNLIKE_SITE, to:site!.identifier!)
        }
        
        BNAppSharedManager.instance.likeSite(self.site)

        
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        likeItButton!.changedIcon(site!.userLiked)
        likeItButton!.icon!.color = iconColor!
        likeItButton!.setNeedsDisplay()
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareSite(self.site, shareView: shareView)
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.SHARE_SITE, to:site!.identifier!)
    }
    
    func collectIt(sender:BNUIButton_CollectionIt){
        site!.userCollected = !site!.userCollected
        updateCollectItBtn()
        animationView!.animate(site!.userCollected)
    }
    
    func updateCollectItBtn(){
        collectItButton!.changeToCollectIcon(site!.userCollected)
        collectItButton!.icon!.color = iconColor
    }
    
    func followit(sender:UIButton){
        site!.userFollowed = !site!.userFollowed
        
        if self.site!.userFollowed {
            animationView!.animateWithText(NSLocalizedString("FollowTxt", comment: "FollowTxt"))
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.FOLLOW_SITE, to:site!.identifier!)
        } else {
            animationView!.animateWithText(NSLocalizedString("NotFollowTxt", comment: "NotFollowTxt"))
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.UNFOLLOW_SITE, to:site!.identifier!)
        }

        BNAppSharedManager.instance.followSite(self.site)

        updateFollowBtn()
    }
    
    func updateFollowBtn() {
        
        followButton!.layer.borderColor = iconColor!.CGColor
        
        if site!.userFollowed {
            followButton!.setTitle(NSLocalizedString("Following", comment: "Following"), forState: UIControlState.Normal)
//            followButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            followButton!.backgroundColor = iconColor!
            followButton!.setTitleColor(iconColor, forState: UIControlState.Normal)
            followButton!.backgroundColor = UIColor.clearColor()
        } else  {
            followButton!.setTitle(NSLocalizedString("Follow", comment: "Follow"), forState: UIControlState.Normal)
//            followButton!.setTitleColor(iconColor, forState: UIControlState.Normal)
//            followButton!.backgroundColor = UIColor.clearColor()
            
            followButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            followButton!.backgroundColor = iconColor!
        }
    }
}

@objc protocol SiteView_Delegate:NSObjectProtocol {
    optional func hideSiteView(view:SiteView)
}