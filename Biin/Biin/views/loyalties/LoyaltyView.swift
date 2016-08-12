//  LoyaltyView.swift
//  biin
//  Created by Esteban Padilla on 7/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import UIKit

class LoyaltyView: BNView {
    
    var delegate:LoyaltyView_Delegate?
    //    var gift:BNGift?
    var image:BNUIImageView?
    var imageRequested = false
    var imageUrl:String = ""
    
    var deleteItButton:BNUIButton_Delete?
    var receivedLbl:UILabel?
    var titleLbl:UILabel?
    var subTitleLbl:UILabel?
    var textLbl:UILabel?
    var stars:Array<BNUIView_StarSmall>?
    var statusLbl:UILabel?
    
    var foreground:UIView?
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
    
    convenience init(frame:CGRect, father:BNView?, loyalty:BNLoyalty?){
        
        self.init(frame: frame, father:father )
        
        self.model = loyalty
        var xpos:CGFloat = 5
        var ypos:CGFloat = 0
        var width:CGFloat = 1
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.masksToBounds = true
        
        let organization = BNAppSharedManager.instance.dataManager.organizations[(model as! BNLoyalty).organizationIdentifier!]
        var decorationColor:UIColor?
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ =  organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        
        if white >= 0.9 {
            decorationColor = organization!.secondaryColor
        } else {
            decorationColor = organization!.primaryColor
        }
        
        deleteItButton = BNUIButton_Delete(frame: CGRect(x: (SharedUIManager.instance.screenWidth - SharedUIManager.instance.notificationView_height), y: ypos, width:100, height: frame.height), iconColor: UIColor.whiteColor())
        deleteItButton!.backgroundColor = UIColor.redColor()
        deleteItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        deleteItButton!.icon!.position = CGPoint(x: 40, y: 45)
        self.addSubview(deleteItButton!)
        
        ypos += deleteItButton!.frame.height
        
        ypos = 5
        
        background = UIView(frame: frame)
        background!.backgroundColor = UIColor.whiteColor()
        self.addSubview(background!)
        
        if organization!.media.count > 0 {
            self.imageUrl = organization!.media[0].url!
            image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.loyaltyWalletView_imageSize, SharedUIManager.instance.loyaltyWalletView_imageSize), color:UIColor.bnGrayLight())
            background!.addSubview(image!)
            image!.layer.cornerRadius = 3
            image!.layer.masksToBounds = true
            requestImage()
        }
        
        
        
        xpos = (SharedUIManager.instance.loyaltyWalletView_imageSize + 10)
        ypos = 5
        receivedLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: frame.width, height: 8))
        receivedLbl!.text = (model as! BNLoyalty).loyaltyCard!.startDate!.bnDisplayDateFormatt_by_Day().uppercaseString
        receivedLbl!.textColor = UIColor.bnGray()
        receivedLbl!.font = UIFont(name: "Lato-Regular", size: 8)
        receivedLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(receivedLbl!)
        ypos += (receivedLbl!.frame.height + 2)
        
        width = (frame.width - (xpos + 5))
        
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_TitleSize))
        titleLbl!.text = organization!.brand!
        titleLbl!.textColor = decorationColor
        titleLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_TitleSize)
        titleLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(titleLbl!)
        ypos += (titleLbl!.frame.height + 2)
        
        subTitleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
        subTitleLbl!.text = (model as! BNLoyalty).loyaltyCard!.title!
        subTitleLbl!.textColor = UIColor.appTextColor()
        subTitleLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
        subTitleLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(subTitleLbl!)
        ypos += (subTitleLbl!.frame.height + 2)
        
        textLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width:width, height: SharedUIManager.instance.loyaltyWalletView_TextSize))
        textLbl!.text = (model as! BNLoyalty).loyaltyCard!.rule!
        textLbl!.textColor = UIColor.bnGrayDark()
        textLbl!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.loyaltyWalletView_TextSize)
        textLbl!.textAlignment = NSTextAlignment.Left
        background!.addSubview(textLbl!)
        
        ypos += (textLbl!.frame.height + 20)
        
        if loyalty!.loyaltyCard!.isBiinieEnrolled {
            stars = Array<BNUIView_StarSmall>()
            var star_xpos:CGFloat = xpos
            for slot in loyalty!.loyaltyCard!.slots {
                
                if !slot.isFilled! {
                    decorationColor = UIColor.bnGrayLight()
                }
                
                let star = BNUIView_StarSmall(frame:CGRect(x:star_xpos, y: ypos, width:16, height: 16), color: decorationColor!)
                stars!.append(star)
                background!.addSubview(star)
                star_xpos += 17
            }
            
            star_xpos += 5
            
            if loyalty!.loyaltyCard!.isCompleted {
                statusLbl = UILabel(frame: CGRect(x: star_xpos, y:ypos, width: width, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
                statusLbl!.text = NSLocalizedString("Completed", comment: "Completed")
                statusLbl!.textColor = decorationColor
                statusLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
                statusLbl!.textAlignment = NSTextAlignment.Left
                background!.addSubview(statusLbl!)
            }
            
            
        } else {
            statusLbl = UILabel(frame: CGRect(x: xpos, y:(frame.height - 30), width: width, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
            statusLbl!.text = NSLocalizedString("EnrollNow", comment: "EnrollNow")
            statusLbl!.textColor = UIColor.appTextColor()
            statusLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
            statusLbl!.textAlignment = NSTextAlignment.Left
            background!.addSubview(statusLbl!)

        }
        
        foreground = UIView(frame: frame)
        foreground!.backgroundColor = UIColor.blackColor()
        foreground!.alpha = 0
        foreground!.resignFirstResponder()
        self.addSubview(foreground!)
        
        showSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.showRemoveBtn(_:)))
        showSwipe!.direction = UISwipeGestureRecognizerDirection.Left
        background!.addGestureRecognizer(showSwipe!)
        
        hideSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.hideRemoveBtn(_:)))
        hideSwipe!.direction = UISwipeGestureRecognizerDirection.Right
        hideSwipe!.enabled = false
        background!.addGestureRecognizer(hideSwipe!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        
        
    }
    
    func handleTap(sender:UITapGestureRecognizer) {
        self.foreground!.alpha = 0.1
        
        UIView.animateWithDuration(0.1, animations: {()-> Void in
                self.foreground!.alpha = 0
            }, completion: {(completed:Bool) ->  Void in
                
                if (self.model as! BNLoyalty).loyaltyCard!.isBiinieEnrolled {
                    self.delegate!.showLoyaltyCard!(self)
                } else {
                    self.delegate!.showAlertView_ForLoyaltyCard!(self, loyalty:(self.model as! BNLoyalty))
                }
        })
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
        
        if imageUrl != "" {
            BNAppSharedManager.instance.networkManager.requestImageData(imageUrl, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    override func refresh() {
        
    }
    
    func addStars(){

        if stars != nil {
            for star in stars! {
                star.removeFromSuperview()
            }
            
            stars!.removeAll()
        }
        
        if statusLbl != nil {
            statusLbl!.alpha = 0
        }
        
        let ypos:CGFloat = (textLbl!.frame.origin.y + textLbl!.frame.height + 20)
        var xpos:CGFloat = (SharedUIManager.instance.loyaltyWalletView_imageSize + 10)

        let organization = BNAppSharedManager.instance.dataManager.organizations[(model as! BNLoyalty).organizationIdentifier!]
        var decorationColor:UIColor?
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ =  organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        
        if white >= 0.9 {
            decorationColor = organization!.secondaryColor
        } else {
            decorationColor = organization!.primaryColor
        }

        stars = Array<BNUIView_StarSmall>()
        
        let loyaltyCard = (model as! BNLoyalty).loyaltyCard!
        
        for slot in loyaltyCard.slots {
            
            if !slot.isFilled! {
                decorationColor = UIColor.bnGrayLight()
            }
            
            let star = BNUIView_StarSmall(frame:CGRect(x:xpos, y: ypos, width:16, height: 16), color: decorationColor!)
            stars!.append(star)
            background!.addSubview(star)
            xpos += 17
        }
        
        xpos += 5

        
        if loyaltyCard.isFull {
            if statusLbl != nil {
                statusLbl!.alpha = 1
                statusLbl!.frame.origin.x = xpos
                statusLbl!.frame.origin.y = ypos
                statusLbl!.text = NSLocalizedString("Completed", comment: "Completed")
                statusLbl!.textColor = decorationColor
            } else {
            
                statusLbl = UILabel(frame: CGRect(x: xpos, y:ypos, width: 100, height:SharedUIManager.instance.loyaltyWalletView_SubTitleSize))
                statusLbl!.text = NSLocalizedString("Completed", comment: "Completed")
                statusLbl!.textColor = decorationColor
                statusLbl!.font = UIFont(name: "Lato-Black", size: SharedUIManager.instance.loyaltyWalletView_SubTitleSize)
                statusLbl!.textAlignment = NSTextAlignment.Left
                background!.addSubview(statusLbl!)
            }
        }
        
        self.bringSubviewToFront(foreground!)
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
        subTitleLbl!.removeFromSuperview()
        subTitleLbl = nil
        textLbl!.removeFromSuperview()
        textLbl = nil
        receivedLbl!.removeFromSuperview()
        receivedLbl = nil
        foreground!.removeFromSuperview()
        background!.removeFromSuperview()
        
        if statusLbl != nil {
            statusLbl!.removeFromSuperview()
        }
        
        if stars != nil {
            for star in stars! {
                star.removeFromSuperview()
            }
        }
    }
    
    func removeBtnAction(sender:UIButton){
//        BNAppSharedManager.instance.updateGiftCounter()
//        BNAppSharedManager.instance.networkManager.sendRefusedGift((self.model as! BNGift))
        self.delegate!.resizeScrollOnRemoved!(self)
    }
    
}

@objc protocol LoyaltyView_Delegate:NSObjectProtocol {
    optional func showLoyaltyCard(view:LoyaltyView)
    optional func showAlertView_ForLoyaltyCard(view:LoyaltyView, loyalty:BNLoyalty?)
    optional func resizeScrollOnRemoved(view:LoyaltyView)
    optional func hideOtherViewsOpen(view:LoyaltyView)
    optional func removeFromOtherViewsOpen(view:LoyaltyView)
}
