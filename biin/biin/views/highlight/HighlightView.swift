//  HighlightView.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class HighlightView: BNView {
    
    var siteAvatar:BNUIImageView?
    var delegate:ElementMiniView_Delegate?
    var element:BNElement?
    var image:BNUIImageView?
    
    var imageRequested = false
    
    //var biinItButton:BNUIButton_BiinIt?
    //var shareItButton:BNUIButton_ShareIt?
    //var removeItButton:BNUIButton_RemoveIt?
    //var stickerView:BNUIStickerView?
    //var discountView:BNUIDiscountView?
    //var priceView:BNUIPricesView?
    
    var collectionScrollPosition:Int = 0
    
    //var animationView:BiinItAnimationView?
    
    var percentageView:ElementMiniView_Precentage?
    
    //var isNumberVisible = true
    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    
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
    
//    convenience init(frame:CGRect, father:BNView?, element:BNElement?, elementPosition:Int, showRemoveBtn:Bool, isNumberVisible:Bool, isHighlight:Bool){
//        self.init(frame:frame, father:father, element:element, elementPosition:elementPosition, showRemoveBtn:showRemoveBtn, isNumberVisible:isNumberVisible)
//        
//        //biinItButton!.frame.origin.y = (frame.height - 92)
//        //shareItButton!.frame.origin.y = (frame.height - 92)
//        
//        var siteMiniLocation:SiteView_MiniLocation?
//        if let site = BNAppSharedManager.instance.dataManager.sites[element!.siteIdentifier!] {
//            siteMiniLocation = SiteView_MiniLocation(frame: CGRectMake(0, (frame.height - 50), frame.width, 50), father: self, site:site)
//            self.addSubview(siteMiniLocation!)
//        }
//        
//        
//    }
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement){
        
        self.init(frame: frame, father:father )
        
        //self.layer.borderColor = UIColor.redColor().CGColor
        //self.layer.borderWidth = 1
        //self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        self.element = element// BNAppSharedManager.instance.dataManager.elements[element!._id!]
        
        var imageSize:CGFloat = 0
        if frame.width < frame.height {
            imageSize = frame.height// - SharedUIManager.instance.miniView_headerHeight
        } else {
            imageSize = frame.width
        }
        //Positioning image
        image = BNUIImageView(frame: CGRectMake(0, 0, imageSize, imageSize), color:self.element!.media[0].vibrantColor!)
        self.addSubview(image!)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = CGRectMake(0, (frame.height - SharedUIManager.instance.highlightView_headerHeight), frame.width, SharedUIManager.instance.highlightView_headerHeight)
        self.addSubview(visualEffectView)
        
        
        let siteAvatarSize = (SharedUIManager.instance.highlightView_headerHeight - 10)
        siteAvatar = BNUIImageView(frame: CGRectMake(5, 5, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        visualEffectView.addSubview(siteAvatar!)
        
        weak var site = BNAppSharedManager.instance.dataManager.sites[self.element!.siteIdentifier!]
        
        if site!.organization!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site!.organization!.media[0].url!, image: siteAvatar)
            siteAvatar!.cover!.backgroundColor = site!.organization!.media[0].vibrantColor!
        } else {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        var ypos:CGFloat = 5
        let xpos:CGFloat = siteAvatarSize + 12
        
        let title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 20), (SharedUIManager.instance.highlightView_titleSize + 3)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.highlightView_titleSize)
        title.textColor = UIColor.bnGrayDark()
        title.text = self.element!.title!
        visualEffectView.addSubview(title)
        
        
        if self.element!.hasDiscount {
            let percentageViewSize:CGFloat = (SharedUIManager.instance.highlightView_headerHeight - 25)
            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), (frame.height - SharedUIManager.instance.highlightView_headerHeight), percentageViewSize, percentageViewSize), text:"-\(self.element!.discount!)%", textSize:15, color:self.element!.media[0].vibrantColor!, textPosition:CGPoint(x: 5, y: -4))
            self.addSubview(percentageView!)
        }
        

        if self.element!.hasPrice && !self.element!.hasListPrice && !self.element!.hasFromPrice {
            
            ypos += title.frame.height + 3
            self.textPrice1 = UILabel(frame: CGRectMake(xpos, ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
            visualEffectView.addSubview(self.textPrice1!)
            
        } else if self.element!.hasPrice && self.element!.hasListPrice {
            
            let text1Length = getStringLength("\(self.element!.currency!)\(self.element!.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_titleSize)
            
            ypos += title.frame.height + 3
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
            visualEffectView.addSubview(self.textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(xpos, (ypos + 7.5), (text1Length + 1), 0.5))
            lineView.backgroundColor = UIColor.bnGrayDark()
            visualEffectView.addSubview(lineView)
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + xpos), ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice2!.textColor = UIColor.bnGrayDark()
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.listPrice!)"
            visualEffectView.addSubview(self.textPrice2!)
            
        } else if self.element!.hasPrice &&  self.element!.hasFromPrice {
            
            let text1Length = getStringLength(NSLocalizedString("From", comment: "From"), fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_titleSize)
            
            ypos += title.frame.height + 3
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            visualEffectView.addSubview(self.textPrice1!)
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + xpos), ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice2!.textColor = UIColor.bnGrayDark()
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.price!)"
            visualEffectView.addSubview(self.textPrice2!)
        } else {
            ypos += title.frame.height + 3
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = self.element!.subTitle!
            visualEffectView.addSubview(self.textPrice1!)
        }
        
