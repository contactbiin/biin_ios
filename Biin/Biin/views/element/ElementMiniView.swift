//  ElementMiniView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView: BNView {
    
    var delegate:ElementMiniView_Delegate?
    var delegateAllCollectedView:ElementMiniView_Delegate?
    var element:BNElement?
    var image:BNUIImageView?
    var header:ElementMiniView_Header?
    var imageRequested = false
    
    //var biinItButton:BNUIButton_BiinIt?
    //var shareItButton:BNUIButton_ShareIt?
    var removeItButton:BNUIButton_LikeIt?
    //var discountView:BNUIDiscountView?
    //var priceView:BNUIPricesView?
    
    var collectionScrollPosition:Int = 0
    
    //var animationView:BiinItAnimationView?
    
    var percentageView:ElementMiniView_Precentage?
    
    var isNumberVisible = true
    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    
    var title:UILabel?
    var location:UILabel?
//    override init() {
//        super.init()
//    }
    
    var isElementMiniViewInSite = false
    
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
//        self.init(frame:frame, father:father, element:element, elementPosition:elementPosition, showRemoveBtn:showRemoveBtn, isNumberVisible:isNumberVisible, showlocation:false)
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
    
    convenience init(frame:CGRect, father:BNView?, element:BNElement?, elementPosition:Int, showRemoveBtn:Bool, isNumberVisible:Bool, showlocation:Bool){
        
        self.init(frame: frame, father:father )
        self.isNumberVisible = isNumberVisible
        
        //self.layer.borderColor = UIColor.redColor().CGColor
        //self.layer.borderWidth = 1
        //self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.element = element
        var textColor:UIColor?
        var decorationColor:UIColor?
        
        
//        if self.element!.media.count > 0 {
//            
//            if self.element!.useWhiteText {
//                textColor = UIColor.whiteColor()
//                decorationColor = self.element!.media[0].vibrantDarkColor
//            } else {
//                textColor = UIColor.whiteColor()
//                decorationColor = self.element!.media[0].vibrantDarkColor
//            }
//        } else {
//            textColor = UIColor.whiteColor()
//            decorationColor = UIColor.bnGrayDark()
//        }
        
        decorationColor = self.element!.showcase!.site!.organization!.primaryColor
        textColor = self.element!.showcase!.site!.organization!.secondaryColor//UIColor.whiteColor()
        
        var ypos:CGFloat = 0
        var xpos:CGFloat = 0
        var imageSize:CGFloat = 0
        
        var headerHeight:CGFloat = 0
        var headerHeightForImage:CGFloat = 0
        
        if showlocation {
            headerHeight = frame.height - SharedUIManager.instance.miniView_headerHeight
            headerHeightForImage = SharedUIManager.instance.miniView_headerHeight
        } else {
            headerHeight = frame.height - SharedUIManager.instance.miniView_headerHeight_showcase
            headerHeightForImage = SharedUIManager.instance.miniView_headerHeight_showcase
        }
        
        
        if frame.width == frame.height {
            imageSize = (frame.width)
            xpos = ((imageSize - frame.width) / 2) * -1
            ypos = ((imageSize - frame.height) / 2) * -1
            
        } else if frame.width < (frame.height - headerHeightForImage) {
            imageSize = (frame.height - headerHeightForImage)
            xpos = ((imageSize - (frame.height - headerHeightForImage)) / 2) * -1
            //ypos = ((imageSize - frame.height) / 2) * -1
        } else {
            imageSize = frame.width
            ypos = ((imageSize - (frame.height - headerHeightForImage)) / 2) * -1
        }

        if self.element!.media.count > 0 {

            //Positioning image
            image = BNUIImageView(frame: CGRectMake(xpos, ypos, imageSize, imageSize), color:self.element!.media[0].vibrantColor!)
            self.addSubview(image!)
        }
            

        
        if !isNumberVisible {
            header = ElementMiniView_Header(frame: CGRectMake(0, headerHeight, frame.width, SharedUIManager.instance.miniView_headerHeight), father: self, element:self.element, elementPosition:elementPosition, showCircle:false)
            self.addSubview(header!)
            header!.updateSocialButtonsForElement(self.element)
        } else {
            header = ElementMiniView_Header(frame: CGRectMake(0, headerHeight, frame.width, SharedUIManager.instance.miniView_headerHeight), father: self, element:self.element, elementPosition:elementPosition, showCircle:!showRemoveBtn)
            self.addSubview(header!)
            header!.updateSocialButtonsForElement(self.element)
        }
    
        var percentageViewSize:CGFloat = 0
        if element!.hasDiscount {
            percentageViewSize = ( SharedUIManager.instance.miniView_headerHeight - 5 )
            
            percentageView = ElementMiniView_Precentage(frame: CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text: "⁃\(element!.discount!)⁒", textSize: 12, textColor: textColor!, color: decorationColor!, textPosition: CGPoint(x: 6, y: -6))
//            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text:"⁃\(element!.discount!)⁒", textSize:12, color:decorationColor!, textPosition:CGPoint(x: 6, y: -6))
            self.addSubview(percentageView!)
            percentageViewSize -= 20
        }
  
        var titleTextWidth:CGFloat = 0
        if showRemoveBtn {
            titleTextWidth = frame.width - (10 + 25)//20 for remove button
        } else {
            titleTextWidth = frame.width - 10
        }
        
        if showlocation {
            ypos = 2
        } else {
            ypos = 9
        }
        
        title = UILabel(frame: CGRectMake(5, ypos, titleTextWidth, (SharedUIManager.instance.miniView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.miniView_titleSize)
        title!.textColor = textColor
        title!.text = element!.title!
        self.header!.addSubview(title!)

        if showlocation {
            ypos += SharedUIManager.instance.miniView_titleSize + 2
            xpos = 5
//            weak var site = self.element!.showcase!.site!.title!
            let titleText = self.element!.showcase!.site!.title!//site!.title!
            let subtitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 3)))
            subtitle.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.miniView_subTittleSize)
            subtitle.textColor = textColor
            subtitle.text =  "\(titleText)"
            self.header!.addSubview(subtitle)
            
            let subTitleLength = SharedUIManager.instance.getStringLength("\(titleText)", fontName: "Lato-Regular", fontSize:SharedUIManager.instance.miniView_subTittleSize)
            
            location = UILabel(frame: CGRectMake((xpos + (subTitleLength)), ypos, (frame.width - (10 + subTitleLength)), (SharedUIManager.instance.miniView_subTittleSize + 3)))
            location!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_subTittleSize)
            location!.textColor = textColor
            location!.text = "  \(self.element!.showcase!.site!.subTitle!)"
            self.header!.addSubview(location!)
            ypos += SharedUIManager.instance.miniView_subTittleSize + 3
            
        } else {
            ypos += SharedUIManager.instance.miniView_titleSize + 3
        }
            
        if element!.hasPrice && !element!.hasListPrice && !element!.hasFromPrice {

           let text1Length = SharedUIManager.instance.getStringLength(NSLocalizedString("Price", comment: "Price"), fontName: "Lato-Regular", fontSize:SharedUIManager.instance.miniView_pricingSize)
            
            
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice1!.text = NSLocalizedString("Price", comment: "Price")
            self.header!.addSubview(self.textPrice1!)
            
            
            var price = "\(element!.currency!)\(element!.price!)"
            if element!.isTaxIncludedInPrice {
                price += " i.i."
            }
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 7), ypos, frame.width, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice2!.text = price
            self.header!.addSubview(self.textPrice2!)
            
            
