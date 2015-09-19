//  ElementView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementView: BNView {
    
    var delegate:ElementView_Delegate?
    var elementMiniView:ElementMiniView?
    var backBtn:BNUIButton_Back?
    var header:ElementView_Header?
    var buttonsView:SocialButtonsView?
    
    var scroll:UIScrollView?
    
    var imagesScrollView:BNUIScrollView?
    
    var fade:UIView?
    
    var biinItButton:BNUIButton_BiinIt?
    var shareItButton:BNUIButton_ShareIt?
    var likeItButton:BNUIButton_LikeIt?
    var collectItButton:BNUIButton_CollectionIt?
    
    
    var detailsView:ElementView_Details?
    
    var stickerView:BNUIStickerView?
    var discountView:BNUIDiscountView?
    var priceView:BNUIPricesView?
    
    var hasSticker = false
    var hasDiscount = false
    var hasPrice = false
    
    var animationView:BiinItAnimationView?
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }

    convenience init(frame: CGRect, father: BNView?, showBiinItBtn:Bool) {
        
        self.init(frame: frame, father:father )
        self.backgroundColor = UIColor.whiteColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
//        var scrollHeight:CGFloat = screenHeight// - SharedUIManager.instance.elementView_headerHeight
        //Add here any other heights for site view.
        
        scroll = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.whiteColor()
        self.addSubview(scroll!)
        
//        scrollHeight = screenWidth
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        header = ElementView_Header(frame: CGRectMake(0, (screenWidth - SharedUIManager.instance.elementView_headerHeight), screenWidth, SharedUIManager.instance.elementView_headerHeight), father: self)
        scroll!.addSubview(header!)
        
        buttonsView = SocialButtonsView(frame: CGRectMake(1, 5, frame.width, 15), father: self, element: nil)
        //scroll!.addSubview(buttonsView!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(10, 10, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(backBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        /*
        if showBiinItBtn {
            biinItButton = BNUIButton_BiinIt(frame: CGRectMake((screenWidth - 80), 4, 37, 37))
            biinItButton!.addTarget(self, action: "biinit:", forControlEvents: UIControlEvents.TouchUpInside)
            scroll!.addSubview(biinItButton!)
        }
        
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake((screenWidth - 41), 4, 37, 37))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(shareItButton!)
        */
        var buttonSpace:CGFloat = 26
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake((screenWidth - buttonSpace), (SharedUIManager.instance.elementView_headerHeight - 27), 25, 25))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        header!.addSubview(shareItButton!)
        
        //Like button
        buttonSpace += 27
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake((screenWidth - buttonSpace), (SharedUIManager.instance.elementView_headerHeight - 27), 25, 25))
        likeItButton!.addTarget(self, action: "likeit:", forControlEvents: UIControlEvents.TouchUpInside)
        header!.addSubview(likeItButton!)
        
        //Collect button
        buttonSpace += 27
        collectItButton = BNUIButton_CollectionIt(frame: CGRectMake((screenWidth - buttonSpace), (SharedUIManager.instance.elementView_headerHeight - 27), 25, 25))
        collectItButton!.addTarget(self, action: "collectIt:", forControlEvents: UIControlEvents.TouchUpInside)
        header!.addSubview(collectItButton!)
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, 0, screenWidth, screenWidth))
        animationView!.alpha = 0
        scroll!.addSubview(animationView!)
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
        UIView.animateWithDuration(0.25, animations: {()-> Void in
            self.frame.origin.x = SharedUIManager.instance.screenWidth
        })
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
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.hideElementView!(elementMiniView)
        self.elementMiniView!.refresh()
