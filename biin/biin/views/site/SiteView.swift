//  SiteView.swift
//  biin
//  Created by Esteban Padilla on 1/30/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView:BNView, UIScrollViewDelegate, ElementView_Delegate {
 
    var delegate:SiteView_Delegate?
    var site:BNSite?
    var backBtn:BNUIButton_Back?
    var header:SiteView_Header?
    var bottom:SiteView_Bottom?
    //var buttonsView:SocialButtonsView?
    
    var scroll:UIScrollView?
    var showcases:Array<SiteView_Showcase>?
    
    var nutshell:UILabel?
    
    var imagesScrollView:BNUIScrollView?
    
    var location:SiteView_Location?
    
    var fade:UIView?
    var informationView:SiteView_Information?
    
    var elementView:ElementView?
    var isShowingElementView = false
    
    var biinItButton:BNUIButton_BiinIt?
    var shareItButton:BNUIButton_ShareIt?
    
    var locationViewHeigh:CGFloat = 400
    var panIndex = 0
    var scrollSpaceForShowcases:CGFloat = 0
    
    var showcaseHeight:CGFloat = 0
    
    var animationView:BiinItAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appShowcaseBackground()

        showcases = Array<SiteView_Showcase>()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var scrollHeight:CGFloat = screenHeight - (SharedUIManager.instance.siteView_headerHeight + SharedUIManager.instance.siteView_bottomHeight + 20) + 6
        //Add here any other heights for site view.
        
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.siteView_headerHeight, screenWidth, scrollHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.appShowcaseBackground()
        scroll!.delegate = self
        self.addSubview(scroll!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        location = SiteView_Location(frame: CGRectMake(0, screenWidth, screenHeight, locationViewHeigh), father: self)
        scroll!.addSubview(location!)
        
        header = SiteView_Header(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.siteView_headerHeight), father: self)
        self.addSubview(header!)
        
        //buttonsView = SocialButtonsView(frame: CGRectMake(0, 5, frame.width, 15), father: self, site: nil, showShareButton:true)
        //scroll!.addSubview(buttonsView!)
        
        
        nutshell = UILabel(frame: CGRectMake(10, 100, (frame.width - 20), 18))
        nutshell!.font = UIFont(name:"Lato-Black", size:16)
        nutshell!.textColor = UIColor.whiteColor()
        nutshell!.text = ""
//        nutshell!.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
//        nutshell!.shadowOffset = CGSize(width: 1, height: 1)
        nutshell!.numberOfLines = 0
        nutshell!.sizeToFit()
