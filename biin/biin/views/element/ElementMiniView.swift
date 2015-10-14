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
        if self.element!.useWhiteText {
            textColor = UIColor.whiteColor()
            decorationColor = self.element!.media[0].vibrantDarkColor
        } else {
            textColor = UIColor.bnGrayDark()
            decorationColor = self.element!.media[0].vibrantDarkColor
        }
        
        var ypos:CGFloat = 0
        var xpos:CGFloat = 0
        var imageSize:CGFloat = 0
        if frame.width < frame.height {
            imageSize = frame.height
            xpos = ((imageSize - frame.width) / 2) * -1
        } else {
            imageSize = frame.width
            ypos = ((imageSize - frame.height) / 2) * -1
        }

        //Positioning image
        image = BNUIImageView(frame: CGRectMake(xpos, ypos, imageSize, imageSize), color:self.element!.media[0].vibrantColor!)
        self.addSubview(image!)
 
        var headerHeight:CGFloat = 0
        if showlocation {
            headerHeight = frame.height - SharedUIManager.instance.miniView_headerHeight
        } else {
            headerHeight = frame.height - SharedUIManager.instance.miniView_headerHeight_showcase
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
            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text:"⁃\(element!.discount!)⁒", textSize:12, color:decorationColor!, textPosition:CGPoint(x: 6, y: -6))
            self.addSubview(percentageView!)
            percentageViewSize -= 20
        }
  
        var titleTextWidth:CGFloat = 0
        if showRemoveBtn {
            titleTextWidth = frame.width - (10 + 25)//20 for remove button
        } else {
            titleTextWidth = frame.width - 10
        }
        
        ypos = 3
        let title = UILabel(frame: CGRectMake(5, ypos, titleTextWidth, (SharedUIManager.instance.miniView_titleSize + 3)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
        title.textColor = textColor
        title.text = element!.title!
        self.header!.addSubview(title)

        if showlocation {
            ypos += SharedUIManager.instance.miniView_titleSize + 2
            xpos = 5
            weak var site = BNAppSharedManager.instance.dataManager.sites[self.element!.siteIdentifier!]
            let titleText = site!.title!
            let subtitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 3)))
            subtitle.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.miniView_subTittleSize)
            subtitle.textColor = textColor
            subtitle.text = titleText
            self.header!.addSubview(subtitle)
            
            let subTitleLength = SharedUIManager.instance.getStringLength(titleText, fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_subTittleSize)
            
            let location = UILabel(frame: CGRectMake((xpos + (subTitleLength)), ypos, (frame.width - (20 + subTitleLength)), (SharedUIManager.instance.miniView_subTittleSize + 4)))
            location.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.miniView_subTittleSize)
            location.textColor = textColor
            location.text = " | \(site!.city!)"
            self.header!.addSubview(location)
            ypos += SharedUIManager.instance.miniView_subTittleSize + 2
            
        } else {
            ypos += SharedUIManager.instance.miniView_titleSize + 2
        }
            
        if element!.hasPrice && !element!.hasListPrice && !element!.hasFromPrice {

            self.textPrice1 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice1!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice1!)
            
        } else if element!.hasPrice && element!.hasListPrice {
            
            let text1Length = SharedUIManager.instance.getStringLength("\(element!.currency!)\(element!.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_titleSize)
            

            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice1!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(5, (ypos + 7.5), (text1Length + 1), 0.5))
            lineView.backgroundColor = textColor
            self.header!.addSubview(lineView)
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 10), ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice2!.text = "\(element!.currency!)\(element!.listPrice!)"
            self.header!.addSubview(self.textPrice2!)
            
        } else if element!.hasPrice &&  element!.hasFromPrice {
  
            let text1Length = SharedUIManager.instance.getStringLength(NSLocalizedString("From", comment: "From"), fontName: "Lato-Light", fontSize:SharedUIManager.instance.miniView_titleSize)
            
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, text1Length, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            self.header!.addSubview(self.textPrice1!)

            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + 7), ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
            self.textPrice2!.text = "\(element!.currency!)\(element!.price!)"
            self.header!.addSubview(self.textPrice2!)
        } else {
            
            self.textPrice1 = UILabel(frame:CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.miniView_subTittleSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.miniView_subTittleSize)
            self.textPrice1!.text = element!.title!
            self.header!.addSubview(self.textPrice1!)
        }
        
        if showRemoveBtn {
            removeItButton = BNUIButton_RemoveIt(frame: CGRectMake((frame.width - 20), (headerHeight + 4), 15, 15), color:decorationColor)
            removeItButton!.addTarget(self, action: "unCollect:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(removeItButton!)
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
}

@objc protocol ElementMiniView_Delegate:NSObjectProtocol {
    optional func showElementView( view:ElementMiniView, element:BNElement )
    optional func showElementViewFromSite( view:ElementMiniView, element:BNElement )
    optional func resizeScrollOnRemoved(view:ElementMiniView )
}