//            
//            self.textPrice1 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
//            self.textPrice1!.textColor = textColor
//            self.textPrice1!.textAlignment = NSTextAlignment.Left
//            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
//            self.textPrice1!.text = "\(element!.currency!)\(element!.price!)"
//            self.header!.addSubview(self.textPrice1!)
            
        } else if element!.hasPrice && element!.hasListPrice {
            
            let text1Length = SharedUIManager.instance.getStringLength("\(element!.currency!)\(element!.price!)", fontName: "Lato-Regular", fontSize:SharedUIManager.instance.miniView_pricingSize)
            

            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice1!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(5, (ypos + 6.5), (text1Length + 1), 1))
            lineView.backgroundColor = textColor
            self.header!.addSubview(lineView)
            
            
            var price = "\(element!.currency!)\(element!.listPrice!)"
            if element!.isTaxIncludedInPrice {
                price += " i.i."
            }
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 10), ypos, frame.width, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice2!.text = price
            self.header!.addSubview(self.textPrice2!)
            
        } else if element!.hasPrice &&  element!.hasFromPrice {
  
            let text1Length = SharedUIManager.instance.getStringLength(NSLocalizedString("From", comment: "From"), fontName: "Lato-Regular", fontSize:SharedUIManager.instance.miniView_pricingSize)
            
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            self.header!.addSubview(self.textPrice1!)

            var price = "\(element!.currency!)\(element!.price!)"
            if element!.isTaxIncludedInPrice {
                price += " i.i."
            }
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 7), ypos, frame.width, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice2!.text = price
            self.header!.addSubview(self.textPrice2!)
        } else {
            
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.miniView_pricingSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_pricingSize)
            self.textPrice1!.text = element!.subTitle!
            self.header!.addSubview(self.textPrice1!)
        }
        
        if showRemoveBtn {
            removeItButton = BNUIButton_LikeIt(frame: CGRectMake((frame.width - 30), (headerHeight + 5), 25, 25))
            removeItButton!.icon!.color = textColor
            removeItButton!.changedIcon(true)
            removeItButton!.setNeedsDisplay()
            removeItButton!.addTarget(self, action: #selector(self.unCollect(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(removeItButton!)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isFirstResponder()
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
        
        if element!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(element!.media[0].url!, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    func unCollect(sender:BNUIButton_RemoveIt) {
        
        self.element!.userLiked = false
        BNAppSharedManager.instance.likeElement(self.element)
        SharedAnswersManager.instance.logUnCollect_Element(element)
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        
        if isElementMiniViewInSite {
            delegate!.showElementViewFromSite!(self, element: self.element!)
        } else {
            delegate!.showElementView!(self, element: self.element!)
        }
    }
    
//    func userViewedElement(){
//        element!.userViewed  = true
//        header!.circleLabel?.animateCircleIn()
//
//        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.VIEWED_ELEMENT, to:element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.addElementView(element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.save()
//    }
    
    override func refresh() {

    }
    
    override func clean(){
        
        delegate = nil
        delegateAllCollectedView = nil
        element = nil
        image?.removeFromSuperview()
        header?.clean()
        header!.removeFromSuperview()
        removeItButton?.removeFromSuperview()
        percentageView?.removeFromSuperview()
        textPrice1?.removeFromSuperview()
        textPrice2?.removeFromSuperview()
        title?.removeFromSuperview()
        location?.removeFromSuperview()
    }
}

@objc protocol ElementMiniView_Delegate:NSObjectProtocol {
    optional func showElementView( view:ElementMiniView, element:BNElement )
    optional func showElementViewFromSite( view:ElementMiniView, element:BNElement )
    optional func resizeScrollOnRemoved(view:ElementMiniView )
}
