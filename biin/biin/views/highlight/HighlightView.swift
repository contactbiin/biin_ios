//  HighlightView.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class HighlightView: BNView {
    
    var siteAvatar:BNUIImageView?
    var delegate:HightlightView_Delegate?
    var element:BNElement?
    var site:BNSite?
    var image:BNUIImageView?
    
    var imageRequested = false
    var percentageView:ElementMiniView_Precentage?
    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    
    var likeItButton:BNUIButton_LikeIt?
    var shareItButton:BNUIButton_ShareIt?
    var collectItButton:BNUIButton_CollectionIt?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }

    convenience init(frame:CGRect, father:BNView?, element:BNElement){
        
        self.init(frame: frame, father:father )
        self.layer.masksToBounds = true
        self.element = element

        let textColor:UIColor = UIColor.whiteColor()
        var titleColor:UIColor?
        
        if self.element!.useWhiteText {
            titleColor = self.element!.media[0].vibrantLightColor!
        } else {
            titleColor = self.element!.media[0].vibrantLightColor!
        }
        
        
        var ypos:CGFloat = 0
        var imageSize:CGFloat = 0
        if frame.width < frame.height {
            imageSize = frame.height// - SharedUIManager.instance.miniView_headerHeight
            ypos = ((imageSize - frame.width) / 2) * -1
        } else {
            imageSize = frame.width
            ypos = ((imageSize - frame.height) / 2) * -1
        }
        
        //Positioning image
        image = BNUIImageView(frame: CGRectMake(0, ypos, imageSize, imageSize), color:self.element!.media[0].vibrantColor!)
        self.addSubview(image!)

        
        let whiteView = UIView(frame: CGRectMake(0, (frame.height - SharedUIManager.instance.highlightView_headerHeight), frame.width, SharedUIManager.instance.highlightView_headerHeight))
        whiteView.backgroundColor = self.element!.media[0].vibrantColor!.colorWithAlphaComponent(0)
        //self.addSubview(whiteView)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = CGRectMake(0, (frame.height - SharedUIManager.instance.highlightView_headerHeight), frame.width, SharedUIManager.instance.highlightView_headerHeight)
        self.addSubview(visualEffectView)
        
        let containerView = UIView(frame: CGRectMake(0, (frame.height - SharedUIManager.instance.highlightView_headerHeight), frame.width, SharedUIManager.instance.highlightView_headerHeight))
        containerView.backgroundColor = UIColor.clearColor()
        self.addSubview(containerView)
        

        
        let siteAvatarSize = (SharedUIManager.instance.highlightView_headerHeight - 8)
        siteAvatar = BNUIImageView(frame: CGRectMake(4, 4, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        containerView.addSubview(siteAvatar!)
        
        site = BNAppSharedManager.instance.dataManager.sites[self.element!.siteIdentifier!]
        
        if site!.organization!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(self.site!.organization!.media[0].url!, image: siteAvatar)
            siteAvatar!.cover!.backgroundColor = self.site!.organization!.media[0].vibrantColor!
        } else {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        ypos = 6
        let xpos:CGFloat = siteAvatarSize + 10
        
        let title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 20), (SharedUIManager.instance.highlightView_titleSize + 3)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.highlightView_titleSize)
        title.textColor = titleColor
        title.text = self.element!.title!
        containerView.addSubview(title)
        
        ypos += title.frame.height
        let subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 20), (SharedUIManager.instance.highlightView_subTitleSize + 3)))
        subTitle.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.highlightView_subTitleSize)
        subTitle.textColor = textColor
        subTitle.text = self.site!.title!
        containerView.addSubview(subTitle)
        
        if self.element!.hasDiscount {
            let percentageViewSize:CGFloat = (SharedUIManager.instance.highlightView_headerHeight - 25)
            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), (frame.height - SharedUIManager.instance.highlightView_headerHeight), percentageViewSize, percentageViewSize), text:"-\(self.element!.discount!)%", textSize:14, color:self.element!.media[0].vibrantColor!, textPosition:CGPoint(x: 10, y: -5))
            self.addSubview(percentageView!)
        }
        
        if self.element!.hasPrice && !self.element!.hasListPrice && !self.element!.hasFromPrice {
            
            ypos += subTitle.frame.height
            self.textPrice1 = UILabel(frame: CGRectMake(xpos, ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
            containerView.addSubview(self.textPrice1!)
            
        } else if self.element!.hasPrice && self.element!.hasListPrice {
            
            let text1Length = getStringLength("\(self.element!.currency!)\(self.element!.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.highlightView_priceSize)
            
            ypos += subTitle.frame.height
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
            containerView.addSubview(self.textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(xpos, (ypos + 9), (text1Length + 1), 0.5))
            lineView.backgroundColor = textColor
            containerView.addSubview(lineView)
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + xpos + 5), ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.listPrice!)"
            containerView.addSubview(self.textPrice2!)
            
        } else if self.element!.hasPrice &&  self.element!.hasFromPrice {
            
            let text1Length = getStringLength(NSLocalizedString("From", comment: "From"), fontName: "Lato-Light", fontSize:SharedUIManager.instance.highlightView_priceSize)
            
            ypos += subTitle.frame.height 
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            containerView.addSubview(self.textPrice1!)
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + xpos + 5), ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.price!)"
            containerView.addSubview(self.textPrice2!)
        }
        
        
        
        
        var buttonSpace:CGFloat = 30
        //Share button
        buttonSpace += 1
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake((frame.width - buttonSpace), (SharedUIManager.instance.highlightView_headerHeight - 27), 25, 25))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        shareItButton!.icon!.color = titleColor
        containerView.addSubview(shareItButton!)
        
        //Like button
        buttonSpace += 27
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake((frame.width - buttonSpace), (SharedUIManager.instance.highlightView_headerHeight - 27), 25, 25))
        likeItButton!.addTarget(self, action: "likeit:", forControlEvents: UIControlEvents.TouchUpInside)
        likeItButton!.changedIcon(site!.userLiked)
        likeItButton!.icon!.color = titleColor
        containerView.addSubview(likeItButton!)
        
        //Collect button
        buttonSpace += 27
        collectItButton = BNUIButton_CollectionIt(frame: CGRectMake((frame.width - buttonSpace), (SharedUIManager.instance.highlightView_headerHeight - 27), 25, 25))
        collectItButton!.addTarget(self, action: "collectIt:", forControlEvents: UIControlEvents.TouchUpInside)
        collectItButton!.changeToCollectIcon(site!.userCollected)
        collectItButton!.icon!.color = titleColor
        containerView.addSubview(collectItButton!)
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isFirstResponder()
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
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
        
        if element!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(element!.media[0].url!, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        delegate!.showElementView!(self.element!)

        //delegate!.showElementViewForHighlight!(self, position:CGRectMake(0, 0, 0, 0))
    }
    
    func userViewedElement(){
//        element!.userViewed  = true
        
//        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.VIEWED_ELEMENT, to:element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.addElementView(element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.save()
    }
    
    

    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareIt(self.element!._id!, isElement: true)
    }
    
    func likeit(sender:BNUIButton_BiinIt){
        self.element!.userLiked = !self.element!.userLiked
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        BNAppSharedManager.instance.likeIt(self.element!._id!, isElement: true)
        likeItButton!.changedIcon(self.element!.userLiked)
        likeItButton!.icon!.color = self.element!.media[0].vibrantColor!
    }
    
    func collectIt(sender:BNUIButton_CollectionIt){
        
        if !self.element!.userCollected {
            BNAppSharedManager.instance.collectIt(self.element!._id!, isElement: true)
        } else {
            BNAppSharedManager.instance.unCollectit(self.element!._id!, isElement: true)
        }
        
        updateCollectItBtn()
    }
    
    func updateCollectItBtn(){
        collectItButton!.changeToCollectIcon(self.element!.userCollected)
        collectItButton!.icon!.color = self.element!.media[0].vibrantColor!
        collectItButton!.setNeedsDisplay()
    }
    
    func updateShareBtn() {
        shareItButton!.icon!.color = self.element!.media[0].vibrantColor!
        shareItButton!.setNeedsDisplay()
    }
    
    override func refresh() {
        
        //        if element!.userCollected {
        //            header!.updateSocialButtonsForElement(element!)
        //            biinItButton?.showDisable()
        //        }
    }
    
    func getStringLength(text:String, fontName:String, fontSize:CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRectMake(0, 0, 0, 0))
        label.font = UIFont(name: fontName, size:fontSize)
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
}

@objc protocol HightlightView_Delegate:NSObjectProtocol {
    optional func showElementView(element:BNElement)
}
