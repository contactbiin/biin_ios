//  GiftView.swift
//  Biin
//  Created by Esteban Padilla on 7/2/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class GiftView: BNView {
    
    var delegate:GiftView_Delegate?
//    var gift:BNGift?
    var image:BNUIImageView?
    var imageRequested = false

    var deleteItButton:BNUIButton_Delete?
    var titleLbl:UILabel?
    var messageLbl:UILabel?
    var receivedLbl:UILabel?
    
    var giftStoresBtn:BNUIButton_GiftStores?
    var actionBtn:BNUIButton_Gift?
    var shareGiftBtn:BNUIButton_ShareGift?
    
    var expiredTitleLbl:UILabel?
    var expiredDateLbl:UILabel?
    
    var background:UIView?
    var showSwipe:UISwipeGestureRecognizer?
    var hideSwipe:UISwipeGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, gift:BNGift?){
        
        self.init(frame: frame, father:father )
        
        
        var xpos:CGFloat = 5
        var ypos:CGFloat = 0
        var width:CGFloat = 1
        let height:CGFloat = 1
        var viewHeight:CGFloat = 0
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.masksToBounds = true
        
        self.model = gift
        var decorationColor:UIColor?
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ = gift!.primaryColor!.getWhite(&white, alpha: &alpha)
        
        if white >= 0.95 {
            print("Is white - \(gift!.name!)")
            decorationColor = gift!.secondaryColor
        } else {
            decorationColor = gift!.primaryColor
        }
        
        deleteItButton = BNUIButton_Delete(frame: CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: ypos, width: SharedUIManager.instance.notificationView_height, height: (frame.height / 3)), iconColor: UIColor.whiteColor())
        deleteItButton!.backgroundColor = UIColor.redColor()
        deleteItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(deleteItButton!)
        
        ypos += deleteItButton!.frame.height
        
        shareGiftBtn = BNUIButton_ShareGift(frame:CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: ypos, width: SharedUIManager.instance.notificationView_height, height: (frame.height / 3)), iconColor: UIColor.whiteColor())
        shareGiftBtn!.backgroundColor = UIColor.bnShareGiftColor()
        shareGiftBtn!.addTarget(self, action: #selector(self.shareGiftBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(shareGiftBtn!)

        ypos += shareGiftBtn!.frame.height
        giftStoresBtn = BNUIButton_GiftStores(frame:CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: ypos, width: SharedUIManager.instance.notificationView_height, height: (frame.height / 3)), iconColor: UIColor.whiteColor())
        giftStoresBtn!.backgroundColor = UIColor.bnGiftStoresColor()
        self.addSubview(giftStoresBtn!)
        
        ypos = 5
        
        background = UIView(frame: frame)
        background!.backgroundColor = UIColor.whiteColor()
        self.addSubview(background!)
        
        if (model as! BNGift).media!.count > 0 {
            image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.giftView_imageSize, SharedUIManager.instance.giftView_imageSize), color:UIColor.bnGrayLight())
            background!.addSubview(image!)
            image!.layer.cornerRadius = 3
            image!.layer.masksToBounds = true
            requestImage()
        }
        
        xpos = (SharedUIManager.instance.giftView_imageSize + 10)
        ypos = 5
        receivedLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: frame.width, height: height))
        receivedLbl!.text = (model as! BNGift).receivedDate!.bnDisplayDateFormatt_by_Day().uppercaseString
        receivedLbl!.textColor = UIColor.bnGray()
        receivedLbl!.font = UIFont(name: "Lato-Regular", size: 10)
        receivedLbl!.textAlignment = NSTextAlignment.Left
        receivedLbl!.numberOfLines = 0
        receivedLbl!.sizeToFit()
        background!.addSubview(receivedLbl!)
        ypos += (receivedLbl!.frame.height)
        viewHeight += receivedLbl!.frame.height
        
        width = (frame.width - (xpos + 27))
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height: height))
        titleLbl!.text = (model as! BNGift).name!
        titleLbl!.textColor = decorationColor
        titleLbl!.font = UIFont(name: "Lato-Black", size: 25)
        titleLbl!.textAlignment = NSTextAlignment.Left
        titleLbl!.numberOfLines = 0
        titleLbl!.sizeToFit()
        background!.addSubview(titleLbl!)
        
        viewHeight += 5
        viewHeight += titleLbl!.frame.height
        
        ypos = viewHeight
        width = (frame.width - (xpos + 5))
        messageLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width:width, height: height))
        messageLbl!.text = (model as! BNGift).message!
        messageLbl!.textColor = UIColor.bnGrayDark()
        messageLbl!.font = UIFont(name: "Lato-Regular", size: 15)
        messageLbl!.textAlignment = NSTextAlignment.Left
        messageLbl!.numberOfLines = 0
        messageLbl!.sizeToFit()
        background!.addSubview(messageLbl!)
        
        viewHeight += 5
        viewHeight += messageLbl!.frame.height
        
        ypos = viewHeight
        viewHeight += 5
        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            ypos = viewHeight
        } else {
            ypos = (SharedUIManager.instance.giftView_imageSize + 10)
        }

        var buttonHeight:CGFloat = 0
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            viewHeight += SharedUIManager.instance.giftView_bottomHeight
            
            self.frame = CGRect(x: 0, y: 0, width: frame.width, height: viewHeight)
            buttonHeight = self.frame.height / 3
            deleteItButton!.frame = CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: 0, width: SharedUIManager.instance.notificationView_height, height: buttonHeight)
            shareGiftBtn!.frame = CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: (deleteItButton!.frame.height), width: SharedUIManager.instance.notificationView_height, height: buttonHeight)
            giftStoresBtn!.frame = CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: (deleteItButton!.frame.height + shareGiftBtn!.frame.height), width: SharedUIManager.instance.notificationView_height, height: buttonHeight)
        }
        
        buttonHeight = self.frame.height / 3
        deleteItButton!.icon!.position = CGPoint(x: ((SharedUIManager.instance.notificationView_height / 2) - 7), y: ((buttonHeight / 2) - 7))

        shareGiftBtn!.icon!.position = CGPoint(x: ((SharedUIManager.instance.notificationView_height / 2) - 12), y: ((buttonHeight / 2) - 12))
        
        giftStoresBtn!.icon!.position = CGPoint(x: ((SharedUIManager.instance.notificationView_height / 2) - 12), y: ((buttonHeight / 2) - 12))
        
        xpos = 5
        width = (frame.width - (xpos + 5))
        actionBtn = BNUIButton_Gift(frame: CGRect(x: xpos, y: ypos, width: width, height: SharedUIManager.instance.giftView_bottomHeight), gift:(model as! BNGift), color: decorationColor)
        actionBtn!.addTarget(self, action: #selector(self.actionBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        background!.addSubview(actionBtn!)
        updateActionBtnStatus()
        
        showSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.showRemoveBtn(_:)))
        showSwipe!.direction = UISwipeGestureRecognizerDirection.Left
        background!.addGestureRecognizer(showSwipe!)
        
        hideSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.hideRemoveBtn(_:)))
        hideSwipe!.direction = UISwipeGestureRecognizerDirection.Right
        hideSwipe!.enabled = false
        background!.addGestureRecognizer(hideSwipe!)
        
    }
    
    
    func showRemoveBtn(sender:UISwipeGestureRecognizer) {
        
        delegate!.hideOtherViewsOpen!(self)
        sender.enabled = false
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.background?.frame.origin.x -= SharedUIManager.instance.notificationView_height
            }, completion: {(completed:Bool) -> Void in
                self.hideSwipe!.enabled = true
        })
    }
    
    
    func hideRemoveBtn(sender:UISwipeGestureRecognizer) {
        
        delegate!.removeFromOtherViewsOpen!(self)
        sender.enabled = false
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.background?.frame.origin.x += SharedUIManager.instance.notificationView_height
            }, completion: {(completed:Bool) -> Void in
                self.showSwipe!.enabled = true
        })
    }
    
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
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
    
    func requestImage(){
        
        if imageRequested { return }
        
        imageRequested = true
        
        if (model as! BNGift).media!.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData((model as! BNGift).media![0].url!, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    override func refresh() {
        
    }
    
    override func clean(){
        
        delegate = nil
        model = nil
        image?.removeFromSuperview()
        image = nil
        deleteItButton?.removeFromSuperview()
        deleteItButton = nil
        titleLbl!.removeFromSuperview()
        titleLbl = nil
        messageLbl!.removeFromSuperview()
        messageLbl = nil
        receivedLbl!.removeFromSuperview()
        receivedLbl = nil
        actionBtn!.removeFromSuperview()
        actionBtn = nil
        shareGiftBtn!.removeFromSuperview()
        shareGiftBtn = nil
        expiredTitleLbl!.removeFromSuperview()
        expiredTitleLbl = nil
        expiredDateLbl!.removeFromSuperview()
        expiredDateLbl = nil
    }

    func removeBtnAction(sender:UIButton){
        BNAppSharedManager.instance.networkManager.sendRefusedGift((self.model as! BNGift))
        BNAppSharedManager.instance.updateGiftCounter()
        self.delegate!.resizeScrollOnRemoved!(self)
    }
    
    func shareGiftBtnAction(sender:UIButton) {
        delegate!.showFriendsView_ToShareGift!((self.model as! BNGift))
    }
    
    func updateActionBtnStatus(){
        switch (model as! BNGift).status! {
        case .CLAIMED:
            actionBtn!.enabled = false
            actionBtn!.titleLbl!.text = NSLocalizedString("CLAIMED", comment: "CLAIMED")
        case .SENT:
            actionBtn!.enabled = false
            actionBtn!.titleLbl!.text = NSLocalizedString("SENT", comment: "SENT")
        case .DELIVERED:
            actionBtn!.enabled = false
            actionBtn!.titleLbl!.text = NSLocalizedString("DELIVERED", comment: "DELIVERED")
        default:
            actionBtn!.enabled = false
            actionBtn!.titleLbl!.text = NSLocalizedString("SENT", comment: "SENT")
        }
    }
    
    func updateToClaimNow(){
        actionBtn!.titleLbl!.text = NSLocalizedString("READY_TO_CLAIM", comment: "READY_TO_CLAIM")
        actionBtn!.enabled = true
    }
    
    func actionBtnAction(sender:UIButton) {
        BNAppSharedManager.instance.networkManager!.sendClaimedGift((model as! BNGift))
        (model as! BNGift).status = BNGiftStatus.CLAIMED
        updateActionBtnStatus()
    }
}

@objc protocol GiftView_Delegate:NSObjectProtocol {
//    optional func showElementView( view:ElementMiniView, element:BNElement )
//    optional func showElementViewFromSite( view:ElementMiniView, element:BNElement )
    optional func resizeScrollOnRemoved(view:GiftView)
    optional func hideOtherViewsOpen(view:GiftView)
    optional func removeFromOtherViewsOpen(view:GiftView)
    optional func showFriendsView_ToShareGift(gift:BNGift?)
}
