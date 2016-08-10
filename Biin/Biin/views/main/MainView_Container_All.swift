//  MainView_Container_All.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreLocation


class MainView_Container_All: BNView, MainView_Delegate_HighlightsContainer, MainView_Delegate_BiinsContainer {
    
    var optionsBar:MainView_Container_OptionsBar?
    var inSiteView:InSiteView?
    var highlightContainer:MainView_Container_Highlights?
    var nearSitesContainer:MainView_Container_NearSites?
    var favoriteSitesContainer:MainView_Container_FavoriteSites?
    var bannerContainer:MainView_Container_Banner?
    var elementContainers:Array <MainView_Container_Elements>?

    var scroll:BNScroll?
    
//    var fade:UIView?
    
    var refreshButton:UIButton?
    var isShowing_refreshButton = false
    var isShowing_inSiteView = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        //NSLog("MainViewContainer init()")
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight

        self.scroll = BNScroll(frame: CGRectMake(0, 0, screenWidth, (screenHeight - 20)), father: self, direction: BNScroll_Direction.VERTICAL, space: 0, extraSpace: 45, color: UIColor.darkGrayColor(), delegate: nil)
        self.addSubview(scroll!)
        
        inSiteView = InSiteView(frame: CGRectMake(0, -80, screenWidth, SharedUIManager.instance.inSiteView_Height), father: self)
        inSiteView!.delegate = BNAppSharedManager.instance.mainViewController!.mainView!
        self.addSubview(inSiteView!)
        
        optionsBar = MainView_Container_OptionsBar(frame: CGRectMake(0, (screenHeight - (SharedUIManager.instance.mainView_OptionsBarHeight + 20)), screenWidth, SharedUIManager.instance.mainView_OptionsBarHeight), father: self)
        self.addSubview(optionsBar!)
        
//        fade = UIView(frame: frame)
//        fade!.backgroundColor = UIColor.blackColor()
//        fade!.alpha = 0
//        self.addSubview(fade!)
        
        refreshButton = UIButton(frame: CGRectMake(0, -50, self.frame.width, 50))
        refreshButton!.addTarget(self, action: #selector(self.refreshButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        refreshButton!.titleLabel!.font = UIFont(name: "Lato-Light", size: 15)
        refreshButton!.setTitle(NSLocalizedString("Refresh", comment: "Refresh"), forState: UIControlState.Normal)
        
        refreshButton!.backgroundColor = UIColor.biinDarkColor()
        self.addSubview(refreshButton!)
        
        elementContainers = Array<MainView_Container_Elements>()
        
        
        updateContainer()

        addFade()
    }
    
    func refreshButtonAction(sender:UIButton) {
        
        //NSLog("BIIN - refreshButtonAction")
        
        let vc = LoadingViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        BNAppSharedManager.instance.mainViewController!.presentViewController(vc, animated: true, completion: nil)
        
        if SimulatorUtility.isRunningSimulator {
            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.923165731693336, -84.03725208107909)
        }
        
