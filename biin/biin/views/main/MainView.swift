//  MainView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class MainView:BNView, SiteMiniView_Delegate, SiteView_Delegate, ProfileView_Delegate, CollectionsView_Delegate, ElementMiniView_Delegate, AboutView_Delegate, ElementView_Delegate, HightlightView_Delegate, AllSitesView_Delegate, AllElementsView_Delegate, MainViewContainer_Elements_Delegate, AllCollectedView_Delegate, InSiteView_Delegate, MainViewContainer_NearSites_Delegate, SurveyView_Delegate {
    
    var delegate:MainViewDelegate?
    //var delegate_HighlightsContainer:MainViewDelegate_HighlightsContainer?
    //var delegate_BiinsContainer:MainViewDelegate_BiinsContainer?
    
    var rootViewController:MainViewController?
    //var fade:UIView?
    var userControl:ControlView?
    
    //var isSectionsLast = true
    //var isSectionOrShowcase = false
    let lastOption = 1
    //var goto:BNGoto = BNGoto.Main
    //states
    var showMenuSwipe:UIScreenEdgePanGestureRecognizer?
    var mainViewContainerState:MainViewContainerState?
    //var biinieCategoriesState:BiinieCategoriesState?
    var siteState:SiteState?
    var elementState:ElementState?
    var elementFromSiteState:ElementFromSiteState?
    var profileState:ProfileState?
    var collectionsState:CollectionsState?    
    var notificationsState:NotificationsState?
    var loyaltiesState:LoyaltiesState?
    var aboutState:AboutState?
    var allSitesState:AllSitesState?
    var allElementsState:AllElementsState?
    var allCollectedState:AllCollectedState?
    var surveyState:SurveyState?
    //var errorState:ErrorState?
    
    var isShowingSite = false
    var isShowingSiteFromElement = false
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
        
        mainViewContainerState = MainViewContainerState(context: self, view:nil)

        
        //delegate_HighlightsContainer = mainViewContainer
        //delegate_BiinsContainer = mainViewContainer
        
        allSitesState = AllSitesState(context: self, view:nil)

        
        allElementsState = AllElementsState(context: self, view:nil)
        
        
        profileState = ProfileState(context: self, view:nil)
        
        
        
//        let collectionsView = CollectionsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
//        collectionsState = CollectionsState(context: self, view: collectionsView)
//        collectionsView.delegate = self
//        self.addSubview(collectionsView)
        
        allCollectedState = AllCollectedState(context: self, view:nil)

        
