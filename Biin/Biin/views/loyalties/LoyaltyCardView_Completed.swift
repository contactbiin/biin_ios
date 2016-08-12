//  LoyaltyCardView_Completed.swift
//  Biin
//  Created by Esteban Padilla on 7/28/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoyaltyCardView_Completed: BNView {
    
    var delegate:LoyaltyCardView_Completed_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    
    var backgroundView:UIView?
    var titleLbl:UILabel?
    var text1Lbl:UILabel?
    var text2Lbl:UILabel?
    
    var giftView:BNUIView_Gift?
    
    var okBtn:UIButton?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        var xpos:CGFloat = 5
        var ypos:CGFloat = 27
        var width:CGFloat = 1
        
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.mainView_TitleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.mainView_TitleSize)
        title!.text = "TUKASA"
        title!.textColor = UIColor.whiteColor()
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        ypos = SharedUIManager.instance.mainView_HeaderSize
        backgroundView = UIView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (SharedUIManager.instance.mainView_HeaderSize + SharedUIManager.instance.mainView_StatusBarHeight))))
        backgroundView!.backgroundColor = UIColor.appBackground()
        self.addSubview(backgroundView!)
        
        width = (screenWidth - 10)
        okBtn = UIButton(frame: CGRect(x: 5, y: (screenHeight - ( 65 + SharedUIManager.instance.mainView_HeaderSize + SharedUIManager.instance.mainView_StatusBarHeight)), width: width, height: 60))
        okBtn!.setTitle(NSLocalizedString("OK", comment: "OK"), forState: UIControlState.Normal)
        okBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        okBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 21)
        okBtn!.backgroundColor = UIColor.appBackground()
        okBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundView!.addSubview(okBtn!)
        
        width = (frame.width - 20)
        ypos += 30
        xpos = 10
        
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:(SharedUIManager.instance.loyaltyCardView_Completed_TitleSize + 2)))
        titleLbl!.textColor = UIColor.whiteColor()
        titleLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyCardView_Completed_TitleSize)
        titleLbl!.textAlignment = NSTextAlignment.Center
        titleLbl!.text = NSLocalizedString("Congratulations", comment: "Congratulations")
        backgroundView!.addSubview(titleLbl!)
        ypos += (titleLbl!.frame.height + 5)
        

        width = (frame.width - 150)
        text1Lbl = UILabel(frame: CGRect(x: 0, y: ypos, width: width, height:SharedUIManager.instance.loyaltyCardView_Completed_Text1Size))
        text1Lbl!.textColor = UIColor.whiteColor()
        text1Lbl!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.loyaltyCardView_Completed_Text1Size)
        text1Lbl!.textAlignment = NSTextAlignment.Center
        text1Lbl!.numberOfLines = 0
        text1Lbl!.text = NSLocalizedString("CompletedCard", comment: "CompletedCard")
        text1Lbl!.sizeToFit()
        backgroundView!.addSubview(text1Lbl!)
        text1Lbl!.frame.origin.x = ((screenWidth - text1Lbl!.frame.width) / 2 )
        
        
        ypos += (text1Lbl!.frame.height + 40)
        xpos = ((screenWidth - 100) / 2)
        giftView = BNUIView_Gift(frame: CGRect(x: xpos, y: ypos, width: 100, height: 125), color: UIColor.whiteColor())
        backgroundView!.addSubview(giftView!)
        
        
        ypos += (giftView!.frame.height + 10)
        text2Lbl = UILabel(frame: CGRect(x: 0, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
        text2Lbl!.textColor = UIColor.whiteColor()
        text2Lbl!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
        text2Lbl!.textAlignment = NSTextAlignment.Center
        text2Lbl!.numberOfLines = 0
        text2Lbl!.text = NSLocalizedString("GiftInTreasureChest", comment: "GiftInTreasureChest")
        text2Lbl!.sizeToFit()
        backgroundView!.addSubview(text2Lbl!)
        text2Lbl!.frame.origin.x = ((screenWidth - text2Lbl!.frame.width) / 2 )
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
        
        state!.action()

//        if state!.stateType != BNStateType.QRCodeState &&
//            state!.stateType != BNStateType.AlertState {
        
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            })
//        }
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
    
    //Instance Methods
    func okBtnAction(sender:UIButton) {
        delegate!.hideLoyaltyCardView_Completed!(self)
    }
    
    func backBtnAction(sender:UIButton) {
        delegate!.hideLoyaltyCardView_Completed!(self)
    }
    
    override func clean() {
        delegate = nil
        title?.removeFromSuperview()
        text1Lbl!.removeFromSuperview()
        text2Lbl!.removeFromSuperview()
        okBtn!.removeFromSuperview()
        
        titleLbl?.removeFromSuperview()
        backBtn?.removeFromSuperview()
    }
    
    func show() {
        
    }
    
    func updateLoyaltyCard(loyalty:BNLoyalty?) {
        
        if model != nil {
            if model!.identifier! != loyalty?.identifier! {
                updateLoyaltyCardView_Completed(loyalty)
            } else {
            }
        } else {
            updateLoyaltyCardView_Completed(loyalty)
        }
    }
    
    private func updateLoyaltyCardView_Completed(loyalty:BNLoyalty?){
        self.model = loyalty
        
        weak var organization = BNAppSharedManager.instance.dataManager.organizations[loyalty!.organizationIdentifier!]
        
        var decorationColor:UIColor?
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ =  organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        
        if white >= 0.9 {
            decorationColor = organization!.secondaryColor
        } else {
            decorationColor = organization!.primaryColor
        }
    
        self.backgroundView!.backgroundColor = decorationColor
        title!.text = organization!.brand!.uppercaseString
    }
}

@objc protocol LoyaltyCardView_Completed_Delegate:NSObjectProtocol {
    optional func hideLoyaltyCardView_Completed(view:LoyaltyCardView_Completed)
}