        BNAppSharedManager.instance.dataManager.clean()
        BNAppSharedManager.instance.dataManager.requestInitialData()
    }
    
    func show_refreshButton(){        
        if !isShowing_refreshButton {
            isShowing_refreshButton = true
            let scroll_height = (scroll!.scroll!.frame.height - 50)
            scroll!.scroll!.frame = CGRectMake(0, 0, self.frame.width, scroll_height)
            
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.scroll!.frame.origin.y = 50
                self.refreshButton!.frame.origin.y = 0
            })
        }
    }
    
    func updateContainer(){
        
        if BNAppSharedManager.instance.dataManager.sites_ordered.count == 0 {
            //NSLog("BIIN ----------------------------------------------------")
            //NSLog("BIIN - not sites in list, request data again")
            //NSLog("BIIN - sites:\(BNAppSharedManager.instance.dataManager.sites.count)")
            //NSLog("BIIN - elements_by_identifier:\(BNAppSharedManager.instance.dataManager.elements_by_identifier.count)")
            //NSLog("BIIN ----------------------------------------------------")
            self.refreshButtonAction(UIButton())
            
            
        } else {
            
            let screenWidth = SharedUIManager.instance.screenWidth
            //let screenHeight = SharedUIManager.instance.screenHeight
            var ypos:CGFloat = 0
            let spacer:CGFloat = 0
            var height:CGFloat = 0
            
            SharedUIManager.instance.highlightContainer_Height = SharedUIManager.instance.screenWidth + SharedUIManager.instance.sitesContainer_headerHeight

            height = SharedUIManager.instance.highlightContainer_Height + SharedUIManager.instance.highlightView_headerHeight
            self.highlightContainer = MainView_Container_Highlights(frame: CGRectMake(0, ypos, screenWidth, height), father: self)
            self.scroll!.addChild(self.highlightContainer!)

            ypos += height

            height = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.sitesContainer_headerHeight + SharedUIManager.instance.siteMiniView_headerHeight// + 1
            
            self.nearSitesContainer = MainView_Container_NearSites(frame: CGRectMake(0, ypos, screenWidth, height))
            self.nearSitesContainer!.delegate = (self.father! as! MainView)
            self.nearSitesContainer!.father = self
            self.nearSitesContainer!.addAllSites()
            self.scroll!.addChild(self.nearSitesContainer!)
            ypos += height
            
           
            self.favoriteSitesContainer = MainView_Container_FavoriteSites(frame: CGRectMake(0, ypos, screenWidth, height))
            self.favoriteSitesContainer!.delegate = (self.father! as! MainView)
            self.favoriteSitesContainer!.father = self
            self.favoriteSitesContainer!.addAllSites()
            self.scroll!.addChild(self.favoriteSitesContainer!)
            ypos += height
            
            
            
            /*
            self.bannerContainer = MainViewContainer_Banner(frame: CGRectMake(0, ypos, screenWidth, SharedUIManager.instance.bannerContainer_Height), father: self)
            self.scroll!.addSubview(self.bannerContainer!)
            ypos += (SharedUIManager.instance.bannerContainer_Height + spacer)
            */
            
            //let biinie = BNAppSharedManager.instance.dataManager.bnUser
            
            var colorIndex:Int = 0
            for category in BNAppSharedManager.instance.dataManager.biinie!.categories {
                
                if isThereElementsInCategory(category) {
                    
                    let elementContainer = MainView_Container_Elements(frame: CGRectMake(0, ypos, screenWidth, SharedUIManager.instance.elementContainer_Height), father: self, category:category, colorIndex:colorIndex)
                    elementContainer.delegate = (self.father! as! MainView)
                    ypos += (SharedUIManager.instance.elementContainer_Height + spacer)
                    self.scroll!.addChild(elementContainer)
                    self.elementContainers!.append(elementContainer)
                    
                    colorIndex += 1
                    if colorIndex  > 1 {
                        colorIndex = 0
                    }
                }
            }
            
            ypos += SharedUIManager.instance.categoriesHeaderHeight
            self.scroll!.setChildrenPosition()
        }
    }
    
    func isThereElementsInCategory (category:BNCategory) ->Bool {
        
        if category.elements.count > 0 {
            return true
        }

        return false
    }
    
    func showMenuBtnActon(sender:BNUIButton) {
        (father as! MainView).showMenu(UIScreenEdgePanGestureRecognizer())
    }
    
    func showGiftsBtnAction(sender:BNUIButton) {
        (father as! MainView).setNextState(BNGoto.Gifts)
    }
    
    func showNotificationBtnAction(sender:BNUIButton) {
        (father as! MainView).setNextState(BNGoto.Notifications)
    }
    
    func showLoyalties(sender:BNUIButton) {
        (father as! MainView).setNextState(BNGoto.LoyaltyWallet)
    }
    
    override func transitionIn() {
        
//        UIView.animateWithDuration(0.5, animations: {()->Void in
//            self.fade!.alpha = 0
//        })
    }
    
    override func transitionOut( state:BNState? ) {
        
//        UIView.animateWithDuration(0.1, animations: {()->Void in
//            self.fade!.alpha = 0.5
//        })
//        
        state!.action()
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
    
    override func refresh() {
        refresh_NearSitesContainer()
    }

    
    func showInSiteView(site:BNSite?){
        
        if !isShowing_inSiteView {
            
            isShowing_inSiteView = true
            
            inSiteView!.updateForSite(site!)
            
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.inSiteView!.frame.origin.y += SharedUIManager.instance.inSiteView_Height
                self.highlightContainer!.frame.origin.y += SharedUIManager.instance.inSiteView_Height
                self.nearSitesContainer!.frame.origin.y += SharedUIManager.instance.inSiteView_Height
                self.favoriteSitesContainer!.frame.origin.y += SharedUIManager.instance.inSiteView_Height
                for container in self.elementContainers! {
                    container.frame.origin.y += SharedUIManager.instance.inSiteView_Height
                }
            })
        }
    }
    
    func hideInSiteView(){
        
        if isShowing_inSiteView {
            
            isShowing_inSiteView = false
            
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.inSiteView!.frame.origin.y -= SharedUIManager.instance.inSiteView_Height
                self.highlightContainer!.frame.origin.y -= SharedUIManager.instance.inSiteView_Height
                self.nearSitesContainer!.frame.origin.y -= SharedUIManager.instance.inSiteView_Height
                self.favoriteSitesContainer!.frame.origin.y -= SharedUIManager.instance.inSiteView_Height
                
                for container in self.elementContainers! {
                    container.frame.origin.y -= SharedUIManager.instance.inSiteView_Height
                }
            })
        }
    }
    
    
    func updateLikeButtons(){
        self.nearSitesContainer!.updateLikeButtons()
    }
    
    func refresh_NearSitesContainer(){
        self.nearSitesContainer!.refresh()
    }
    
    func refresh_favoritesSitesContaier(site:BNSite?) {
        
        if site!.userLiked {
            self.favoriteSitesContainer!.addSite(site)
            self.nearSitesContainer!.removeSite(site)
        } else {
            self.favoriteSitesContainer!.removeSite(site)
            self.nearSitesContainer!.addSite(site)
        }
//        self.favoriteSitesContainer!.refresh()
    }
    
    func refresh_elementContainer(identifier:String) {
        for container in elementContainers! {
            if container.category!.identifier == identifier {
                container.refresh()
                return
            }
        }
    }

    override func clean(){
        
        //NSLog("MainViewContainer clean()")
        
        if highlightContainer != nil {
            highlightContainer!.clean()
            highlightContainer!.removeFromSuperview()
        }
        
        if nearSitesContainer != nil {
            //nearSitesContainer!.clean()
            nearSitesContainer!.removeFromSuperview()
        }
        
        if bannerContainer != nil {
            bannerContainer!.clean()
            bannerContainer!.removeFromSuperview()
        }
        
        if inSiteView != nil {
            inSiteView!.clean()
            inSiteView!.removeFromSuperview()
        }
        
        if optionsBar != nil {
            optionsBar!.clean()
            optionsBar!.removeFromSuperview()
        }
        
        if elementContainers?.count > 0 {
            
            for elementContainer in elementContainers! {
                elementContainer.clean()
                elementContainer.removeFromSuperview()
            }
            
            elementContainers!.removeAll(keepCapacity: false)
        }
        
        elementContainers = nil
        scroll!.removeFromSuperview()
        fade!.removeFromSuperview()
    }
}
