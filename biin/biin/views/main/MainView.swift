//  MainView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class MainView:BNView, SiteMiniView_Delegate, SiteView_Delegate, ProfileView_Delegate, CollectionsView_Delegate, NotificationsView_Delegate, ElementMiniView_Delegate, SiteView_MiniLocation_Delegate {
    
    var delegate:MainViewDelegate?
    var delegate_HighlightsContainer:MainViewDelegate_HighlightsContainer?
    var delegate_BiinsContainer:MainViewDelegate_BiinsContainer?
    
    var rootViewController:MainViewController?
    var fade:UIView?
    var userControl:ControlView?
    
    //var isSectionsLast = true
    //var isSectionOrShowcase = false
    var lastOption = 1
    
    
    //states
    var biinieCategoriesState:BiinieCategoriesState?
    var siteState:SiteState?
    var profileState:ProfileState?
    var collectionsState:CollectionsState?    
    var notificationsState:NotificationsState?
    
    var searchState:SearchState?
    var settingsState:SettingsState?
    
//    override init() {
//        super.init()
//    }
    
    var testButton:UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father: BNView?) {
        super.init(frame: frame, father: father)
    }
    
    convenience init(frame: CGRect, father:BNView?, rootViewController:MainViewController?) {
        
        self.init(frame: frame, father: father)
        self.rootViewController = rootViewController
        
        self.backgroundColor = UIColor.appBackground()
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        
        //Create views
        var categoriesView = BiinieCategoriesView(frame: CGRectMake(0, 0, frame.width, frame.height), father: self)
        biinieCategoriesState = BiinieCategoriesState(context: self, view: categoriesView, stateType: BNStateType.BiinieCategoriesState)
        self.addSubview(categoriesView)
        state = biinieCategoriesState!
        
        delegate_HighlightsContainer = categoriesView
        delegate_BiinsContainer = categoriesView
        
        
        var siteView = SiteView(frame:CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        siteState = SiteState(context: self, view: siteView, stateType: BNStateType.SiteState)
        siteView.delegate = self
        self.addSubview(siteView)
        
        var profileView = ProfileView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        profileState = ProfileState(context: self, view: profileView, stateType: BNStateType.ProfileState)
        profileView.delegate = rootViewController!
        profileView.delegateFather = self
        self.addSubview(profileView)
        
        
        var collectionsView = CollectionsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        collectionsState = CollectionsState(context: self, view: collectionsView)
        collectionsView.delegate = self
        self.addSubview(collectionsView)
        
        
        var notificationsView = NotificationsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        notificationsState = NotificationsState(context: self, view: notificationsView)
        notificationsView.delegate = self
        self.addSubview(notificationsView)
        
        /*
        //Create views
        var sectionsView = SectionsView(frame: CGRectMake(320, 0, 320, 568), father:self)
        self.addSubview(sectionsView)
        
        var showcaseView = ShowcaseView(frame: CGRectMake(320, 0, 320, 568), father:self)
        self.addSubview(showcaseView)
    
        var searchView = SearchView(frame: CGRectMake(-321, 0, 320, 568), father: self)
        self.addSubview(searchView)
        
        var settingsView = SettingsView(frame: CGRectMake(-321, 0, 320, 568), father: self)
        self.addSubview(settingsView)
        
        var collectionsView = CollectionsView(frame: CGRectMake(-321, 0, 320, 568), father: self)
        self.addSubview(collectionsView)
        
        var profileView = ProfileView(frame: CGRectMake(-321, 0, 320, 568), father:self)
        self.addSubview(profileView)
        
        var boardsView = BoardsView(frame: CGRectMake(-321, 0, 320, 568), father:self)
        self.addSubview(boardsView)
        
        //Pass view to states
        sectionState = SectionsState(context:self, view: sectionsView)
        showcaseState = ShowcaseState(context:self, view: showcaseView)
        searchState = SearchState(context: self, view: searchView)
        settingsState = SettingsState(context: self, view: settingsView)
        collectionsState = CollectionsState(context: self, view:collectionsView)
        profileState = ProfileState(context: self, view: profileView)
        boardsState = BoardsState(context: self, view: boardsView)
        
        state = sectionState!
        state!.view!.transitionIn()
        
        fade = UIView(frame: frame)
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        userControl = UserControlView(frame:CGRectZero, father: self)
        self.addSubview(userControl!)
        */
        var showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        categoriesView.scroll!.addGestureRecognizer(showMenuSwipe)
        
        //showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        //showMenuSwipe.edges = UIRectEdge.Left
        //siteView.scroll!.addGestureRecognizer(showMenuSwipe)

        /*
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        showcaseView.addGestureRecognizer(showMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        searchView.addGestureRecognizer(showMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        settingsView.addGestureRecognizer(showMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        collectionsView.addGestureRecognizer(showMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        profileView.addGestureRecognizer(showMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        boardsView.addGestureRecognizer(showMenuSwipe)
        */
        
        //showNotificationContext()
        
        testButton = UIButton(frame: CGRectMake(10, 100, 100, 50))
        testButton!.backgroundColor = UIColor.bnOrange()
        testButton!.setTitle("TEST", forState: UIControlState.Normal)
        testButton!.addTarget(self, action: "testButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.addSubview(testButton!)
    }
    
    func testButtonAction(sender:UIButton) {
        println("testButtonAction()")
        BNAppSharedManager.instance.dataManager.requestDataForNewPosition()
    }
    
    func showMenu(sender:UIScreenEdgePanGestureRecognizer) {
        println("Showmain Menu")
        self.delegate!.mainView!(self, showMenu: true)
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( nextState:BNState? ) {
        
    }
        
    override func setNextState(option:Int){
        //Start transition on root view controller
//        self.rootViewController!.setNextState(option)
        //delegate!.mainView!(self, hideMenu: false)
        delegate!.mainView!(self, hideMenuOnChange: false, index:option)
        
        switch (option) {
        case 1:
           
            /*
            state!.next( self.showcaseState )
            isSectionsLast = false
            isSectionOrShowcase = true
            */
            state!.next(self.biinieCategoriesState)
            lastOption = option
            break
        case 2:
            state!.next(self.siteState)
            lastOption = option
            /*
            if !isSectionOrShowcase && !isSectionsLast {
                state!.next( self.showcaseState )
                isSectionsLast = false
                isSectionOrShowcase = true
            } else {
            
                //state!.next( self.sectionState )
                isSectionsLast = true
                isSectionOrShowcase = true
            }
            */
            break
        case 3:
            state!.next(self.profileState)
            self.bringSubviewToFront(state!.view!)
            break
        case 4:
            state!.next(self.collectionsState)
            self.bringSubviewToFront(state!.view!)
            self.collectionsState!.view!.refresh()
            break
        case 5:
            break
        case 6:
            state!.next(self.notificationsState)
            self.bringSubviewToFront(state!.view!)
            break
        case 7:

            break
        default:
            break
        }
    }

    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            if value {
                delegate!.mainView!(self, hideMenu: false)
                userControl!.showUserControl(value, son: son, point: point)
                UIView.animateWithDuration(0.2, animations: {()->Void in
                  self.fade!.alpha = 0.25
                })
            } else {
                userControl!.showUserControl(value, son: son, point: point)
                UIView.animateWithDuration(0.1, animations: {()->Void in
                  self.fade!.alpha = 0
                })
            }
        }else{

            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            userControl!.updateUserControl(position)
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //SiteMiniView_Delegate Methods
    func showSiteView(view: SiteMiniView, site: BNSite?, position: CGRect) {
        //println("site to show: \(site!.identifier) xpos: \(position.origin.x) ypos: \(position.origin.y)")
        (siteState!.view as! SiteView).updateSiteData(site)
        setNextState(2)
        
    }
    
    
    //ElementMiniView_Delegate
    func showElementView(view: ElementMiniView, position: CGRect) {
        
    }
    
    //SiteView_Delegate Methods
    func showCategoriesView(view: SiteView) {
        setNextState(1)
    }
    
    func hideProfileView(view: ProfileView) {
         setNextState(lastOption)
    }
    
    func hideCollectionsView(view: CollectionsView) {
        setNextState(lastOption)
    }
    
    func hideNotificationsView(view: NotificationsView) {
        setNextState(lastOption)
    }
    
    
    func showNotification(){
        //header!.showNotification(quantity)
        (biinieCategoriesState!.view as! BiinieCategoriesView).showNotification()
        (notificationsState!.view as! NotificationsView).addNotifications()
    }
    
    func hideNotification(){
        //header!.hideNotification()
        (biinieCategoriesState!.view as! BiinieCategoriesView).hideNotification()
    }
    
    override func refresh() {
        biinieCategoriesState!.view!.refresh()
    }
    
    func updateHighlightsContainer() {
        delegate_HighlightsContainer!.updateHighlightsContainer!(self, update: true)
    }
    
    func updateBiinsContainer() {
        delegate_BiinsContainer!.updateBiinsContainer!(self, update: true)
    }
    
    func showNotificationContext(){
        if BNAppSharedManager.instance.notificationManager.currentNotification != nil {
            switch BNAppSharedManager.instance.notificationManager.currentNotification!.notificationType! {
            case .PRODUCT:
                println("GOTO TO ELEMENT VIEW on product notification: \(BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!)")
                if let element = BNAppSharedManager.instance.dataManager.elements[BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!] {
                    //(siteState!.view as! SiteView).updateSiteData(site)
                    //setNextState(2)
                    println("Show element view for element: \(element._id!)")
                    var elementView = ElementMiniView(frame:CGRectMake(0, 0, 0, 0) , father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible: false)
                    (self.biinieCategoriesState!.view as? BiinieCategoriesView)?.showElementView(elementView)
                }
                break
            case .INTERNAL:
                println("GOTO TO SITE VIEW on Internal notification")
                if let site = BNAppSharedManager.instance.dataManager.sites[BNAppSharedManager.instance.notificationManager.currentNotification!.siteIdentifier!] {
                    (siteState!.view as! SiteView).updateSiteData(site)
                    setNextState(2)
                }
                break
            case .EXTERNAL:
                println("GOTO TO SITE VIEW on external notification")
//                if let site = BNAppSharedManager.instance.dataManager.sites[BNAppSharedManager.instance.notificationManager.currentNotification!.siteIdentifier!] {
//                    (siteState!.view as! SiteView).updateSiteData(site)
//                    setNextState(2)
//                }
//                
                
                println("GOTO TO ELEMENT VIEW on product notification: \(BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!)")
                if let element = BNAppSharedManager.instance.dataManager.elements[BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!] {
                    //(siteState!.view as! SiteView).updateSiteData(site)
                    //setNextState(2)
                    println("Show element view for element: \(element._id!)")
                    var elementView = ElementMiniView(frame:CGRectMake(0, 0, 0, 0) , father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible: false)
                    (self.biinieCategoriesState!.view as? BiinieCategoriesView)?.showElementView(elementView)
                }
                break
            default:
                break
            }
        }
        
        BNAppSharedManager.instance.notificationManager.currentNotification = nil
    }
    
    func showSiteView(view: SiteView_MiniLocation, site: BNSite) {
        println("showSiteView() from mini location view")
        (siteState!.view as! SiteView).updateSiteData(site)
        setNextState(2)
    }
}


@objc protocol MainViewDelegate:NSObjectProtocol {
    
    //Methods to conform on BNNetworkManager in
    
    
    ///Request a region's data.
    ///
    ///:param: BNDataManager that store all data.
    ///:param: Region's identifier requesting the data.
    optional func mainView(mainView:MainView!, hideMenu value:Bool)
    optional func mainView(mainView:MainView!, hideMenuOnChange value:Bool, index:Int)
    
    optional func mainView(mainView:MainView!, showMenu value:Bool)

}

@objc protocol MainViewDelegate_HighlightsContainer:NSObjectProtocol {
    optional func updateHighlightsContainer(view:MainView,  update:Bool)

}

@objc protocol MainViewDelegate_BiinsContainer:NSObjectProtocol {
    optional func updateBiinsContainer(view:MainView,  update:Bool)
    
}