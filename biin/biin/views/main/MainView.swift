//  MainView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class MainView:BNView, SiteMiniView_Delegate, SiteView_Delegate, ProfileView_Delegate, CollectionsView_Delegate, NotificationsView_Delegate, ElementMiniView_Delegate, SiteView_MiniLocation_Delegate, LoyaltiesView_Delegate, AboutView_Delegate, ElementView_Delegate, HightlightView_Delegate, MainViewContainer_Sites_Delegate, AllSitesView_Delegate, AllElementsView_Delegate, MainViewContainer_Elements_Delegate, AllCollectedView_Delegate {
    
    var delegate:MainViewDelegate?
    //var delegate_HighlightsContainer:MainViewDelegate_HighlightsContainer?
    //var delegate_BiinsContainer:MainViewDelegate_BiinsContainer?
    
    var rootViewController:MainViewController?
    //var fade:UIView?
    var userControl:ControlView?
    
    //var isSectionsLast = true
    //var isSectionOrShowcase = false
    var lastOption = 1
    
    //states
    var mainViewContainerState:MainViewContainerState?
    //var biinieCategoriesState:BiinieCategoriesState?
    var siteState:SiteState?
    var elementState:ElementState?
    var profileState:ProfileState?
    var collectionsState:CollectionsState?    
    var notificationsState:NotificationsState?
    var loyaltiesState:LoyaltiesState?
    var aboutState:AboutState?
    var allSitesState:AllSitesState?
    var allElementsState:AllElementsState?
    var allCollectedState:AllCollectedState?
    //var errorState:ErrorState?
    
    var isShowingSite = false
    var isShowingAllSite = false
    var isShowingAllElements = false
    var isShowingAllCollectedView = false
    
    var searchState:SearchState?
    var settingsState:SettingsState?
    
//    override init() {
//        super.init()
//    }
    
    var testButton:UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
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
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        
        

    }
    
    func addUIViews(){
        //Create views
        //        let categoriesView = BiinieCategoriesView(frame: CGRectMake(0, 0, frame.width, frame.height), father: self)
        //        biinieCategoriesState = BiinieCategoriesState(context: self, view: categoriesView, stateType: BNStateType.BiinieCategoriesState)
        //        self.addSubview(categoriesView)
        //        state = biinieCategoriesState!
        
        let mainViewContainer = MainViewContainer(frame: CGRectMake(0, 0, frame.width, frame.height), father: self)
        mainViewContainerState = MainViewContainerState(context: self, view: mainViewContainer)
        self.addSubview(mainViewContainer)
        state = mainViewContainerState!
        
        //delegate_HighlightsContainer = mainViewContainer
        //delegate_BiinsContainer = mainViewContainer
        
        let allSitesView = AllSitesView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: false)
        allSitesState = AllSitesState(context: self, view: allSitesView)
        allSitesView.delegate = self
        addSubview(allSitesView)
        
        let allElementsView = AllElementsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: true)
        allElementsState = AllElementsState(context: self, view: allElementsView)
        allElementsView.delegate = self
        self.addSubview(allElementsView)
        
        let siteView = SiteView(frame:CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        siteState = SiteState(context: self, view: siteView, stateType: BNStateType.SiteState)
        siteView.delegate = self
        self.addSubview(siteView)
        
        let elementView = ElementView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn:true)
        elementState = ElementState(context: self, view: elementView)
        elementView.delegate = self
        self.addSubview(elementView)
        
        let profileView = ProfileView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        profileState = ProfileState(context: self, view: profileView, stateType: BNStateType.ProfileState)
        profileView.delegate = rootViewController!
        profileView.delegateFather = self
        self.addSubview(profileView)
        
