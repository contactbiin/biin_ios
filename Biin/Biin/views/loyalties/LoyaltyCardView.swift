//  LoyaltyCardView.swift
//  Biin
//  Created by Esteban Padilla on 7/28/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoyaltyCardView: BNView {
    
    var delegate:LoyaltyCardView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
    
    var background:UIView?
    
    var image:BNUIImageView?
    var imageRequested = false
    var imageUrl:String = ""

    var receivedLbl:UILabel?
    var titleLbl:UILabel?
    var ruleLbl:UILabel?

    var backgroundFrame:UIView?
    
    var slots:Array<BNUIView_Star>?
    
    var goalLbl:UILabel?
    var seeGiftBtn:UIButton?
    var seeConditionsBtn:UIButton?
    
    var readQRCodeBtn:BNUIButton_ReadQRCode?
    
    var scroll:UIScrollView?
    
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
        
        background = UIView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - (SharedUIManager.instance.mainView_HeaderSize + SharedUIManager.instance.mainView_StatusBarHeight))))
        background!.backgroundColor = UIColor.whiteColor()
        self.addSubview(background!)
    
        ypos = 5
        image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.loyaltyWalletView_imageSize, SharedUIManager.instance.loyaltyWalletView_imageSize), color:UIColor.bnGrayLight())
        background!.addSubview(image!)
        image!.layer.cornerRadius = 3
        image!.layer.masksToBounds = true
        requestImage()
        xpos = (SharedUIManager.instance.loyaltyWalletView_imageSize + 10)

        receivedLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: frame.width, height: 8))
        receivedLbl!.text = NSDate().bnDisplayDateFormatt()
        receivedLbl!.textColor = UIColor.bnGray()
        receivedLbl!.font = UIFont(name: "Lato-Regular", size: 8)
        receivedLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(receivedLbl!)
        ypos += (receivedLbl!.frame.height + 5)
        
        width = (frame.width - (xpos + 5))
        
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_TitleSize))
        titleLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_TitleSize)
        titleLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(titleLbl!)
        ypos += (titleLbl!.frame.height + 2)
        
        ruleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
        ruleLbl!.textColor = UIColor.appTextColor()
        ruleLbl!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
        ruleLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(ruleLbl!)
        
        ypos = (SharedUIManager.instance.loyaltyWalletView_imageSize + 9)
        let line = UIView(frame: CGRect(x: 0, y: ypos, width: screenWidth, height: 1))
        line.backgroundColor = UIColor.bnGrayLight()
        background!.addSubview(line)
        
        ypos += 1
        scroll = UIScrollView(frame: CGRect(x: 0, y: ypos, width: screenWidth, height: (background!.frame.height - (SharedUIManager.instance.loyaltyWalletView_imageSize ))))
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.showsVerticalScrollIndicator = false
        background!.addSubview(scroll!)
        
        width = (screenWidth - 10)
        backgroundFrame = UIView(frame: CGRect(x: 5, y:5, width:width, height: (background!.frame.height - (SharedUIManager.instance.loyaltyWalletView_imageSize + 15))))
        backgroundFrame!.backgroundColor = UIColor.whiteColor()
        backgroundFrame!.layer.borderColor = UIColor.bnGrayLight().CGColor
        backgroundFrame!.layer.borderWidth = 1
        backgroundFrame!.layer.cornerRadius = 3
        scroll!.addSubview(backgroundFrame!)
        
        width = 150
        xpos = ((backgroundFrame!.frame.width - width) / 2)
        goalLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
        goalLbl!.textColor = UIColor.appTextColor()
        goalLbl!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
        goalLbl!.textAlignment = NSTextAlignment.Center
        goalLbl!.numberOfLines = 0
        backgroundFrame!.addSubview(goalLbl!)
        
        width = (screenWidth - 30)
        seeGiftBtn = UIButton(frame: CGRect(x: 15, y: ypos, width: width, height: 16))
        seeGiftBtn!.setTitle(NSLocalizedString("SeeGift", comment: "SeeGift"), forState: UIControlState.Normal)
        seeGiftBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 14)
        seeGiftBtn!.addTarget(self, action: #selector(self.seeGiftBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundFrame!.addSubview(seeGiftBtn!)

        
        seeConditionsBtn = UIButton(frame: CGRect(x: 15, y: ypos, width: width, height: 12))
        seeConditionsBtn!.setTitle(NSLocalizedString("SeeConditions", comment: "SeeConditions"), forState: UIControlState.Normal)
        seeConditionsBtn!.setTitleColor(UIColor.bnGray(), forState: UIControlState.Normal)
        seeConditionsBtn!.setTitleColor(UIColor.appTextColor(), forState: UIControlState.Selected)
        seeConditionsBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 10)
        seeConditionsBtn!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        seeConditionsBtn!.addTarget(self, action: #selector(self.seeConditionsBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundFrame!.addSubview(seeConditionsBtn!)
        
        width = 100
        xpos = ((screenWidth - width) / 2)
        readQRCodeBtn = BNUIButton_ReadQRCode(frame: CGRect(x: xpos, y: ypos, width: width, height: 70), iconColor: UIColor.blackColor())
        readQRCodeBtn!.setTitle(NSLocalizedString("ReadQRCode", comment: "ReadQRCode"), forState: UIControlState.Normal)
        readQRCodeBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 14)
        readQRCodeBtn!.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        readQRCodeBtn!.addTarget(self, action: #selector(self.openQRCodeReaderView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(readQRCodeBtn!)
        
        slots = Array<BNUIView_Star>()
        
        addFade()
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

        if state!.stateType != BNStateType.QRCodeState &&
            state!.stateType != BNStateType.AlertState &&
            state!.stateType != BNStateType.LoyaltyCardCompletedState &&
            state!.stateType != BNStateType.ElementState {
        
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.frame.origin.x = SharedUIManager.instance.screenWidth
            })
        }
    }
    
    func hideViewWhenShowingCompleted(){
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.hideView(_:)), userInfo: nil, repeats: false)
    }
    
    func hideView(sender:NSTimer){
        hideFade()
        self.frame.origin.x = SharedUIManager.instance.screenWidth
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
    func openQRCodeReaderView(sender:UIButton) {
        delegate!.openQRCodeReaderView!()
    }
    
    func seeConditionsBtnAction(sender:UIButton) {
        delegate!.seeConditions!((self.model as! BNLoyalty))
    }
    
    func seeGiftBtnAction(sender:UIButton) {
        delegate!.seeGift!((self.model as! BNLoyalty))
    }
    
    
    func backBtnAction(sender:UIButton) {
        delegate!.hideLoyaltyCardView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
    
    override func clean() {
        delegate = nil
        title?.removeFromSuperview()
        receivedLbl?.removeFromSuperview()
        titleLbl?.removeFromSuperview()
        ruleLbl?.removeFromSuperview()
        goalLbl?.removeFromSuperview()
        backBtn?.removeFromSuperview()
        fade?.removeFromSuperview()
        
        for slot in slots! {
            slot.removeFromSuperview()
        }
        
        slots!.removeAll()
        slots = nil
        scroll!.removeFromSuperview()
    }
    
    func show() { }
    
    func requestImage(){
        
        if imageRequested { return }
        
        imageRequested = true
        
        if imageUrl != "" {
            BNAppSharedManager.instance.networkManager.requestImageData(imageUrl, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    func updateLoyaltyCard(loyalty:BNLoyalty?) {
        
        if model != nil {
            if model!.identifier! != loyalty?.identifier! {
                updateCard(loyalty)
            } else {
            }
        } else {
            updateCard(loyalty)
        }
    }
    
    func updateCard(loyalty:BNLoyalty?){
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
        
        
        if organization!.media.count > 0 {
            self.imageRequested = false
            self.imageUrl = organization!.media[0].url!
            requestImage()
        }
        
        title!.text = organization!.brand!.uppercaseString
        
        receivedLbl!.text = loyalty!.loyaltyCard!.startDate!.bnDisplayDateFormatt_by_Day().uppercaseString
        titleLbl!.text = loyalty!.loyaltyCard!.title!
        titleLbl!.textColor = decorationColor
        ruleLbl!.text = loyalty!.loyaltyCard!.rule!
        ruleLbl!.numberOfLines = 0
        ruleLbl!.sizeToFit()
        
        for slot in self.slots! {
            slot.removeFromSuperview()
        }
        
        self.slots!.removeAll()
        
        let screenWidth:CGFloat = SharedUIManager.instance.screenWidth
        
        let slotWidth:CGFloat = SharedUIManager.instance.loyaltyCardView_SlotWidth
        let slotSpace:CGFloat = 10
        var counter:Int = 0
        let xposSpace:CGFloat = (((screenWidth - ((slotWidth * 4) + (slotSpace * 3))) / 2) - 5)
        var xpos:CGFloat = xposSpace
        var ypos:CGFloat = xposSpace
        
        for slot in loyalty!.loyaltyCard!.slots {
            
            if counter == 4 || counter == 8 || counter == 12 {
                if loyalty!.loyaltyCard!.slots.count == 10 && counter == 8 {
                    ypos += (slotWidth + slotSpace)
                    xpos = (xposSpace + slotWidth + slotSpace)
                } else if loyalty!.loyaltyCard!.slots.count == 14 && counter == 12 {
                    ypos += (slotWidth + slotSpace)
                    xpos = (xposSpace + slotWidth + slotSpace)
                } else {
                    ypos += (slotWidth + slotSpace)
                    xpos = xposSpace
                }
            }
            
            let slotView = BNUIView_Star(frame: CGRect(x: xpos, y: ypos, width: slotWidth, height: slotWidth) , color: decorationColor, isFilled:slot.isFilled!)
            self.slots!.append(slotView)
            self.backgroundFrame!.addSubview(slotView)
            xpos += (slotWidth + slotSpace)
            counter += 1
        }
        
        ypos += 80
        goalLbl!.frame.origin.y = ypos
        goalLbl!.text = loyalty!.loyaltyCard!.goal!
        goalLbl!.sizeToFit()
        
        ypos += (goalLbl!.frame.height + 5)
        seeGiftBtn!.frame.origin.y = ypos
        seeGiftBtn!.setTitleColor(decorationColor, forState: UIControlState.Normal)
        
        ypos += (seeGiftBtn!.frame.height + 10)
        seeConditionsBtn!.frame.origin.y = ypos
        seeConditionsBtn!.titleLabel!.textAlignment = NSTextAlignment.Right

        ypos += ( seeConditionsBtn!.frame.height + 5)
        backgroundFrame!.frame = CGRect(x: backgroundFrame!.frame.origin.x, y: backgroundFrame!.frame.origin.y, width: backgroundFrame!.frame.width, height: ypos)

        ypos += SharedUIManager.instance.loyaltyCardView_LastSpace
        readQRCodeBtn!.frame.origin.y = ypos
        readQRCodeBtn!.setNeedsDisplay()
        
        if organization != nil {
            if true {///organization!.isUserInSite {
                readQRCodeBtn!.enabled = true
                readQRCodeBtn!.icon!.color = decorationColor
                readQRCodeBtn!.setTitleColor(decorationColor, forState: UIControlState.Normal)
            } else {
                readQRCodeBtn!.enabled = false
                readQRCodeBtn!.setTitleColor(UIColor.bnGrayLight(), forState: UIControlState.Normal)
                readQRCodeBtn!.icon!.color = UIColor.bnGrayLight()
            }
        }
        
        backgroundFrame!.bringSubviewToFront(readQRCodeBtn!)
        
        ypos += (readQRCodeBtn!.frame.height + 25)
        scroll!.contentSize = CGSizeMake(screenWidth, ypos)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.pagingEnabled = false
    }
    
    func addStar() {
        (model as! BNLoyalty).addStar()
        NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: #selector(self.addStar(_:)), userInfo: nil, repeats: false)
    }
    
    @objc private func addStar(sender:NSTimer) {
        
        updateCard((self.model as! BNLoyalty))
        
        if (model as! BNLoyalty).loyaltyCard!.isFull {
            BNAppSharedManager.instance.networkManager.sendLoyaltyCardCompleted(BNAppSharedManager.instance.dataManager.biinie, loyalty: (model as! BNLoyalty))
            NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: #selector(self.addCompletedView(_:)), userInfo: nil, repeats: false)
        } else {
            BNAppSharedManager.instance.networkManager.sendLoyaltyCardAddStar(BNAppSharedManager.instance.dataManager.biinie, loyalty: (model as! BNLoyalty))
        }
    }
    
    @objc private func addCompletedView(sender:NSTimer) {
        delegate!.showCompleted!((model as! BNLoyalty))
    }
}

@objc protocol LoyaltyCardView_Delegate:NSObjectProtocol {
    optional func hideLoyaltyCardView(view:LoyaltyCardView)
    optional func openQRCodeReaderView()
    optional func seeConditions(loyalty:BNLoyalty)
    optional func seeGift(loyalty:BNLoyalty)
    optional func showCompleted(loyalty:BNLoyalty)
}
