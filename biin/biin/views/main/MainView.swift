//  MainView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class MainView:BNView {
    
    var delegate:MainViewDelegate?
    
    var rootViewController:MainViewController?
    var fade:UIView?
    var userControl:ControlView?
    
    var isSectionsLast = true
    var isSectionOrShowcase = false
    
    //states
    var biinieCategoriesState:BiinieCategoriesState?
//    var sectionState:SectionsState?
    var showcaseState:ShowcaseState?
    var searchState:SearchState?
    var settingsState:SettingsState?
    var collectionsState:CollectionsState?
    var profileState:ProfileState?
    var boardsState:BoardsState?
    
    override init() {
        super.init()
    }
    
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
        
        //Create views
        var categoriesView = BiinieCategoriesView(frame: frame, father: self)
        self.addSubview(categoriesView)
        
        
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
        
        var showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        sectionsView.top!.scroll!.addGestureRecognizer(showMenuSwipe)
        
        showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: "showMenu:")
        showMenuSwipe.edges = UIRectEdge.Left
        sectionsView.bottom!.scroll!.addGestureRecognizer(showMenuSwipe)
        
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
    }
    
    func showMenu(sender:UIScreenEdgePanGestureRecognizer) {
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
        delegate!.mainView!(self, hideMenuOnChange: false)
        
        switch (option) {
        case 1:
            
            state!.next( self.showcaseState )
            isSectionsLast = false
            isSectionOrShowcase = true
            
            break
        case 2:
            
            if !isSectionOrShowcase && !isSectionsLast {
                state!.next( self.showcaseState )
                isSectionsLast = false
                isSectionOrShowcase = true
            } else {
            
                //state!.next( self.sectionState )
                isSectionsLast = true
                isSectionOrShowcase = true
            }
            
            break
        case 3:
            state!.next(self.searchState)
            isSectionOrShowcase = false
            break
        case 4:
            state!.next(self.settingsState)
            isSectionOrShowcase = false
            break
        case 5:
            state!.next(self.collectionsState)
            isSectionOrShowcase = false
            break
        case 6:
            state!.next(self.profileState)
            rootViewController!.disableMenuButton(4)//Profile index on menu
            isSectionOrShowcase = false
            break
        case 7:
            state!.next(self.boardsState)
            isSectionOrShowcase = false
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
}


@objc protocol MainViewDelegate:NSObjectProtocol {
    
    //Methods to conform on BNNetworkManager
    
    ///Request a region's data.
    ///
    ///:param: BNDataManager that store all data.
    ///:param: Region's identifier requesting the data.
    optional func mainView(mainView:MainView!, hideMenu value:Bool)
    optional func mainView(mainView:MainView!, hideMenuOnChange value:Bool)
    
    optional func mainView(mainView:MainView!, showMenu value:Bool)
}