//        if showRemoveBtn {
//            removeItButton = BNUIButton_RemoveIt(frame: CGRectMake((frame.width - 19), 4, 15, 15))
//            removeItButton!.addTarget(self, action: "unBiinit:", forControlEvents: UIControlEvents.TouchUpInside)
//            self.addSubview(removeItButton!)
//        } else {
//            
//            //biinItButton = BNUIButton_BiinIt(frame: CGRectMake(xpos, (frame.height - 42), 37, 37))
//            //biinItButton!.addTarget(self, action: "biinit:", forControlEvents: UIControlEvents.TouchUpInside)
//            //xpos += 37
//            
//            //if self.element!.userCollected {
//            //    biinItButton!.showDisable()
//            //}
//        }
        
        //shareItButton = BNUIButton_ShareIt(frame: CGRectMake(xpos, (frame.height - 42), 37, 37))
        //shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.addSubview(shareItButton!)
        
        //animationView = BiinItAnimationView(frame:CGRectMake(0, 0, frame.width, frame.height))
        //animationView!.alpha = 0
        //self.addSubview(animationView!)
        
        
        
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
//        delegate!.showElementView!(self.element!)

        //delegate!.showElementViewForHighlight!(self, position:CGRectMake(0, 0, 0, 0))
    }
    
    func userViewedElement(){
//        element!.userViewed  = true
        
//        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.VIEWED_ELEMENT, to:element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.addElementView(element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.save()
    }
    
    func biinit(sender:BNUIButton_BiinIt){
        BNAppSharedManager.instance.collectIt(element!._id!, isElement:true)
        //header!.updateSocialButtonsForElement(element!)
        //biinItButton!.showDisable()
        //animationView!.animate()
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        //        BNAppSharedManager.instance.shareit(element!._id!)
        BNAppSharedManager.instance.shareIt(element!._id!, isElement: true)
        element!.userShared = true
        //header!.updateSocialButtonsForElement(element!)
    }
    
//    func unBiinit(sender:BNUIButton_ShareIt){
//        
//        UIView.animateWithDuration(0.1, animations: {()->Void in
//            self.alpha = 0
//            }, completion: {(completed:Bool)->Void in
//                BNAppSharedManager.instance.unCollectit(self.element!._id!, isElement:true)
//                self.delegate!.resizeScrollOnRemoved!(self)
//                self.removeFromSuperview()
//        })
//    }
    
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

//@objc protocol ElementMiniView_Delegate:NSObjectProtocol {
//    optional func showElementView(view:ElementMiniView, position:CGRect)
//    optional func resizeScrollOnRemoved(view:ElementMiniView)
//}
