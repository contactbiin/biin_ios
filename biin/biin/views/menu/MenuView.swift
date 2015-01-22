//  MenuView.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class MenuView:UIView {
    
    var delegate:MenuViewDelegate?
    var isHidden = true
    /*
    var homeBtn:BNButton?
    var searchBtn:BNButton?
    var settingsBtn:BNButton?
    var collectionsBtn:BNButton?
    var profileBtn:BNButton?
    var boardsBtn:BNButton?
    var buttons = Array<BNButton>()
    */
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor()
        
        var ypos:CGFloat = 0
        /*
        homeBtn = BNButton(frame:CGRectMake(40, ypos, 100, 100), icon: HomeIcon(color: UIColor.whiteColor(), scale:1, position:CGPointMake(35, 25), stroke: 1, isFilled: false), text:"Home")
        homeBtn!.addTarget(self, action: "homeBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        homeBtn!.setButtonSelected(true)
        addSubview(homeBtn!)
        buttons.append(homeBtn!)
        
        ypos += 95
        searchBtn = BNButton(frame:CGRectMake(40, ypos, 100, 100), icon: SearchIcon(color: UIColor.whiteColor(), scale:1, position:CGPointMake(35, 25), stroke: 1, isFilled: false), text:"Search")
        searchBtn!.addTarget(self, action: "searchBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(searchBtn!)
        buttons.append(searchBtn!)
        
        ypos += 95
        settingsBtn = BNButton(frame:CGRectMake(40, ypos, 100, 100), icon: SettingsIcon(color: UIColor.whiteColor(), scale:1, position:CGPointMake(35, 25), stroke: 1, isFilled: false), text:"Settings")
        settingsBtn!.addTarget(self, action: "settingsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(settingsBtn!)
        buttons.append(settingsBtn!)
        
        ypos += 95
        collectionsBtn = BNButton(frame:CGRectMake(40, ypos, 100, 100), icon: CollectionsIcon(color: UIColor.whiteColor(), scale:1, position:CGPointMake(35, 25), stroke: 1, isFilled: false), text:"Collections")
        collectionsBtn!.addTarget(self, action: "collectionsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(collectionsBtn!)
        buttons.append(collectionsBtn!)
        
        ypos += 95
        profileBtn = BNButton(frame:CGRectMake(40, ypos, 100, 100), icon: ProfileIcon(color: UIColor.whiteColor(), scale:1, position:CGPointMake(35, 25), stroke: 1, isFilled: false), text:"Profile")
        profileBtn!.addTarget(self, action: "profileBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(profileBtn!)
        buttons.append(profileBtn!)
        
        ypos += 95
        boardsBtn = BNButton(frame:CGRectMake(40, ypos, 100, 100), icon: CollectionsIcon(color: UIColor.whiteColor(), scale:1, position:CGPointMake(35, 25), stroke: 1, isFilled: false), text:"Boards")
        boardsBtn!.addTarget(self, action: "boardsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(boardsBtn!)
        buttons.append(boardsBtn!)
        */
    }
    
    func homeBtnActon(sender:BNUIButton) {
        disableButton(0)
        delegate!.menuView!(self, showHome: true)
    }
    
    func searchBtnActon(sender:BNUIButton) {
        disableButton(1)
        delegate!.menuView!(self, showSearch: true)
    }
    
    func settingsBtnActon(sender:BNUIButton) {
        disableButton(2)
        delegate!.menuView!(self, showSettings: true)
    }
    
    func collectionsBtnActon(sender:BNUIButton) {
        disableButton(3)
        delegate!.menuView!(self, showCollections: true)
    }
    
    func profileBtnActon(sender:BNUIButton) {
        disableButton(4)
        delegate!.menuView!(self, showProfile: true)
    }
    
    func boardsBtnActon(sender:BNUIButton) {
        disableButton(5)
        delegate!.menuView!(self, showBoards: true)
    }
    
    func disableButton(index:Int) {
        /*
        for var i = 0; i < buttons.count; i++ {
            if i == index {
                buttons[i].setButtonSelected(true)
            } else {
                buttons[i].setButtonSelected(false)
            }
        }
        */
    }
}

@objc protocol MenuViewDelegate:NSObjectProtocol {
    optional func menuView(menuView:MenuView!, showHome value:Bool)
    optional func menuView(menuView:MenuView!, showSearch value:Bool)
    optional func menuView(menuView:MenuView!, showSettings value:Bool)
    optional func menuView(menuView:MenuView!, showCollections value:Bool)
    optional func menuView(menuView:MenuView!, showProfile value:Bool)
    optional func menuView(menuView:MenuView!, showBoards value:Bool)
}