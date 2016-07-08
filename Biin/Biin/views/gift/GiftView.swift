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
    var actionBtn:UIButton?
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
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        self.model = gift
        
        removeItButton = BNUIButton_Close(frame: CGRectMake((frame.width - 27), 5, 22, 22), iconColor: UIColor.bnGrayLight())
        removeItButton!.icon!.color = UIColor.bnGrayLight()
        removeItButton!.addTarget(self, action: #selector(self.removeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(removeItButton!)
        
        if (model as! BNGift).media!.count > 0 {
            image = BNUIImageView(frame: CGRectMake(xpos, ypos, SharedUIManager.instance.giftView_imageSize, SharedUIManager.instance.giftView_imageSize), color:UIColor.bnGrayLight())
            self.addSubview(image!)
            requestImage()
        }
        
        ypos = 5
        xpos = (SharedUIManager.instance.giftView_imageSize + 10)
        width = (frame.width - (xpos + 27))
        titleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height: height))
        titleLbl!.text = (model as! BNGift).name!
        titleLbl!.textColor = UIColor.bnRed()
        titleLbl!.font = UIFont(name: "Lato-Black", size: 24)
        titleLbl!.textAlignment = NSTextAlignment.Left
        titleLbl!.numberOfLines = 0
        titleLbl!.sizeToFit()
        self.addSubview(titleLbl!)
        
        viewHeight += 10
        viewHeight += titleLbl!.frame.height
        
        
        ypos = viewHeight
        width = (frame.width - (xpos + 5))
        messageLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width:width, height: height))
        messageLbl!.text = (model as! BNGift).message!
        messageLbl!.textColor = UIColor.bnGrayDark()
        messageLbl!.font = UIFont(name: "Lato-Light", size: 14)
        messageLbl!.textAlignment = NSTextAlignment.Left
        messageLbl!.numberOfLines = 0
        messageLbl!.sizeToFit()
        self.addSubview(messageLbl!)
        
        viewHeight += 5
        viewHeight += messageLbl!.frame.height
        
        ypos = viewHeight
        receivedLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width: width, height: height))
        receivedLbl!.text = (model as! BNGift).receivedDate!.bnDisplayDateFormatt_by_Day().uppercaseString
        receivedLbl!.textColor = UIColor.bnGrayDark()
        receivedLbl!.font = UIFont(name: "Lato-Regular", size: 10)
        receivedLbl!.textAlignment = NSTextAlignment.Left
        receivedLbl!.numberOfLines = 0
        receivedLbl!.sizeToFit()
        self.addSubview(receivedLbl!)
        
        let text_Length = SharedUIManager.instance.getStringLength(NSLocalizedString("GiftShowSites", comment: "GiftShowSites"), fontName: "Lato-Light", fontSize:10)
        xpos = (frame.width - (text_Length + 5))
        sitesBtn = UIButton(frame: CGRect(x: xpos, y: ypos, width:text_Length, height: 10))
        sitesBtn!.setTitleColor(UIColor.bnGrayDark(), forState: UIControlState.Normal)
        sitesBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 10)
        sitesBtn!.setTitle(NSLocalizedString("GiftShowSites", comment: "GiftShowSites"), forState: UIControlState.Normal)
        self.addSubview(sitesBtn!)
        
        viewHeight += receivedLbl!.frame.height
        viewHeight += 5
        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            ypos = viewHeight
        } else {
            ypos = (SharedUIManager.instance.giftView_imageSize + 10)
        }

        sitesBtn!.frame.origin.y = (ypos - (sitesBtn!.frame.height + 3))
        receivedLbl!.frame.origin.y = (ypos - (receivedLbl!.frame.height + 3))

        let line = UIView(frame: CGRect(x: 5, y: ypos, width: (frame.width - 10), height: 1))
        line.backgroundColor = UIColor.bnGrayLight()
        self.addSubview(line)
        
        if viewHeight >= (SharedUIManager.instance.giftView_imageSize + 10) {
            viewHeight += SharedUIManager.instance.giftView_bottomHeight
            self.frame = CGRect(x: 0, y: 0, width: frame.width, height: viewHeight)
        }
        
        if (model as! BNGift).hasExpirationDate {
            width = (frame.width * 0.35)
            xpos = 0
            ypos += 15
            expiredTitleLbl = UILabel(frame: CGRect(x: xpos, y: ypos, width:width, height:14))
            expiredTitleLbl!.text = "EXPIRES"
            expiredTitleLbl!.textColor = UIColor.bnGrayDark()
            expiredTitleLbl!.font = UIFont(name: "Lato-Light", size: 10)
            expiredTitleLbl!.textAlignment = NSTextAlignment.Center
            self.addSubview(expiredTitleLbl!)
            
            expiredDateLbl = UILabel(frame: CGRect(x: xpos, y: (ypos + 15), width:width, height:14))
            expiredDateLbl!.text = (model as! BNGift).expirationDate!.bnDisplayDateFormatt()
            expiredDateLbl!.textColor = UIColor.bnGrayDark()
            expiredDateLbl!.font = UIFont(name: "Lato-Black", size: 14)
            expiredDateLbl!.textAlignment = NSTextAlignment.Center
            self.addSubview(expiredDateLbl!)
            
            ypos = line.frame.origin.y
            xpos = width
            width = (frame.width * 0.45)
        } else {
            xpos = 0
            width = (frame.width * 0.8)
        }
        
        actionBtn = UIButton(frame: CGRect(x: xpos, y: ypos, width: width, height: SharedUIManager.instance.giftView_bottomHeight))
        actionBtn!.titleLabel!.numberOfLines = 0
        actionBtn!.titleLabel!.textAlignment = NSTextAlignment.Center
        actionBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 16)
        actionBtn!.setTitleColor(UIColor.bnGrayDark(), forState: UIControlState.Normal)
        updateActionBtnStatus()
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