//        nutshell!.layer.shadowRadius = 3.0
//        nutshell!.layer.shadowColor = UIColor.blackColor().CGColor
//        nutshell!.layer.shadowOffset = CGSize(width: 2, height: 2)
        scroll!.addSubview(nutshell!)
        
        nutshell!.frame.origin.y = (imagesScrollView!.frame.height - (nutshell!.frame.height + 10))
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 10, 50, 50))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        bottom = SiteView_Bottom(frame: CGRectMake(0, screenHeight - (SharedUIManager.instance.siteView_bottomHeight + 20), screenWidth, SharedUIManager.instance.siteView_bottomHeight), father:self)
        self.addSubview(bottom!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        informationView = SiteView_Information(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self)
        self.addSubview(informationView!)
        
        biinItButton = BNUIButton_BiinIt(frame: CGRectMake((screenWidth - 80), 4, 37, 37))
        biinItButton!.addTarget(self, action: "biinit:", forControlEvents: UIControlEvents.TouchUpInside)
        //scroll!.addSubview(biinItButton!)

        shareItButton = BNUIButton_ShareIt(frame: CGRectMake((screenWidth - 41), 4, 37, 37))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(shareItButton!)
        
        elementView = ElementView(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self, showBiinItBtn:true)
        elementView!.delegate = self
        self.addSubview(elementView!)
      
        animationView = BiinItAnimationView(frame:CGRectMake(0, 0, screenWidth, screenWidth))
        animationView!.alpha = 0
        scroll!.addSubview(animationView!)
        
        //var showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: father!, action: "showMenu:")
        //showMenuSwipe.edges = UIRectEdge.Left
        //elementView!.scroll!.addGestureRecognizer(showMenuSwipe)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    override func transitionIn() {
    
        UIView.animateWithDuration(0.2, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        if state!.stateType == BNStateType.BiinieCategoriesState {
            UIView.animateWithDuration(0.4, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            })
        }
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
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
        delegate!.showCategoriesView!(self)
    }
    
    func updateSiteData(site:BNSite?) {
        self.site = site
        

        
        header!.updateForSite(site)
        
        
        
        //buttonsView!.updateSocialButtonsForSite(site)
        bottom!.updateForSite(site)
        
        
        if true {
            imagesScrollView!.updateImages(site!.media)
        }
        

        if true {
            updateShowcases(site)
        }
        
        
        if true {
            location!.updateForSite(site)
        }
        
        nutshell!.frame = CGRectMake(10, 0, (SharedUIManager.instance.screenWidth - 20), 18)
        nutshell!.text = site!.nutshell!
        nutshell!.numberOfLines = 0
        nutshell!.sizeToFit()
        scroll!.addSubview(nutshell!)
        var ypos:CGFloat = 0
        
        if site!.media.count > 1 {
            ypos = 30
        } else {
            ypos = 10
        }
        
        nutshell!.frame.origin.y = (self.imagesScrollView!.frame.height - (nutshell!.frame.height + ypos))
        
        if site!.userBiined {
            biinItButton!.showDisable()
        } else {
            biinItButton!.showEnable()
        }
    }
    
    func showInformationView(sender:BNUIButton_Information){
        println("show site information window")
        UIView.animateWithDuration(0.3, animations: {()-> Void in
            self.informationView!.frame.origin.x = 0
            self.fade!.alpha = 0.25
        })
    }
    
    func hideInformationView(sender:UIButton){
        UIView.animateWithDuration(0.4, animations: {()-> Void in
            self.informationView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
        })
    }
    
    func showElementView(elementMiniView:ElementMiniView?){
        
        elementView!.updateElementData(elementMiniView)
        
        UIView.animateWithDuration(0.3, animations: {()-> Void in
            self.elementView!.frame.origin.x = 0
            self.fade!.alpha = 0.25
        })
    }
    
    func hideElementView(view:ElementMiniView?) {        
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.elementView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
            }, completion: {(completed:Bool)-> Void in
                
                if !view!.element!.userViewed {
                    view!.userViewedElement()
                }
                
                self.elementView!.clean()
        })
    }

    func updateShowcases(site:BNSite?){
        
        //clean()
        if showcases?.count > 0 {
            
            for view in scroll!.subviews {
                
                if view is SiteView_Showcase {
                    (view as! SiteView_Showcase).transitionOut(nil)
                    (view as! SiteView_Showcase).removeFromSuperview()
                }
            }
            
//            for view in showcases! {
//                view.removeFromSuperview()
//            }

            showcases!.removeAll(keepCapacity: false)
        }
        
        showcaseHeight = SharedUIManager.instance.siteView_headerHeight + SharedUIManager.instance.miniView_height + 15

        //scroll!.addSubview(imagesScrollView!)
        
        var ypos:CGFloat = SharedUIManager.instance.screenWidth + 2
        scrollSpaceForShowcases = 0
        
        if site!.showcases != nil {
            for showcase in site!.showcases! {
                var showcaseView = SiteView_Showcase(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, showcaseHeight), father: self, showcase:showcase, site:site)
                scroll!.addSubview(showcaseView)
                showcases!.append(showcaseView)
                ypos += showcaseHeight
                //ypos += 1
            }
        }

        scrollSpaceForShowcases = ypos
        location!.frame.origin.y = ypos
        ypos += locationViewHeigh //200 for location View
        
        scroll!.contentSize = CGSizeMake(0, ypos)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
        
        if showcases!.count > 0 {
            showcases![0].getToWork()
        }
        
        //println("scrollSpaceForShowcases: \(scrollSpaceForShowcases)")
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        var imagesHeight = SharedUIManager.instance.screenWidth
        var page:Int = 0
        var ypos:CGFloat = floor(scrollView.contentOffset.y)
        
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
        for view in self.scroll!.subviews {
            if view.isKindOfClass(SiteView_Showcase) {
                view.removeFromSuperview()
            }
        }
    }
    
    func updateLoyaltyPoints(){
        bottom!.updateForSite(site)
    }
    
    func biinit(sender:BNUIButton_BiinIt){
        BNAppSharedManager.instance.biinit(site!.identifier!, isElement:false)
        header!.updateForSite(site!)
        biinItButton!.showDisable()
        animationView!.animate()
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareIt(site!.identifier!, isElement: false)
    }
}

@objc protocol SiteView_Delegate:NSObjectProtocol {
    optional func showCategoriesView(view:SiteView)
}