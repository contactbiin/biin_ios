//  MainView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreLocation

class MainView:BNView, SiteMiniView_Delegate, SiteView_Delegate, ProfileView_Delegate, CollectionsView_Delegate, ElementMiniView_Delegate, AboutView_Delegate, ElementView_Delegate, HightlightView_Delegate, AllSitesView_Delegate, AllElementsView_Delegate, MainView_Container_Elements_Delegate, AllCollectedView_Delegate, InSiteView_Delegate, MainView_Container_NearSites_Delegate, SurveyView_Delegate, MainView_Container_FavoriteSites_Delegate, GiftsView_Delegate, NotificationsView_Delegate {
    
    var delegate:MainViewDelegate?
    var rootViewController:MainViewController?
    //var fade:UIView?
    var userControl:ControlView?
    
    //states
    var showMenuSwipe:UIScreenEdgePanGestureRecognizer?
    var mainViewContainerState:MainViewContainerState?
    var siteState:SiteState?
    var brotherSiteState:BrotherSiteState?
    var elementState:ElementState?
    var elementFromSiteState:ElementFromSiteState?
    var profileState:ProfileState?
    var collectionsState:CollectionsState?
    var aboutState:AboutState?
    var allSitesState:AllSitesState?
    var allFavoriteSitesState:AllFavoriteSitesState?
    var allElementsState:AllElementsState?
    var allCollectedState:AllCollectedState?
    var surveyState:SurveyState?
    var notificationsState:NotificationsState?
    var giftsState:GiftsState?
    
    var isShowingNotificationContext = false
    
