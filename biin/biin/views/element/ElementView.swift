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
    
    var scroll:UIScrollView?
    
    var imagesScrollView:BNUIScrollView?
    
    var fade:UIView?
    
    var biinItButton:BNUIButton_BiinIt?
    var shareItButton:BNUIButton_ShareIt?
    
    var detailsView:ElementView_Details?
    var stickerView:BNUIStickerView?
    var discountView:BNUIDiscountView?
    var priceView:BNUIPricesView?
    
    var hasSticker = false
    var hasDiscount = false
    var hasPrice = false
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var scrollHeight:CGFloat = screenHeight - SharedUIManager.instance.siteView_headerHeight
        //Add here any other heights for site view.
        
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.siteView_headerHeight, screenWidth, scrollHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.appBackground()
        self.addSubview(scroll!)
        
        scrollHeight = screenWidth
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        header = ElementView_Header(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.siteView_headerHeight), father: self)
        self.addSubview(header!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(2, 5, 30, 15))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        biinItButton = BNUIButton_BiinIt(frame: CGRectMake((screenWidth - 80), 4, 37, 37))
        biinItButton!.addTarget(self, action: "biinit:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(biinItButton!)
        
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake((screenWidth - 41), 4, 37, 37))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(shareItButton!)
        
//        detailsView = ElementView_Details(frame: CGRectMake(0, screenWidth, screenWidth, screenWidth), father: self)
//        scroll!.addSubview(detailsView!)
//        scrollHeight += screenWidth
//        scroll!.contentSize = CGSizeMake(screenWidth, scrollHeight)
        
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        println("trasition in on ElementView")
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on ElementView")
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
            println("showUserControl: ElementView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: ElementView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        detailsView!.removeFromSuperview()
        detailsView = nil
        scroll!.setContentOffset(CGPointMake(0, 0), animated: false)
        delegate!.hideElementView!(elementMiniView)
        
  
    }
    
    func updateElementData(elementMiniView:ElementMiniView?) {
        self.elementMiniView = elementMiniView
        header!.updateForElement(elementMiniView!.element!)
        imagesScrollView!.updateImages(elementMiniView!.element!.media)

        var ypos:CGFloat = 5
        
        if elementMiniView!.element!.hasDiscount {
            //Add pig
            discountView = BNUIDiscountView(frame: CGRectMake(-5, ypos, 40, 35), text: elementMiniView!.element!.discount!)
            scroll!.addSubview(discountView!)
            hasDiscount = true
            ypos += 40
        }
        
        if elementMiniView!.element!.hasListPrice  {
            priceView = BNUIPricesView(frame: CGRectMake(-5, ypos, 100, 36), oldPrice: elementMiniView!.element!.listPrice!, newPrice: elementMiniView!.element!.price!)
            scroll!.addSubview(priceView!)
            hasPrice = true
            ypos += 40
        }
        
        
        if elementMiniView!.element!.hasSticker {
            stickerView = BNUIStickerView(frame:CGRectMake(5, ypos, 50, 50), type:elementMiniView!.element!.sticker!.type, color:elementMiniView!.element!.sticker!.color! )
            scroll!.addSubview(stickerView!)
            hasSticker = true
        }
        

        
        
        detailsView = ElementView_Details(frame: CGRectMake(0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth), father: self, element:elementMiniView!.element)
        scroll!.addSubview(detailsView!)
        
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
    }
    
    func biinit(sender:BNUIButton_BiinIt){
        BNAppSharedManager.instance.biinit(elementMiniView!.element!._id!)
        println("Show biinit options")
        elementMiniView!.element!.biins++
        elementMiniView!.element!.userBiined = true
        header!.updateSocialButtonsForElement(elementMiniView!.element!)
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareit(elementMiniView!.element!._id!)
        println("Show shareit options")
        elementMiniView!.element!.userShared = true
        header!.updateSocialButtonsForElement(elementMiniView!.element!)
    }
}

@objc protocol ElementView_Delegate:NSObjectProtocol {
    optional func hideElementView(view:ElementMiniView?)
}