//        let notificationsView = NotificationsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
//        notificationsState = NotificationsState(context: self, view: notificationsView)
//        notificationsView.delegate = self
//        self.addSubview(notificationsView)
        
        
//        let loyaltiesView = LoyaltiesView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
//        loyaltiesState = LoyaltiesState(context: self, view: loyaltiesView)
//        loyaltiesView.delegate = self
//        self.addSubview(loyaltiesView)
        
        
        
        aboutState = AboutState(context: self, view:nil)
        siteState = SiteState(context: self, view:nil)
        elementState = ElementState(context: self, view:nil)
        elementFromSiteState = ElementFromSiteState(context: self, view:nil)
        surveyState = SurveyState(context: self, view: nil)
        
    
        
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
        
        show()
        
        
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
        testButton!.setTitle("test", forState: UIControlState.Normal)
        testButton!.addTarget(self, action: "testButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(testButton!)
    }
    
    func testButtonAction(sender:UIButton) {
        

//        if SimulatorUtility.isRunningSimulator {
//            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.9339660564594, -84.05398699629518)
//        }
//        
//        BNAppSharedManager.instance.dataManager.requestInitialData()
//        (mainViewContainerState!.view as! MainViewContainer).show_refreshButton()
        
        
        setNextState(BNGoto.Survey)
        
    }
    
    func show_refreshButton(){
        (mainViewContainerState!.view as! MainViewContainer).show_refreshButton()
    }
    
    func showMenu(sender:UIScreenEdgePanGestureRecognizer) {
        
        self.delegate!.mainView!(self, showMenu: true)
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( nextState:BNState? ) {
        
    }
        
    override func setNextState(goto:BNGoto){

        delegate!.mainView!(self, hideMenuOnChange: false, index:0)
        
        switch (goto) {
        case .Main:
            state!.next(self.mainViewContainerState)
            break
        case .Site:
            state!.next(self.siteState)
            break
        case .Profile:
            state!.next(self.profileState)
            break
        case .Collected:
            
//            if !isShowingAllCollectedView {
                self.allCollectedState!.view!.refresh()
//            }
            
            isShowingAllCollectedView = true
            state!.next(self.allCollectedState)
            
            break
        case .About:
            state!.next(self.aboutState)
            break
        case .Element:
            state!.next(self.elementState)
            break
        case .AllSites:
            state!.next(self.allSitesState)
            break
        case .AllElements:
            state!.next(self.allElementsState)
            break
        case .ElementFromSite:
            state!.next(self.elementFromSiteState)
            self.bringSubviewToFront(state!.view!)
            break
        case .Survey:
            state!.next(self.surveyState)
            self.bringSubviewToFront(state!.view!)
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
         setNextState(BNGoto.Main)
    }
    
    func hideCollectionsView(view: CollectionsView) {
        setNextState(BNGoto.Main)
    }
    
    func hideNotificationsView(view: NotificationsView) {
        setNextState(BNGoto.Main)
    }
    
    func hideLoyaltiesView(view: LoyaltiesView) {
        setNextState(BNGoto.Main)
        
    }
    
    func hideAboutView(view: AboutView) {
        setNextState(BNGoto.Main)
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
        
    }
    
    override func refresh() {
        mainViewContainerState!.view!.refresh()
    }
    
    func updateHighlightsContainer() {
        //delegate_HighlightsContainer!.updateHighlightsContainer!(self, update: true)
    }
    
    func showInSiteView(site:BNSite?) {
        (mainViewContainerState!.view as! MainViewContainer).showInSiteView(site)
    }
    
    func hideInSiteView(){
        (mainViewContainerState!.view as! MainViewContainer).hideInSiteView()
    }
    
    func showNotificationContext(){
        NSLog("BIIN - showNotificationContext")
        
        if BNAppSharedManager.instance.notificationManager.currentNotification != nil {
            switch BNAppSharedManager.instance.notificationManager.currentNotification!.notificationType! {
            case .PRODUCT:
//                NSLog("BIIN - GOTO TO ELEMENT VIEW on product notification: \(BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!)")
//                if let element = BNAppSharedManager.instance.dataManager.elements[BNAppSharedManager.instance.notificationManager.currentNotification!.objectIdentifier!] {
//                    //(siteState!.view as! SiteView).updateSiteData(site)
//                    //setNextState(2)
//                    NSLog("BIIN - Show element view for element: \(element._id!)")
//                    //let elementView = ElementMiniView(frame:CGRectMake(0, 0, 0, 0) , father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible: false)
//                    //(self.biinieCategoriesState!.view as? BiinieCategoriesView)?.showElementView(element)
//                }
                break
            case .INTERNAL:
//                NSLog("BIIN - GOTO TO SITE VIEW on Internal notification")
                if let site = BNAppSharedManager.instance.dataManager.sites[BNAppSharedManager.instance.notificationManager.currentNotification!.siteIdentifier!] {
                    (siteState!.view as! SiteView).updateSiteData(site)
                    setNextState(BNGoto.Site)
                }
                break
            case .EXTERNAL:
                NSLog("BIIN - GOTO TO SITE VIEW on external notification")
                if let site = BNAppSharedManager.instance.dataManager.sites[BNAppSharedManager.instance.notificationManager.currentNotification!.siteIdentifier!] {
                    (siteState!.view as! SiteView).updateSiteData(site)
                    setNextState(BNGoto.Site)
                } else if let element = BNAppSharedManager.instance.dataManager.elements_by_id[BNAppSharedManager.instance.notificationManager.currentNotification!.object_id!] {
                    
                    NSLog("BIIN - GOTO TO ELEMENT VIEW on product notification: \(BNAppSharedManager.instance.notificationManager.currentNotification!.object_id!)")
                    
                    (elementState!.view as! ElementView).updateElementData(element, showSiteBtn: true)
                    //(siteState!.view as! SiteView).updateSiteData(site)
                    
                    setNextState(BNGoto.Element)
                    NSLog("BIIN - Show element view for element: \(element._id!)")
//                    let elementView = ElementMiniView(frame:CGRectMake(0, 0, 0, 0) , father: self, element: element, elementPosition: 0, showRemoveBtn: false, isNumberVisible: false)
                    //(self.biinieCategoriesState!.view as? BiinieCategoriesView)?.showElementView(element)
                }
                break
            default:
                break
            }
        }
        
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.NOTIFICATION_OPENED , to:BNAppSharedManager.instance.notificationManager.currentNotification!.object_id!)
        BNAppSharedManager.instance.notificationManager.clearCurrentNotification()
        
    }
    
    //Show elementView from element containers or showcase.
    func showElementView(view: ElementMiniView, element: BNElement) {
        
        
//        if isShowingSite {
//            (siteState!.view as! SiteView).showFade()
//            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:false)
//        } else
        if isShowingAllElements {
            (allElementsState!.view as! AllElementsView).showFade()
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        } else if isShowingAllCollectedView {
            (allCollectedState!.view as! AllCollectedView).showFade()
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        } else {
            (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        }
        
        setNextState(BNGoto.Element)
    }
    
    func showElementViewFromSite(view: ElementMiniView, element: BNElement) {
        (siteState!.view as! SiteView).showFade()
        (elementFromSiteState!.view as! ElementView).updateElementData(element, showSiteBtn:false)
        setNextState(BNGoto.ElementFromSite)
    }
    
    //Show elementView from hightlight.
    func showElementViewFromHighlight(element: BNElement) {
        
        (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        setNextState(BNGoto.Element)
    }
    
    func hideElementView(element: BNElement) {
        
//        if isShowingSite {
//            setNextState(2)
//            (siteState!.view as! SiteView).hideFade()
//        } else
        if isShowingAllElements {
            setNextState(BNGoto.AllElements)
            (allElementsState!.view as! AllElementsView).hideFade()
        } else if isShowingAllCollectedView {
            setNextState(BNGoto.Collected)
            (allCollectedState!.view as! AllCollectedView).hideFade()
        } else {
            setNextState(BNGoto.Main)
        }
    }
    
    func hideElementViewFromSite(element: BNElement) {
        if isShowingSite {
            setNextState(BNGoto.Site)
            (siteState!.view as! SiteView).hideFade()
        }
    }
    
    func showSiteFromElement(element: BNElement) {
        
        if let site = BNAppSharedManager.instance.dataManager.sites[element.showcase!.site!.identifier!] {
            isShowingSite = true
            isShowingSiteFromElement = true
            
            (elementState!.view as! ElementView).showFade()
            self.bringSubviewToFront((siteState!.view as! SiteView))
            (siteState!.view as! SiteView).updateSiteData(site)
            setNextState(BNGoto.Site)

        }
    }
    
    //MainViewContainer_NearSites_Delegate Methods
    func showAllNearSitesView() {
        (self.allSitesState!.view as! AllSitesView).refresh()
        isShowingAllSite = true
        setNextState(BNGoto.AllSites)
    }
    
    //AllSitesView_Delegate Methdos
    func hideAllSitesView() {
        (self.mainViewContainerState!.view as! MainViewContainer).refresh_NearSitesContainer()
        isShowingAllSite = false
        setNextState(BNGoto.Main)
    }
    
    //AllElementsView_Delegate  Methods
    func hideAllElementsView(category:BNCategory?) {
        (self.mainViewContainerState!.view as! MainViewContainer).refresh_elementContainer(category!.identifier!)
        setNextState(BNGoto.Main)
        isShowingAllElements = false
    }
    
    //MainViewContainer_Elements_Delegate Methods
    func showAllElementsViewForCategory(category: BNCategory?) {
        isShowingAllElements = true
        (allElementsState!.view as! AllElementsView).updateCategoryData(category)
        setNextState(BNGoto.AllElements)
    }
    
    //SiteMiniView_Delegate Methods
    func showSiteView(view: SiteMiniView) {
        
        (siteState!.view as! SiteView).updateSiteData(view.site!)
        setNextState(BNGoto.Site)
        isShowingSite = true
        
        if isShowingAllSite {
            (allSitesState!.view as! AllSitesView).showFade()
        }
    }
    
    func showSiteViewOnContext(site: BNSite) {
        (siteState!.view as! SiteView).updateSiteData(site)
        setNextState(BNGoto.Site)
        isShowingSite = true
    }
    
    func hideSiteView(view: SiteView) {

        isShowingSite = false
        (allElementsState!.view as! AllElementsView).hideFade()
        
        if isShowingAllSite {
            (allSitesState!.view as! AllSitesView).hideFade()
            isShowingAllSite = true
            setNextState(BNGoto.AllSites)
            //view.transitionOut(nil)
        } else if isShowingSiteFromElement {
            setNextState(BNGoto.Element)
            (elementState!.view as! ElementView).hideFade()
            isShowingSiteFromElement = false
        } else {
            setNextState(BNGoto.Main)
        }
    }
    
    //AllCollectedView_Delegate Methods
    func hideAllCollectedView() {
        isShowingAllCollectedView = false
        setNextState(BNGoto.Main)
    }
    
    func updateAllCollectedView() {
        (allCollectedState!.view as? AllCollectedView)!.refresh()
    }
    
    //SurveyView_Delegate Methods
    func hideSurveyView() {
        setNextState(BNGoto.Main)
    }
    
    func clean(){
        
        
        showMenuSwipe?.removeTarget(self, action: "showMenu:")
        showMenuSwipe = nil
        
        (mainViewContainerState!.view as! MainViewContainer).clean()
        mainViewContainerState!.view!.removeFromSuperview()
        mainViewContainerState!.view = nil
        
        (allSitesState!.view as! AllSitesView).clean()
        allSitesState!.view!.removeFromSuperview()
        allSitesState!.view = nil
        
        (allElementsState!.view as! AllElementsView).clean()
        allElementsState!.view!.removeFromSuperview()
        allElementsState!.view = nil
        
        (profileState!.view as! ProfileView).clean()
        profileState!.view!.removeFromSuperview()
        profileState!.view = nil
        
        (allCollectedState!.view as! AllCollectedView).clean()
        allCollectedState!.view!.removeFromSuperview()
        allCollectedState!.view = nil

        (aboutState!.view as! AboutView).clean()
        aboutState!.view!.removeFromSuperview()
        aboutState!.view = nil
        
        (siteState!.view as! SiteView).clean()
        siteState!.view!.removeFromSuperview()
        siteState!.view = nil
        
        (elementState!.view as! ElementView).clean()
        elementState!.view!.removeFromSuperview()
        elementState!.view = nil
        
        (elementFromSiteState!.view as! ElementView).clean()
        elementFromSiteState!.view!.removeFromSuperview()
        elementFromSiteState!.view = nil

        (surveyState!.view as! SurveyView).clean()
        surveyState!.view!.removeFromSuperview()
        surveyState!.view = nil
    }
    
    func show(){
        
        let mainViewContainer = MainViewContainer(frame: CGRectMake(0, 0, frame.width, frame.height), father: self)
        self.addSubview(mainViewContainer)
        mainViewContainerState!.view = mainViewContainer
        state = mainViewContainerState!
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe!.edges = UIRectEdge.Left
        mainViewContainer.scroll!.addGestureRecognizer(showMenuSwipe!)

        
        let allSitesView = AllSitesView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: false)
        addSubview(allSitesView)
        allSitesState!.view = allSitesView
        allSitesView.delegate = self
        
        let allElementsView = AllElementsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: true)
        self.addSubview(allElementsView)
        allElementsState!.view = allElementsView
        allElementsView.delegate = self

        let profileView = ProfileView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        self.addSubview(profileView)
        profileState!.view = profileView
        profileView.delegate = rootViewController!
        profileView.delegateFather = self

        let allCollectedView = AllCollectedView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: false)
        self.addSubview(allCollectedView)
        allCollectedState!.view = allCollectedView
        allCollectedView.delegate = self
        
        let aboutView = AboutView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        aboutState!.view = aboutView
        aboutView.delegate = self
        self.addSubview(aboutView)
        
        let siteView = SiteView(frame:CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        siteState!.view = siteView
        siteView.delegate = self
        self.addSubview(siteView)
        
        let elementView = ElementView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn:true)
        elementState!.view = elementView
        elementView.delegate = self
        self.addSubview(elementView)
        
        let elementViewFromSite = ElementView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn:true)
        elementViewFromSite.isElementViewFromSite = true
        elementFromSiteState!.view = elementViewFromSite
        elementViewFromSite.delegate = self
        self.addSubview(elementViewFromSite)
        
        let surveyView = SurveyView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        surveyState!.view = surveyView
        surveyView.delegate = self
        self.addSubview(surveyView)
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

enum BNGoto {
    case Main
    case Site
    case Element
    case ElementFromSite
    case Profile
    case About
    case Collected
    case AllSites
    case AllElements
    case Survey
}