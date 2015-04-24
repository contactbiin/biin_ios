//  MenuView.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class MenuView:UIView {
    
    var delegate:MenuViewDelegate?
    var isMenuHidden = true
    
    var profileBtn:BNUIButton_Menu?
    var homeBtn:BNUIButton_Menu?
    var collectionsBtn:BNUIButton_Menu?
    var loyaltyBtn:BNUIButton_Menu?
    var notificationsBtn:BNUIButton_Menu?
    var inviteFriendsBtn:BNUIButton_Menu?
    var settingsBtn:BNUIButton_Menu?
    var searchBtn:BNUIButton_Menu?
    
    var buttons = Array<BNUIButton_Menu>()

//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.appMainColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        var ypos:CGFloat = 40
        var distance:CGFloat = 65

        /*
        Profile = "Profile";
        Home = "Inicio";
        Collections = "Collecciones";
        Loyalty = "Lealtad";
        Notifications = "Notificaciones";
        InviteFriends = "Invitar Amigos";
        Settings = "Ajustes";
        Search = "Buscar";
        */
        
        profileBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Profile", comment: "profile button title"), iconType: BNIconType.profileMedium)
        profileBtn!.addTarget(self, action: "profileBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(profileBtn!)
        
        ypos += distance
        homeBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Home", comment: "home button title"), iconType: BNIconType.homeMedium)
        homeBtn!.addTarget(self, action: "homeBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(homeBtn!)
        homeBtn!.showSelected()

        ypos += distance
        collectionsBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Collections", comment: "collections button title"), iconType: BNIconType.collectionMedium)
        collectionsBtn!.addTarget(self, action: "collectionsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(collectionsBtn!)
        
        ypos += distance
        loyaltyBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Loyalty", comment: "loyalty button title"), iconType: BNIconType.loyaltyMedium)
        loyaltyBtn!.addTarget(self, action: "loyaltyBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(loyaltyBtn!)

        ypos += distance
        notificationsBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Notifications", comment: "notifications button title"), iconType: BNIconType.notificationMedium)
        notificationsBtn!.addTarget(self, action: "notificationsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(notificationsBtn!)
        
        ypos += distance
        inviteFriendsBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("InviteFriends", comment: "invite friends button title"), iconType: BNIconType.friendsMedium)
        inviteFriendsBtn!.addTarget(self, action: "inviteFriendsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(inviteFriendsBtn!)

        ypos += distance
        settingsBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Settings", comment: "settings button title"), iconType: BNIconType.settingsMedium)
        settingsBtn!.addTarget(self, action: "settingsBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(settingsBtn!)
        
        ypos += distance
        searchBtn = BNUIButton_Menu(frame: CGRectMake(40, ypos, 100, 60), text:NSLocalizedString("Search", comment: "search button title"), iconType: BNIconType.searchMedium)
        searchBtn!.addTarget(self, action: "searchBtnActon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(searchBtn!)
        
        buttons.append(profileBtn!)
        buttons.append(homeBtn!)
        buttons.append(collectionsBtn!)
        buttons.append(loyaltyBtn!)
        buttons.append(notificationsBtn!)
        buttons.append(inviteFriendsBtn!)
        buttons.append(settingsBtn!)
        buttons.append(searchBtn!)
        
        //TODO:Disable buttons for version 0.1.8
        //loyaltyBtn!.enabled = false
        //notificationsBtn!.enabled = false
//        inviteFriendsBtn!.enabled = false
        settingsBtn!.enabled = false
        searchBtn!.enabled = false
        
        //loyaltyBtn!.showDisable()
        //notificationsBtn!.showDisable()
        inviteFriendsBtn!.showEnable()
        settingsBtn!.showDisable()
        searchBtn!.showDisable()
    }
    
    func profileBtnActon(sender:BNUIButton) {
        disableButton(0)
        delegate!.menuView!(self, showProfile: true)
    }
    
    func homeBtnActon(sender:BNUIButton) {
        disableButton(1)
        delegate!.menuView!(self, showHome: true)
    }
    
    func collectionsBtnActon(sender:BNUIButton) {
        disableButton(2)
        delegate!.menuView!(self, showCollections: true)
    }
    
    func loyaltyBtnActon(sender:BNUIButton) {
        disableButton(3)
        delegate!.menuView!(self, showLoyalty: true)
    }
    
    func notificationsBtnActon(sender:BNUIButton) {
        disableButton(4)
        delegate!.menuView!(self, showNotifications: true)
    }
    
    func inviteFriendsBtnActon(sender:BNUIButton) {
        //disableButton(5)
        delegate!.menuView!(self, showInviteFriends: true)
    }

    func settingsBtnActon(sender:BNUIButton) {
        disableButton(6)
        delegate!.menuView!(self, showSettings: true)
    }
    
    func searchBtnActon(sender:BNUIButton) {
        disableButton(7)
        delegate!.menuView!(self, showSearch: true)
    }

    func disableButton(index:Int) {
        for var i = 0; i < buttons.count; i++ {
            if i == index {
                buttons[i].showSelected()
                buttons[i].enabled = false
            } else {

                buttons[i].showEnable()
                buttons[i].enabled = true

            }
        }
    }
}

@objc protocol MenuViewDelegate:NSObjectProtocol {
    optional func menuView(menuView:MenuView!, showHome value:Bool)
    optional func menuView(menuView:MenuView!, showProfile value:Bool)
    optional func menuView(menuView:MenuView!, showCollections value:Bool)
    optional func menuView(menuView:MenuView!, showLoyalty value:Bool)
    optional func menuView(menuView:MenuView!, showNotifications value:Bool)
    optional func menuView(menuView:MenuView!, showInviteFriends value:Bool)
    optional func menuView(menuView:MenuView!, showSettings value:Bool)
    optional func menuView(menuView:MenuView!, showSearch value:Bool)


}