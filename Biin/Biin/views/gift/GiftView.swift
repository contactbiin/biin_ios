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

    var removeItButton:BNUIButton_Close?
    var titleLbl:UILabel?
    var messageLbl:UILabel?
    var receivedLbl:UILabel?
    
    var sitesBtn:UIButton?
    var actionBtn:BNUIButton_Gift?
    var shareBtn:UIButton?
    
    var expiredTitleLbl:UILabel?
    var expiredDateLbl:UILabel?
    
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
        var ypos:CGFloat = 5
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
            decorationColor = gift!.primaryColor
        } else {
            decorationColor = gift!.secondaryColor
        }
        
        removeItButton = BNUIButton_Close(frame: CGRectMake((frame.width - 27), 5, 22, 22), iconColor: UIColor.bnGrayLight())
        removeItButton!.icon!.color = UIColor.bnGrayLight()
        removeItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(removeItButton!)
        
        if (model as! BNGift).media!.count > 0 {
            image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.giftView_imageSize, SharedUIManager.instance.giftView_imageSize), color:UIColor.bnGrayLight())
            self.addSubview(image!)
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
        self.addSubview(receivedLbl!)
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
        self.addSubview(titleLbl!)
        
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
        self.addSubview(messageLbl!)
        
        viewHeight += 5
        viewHeight += messageLbl!.frame.height
        
        ypos = viewHeight
        viewHeight += 5
        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            ypos = viewHeight
        } else {
            ypos = (SharedUIManager.instance.giftView_imageSize + 10)
        }

        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            viewHeight += SharedUIManager.instance.giftView_bottomHeight
            self.frame = CGRect(x: 0, y: 0, width: frame.width, height: viewHeight)
        }
        
        xpos = 5
        sitesBtn = UIButton(frame: CGRect(x: xpos, y: ypos, width:SharedUIManager.instance.giftView_imageSize, height: 25))
        sitesBtn!.setTitleColor(decorationColor, forState: UIControlState.Normal)
        sitesBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 10)
        sitesBtn!.titleLabel!.numberOfLines = 0
        sitesBtn!.setTitle(NSLocalizedString("GiftShowSites", comment: "GiftShowSites"), forState: UIControlState.Normal)
        sitesBtn!.backgroundColor = UIColor.whiteColor()
        sitesBtn!.layer.cornerRadius = 3
        sitesBtn!.layer.borderColor = decorationColor!.CGColor
        sitesBtn!.layer.borderWidth = 0.5
        self.addSubview(sitesBtn!)
        
        shareBtn = UIButton(frame: CGRect(x: xpos, y: (ypos + 30), width:SharedUIManager.instance.giftView_imageSize, height: 25))
        shareBtn!.setTitleColor(decorationColor, forState: UIControlState.Normal)
        shareBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 10)
        shareBtn!.titleLabel!.numberOfLines = 0
        shareBtn!.setTitle("Enviar a amigo", forState: UIControlState.Normal)
        shareBtn!.backgroundColor = UIColor.whiteColor()
        shareBtn!.layer.cornerRadius = 3
        shareBtn!.layer.borderColor = decorationColor!.CGColor
        shareBtn!.layer.borderWidth = 0.5
        self.addSubview(shareBtn!)
        
        xpos += (SharedUIManager.instance.giftView_imageSize + 5)
        width = (frame.width - (xpos + 5))
        actionBtn = BNUIButton_Gift(frame: CGRect(x: xpos, y: ypos, width: width, height: SharedUIManager.instance.giftView_bottomHeight), hasExpiration:(model as! BNGift).hasExpirationDate, color: decorationColor)
        self.addSubview(actionBtn!)
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
        removeItButton?.removeFromSuperview()
        removeItButton = nil
        titleLbl!.removeFromSuperview()
        titleLbl = nil
        messageLbl!.removeFromSuperview()
        messageLbl = nil
        receivedLbl!.removeFromSuperview()
        receivedLbl = nil
        actionBtn!.removeFromSuperview()
        actionBtn = nil
        shareBtn!.removeFromSuperview()
        shareBtn = nil
        expiredTitleLbl!.removeFromSuperview()
        expiredTitleLbl = nil
        expiredDateLbl!.removeFromSuperview()
        expiredDateLbl = nil
    }

    func removeBtnAction(sender:UIButton){
        self.delegate!.resizeScrollOnRemoved!(self)
    }
    
    func updateActionBtnStatus(){
        switch (model as! BNGift).status! {
        case .APPROVED:
            actionBtn!.enabled = true
            actionBtn!.setTitle(NSLocalizedString("APPROVED", comment: "APPROVED"), forState: UIControlState.Normal)
        case .CLAIMED:
            actionBtn!.enabled = false
            actionBtn!.setTitle(NSLocalizedString("CLAIMED", comment: "CLAIMED"), forState: UIControlState.Normal)
        case .SENT:
            actionBtn!.enabled = false
            actionBtn!.setTitle(NSLocalizedString("SENT", comment: "SENT"), forState: UIControlState.Normal)
        case .DELIVERED:
            actionBtn!.enabled = false
            actionBtn!.setTitle(NSLocalizedString("DELIVERED", comment: "DELIVERED"), forState: UIControlState.Normal)
        default:
            actionBtn!.enabled = false
            actionBtn!.setTitle(NSLocalizedString("SENT", comment: "SENT"), forState: UIControlState.Normal)
        }
    }
    
    func updateToClaimNow(){
        actionBtn!.setTitle(NSLocalizedString("READY_TO_CLAIM", comment: "READY_TO_CLAIM"), forState: UIControlState.Normal)
        actionBtn!.enabled = true
    }
}

@objc protocol GiftView_Delegate:NSObjectProtocol {
//    optional func showElementView( view:ElementMiniView, element:BNElement )
//    optional func showElementViewFromSite( view:ElementMiniView, element:BNElement )
    optional func resizeScrollOnRemoved(view:GiftView)
}
