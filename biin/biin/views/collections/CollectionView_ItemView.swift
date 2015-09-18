//
//  CollectionView_ItemView.swift
//  biin
//
//  Created by Esteban Padilla on 3/29/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class CollectionView_ItemView: BNView {
    
    var delegate:CollectionView_ItemView_Delegate?
    var element:BNElement?
    var site:BNSite?
    var image:BNUIImageView?
    var header:ElementMiniView_Header?
    var siteHeader:SiteMiniView_Header?
    
    var imageRequested = false
    
    //var biinItButton:BNUIButton_BiinIt?
    var shareItButton:BNUIButton_ShareIt?
    var removeItButton:BNUIButton_RemoveIt?
    var stickerView:BNUIStickerView?
    var discountView:BNUIDiscountView?
    var priceView:BNUIPricesView?
    
    var collectionScrollPosition:Int = 0
    
    var isElement = false
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?, isElement:Bool, site:BNSite? ){
        self.init(frame: frame, father:father )
        
        self.layer.borderColor = UIColor.appMainColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.isElement = isElement
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        
        if self.isElement {
            self.element = BNAppSharedManager.instance.dataManager.elements[element!._id!]
            
            if self.element!.media.count > 0 {
                if let color = self.element!.media[0].domainColor {
                    self.backgroundColor = color
                } else {
                    self.backgroundColor = UIColor.appMainColor()
                }
            } else {
                self.backgroundColor = UIColor.appMainColor()
            }
            
        } else {
            self.site = BNAppSharedManager.instance.dataManager.sites[site!.identifier!]
            if self.site!.media.count > 0 {
                if let color = self.site!.media[0].domainColor {
                    self.backgroundColor = color
                } else {
                    self.backgroundColor = UIColor.appMainColor()
                }
            } else {
                self.backgroundColor = UIColor.appMainColor()
            }
        }
        
        

        
        //Positioning image
        let imageSize = frame.height - SharedUIManager.instance.miniView_headerHeight
        var xpos = ((imageSize - frame.width) / 2 ) * -1
        image = BNUIImageView(frame: CGRectMake(xpos, SharedUIManager.instance.miniView_headerHeight, imageSize, imageSize))
        self.addSubview(image!)
        
        if self.isElement {
            header = ElementMiniView_Header(frame: CGRectMake(0, 0, frame.width, SharedUIManager.instance.miniView_headerHeight), father: self, element:self.element, elementPosition:0, showCircle:false)
            self.addSubview(header!)
            header!.updateSocialButtonsForElement(self.element)
        } else {
            siteHeader = SiteMiniView_Header(frame: CGRectMake(0, 0, frame.width, SharedUIManager.instance.miniView_headerHeight), father:self, site: self.site!, showShareButton:false)
            self.addSubview(siteHeader!)
            siteHeader!.updateSocialButtonsForSite(self.site!)
        }
        
        xpos = 5
   
        removeItButton = BNUIButton_RemoveIt(frame: CGRectMake((frame.width - 19), 4, 15, 15))
        removeItButton!.addTarget(self, action: "unBiinit:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(removeItButton!)

        
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake(xpos, (frame.height - 42), 37, 37))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(shareItButton!)
        
        var ypos:CGFloat = SharedUIManager.instance.elementView_headerHeight - 5
        if self.isElement {
            if self.element!.hasDiscount {
                //discountView = BNUIDiscountView(frame: CGRectMake(-5, ypos, 40, 35), text: self.element!.discount!)
                //self.addSubview(discountView!)
                ypos += 40
            }
            
            if self.element!.hasListPrice && !self.element!.hasDiscount {
                //priceView = BNUIPricesView(frame: CGRectMake(-5, ypos, 100, 36), listPrice: self.element!.listPrice!)
                //self.addSubview(priceView!)
                
            } else if self.element!.hasListPrice {
                
                //priceView = BNUIPricesView(frame: CGRectMake(-5, ypos, 100, 36), oldPrice: self.element!.listPrice!, newPrice: self.element!.price!)
                //self.addSubview(priceView!)
            }
            
            if self.element!.hasSticker {
                stickerView = BNUIStickerView(frame:CGRectMake((SharedUIManager.instance.miniView_width - 55), (SharedUIManager.instance.miniView_headerHeight + 5), 50, 50), type:self.element!.sticker!.type, color:self.element!.sticker!.color! )
                self.addSubview(stickerView!)
            }
        }
        
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
        if self.isElement {
            if element!.media.count > 0 {
                BNAppSharedManager.instance.networkManager.requestImageData(element!.media[0].url!, image: image)
            } else {
                image!.image =  UIImage(named: "noImage.jpg")
                image!.showAfterDownload()
            }
        } else {
            if site!.media.count > 0 {
                BNAppSharedManager.instance.networkManager.requestImageData(site!.media[0].url!, image: image)
            } else {
                image!.image =  UIImage(named: "noImage.jpg")
                image!.showAfterDownload()
            }
        }
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        
        //TODO: Show element or site.
        
        //delegate!.showElementView!(self, position:CGRectMake(0, 0, 0, 0))
    }
    
    func userViewedElement(){
        //element!.userViewed  = true
        //header!.circleLabel?.animateCircleIn()
    }
    
//    func biinit(sender:BNUIButton_BiinIt){
//        BNAppSharedManager.instance.biinit(element!._id!, isElement:true)
//        header!.updateSocialButtonsForElement(element!)
//        biinItButton!.showDisable()
//    }
    
    func shareit(sender:BNUIButton_ShareIt){
        
        if self.isElement {
            //BNAppSharedManager.instance.shareIt(element!._id!)
            BNAppSharedManager.instance.shareIt(element!._id!, isElement: true)
            element!.userShared = true
            header!.updateSocialButtonsForElement(element!)
        } else {
            BNAppSharedManager.instance.shareIt(site!.identifier!, isElement: false)
            site!.userShared = true
        }
    }
    
    func unBiinit(sender:BNUIButton_ShareIt){
        
        UIView.animateWithDuration(0.1, animations: {()->Void in
            self.alpha = 0
            }, completion: {(completed:Bool)->Void in
                if self.isElement {
                    self.delegate!.resizeScrollOnRemoved!(self)
                    BNAppSharedManager.instance.unCollectit(self.element!.identifier!, isElement:true)
                    self.removeFromSuperview()
                } else  {
                    self.delegate!.resizeScrollOnRemoved!(self)
                    BNAppSharedManager.instance.unCollectit(self.site!.identifier!, isElement:false)
                    self.removeFromSuperview()
                }
        })
    }
    
    override func refresh() {
        
        if self.isElement {
            if element!.userCollected {
                header!.updateSocialButtonsForElement(element!)
                //biinItButton?.showDisable()
            }
        } else {
            siteHeader!.updateSocialButtonsForSite(site!)
        }
    }
}

@objc protocol CollectionView_ItemView_Delegate:NSObjectProtocol {
    optional func showItemView(view:CollectionView_ItemView, position:CGRect)
    optional func resizeScrollOnRemoved(view:CollectionView_ItemView)
}

