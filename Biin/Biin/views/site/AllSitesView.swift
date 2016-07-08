//  AllSitesView.swift
//  biin
//  Created by Esteban Padilla on 10/7/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class AllSitesView: BNView {

    var delegate:AllSitesView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    var scroll:BNScroll?
    
    var spacer:CGFloat = 1    

//    var fade:UIView?
    
    var isShowingFavorites = false
    var siteCounter:Int = 0

    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father: BNView?, showBiinItBtn:Bool) {
        
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.whiteColor()
        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
//        visualEffectView.frame = self.bounds
//        self.addSubview(visualEffectView)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        
        var ypos:CGFloat = 10
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, 16))
        title!.font = UIFont(name:"Lato-Regular", size:13)
        title!.textColor = UIColor.blackColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = UIColor.darkGrayColor().CGColor
        backBtn!.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        self.addSubview(backBtn!)
        
        ypos = 35
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.darkGrayColor()
        
        scroll = BNScroll(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (ypos + 20))), father: self, direction: BNScroll_Direction.VERTICAL, space: 1, extraSpace: 0, color: UIColor.bnGrayDark(), delegate: nil)
        self.addSubview(scroll!)
        self.addSubview(line)

        addAllSites()
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        addFade()

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
        state?.action()

        if state!.stateType != BNStateType.SiteState {
            UIView.animateWithDuration(0.3, animations: {()->Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
                }, completion: {(completed:Bool)->Void in
                    self.scroll!.scroll!.setContentOffset(CGPointZero, animated: false)
            })
        }
    }
    
//    override func transitionOutOnPrevious() {
//        self.fade!.alpha = 0
//    }
//    
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
        //delegate!.hideElementView!(self.element!)
        delegate!.hideAllSitesView!()
    }
    
    func addAllSites(){
      
        siteCounter = 0
        isShowingFavorites = false
        
        scroll?.clean()
        
        let titleText = NSLocalizedString("NearYou", comment: "NearYou").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString

        var sites = Array<SiteMiniView>()
        let sitesArray = BNAppSharedManager.instance.dataManager.sites_ordered
        
        var xpos:CGFloat = 0
        var ypos:CGFloat = 0
        var colunmCounter = 0
        var siteView_width:CGFloat = 0
        let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        
        if sitesArray.count == 1 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        siteView_width = SharedUIManager.instance.screenWidth
        
        for site in sitesArray {
            if !site.userLiked {
                if !isSiteAdded(site.identifier!) {
                    
                    siteCounter += 1
                    let miniSiteView = SiteMiniView(frame: CGRectMake(0, 0, siteView_width, miniSiteHeight), father: self, site:site)
                    miniSiteView.isPositionedInFather = true
                    miniSiteView.isReadyToRemoveFromFather = false
                    miniSiteView.delegate = father! as! MainView
                    
                    sites.append(miniSiteView)
                    
                    xpos += siteView_width + 1
                    colunmCounter += 1
                    
                    if colunmCounter == 2 {
                        colunmCounter = 0
                        xpos = 0
                        ypos += (miniSiteHeight + 1)
                    }
                }
            }
        }
        
        self.scroll!.addMoreChildren(sites)

    }
    
    func showAllFavoriteSite(){
        scroll?.clean()
        addAllFavoriteSites()
    }

    func addAllFavoriteSites(){
        
        siteCounter = 0
        isShowingFavorites = true

        let titleText = NSLocalizedString("FavoritePlaces", comment: "FavoritePlaces").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        
        var sites = Array<SiteMiniView>()
        let sitesArray = BNAppSharedManager.instance.dataManager.favoritesSites
        
        var xpos:CGFloat = 0
        var ypos:CGFloat = 0
        var colunmCounter = 0
        var siteView_width:CGFloat = 0
        let miniSiteHeight:CGFloat = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.siteMiniView_headerHeight
        
        if sitesArray.count == 1 {
            siteView_width = SharedUIManager.instance.screenWidth
        } else {
            siteView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        }
        
        siteView_width = SharedUIManager.instance.screenWidth
        
        for i in (0..<sitesArray.count) {

            if let site = BNAppSharedManager.instance.dataManager.sites[sitesArray[i]] {
                
                if !isSiteAdded(site.identifier!) {
                    
                    siteCounter += 1
                    
                    let miniSiteView = SiteMiniView(frame: CGRectMake(0, 0, siteView_width, miniSiteHeight), father: self, site:site)
                    miniSiteView.isPositionedInFather = true
                    miniSiteView.isReadyToRemoveFromFather = false
                    miniSiteView.delegate = father! as! MainView
                    
                    sites.append(miniSiteView)
                    
                    xpos += siteView_width + 1
                    colunmCounter += 1
                    
                    if colunmCounter == 2 {
                        colunmCounter = 0
                        xpos = 0
                        ypos += (miniSiteHeight + 1)
                    }
                }
            }
        }
        
        self.scroll!.addMoreChildren(sites)
    }

    
    func isSiteAdded(identifier:String) -> Bool {
        for view in scroll!.children {
            if view.model!.identifier! == identifier {
                return true
            }
        }
        return false
    }
    
//    func showFade(){
////        UIView.animateWithDuration(0.2, animations: {()-> Void in
////            self.fade!.alpha = 0.5
////        })
//    }
//    
//    func hideFade(){
////        UIView.animateWithDuration(0.5, animations: {()-> Void in
////            self.fade!.alpha = 0
////        })
//    }
    
    override func clean() {
        
        delegate = nil
        title?.removeFromSuperview()
        backBtn?.removeFromSuperview()

        fade?.removeFromSuperview()

//        if sites != nil {
//            for view in sites! {
//                view.clean()
//                view.removeFromSuperview()
//            }
//        }
//        
//        sites!.removeAll()
//        addedSitesIdentifiers!.removeAll()
        scroll?.clean()
    }
    
    func show() {
        
    }
    
    func showAllSites(){
        addAllSites()
    }
    
    override func refresh() {
        addAllSites()
    }
    
    override func request() {
        BNAppSharedManager.instance.dataManager.requestSites(self)
    }
    
    override func requestCompleted() {
        if !isShowingFavorites {
            if BNAppSharedManager.instance.dataManager.sites_ordered.count != siteCounter {
                self.addAllSites()
                self.scroll!.requestCompleted()
            }
        } else {
            if BNAppSharedManager.instance.dataManager.favoritesSites.count != siteCounter {
                self.addAllFavoriteSites()
                self.scroll!.requestCompleted()
            }
        }
    }
}

@objc protocol AllSitesView_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func hideAllSitesView()
}