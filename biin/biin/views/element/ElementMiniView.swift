//  ElementMiniView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView: BNView {
    
    var delegate:ElementMiniView_Delegate?
    var element:BNElement?
    var image:BNUIImageView?
    var header:ElementMiniView_Header?
    var imageRequested = false
    
    //var biinItButton:BNUIButton_BiinIt?
    //var shareItButton:BNUIButton_ShareIt?
    var removeItButton:BNUIButton_RemoveIt?
    //var stickerView:BNUIStickerView?
    //var discountView:BNUIDiscountView?
    //var priceView:BNUIPricesView?
    
    var collectionScrollPosition:Int = 0
    
    //var animationView:BiinItAnimationView?
    
    var percentageView:ElementMiniView_Precentage?
    
    var isNumberVisible = true
    
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
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?, elementPosition:Int, showRemoveBtn:Bool, isNumberVisible:Bool, isHighlight:Bool){
        self.init(frame:frame, father:father, element:element, elementPosition:elementPosition, showRemoveBtn:showRemoveBtn, isNumberVisible:isNumberVisible)
        
        //biinItButton!.frame.origin.y = (frame.height - 92)
        //shareItButton!.frame.origin.y = (frame.height - 92)

        var siteMiniLocation:SiteView_MiniLocation?
        if let site = BNAppSharedManager.instance.dataManager.sites[element!.siteIdentifier!] {
            siteMiniLocation = SiteView_MiniLocation(frame: CGRectMake(0, (frame.height - 50), frame.width, 50), father: self, site:site)
            self.addSubview(siteMiniLocation!)
        }
        
        
    }
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?, elementPosition:Int, showRemoveBtn:Bool, isNumberVisible:Bool){
        
        self.init(frame: frame, father:father )
        self.isNumberVisible = isNumberVisible
        
        //self.layer.borderColor = UIColor.appMainColor().CGColor
        //self.layer.borderWidth = 1
        //self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        self.element = element// BNAppSharedManager.instance.dataManager.elements[element!._id!]
        let imageSize = frame.width// - SharedUIManager.instance.miniView_headerHeight

        //Positioning image
        image = BNUIImageView(frame: CGRectMake(0, 0, imageSize, imageSize), color:self.element!.media[0].vibrantColor!)
        self.addSubview(image!)
 
        if !isNumberVisible {
            header = ElementMiniView_Header(frame: CGRectMake(0, (frame.height - SharedUIManager.instance.miniView_headerHeight), frame.width, SharedUIManager.instance.miniView_headerHeight), father: self, element:self.element, elementPosition:elementPosition, showCircle:false)
            self.addSubview(header!)
            header!.updateSocialButtonsForElement(self.element)
        } else {
            header = ElementMiniView_Header(frame: CGRectMake(0, (frame.height - SharedUIManager.instance.miniView_headerHeight), frame.width, SharedUIManager.instance.miniView_headerHeight), father: self, element:self.element, elementPosition:elementPosition, showCircle:!showRemoveBtn)
            self.addSubview(header!)
            header!.updateSocialButtonsForElement(self.element)
        }
    
        if element!.hasDiscount {
            let percentageViewSize:CGFloat = (SharedUIManager.instance.miniView_headerHeight - 5 )
            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), (frame.height - SharedUIManager.instance.miniView_headerHeight), percentageViewSize, percentageViewSize), text:"-\(element!.discount!)%", textSize:8, color:element!.media[0].vibrantColor!, textPosition:CGPoint(x: 5, y: -4))
            self.addSubview(percentageView!)
        }
  
        var ypos:CGFloat = 6
        if element!.hasPrice && !element!.hasListPrice && !element!.hasFromPrice {
            ypos += SharedUIManager.instance.miniView_titleSize
            self.textPrice1 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice1!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice1!)
            
        } else if element!.hasPrice && element!.hasListPrice {
            
            let text1Length = getStringLength("\(element!.currency!)\(element!.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_titleSize)
            
            ypos += SharedUIManager.instance.miniView_titleSize
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice1!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(5, (ypos + 7.5), (text1Length + 1), 0.5))
            lineView.backgroundColor = UIColor.bnGrayDark()
            self.header!.addSubview(lineView)
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 10), ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice2!.textColor = UIColor.bnGrayDark()
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice2!.text = "\(element!.currency!)\(element!.listPrice!)"
            self.header!.addSubview(self.textPrice2!)
            
        } else if element!.hasPrice &&  element!.hasFromPrice {
  
            let text1Length = getStringLength(NSLocalizedString("From", comment: "From"), fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_titleSize)
            
            ypos += SharedUIManager.instance.miniView_titleSize
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            self.header!.addSubview(self.textPrice1!)

            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 7), ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice2!.textColor = UIColor.bnGrayDark()
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice2!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice2!)
        } else {
            ypos += SharedUIManager.instance.miniView_titleSize
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.miniView_subTittleSize + 2)))
            self.textPrice1!.textColor = UIColor.bnGrayDark()
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.miniView_subTittleSize)
            self.textPrice1!.text = element!.title!
            self.header!.addSubview(self.textPrice1!)
        }
        
        if showRemoveBtn {
            removeItButton = BNUIButton_RemoveIt(frame: CGRectMake((frame.width - 19), 4, 15, 15))
            removeItButton!.addTarget(self, action: "unBiinit:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(removeItButton!)
        } else {
            
            //biinItButton = BNUIButton_BiinIt(frame: CGRectMake(xpos, (frame.height - 42), 37, 37))
            //biinItButton!.addTarget(self, action: "biinit:", forControlEvents: UIControlEvents.TouchUpInside)
            //xpos += 37
            
            //if self.element!.userCollected {
            //    biinItButton!.showDisable()
            //}
        }
        
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
        delegate!.showElementView!(self, position:CGRectMake(0, 0, 0, 0))
    }
    
    func userViewedElement(){
        element!.userViewed  = true
        header!.circleLabel?.animateCircleIn()

        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.VIEWED_ELEMENT, to:element!._id!)
        BNAppSharedManager.instance.dataManager.bnUser!.addElementView(element!._id!)
        BNAppSharedManager.instance.dataManager.bnUser!.save()
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
    
    func unBiinit(sender:BNUIButton_ShareIt){
        
        UIView.animateWithDuration(0.1, animations: {()->Void in
                self.alpha = 0
            }, completion: {(completed:Bool)->Void in
                BNAppSharedManager.instance.unCollectit(self.element!._id!, isElement:true)
                self.delegate!.resizeScrollOnRemoved!(self)
                self.removeFromSuperview()
        })
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

@objc protocol ElementMiniView_Delegate:NSObjectProtocol {
    optional func showElementView(view:ElementMiniView, position:CGRect)
    optional func resizeScrollOnRemoved(view:ElementMiniView)
}