    var isReadyToShowSurvey = false
    weak var site_to_survey:BNSite?
    
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
        self.layer.masksToBounds = true
    }
    
    func addUIViews(){

        mainViewContainerState = MainViewContainerState(context: self, view:nil)
        allSitesState = AllSitesState(context: self, view:nil)
        allFavoriteSitesState = AllFavoriteSitesState(context: self, view: nil)
        allElementsState = AllElementsState(context: self, view:nil)
        profileState = ProfileState(context: self, view:nil)
        allCollectedState = AllCollectedState(context: self, view:nil)
        aboutState = AboutState(context: self, view:nil)
        siteState = SiteState(context: self, view:nil)
        brotherSiteState = BrotherSiteState(context: self, view: nil)
        elementState = ElementState(context: self, view:nil)
        elementFromSiteState = ElementFromSiteState(context: self, view:nil)
        surveyState = SurveyState(context: self, view: nil)
        notificationsState = NotificationsState(context: self, view: nil)
        giftsState = GiftsState(context: self, view: nil)
        
        show()

        testButton = UIButton(frame: CGRectMake(10, 100, 100, 50))
        testButton!.backgroundColor = UIColor.bnOrange()
        testButton!.setTitle("test", forState: UIControlState.Normal)
        testButton!.addTarget(self, action: #selector(self.testButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //self.addSubview(testButton!)
    }
    
    var isShowingInsiteView = false
    
    func testButtonAction(sender:UIButton) {
        

        
        
//        BNAppSharedManager.instance.notificationManager.clear()
//        
//        if let site = BNAppSharedManager.instance.dataManager.sites["bb26d8e1-0ff4-40a3-b468-0903e6629c0e"]
//        {
//            site_to_survey = site
//            showSurveyView()
//        }
  
        /*
        if !isShowingInsiteView {
            if let site = BNAppSharedManager.instance.dataManager.sites["bb26d8e1-0ff4-40a3-b468-0903e6629c0e"] {

                isShowingInsiteView = true
                showInSiteView(site)
                
            }
        } else {
            hideInSiteView()
            isShowingInsiteView = false
        }
        */
    }
    
    func updateSurveyView(site:BNSite?) {
        
        (self.surveyState!.view as! SurveyView).updateSiteData(site)
        
        if state?.stateType == BNStateType.MainViewContainerState {
            BNAppSharedManager.instance.notificationManager.add_surveyedSite(site_to_survey!.identifier)
            setNextState(BNGoto.Survey)
            isReadyToShowSurvey = false
        } else {
            isReadyToShowSurvey = true
        }
    }
    
    func show_refreshButton(){
        (mainViewContainerState!.view as! MainView_Container_All).show_refreshButton()
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
//        state!.view!.showFade()
        
        if isShowingNotificationContext {
            isShowingNotificationContext = false
            BNAppSharedManager.instance.notificationManager.currentNotification = nil
        }
        
        switch (goto) {
        case .Previous:
            state!.previous!.view!.hideFade()
            state!.next(state!.previous!)
            break
        case .Main:
            if isReadyToShowSurvey {
                BNAppSharedManager.instance.notificationManager.add_surveyedSite(site_to_survey!.identifier)
                state!.next(self.surveyState)
                isReadyToShowSurvey = false
            } else {
                state!.next(self.mainViewContainerState)
            }
            break
        case .Site:
            state!.view!.showFade()
            self.siteState!.previous = state
            state!.next(self.siteState)
            break
        case .BrotherSite:
            state!.view!.showFade()
            self.bringSubviewToFront(self.brotherSiteState!.view!)
            self.brotherSiteState!.previous = state
            state!.next(self.brotherSiteState)
            break
        case .Profile:
            state!.view!.showFade()
            self.profileState!.previous = state
            state!.next(self.profileState)
            SharedAnswersManager.instance.logContentView_Profile()
            break
        case .Collected:
            
            self.allCollectedState!.view!.refresh()
            SharedAnswersManager.instance.logContentView_Collected()
//            isShowingAllCollectedView = true
            state!.next(self.allCollectedState)
            
            break
        case .About:
            state!.view!.showFade()
            self.aboutState!.previous = state
            state!.next(self.aboutState)
            SharedAnswersManager.instance.logContentView_About()
            break
        case .Element:
            state!.view!.showFade()
            self.elementState!.previous = state
            state!.next(self.elementState)
            break
        case .ElementFromSite:
            state!.view!.showFade()
            self.elementFromSiteState!.previous = state
            state!.next(self.elementFromSiteState)
            self.bringSubviewToFront(state!.view!)
            break
        case .AllSites:
            state!.view!.showFade()
            self.allSitesState!.previous = state
            state!.next(self.allSitesState)
            SharedAnswersManager.instance.logContentView_AllSites()
            break
        case .AllFavoriteSites:
            state!.view!.showFade()
            self.allFavoriteSitesState!.previous = state
            state!.next(self.allFavoriteSitesState)
//            SharedAnswersManager.instance.logContentView_AllSites()
            break
        case .AllElements:
            state!.view!.showFade()
            self.allElementsState!.previous = state
            state!.next(self.allElementsState)
            break
        case .Survey:
            state!.view!.showFade()
            self.surveyState!.previous = state
            state!.next(self.surveyState)
            self.bringSubviewToFront(state!.view!)
            SharedAnswersManager.instance.logContentView_Survey(site_to_survey)
            break
        case .Notifications:
            state!.view!.showFade()
            self.notificationsState!.previous = state
            state!.next(self.notificationsState)
            self.bringSubviewToFront(state!.view!)
            break
        case .Gifts:
            state!.view!.showFade()
            self.giftsState!.previous = state
            state!.next(self.giftsState)
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
         setNextState(BNGoto.Previous)
    }
    
    func hideCollectionsView(view: CollectionsView) {
        setNextState(BNGoto.Main)
    }
    
    func hideNotificationsView() {
        setNextState(BNGoto.Previous)
    }
    
    func hideAboutView(view: AboutView) {
        setNextState(BNGoto.Previous)
    }
    
    //func hideErrorView(view: ErrorView) {
        //setNextState(lastOption)
        
        //For testing
//        var vc = LoadingViewController()
//        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//        self.rootViewController!.presentViewController(vc, animated: true, completion: nil)
//        BNAppSharedManager.instance.dataManager.requestDataForNewPosition()
    //}
    
    override func refresh() {
        NSLog("BIIN - Mainview refresh()")
        mainViewContainerState!.view!.refresh()
    }
    
    func updateHighlightsContainer() {
        //delegate_HighlightsContainer!.updateHighlightsContainer!(self, update: true)
    }
    
    func showInSiteView(site:BNSite?) {

        if !isShowingInsiteView {
            isShowingInsiteView = true
            site_to_survey = site
            (mainViewContainerState!.view as! MainView_Container_All).showInSiteView(site)
        }
    }
    
    func hideInSiteView(){
        
        if isShowingInsiteView {
            isShowingInsiteView = false
            (mainViewContainerState!.view as! MainView_Container_All).hideInSiteView()
            showSurveyView()
        }
    }
    
    func showSurveyView() {
        if site_to_survey != nil {
            if site_to_survey!.organization!.hasNPS {
                if !BNAppSharedManager.instance.notificationManager.is_site_surveyed(site_to_survey!.identifier) {
                    
                    NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.showSurveyOnTimer(_:)), userInfo: nil, repeats: false)
                } else {
                    //print("site: \(site_to_survey!.title!) is already survyed today")
                }
            } else {
                //print("NPS not available")
            }
        }
    }
    
    func showSurveyViewOnRequest() {
        if site_to_survey != nil {
            if site_to_survey!.organization!.hasNPS {
                if !BNAppSharedManager.instance.notificationManager.is_site_surveyed(site_to_survey!.identifier) {
                    
                    state!.view!.showFade()
                    (self.surveyState!.view as! SurveyView).updateSiteData(site_to_survey)
                    self.surveyState!.previous = state
                    state!.next(self.surveyState)
                    isReadyToShowSurvey = false
                    self.bringSubviewToFront(state!.view!)

                } else {
                    print("site: \(site_to_survey!.title!) is already survyed today")
                }
            } else {
                print("NPS not available")
            }
        }
    }

    func showSurveyOnTimer(sender:NSTimer){
        if site_to_survey != nil {
            updateSurveyView(site_to_survey)
        }
    }
    
    func showNotificationContext() {

        print("BIIN - showNotificationContext")
        
        if !isShowingNotificationContext {
            
            isShowingNotificationContext = true
            
            var isShowingElement = false
            
            if let notice = BNAppSharedManager.instance.notificationManager.getLastNoticeOpened() {

                if notice.elementIdentifier != "" {
                    
                    if let element = BNAppSharedManager.instance.dataManager.elements[notice.elementIdentifier!] {

                        isShowingElement = true
                        (elementState!.view as! ElementView).updateElementData(element, showSiteBtn: true)
                        setNextState(BNGoto.Element)
                        BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.NOTIFICATION_OPENED , to:notice.identifier!, by:notice.siteIdentifier)
                        
                    }
                }
            
                if !isShowingElement {
                    if let site = BNAppSharedManager.instance.dataManager.sites[notice.siteIdentifier] {
                        (siteState!.view as! SiteView).updateSiteData(site)
                        setNextState(BNGoto.Site)
                        
                    }
                }
                
                BNAppSharedManager.instance.notificationManager.lastNotice_identifier = ""
            }
        }
    }
    
    //Show elementView from element containers or showcase.
    func showElementView(view: ElementMiniView, element: BNElement) {
        (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        setNextState(BNGoto.Element)
    }
    
    //Show elementView from hightlight.
    func showElementViewFromHighlight(element: BNElement) {
        (elementState!.view as! ElementView).updateElementData(element, showSiteBtn:true)
        setNextState(BNGoto.Element)
    }
    
    func hideElementView(element: BNElement) {
        setNextState(BNGoto.Previous)
    }
    
    func showElementViewFromSite(view: ElementMiniView, element: BNElement) {
        (elementFromSiteState!.view as! ElementView).updateElementData(element, showSiteBtn:false)
        setNextState(BNGoto.ElementFromSite)
    }
    
    func hideElementViewFromSite(element: BNElement) {
        setNextState(BNGoto.Previous)
    }
    
    func showSiteFromElement(element: BNElement) {
        if let site = BNAppSharedManager.instance.dataManager.sites[element.showcase!.site!.identifier!] {
            self.bringSubviewToFront((siteState!.view as! SiteView))
            (siteState!.view as! SiteView).updateSiteData(site)
            setNextState(BNGoto.Site)
        }
    }
    
    //MainViewContainer_NearSites_Delegate Methods
    func showAllNearSitesView() {
        (self.allSitesState!.view as! AllSitesView).showAllSites()
        setNextState(BNGoto.AllSites)
    }
    
    //AllSitesView_Delegate Methdos
    func hideAllSitesView() {
        setNextState(BNGoto.Previous)
    }
    
    //MainViewContainer_NearSites_Delegate Methods
    func showAllFavoriteSitesView() {
        (self.allFavoriteSitesState!.view as! AllSitesView).showAllFavoriteSite()
        setNextState(BNGoto.AllFavoriteSites)
    }
    
    //AllSitesView_Delegate Methdos
    func hideAllFavoriteSitesView() {  }
    
    func refresh_favoritesSitesContaier(site:BNSite?){
        (self.mainViewContainerState!.view as! MainView_Container_All).updateLikeButtons()
        (self.allFavoriteSitesState!.view as! AllSitesView).showAllFavoriteSite()
        (self.mainViewContainerState!.view as! MainView_Container_All).refresh_favoritesSitesContaier(site)
    }
    
    //AllElementsView_Delegate  Methods
    func hideAllElementsView(category:BNCategory?) {
        (self.mainViewContainerState!.view as! MainView_Container_All).refresh_elementContainer(category!.identifier!)
        setNextState(BNGoto.Previous)
//        isShowingAllElements = false
    }
    
    //MainViewContainer_Elements_Delegate Methods
    func showAllElementsViewForCategory(category: BNCategory?) {
        (allElementsState!.view as! AllElementsView).updateCategoryData(category)
        setNextState(BNGoto.AllElements)
    }
    
    //SiteMiniView_Delegate Methods
    func showSiteView(view: SiteMiniView) {
        (siteState!.view as! SiteView).updateSiteData((view.model as! BNSite))
        setNextState(BNGoto.Site)
    }
    
    func showBrotherSiteView(view: SiteMiniView) {
        (brotherSiteState!.view as! SiteView).updateSiteData((view.model as! BNSite))
        setNextState(BNGoto.BrotherSite)
    }
    
    func showSiteViewOnContext(site: BNSite) {
        (siteState!.view as! SiteView).updateSiteData(site)
        setNextState(BNGoto.Site)
    }
    
    func hideSiteViewOnContext(site: BNSite) {
        (mainViewContainerState!.view as! MainView_Container_All).hideInSiteView()
    }
    
    func hideSiteView()             { setNextState(BNGoto.Previous) }
    func hideBrotherSiteView()      { setNextState(BNGoto.Previous) }
    func hideAllCollectedView()     { setNextState(BNGoto.Main) }
    func hideSurveyView()           { setNextState(BNGoto.Previous) }
    func hideGiftsView()            { setNextState(BNGoto.Previous) }
    
    
    func updateAllCollectedView() {
        (allCollectedState!.view as? AllCollectedView)!.refresh()
    }
    
    
    override func clean(){

        showMenuSwipe?.removeTarget(self, action: #selector(self.showMenu(_:)))
        showMenuSwipe = nil
        
        (mainViewContainerState!.view as! MainView_Container_All).clean()
        mainViewContainerState!.view!.removeFromSuperview()
        mainViewContainerState!.view = nil
        
        (allSitesState!.view as! AllSitesView).clean()
        allSitesState!.view!.removeFromSuperview()
        allSitesState!.view = nil
        
        allFavoriteSitesState!.view = nil
        
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
        
        (brotherSiteState!.view as! SiteView).clean()
        brotherSiteState!.view!.removeFromSuperview()
        brotherSiteState!.view = nil
        
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
        
        let mainViewContainer = MainView_Container_All(frame: CGRectMake(0, 0, frame.width, frame.height), father: self)
        self.addSubview(mainViewContainer)
        mainViewContainerState!.view = mainViewContainer
        state = mainViewContainerState!
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.showMenu(_:)))
        showMenuSwipe!.edges = UIRectEdge.Left
        mainViewContainer.scroll!.addGestureRecognizer(showMenuSwipe!)
        
        let allSitesView = AllSitesView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self, showBiinItBtn: false)
        addSubview(allSitesView)
        allSitesState!.view = allSitesView
        allSitesView.delegate = self
        
        allFavoriteSitesState!.view = allSitesView
        
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
        
        let brotherSiteView = SiteView(frame:CGRectMake(SharedUIManager.instance.screenWidth, 0,
            SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        brotherSiteView.isShowingOtherSites = false
        brotherSiteState!.view = brotherSiteView
        brotherSiteView.delegate = self
        self.addSubview(brotherSiteView)
        
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
        
        let notificationView = NotificationsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        notificationsState!.view = notificationView
        notificationView.delegate = self
        self.addSubview(notificationView)
        
        let giftsView = GiftsView(frame: CGRectMake(SharedUIManager.instance.screenWidth, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: self)
        giftsState!.view = giftsView
        giftsView.delegate = self
        self.addSubview(giftsView)
    }
    
    func updateProfileView(){
        (profileState!.view as! ProfileView).update()
    }
    
    func updateGiftsView() {
        (giftsState!.view as! GiftsView).updateGifts()
        (mainViewContainerState!.view as! MainView_Container_All).optionsBar!.updateGiftCounter()
    }
    
    func updateNotificationsView(){
        (notificationsState!.view as! NotificationsView).addNotifications()
        (mainViewContainerState!.view as! MainView_Container_All).optionsBar!.updateNotificationCounter()
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

@objc protocol MainView_Delegate_HighlightsContainer:NSObjectProtocol {
    optional func updateHighlightsContainer(view:MainView,  update:Bool)
}

@objc protocol MainView_Delegate_BiinsContainer:NSObjectProtocol {
    optional func updateBiinsContainer(view:MainView,  update:Bool)
}

enum BNGoto {
    case Main
    case Site
    case BrotherSite
    case Element
    case ElementFromSite
    case Profile
    case About
    case Collected
    case AllSites
    case AllFavoriteSites
    case AllElements
    case Survey
    case Previous
    case Notifications
    case Gifts
}