//        detailsView!.removeFromSuperview()
//        detailsView = nil
    }
    
    func updateElementData(elementMiniView:ElementMiniView?) {
        
        self.elementMiniView = elementMiniView
        header!.updateForElement(elementMiniView!.element!)
        imagesScrollView!.updateImages(elementMiniView!.element!.media, isElement:true)
        //buttonsView!.updateSocialButtonsForElement(elementMiniView!.element!)

        print("element identifier: \(elementMiniView!.element!.identifier!)")
        
        /*
        if elementMiniView!.element!.hasDiscount {
            //Add pig
            discountView = BNUIDiscountView(frame: CGRectMake(-5, ypos, 40, 35), text: elementMiniView!.element!.discount!)
            scroll!.addSubview(discountView!)
            hasDiscount = true
            ypos += 40
        }
        */
        
//        if elementMiniView!.element!.hasListPrice  {
//            priceView = BNUIPricesView(frame: CGRectMake(-5, ypos, 100, 36), oldPrice: elementMiniView!.element!.listPrice!, newPrice: elementMiniView!.element!.price!)
//            scroll!.addSubview(priceView!)
//            hasPrice = true
//            ypos += 40
//        }
        updateBackBtn()
        updateLikeItBtn()
        updateCollectItBtn()
        updateShareBtn()
        
        var ypos:CGFloat = 10
        if priceView != nil {
            priceView!.removeFromSuperview()
            priceView = nil
        }
        
        if !elementMiniView!.element!.hasPrice && elementMiniView!.element!.hasDiscount{
            
            priceView = BNUIPricesView(frame: CGRectMake(0, ypos, 100, 40), price: "\(elementMiniView!.element!.discount!)%", isMini:false, isDiscount:true)
            scroll!.addSubview(priceView!)
            priceView!.frame.origin.x = (SharedUIManager.instance.screenWidth - priceView!.frame.width)
            ypos += 40
            
        } else if elementMiniView!.element!.hasPrice && !elementMiniView!.element!.hasListPrice && !elementMiniView!.element!.hasFromPrice {
            priceView = BNUIPricesView(frame: CGRectMake(0, ypos, 100, 40), price: "\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.price!)", isMini:false, isDiscount:false)
            scroll!.addSubview(priceView!)
            hasPrice = true
            priceView!.frame.origin.x = (SharedUIManager.instance.screenWidth - priceView!.frame.width)
            ypos += 40
            
        } else if elementMiniView!.element!.hasPrice &&  elementMiniView!.element!.hasListPrice && elementMiniView!.element!.hasDiscount {
            
            priceView = BNUIPricesView(frame: CGRectMake(0, ypos, 100, 65), oldPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.price!)", newPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.listPrice!)", percentage:"\(elementMiniView!.element!.discount!)%", isMini:false, isHighlight:elementMiniView!.element!.isHighlight, color:elementMiniView!.element!.media[0].vibrantColor!)
            scroll!.addSubview(priceView!)
            hasPrice = true
            priceView!.frame.origin.x = (SharedUIManager.instance.screenWidth - priceView!.frame.width)
            ypos += 40
            
        } else if elementMiniView!.element!.hasPrice &&  elementMiniView!.element!.hasListPrice && !elementMiniView!.element!.hasDiscount {
            //TODO
            priceView = BNUIPricesView(frame: CGRectMake(0, ypos, 100, 65), oldPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.price!)", newPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.listPrice!)", isMini:false, isHighlight:elementMiniView!.element!.isHighlight)
            scroll!.addSubview(priceView!)
            hasPrice = true
            priceView!.frame.origin.x = (SharedUIManager.instance.screenWidth - priceView!.frame.width)
            ypos += 40
            
        } else if elementMiniView!.element!.hasPrice &&  elementMiniView!.element!.hasFromPrice {
            
            //priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 70), oldPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.listPrice!)", newPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.price!)")
            priceView = BNUIPricesView(frame: CGRectMake(0, ypos, 100, 65), price: "\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.price!)", from:NSLocalizedString("From", comment: "From")
, isMini:false, isHighlight:elementMiniView!.element!.isHighlight)
            scroll!.addSubview(priceView!)
            hasPrice = true
            priceView!.frame.origin.x = (SharedUIManager.instance.screenWidth - priceView!.frame.width)
            ypos += 40
        }
        
        /*
        if elementMiniView!.element!.hasSticker {
            stickerView = BNUIStickerView(frame:CGRectMake(5, ypos, 50, 50), type:elementMiniView!.element!.sticker!.type, color:elementMiniView!.element!.sticker!.color! )
            scroll!.addSubview(stickerView!)
            hasSticker = true
        }
        */
        
        if detailsView != nil {
            detailsView!.removeFromSuperview()
            detailsView = nil
        }
        
        detailsView = ElementView_Details(frame: CGRectMake(0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth), father: self, element:elementMiniView!.element)
        scroll!.addSubview(detailsView!)
        
//        if elementMiniView!.element!.userCollected {
//            //biinItButton?.showDisable()
//            detailsView!.showBiinItButton(false)
//        }else {
//            //biinItButton!.showEnable()
//            detailsView!.showBiinItButton(true)
//        }
        
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenWidth + detailsView!.frame.height))
    }

    func clean(){
        if hasSticker {
            stickerView!.removeFromSuperview()
            hasSticker = false
        }
        
        if hasDiscount {
            discountView!.removeFromSuperview()
            hasDiscount = false
        }
        
        if hasPrice {
            priceView!.removeFromSuperview()
            hasPrice = false
        }
        
        scroll!.setContentOffset(CGPointMake(0, 0), animated: false)
        detailsView!.removeFromSuperview()
        detailsView = nil
    }
    
    /*
    func biinit(sender:BNUIButton_BiinIt){
        BNAppSharedManager.instance.collectIt(elementMiniView!.element!._id!, isElement: true)
        detailsView!.showBiinItButton(false)
        applyBiinIt()
    }
    
    func applyBiinIt(){
        buttonsView!.updateSocialButtonsForElement(elementMiniView!.element!)
        biinItButton!.showDisable()
        detailsView!.showBiinItButton(false)
        animationView!.animate()
    }
    */
    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareIt(elementMiniView!.element!._id!, isElement: true)
    }
    
    func likeit(sender:BNUIButton_BiinIt){
        elementMiniView!.element!.userLiked = !elementMiniView!.element!.userLiked
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        BNAppSharedManager.instance.likeIt(elementMiniView!.element!._id!, isElement: true)
        likeItButton!.changedIcon(elementMiniView!.element!.userLiked)
        likeItButton!.icon!.color = elementMiniView!.element!.media[0].vibrantColor!
    }
    
    func collectIt(sender:BNUIButton_CollectionIt){
        
        if !elementMiniView!.element!.userCollected {
            BNAppSharedManager.instance.collectIt(elementMiniView!.element!._id!, isElement: true)
        } else {
            BNAppSharedManager.instance.unCollectit(elementMiniView!.element!._id!, isElement: true)
        }
        
        updateCollectItBtn()
    }
    
    func updateCollectItBtn(){
        collectItButton!.changeToCollectIcon(elementMiniView!.element!.userCollected)
        collectItButton!.icon!.color = elementMiniView!.element!.media[0].vibrantColor!
        collectItButton!.setNeedsDisplay()
    }
    
    func updateShareBtn() {
        shareItButton!.icon!.color = elementMiniView!.element!.media[0].vibrantColor!
        shareItButton!.setNeedsDisplay()
    }
    
    func updateBackBtn(){
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = elementMiniView!.element!.media[0].vibrantColor!.CGColor
        backBtn!.layer.backgroundColor = elementMiniView!.element!.media[0].vibrantColor!.CGColor
        backBtn!.setNeedsDisplay()
    }
}

@objc protocol ElementView_Delegate:NSObjectProtocol {
    optional func hideElementView(view:ElementMiniView?)
}
