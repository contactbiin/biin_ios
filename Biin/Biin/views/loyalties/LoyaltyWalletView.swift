//  LoyaltyWalletView.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoyaltyWalletView: BNView, LoyaltyView_Delegate {
    
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    
    var delegate:LoyaltyWalletView_Delegate?
    //var elementContainers:Array <MainView_Container_Elements>?
    var scroll:BNScroll?
    
    weak var lastViewOpen:LoyaltyView?
    weak var lastViewSelected:LoyaltyView?
    
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
        
        var ypos:CGFloat = 27
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.mainView_TitleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.mainView_TitleSize)
        let titleText = NSLocalizedString("LoyaltyWallet", comment: "LoyaltyWallet").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = UIColor.appTitleColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        ypos = SharedUIManager.instance.mainView_HeaderSize
        self.scroll = BNScroll(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (SharedUIManager.instance.mainView_HeaderSize + SharedUIManager.instance.mainView_StatusBarHeight))), father: self, direction: BNScroll_Direction.VERTICAL, space: 2, extraSpace: 0, color: UIColor.appBackground(), delegate: nil)
        self.addSubview(scroll!)
        
        //elementContainers = Array<MainView_Container_Elements>()
        updateLoyalties()
        
        addFade()
    }
    
    func updateLoyalties(){
        
        self.scroll!.clean()
        self.scroll!.leftSpace = 0
        
        for (_, organization) in BNAppSharedManager.instance.dataManager.organizations {
            if organization.isLoyaltyEnabled {
                let loyaltyView = LoyaltyView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.loyaltyWalletView_height) , father: self, loyalty:organization.loyalty)
                loyaltyView.delegate = self
                scroll!.addChild(loyaltyView)
            }
        }
        
//        if let biinie = BNAppSharedManager.instance.dataManager.biinie {
//            for (_, value) in biinie.loyalties {
//                let loyaltyView = LoyaltyView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.loyaltyWalletView_height) , father: self, loyalty:value)
//                loyaltyView.delegate = self
//                scroll!.addChild(loyaltyView)
//            }
//        }
        
        self.scroll!.setChildrenPosition()
    }
    
    override func transitionIn() {
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        if state!.stateType == BNStateType.MainViewContainerState {

            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            })
        }
    }
    
    override func setNextState(goto:BNGoto){
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
    
    override func refresh() { }
    
    override func clean(){
        
        scroll!.removeFromSuperview()
        fade!.removeFromSuperview()
    }
    
    func backBtnAction(sender:UIButton) {
        
        delegate!.hideLoyaltyWalletView!()
        
        if lastViewOpen != nil {
            lastViewOpen!.hideRemoveBtn(UISwipeGestureRecognizer())
        }
    }
    
    func resizeScrollOnRemoved(view: LoyaltyView) {
        self.scroll!.removeChildByIdentifier(view.model!.identifier!)
    }
    
    func hideOtherViewsOpen(view: LoyaltyView) {
        
        if lastViewOpen != nil {
            lastViewOpen!.hideRemoveBtn(UISwipeGestureRecognizer())
        }
        
        lastViewOpen = view
    }
    
    func removeFromOtherViewsOpen(view: LoyaltyView) {
        lastViewOpen = nil
    }
    
    func showLoyaltyCard(view: LoyaltyView) {
        lastViewSelected = view
        delegate!.showLoyaltyCard!(view)
    }
    
    func showAlertView_ForLoyaltyCard(view: LoyaltyView, loyalty:BNLoyalty?) {
        lastViewSelected = view
        self.delegate!.showAlertView_ForLoyaltyCard!(view, loyalty:loyalty)
    }
    
    func activateLastLoyaltyCardSeleced(){
        if lastViewSelected != nil {
            lastViewSelected!.addStars()
        }
    }
    
    func updateLoyaltyStars(){
        lastViewSelected!.addStars()
    }
}


@objc protocol LoyaltyWalletView_Delegate:NSObjectProtocol {
    optional func hideLoyaltyWalletView()
    optional func showLoyaltyCard(view:LoyaltyView)
    optional func showAlertView_ForLoyaltyCard(view:LoyaltyView, loyalty:BNLoyalty?)
}