//        let collectionsView = CollectionsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
//        collectionsState = CollectionsState(context: self, view: collectionsView)
//        collectionsView.delegate = self
//        self.addSubview(collectionsView)
        
        let allCollectedView = AllCollectedView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: false)
        allCollectedState = AllCollectedState(context: self, view: allCollectedView)
        allCollectedView.delegate = self
        self.addSubview(allCollectedView)
        
        let notificationsView = NotificationsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        notificationsState = NotificationsState(context: self, view: notificationsView)
        notificationsView.delegate = self
        self.addSubview(notificationsView)
        
        
        let loyaltiesView = LoyaltiesView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        loyaltiesState = LoyaltiesState(context: self, view: loyaltiesView)
        loyaltiesView.delegate = self
        self.addSubview(loyaltiesView)
        
        let aboutView = AboutView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        aboutState = AboutState(context: self, view: aboutView)
        aboutView.delegate = self
        self.addSubview(aboutView)
        
        //        var errorView = ErrorView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        //        errorState = ErrorState(context: self, view: errorView)
        //        errorView.delegate = self
        //        self.addSubview(errorView)
        
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
        let showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        mainViewContainer.scroll!.addGestureRecognizer(showMenuSwipe)
        
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
        print("testButtonAction()")
        BNAppSharedManager.instance.dataManager.requestDataForNewPosition()
    }
    
    func showMenu(sender:UIScreenEdgePanGestureRecognizer) {
        print("Showmain Menu")
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
            
            state!.next(self.mainViewContainerState)
            //lastOption = option
            break
        case 2:
            
            //if isShowingAllSite {
            state!.next(self.siteState)
            //}
            //lastOption = option
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
            
            if !isShowingAllCollectedView {
                self.allCollectedState!.view!.refresh()
            }
            
            isShowingAllCollectedView = true
            state!.next(self.allCollectedState)
//            state!.next(self.collectionsState)
//            self.bringSubviewToFront(state!.view!)
//            self.collectionsState!.view!.refresh()
            break
        case 5:
            break
        case 6:
            state!.next(self.notificationsState)
            self.bringSubviewToFront(state!.view!)
            break
        case 7:
            state!.next(self.loyaltiesState)
            (state!.view as! LoyaltiesView).updateLoyaltiesMiniViews()
            self.bringSubviewToFront(state!.view!)
            break
        case 8:
            state!.next(self.aboutState)
            self.bringSubviewToFront(state!.view!)
            break
        case 9:
            state!.next(self.elementState)
            self.bringSubviewToFront(state!.view!)
            break
        case 10:
            state!.next(self.allSitesState)
            //lastOption = option
            break
        case 11:
            state!.next(self.allElementsState)
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
                  //self.fade!.alpha = 0.25
                })
            } else {
                userControl!.showUserControl(value, son: son, point: point)
                UIView.animateWithDuration(0.1, animations: {()->Void in
                  //self.fade!.alpha = 0
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
    
    func hideProfileView(view: ProfileView) {
         setNextState(lastOption)
    }
    
    func hideCollectionsView(view: CollectionsView) {
        setNextState(lastOption)
    }
    
    func hideNotificationsView(view: NotificationsView) {
        setNextState(lastOption)
    }
    
    func hideLoyaltiesView(view: LoyaltiesView) {
        setNextState(lastOption)
        
    }
    
    func hideAboutView(view: AboutView) {
        setNextState(lastOption)
    }
    
    //func hideErrorView(view: ErrorView) {
        //setNextState(lastOption)
        
        //For testing
//        var vc = LoadingViewController()
//        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//        self.rootViewController!.presentViewController(vc, animated: true, completion: nil)
//        BNAppSharedManager.instance.dataManager.requestDataForNewPosition()
    //}
    
    func showLoyalties(){
        print("showLoyalties()")
    }
    
    override func refresh() {
        mainViewContainerState!.view!.refresh()
    }
    
    func updateHighlightsContainer() {
        //delegate_HighlightsContainer!.updateHighlightsContainer!(self, update: true)
    }
    
    func updateBiinsContainer() {
        print("updateBiinsContainer")
        //delegate_BiinsContainer!.updateBiinsContainer!(self, update: true)
    }
    
    func showNotificationContext(){
        NSLog("BIIN - showNotificationContext")
        
        if BNAppSharedManager.instance.notificationManager.currentNotification != nil {
            switch BNAppSharedManager.instance.notificationManager.currentNotification!.notificationType! {
            case .PRODUCT:
                NSLog("BIIN - GOTO TO ELEMENT VIEW on product notification: \(BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!)")
                if let element = BNAppSharedManager.instance.dataManager.elements[BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!] {
                    //(siteState!.view as! SiteView).updateSiteData(site)
                    //setNextState(2)
                    NSLog("BIIN - Show element view for element: \(element._id!)")
                    //let elementView = ElementMiniView(frame:CGRectMake(0, 0, 0, 0) , father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible: false)
                    //(self.biinieCategoriesState!.view as? BiinieCategoriesView)?.showElementView(element)
                }
                break
            case .INTERNAL:
                NSLog("BIIN - GOTO TO SITE VIEW on Internal notification")
                if let site = BNAppSharedManager.instance.dataManager.sites[BNAppSharedManager.instance.notificationManager.currentNotification!.siteIdentifier!] {
                    (siteState!.view as! SiteView).updateSiteData(site)
                    setNextState(2)
                }
                break
            case .EXTERNAL:
                NSLog("BIIN - GOTO TO SITE VIEW on external notification")
//                if let site = BNAppSharedManager.instance.dataManager.sites[BNAppSharedManager.instance.notificationManager.currentNotification!.siteIdentifier!] {
//                    (siteState!.view as! SiteView).updateSiteData(site)
//                    setNextState(2)
//                }
//                
                
                NSLog("BIIN - GOTO TO ELEMENT VIEW on product notification: \(BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!)")
                if let element = BNAppSharedManager.instance.dataManager.elements[BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!] {
                    //(siteState!.view as! SiteView).updateSiteData(site)
                    //setNextState(2)
                    NSLog("BIIN - Show element view for element: \(element._id!)")
//                    let elementView = ElementMiniView(frame:CGRectMake(0, 0, 0, 0) , father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible: false)
                    //(self.biinieCategoriesState!.view as? BiinieCategoriesView)?.showElementView(element)
                }
                break
            default:
                break
            }
        }
        
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.NOTIFICATION_OPENED , to:BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!)
        BNAppSharedManager.instance.notificationManager.clearCurrentNotification()
        
    }
    
//    func showSiteView(view: SiteView_MiniLocation, site: BNSite) {
//        print("showSiteView() from mini location view")
//        (siteState!.view as! SiteView).updateSiteData(site)
//        setNextState(2)
//    }
    
    //Show elementView from element containers or showcase.
    func showElementView(view: ElementMiniView, element: BNElement) {
        print("showElementView from element")
        
        if isShowingSite {
            (siteState!.view as! SiteView).showFade()
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:false)
        } else if isShowingAllElements {
            (allElementsState!.view as! AllElementsView).showFade()
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        } else if isShowingAllCollectedView {
            (allCollectedState!.view as! AllCollectedView).showFade()
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        } else {
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        }
        
        setNextState(9)
    }
    
    //Show elementView from hightlight.
    func showElementView(element: BNElement) {
        print("showElementView from highlight")
        (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        setNextState(9)
    }
    
    func hideElementView(element: BNElement) {
        
        if isShowingSite {
            setNextState(2)
            (siteState!.view as! SiteView).hideFade()
        } else if isShowingAllElements {
            setNextState(11)
            (allElementsState!.view as! AllElementsView).hideFade()
        } else if isShowingAllCollectedView {
            setNextState(4)
            (allCollectedState!.view as! AllCollectedView).hideFade()
        } else {
            setNextState(1)
        }
    }
    
    func showSiteFromElement(element: BNElement) {
        
        if let site = BNAppSharedManager.instance.dataManager.sites[element.siteIdentifier!] {
            self.bringSubviewToFront((siteState!.view as! SiteView))
            (siteState!.view as! SiteView).updateSiteData(site)
            setNextState(2)
            isShowingSite = true
        }
    }
    
    //MainViewContainer_Sites_Delegate Methods
    func showAllSitesView() {
        print("showAllSitesView")
        isShowingAllSite = true
        setNextState(10)
    }
    
    //AllSitesView_Delegate Methdos
    func hideAllSitesView() {
        isShowingAllSite = false
        setNextState(lastOption)
    }
    
    //AllElementsView_Delegate  Methods
    func hideAllElementsView() {
        setNextState(1)
        isShowingAllElements = false
    }
    
    //MainViewContainer_Elements_Delegate Methods
    func showAllElementsViewForCategory(category: BNCategory?) {
        isShowingAllElements = true
        (allElementsState!.view as! AllElementsView).updateCategoryData(category)
        setNextState(11)
    }
    
    //SiteMiniView_Delegate Methods
    func showSiteView(view: SiteMiniView) {
        
        (siteState!.view as! SiteView).updateSiteData(view.site!)
        setNextState(2)
        isShowingSite = true
        
        if isShowingAllSite {
            (allSitesState!.view as! AllSitesView).showFade()
        }
    }
    
    func hideSiteView(view: SiteView) {

        isShowingSite = false
        (allElementsState!.view as! AllElementsView).hideFade()
        
        if isShowingAllSite {
            (allSitesState!.view as! AllSitesView).hideFade()
            isShowingAllSite = true
            setNextState(10)
            //view.transitionOut(nil)
        } else  {
            setNextState(1)
        }
    }
    
    //AllCollectedView_Delegate Methods
    func hideAllCollectedView() {
        isShowingAllCollectedView = false
        setNextState(1)
    }
}


@objc protocol MainViewDelegate:NSObjectProtocol {
    
    //Methods to conform on BNNetworkManager in
    
    
    ///Request a region's data.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter Region's: identifier requesting the data.
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