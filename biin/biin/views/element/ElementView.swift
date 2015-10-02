//  ElementView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementView: BNView {
    
    var delegate:ElementView_Delegate?
    //var elementMiniView:ElementMiniView?
    var element:BNElement?
    
    var backBtn:BNUIButton_Back?
    
    var scroll:UIScrollView?
    
    var imagesScrollView:BNUIScrollView?
    
    var fade:UIView?
    
    var shareItButton:BNUIButton_ShareIt?
    var likeItButton:BNUIButton_LikeIt?
    var collectItButton:BNUIButton_CollectionIt?
    
    var detailsView:ElementView_Details?
    
    var percentageView:ElementMiniView_Precentage?    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    
    var title:UILabel?
    var subTitle:UILabel?
    
    var lineView:UIView?

    var header:UIView?
    
    var textColor:UIColor?
    var decorationColor:UIColor?
    var iconColor:UIColor?
    var animationView:BiinItAnimationView?

    var butonContainer:UIView?
    
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
        
        scroll = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.whiteColor()
        self.addSubview(scroll!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(10, 10, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(backBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, screenWidth, screenWidth, 0))
        scroll!.addSubview(animationView!)
        
        header = UIView(frame: CGRectMake(0, screenWidth, screenWidth, SharedUIManager.instance.elementView_headerHeight))
        header!.backgroundColor = UIColor.magentaColor()
        scroll!.addSubview(header!)
        
        lineView = UIView(frame: CGRectMake(0, 0, 0, 0))
        lineView!.alpha = 0

        self.textPrice1 = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.textPrice2 = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.title = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.subTitle = UILabel(frame: CGRectMake(0, 0, 0, 0))
        
        var buttonSpace:CGFloat = 5
        let ypos:CGFloat = screenWidth + 2
        
        butonContainer = UIView(frame: CGRectMake(0, screenWidth, screenWidth, 30))
        scroll!.addSubview(butonContainer!)
        
        collectItButton = BNUIButton_CollectionIt(frame: CGRectMake(buttonSpace, ypos, 25, 25))
        collectItButton!.addTarget(self, action: "collectIt:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(collectItButton!)
        
        //Like button
        buttonSpace += 28
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(buttonSpace, ypos, 25, 25))
        likeItButton!.addTarget(self, action: "likeit:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(likeItButton!)

        buttonSpace += 28
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake(buttonSpace,  ypos, 25, 25))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(shareItButton!)
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
        delegate!.hideElementView!(self.element!)
    }
    
    func updateElementData(element:BNElement) {
        
//        self.elementMiniView = elementMiniView
        self.element = element
        
        imagesScrollView!.updateImages(self.element!.media, isElement:true)

        header!.backgroundColor = self.element!.media[0].vibrantColor
        
        if self.element!.useWhiteText {
            textColor = UIColor.whiteColor()
            iconColor = UIColor.whiteColor()
            decorationColor = self.element!.media[0].vibrantDarkColor
        } else {
            textColor = UIColor.whiteColor()
            decorationColor = self.element!.media[0].vibrantDarkColor
            iconColor = self.element!.media[0].vibrantDarkColor
        }
        
        animationView!.updateAnimationView(decorationColor, textColor: textColor)
        butonContainer!.backgroundColor = self.element!.media[0].vibrantColor
        
        updateBackBtn()
        updateLikeItBtn()
        updateCollectItBtn()
        updateShareBtn()
        
        var ypos:CGFloat = SharedUIManager.instance.screenWidth
        
        if percentageView != nil {
            percentageView!.removeFromSuperview()
            percentageView = nil
        }
        
        if self.element!.hasDiscount {
            let percentageViewSize:CGFloat = 60
            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text:"⁃\(self.element!.discount!)⁒", textSize:15, color:decorationColor!, textPosition:CGPoint(x: 10, y: -10))

            scroll!.addSubview(percentageView!)
        }
        
        self.textPrice1!.text = ""
        self.textPrice2!.text = ""
        self.title!.text = ""
        self.subTitle!.text = ""
        self.lineView!.alpha = 0
        
        if self.element!.hasPrice && !self.element!.hasListPrice && !self.element!.hasFromPrice {
            ypos += 10
            self.textPrice1!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Center
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
            self.textPrice1!.text = NSLocalizedString("Price", comment: "Price")
            scroll!.addSubview(self.textPrice1!)
            
            ypos += SharedUIManager.instance.elementView_titleSize
            self.textPrice2!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Center
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.price!)"
            scroll!.addSubview(self.textPrice2!)
            ypos += 60
            
        } else if self.element!.hasPrice && self.element!.hasListPrice {
            
            let text1Length = getStringLength("\(self.element!.currency!)\(self.element!.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.elementView_titleSize)
            let xposition:CGFloat = ( frame.width - text1Length ) / 2
            
            ypos += 10
            self.textPrice1 = UILabel(frame:CGRectMake(xposition, ypos, text1Length, (SharedUIManager.instance.elementView_titleSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
            self.scroll!.addSubview(self.textPrice1!)
            
            lineView!.alpha = 1
            lineView!.frame = CGRectMake(xposition, (ypos + 11), (text1Length + 1), 1)
            lineView!.backgroundColor = self.textColor
            self.scroll!.addSubview(lineView!)
            
            ypos += SharedUIManager.instance.elementView_titleSize
            self.textPrice2 = UILabel(frame: CGRectMake(0, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Center
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.listPrice!)"
            self.scroll!.addSubview(self.textPrice2!)
            ypos += 60
            
        } else if self.element!.hasPrice &&  self.element!.hasFromPrice {
            ypos += 10
            self.textPrice1!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Center
            self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            scroll!.addSubview(self.textPrice1!)
            
            ypos += SharedUIManager.instance.elementView_titleSize
            self.textPrice2!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Center
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
            self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.price!)"
            scroll!.addSubview(self.textPrice2!)
            ypos += 60
            
        } else {
            ypos += 40
            header!.backgroundColor = UIColor.clearColor()
        }

        self.title!.frame = CGRectMake(20, ypos, (frame.width - 40), 0)
        self.title!.textColor = UIColor.appTextColor()
        self.title!.textAlignment = NSTextAlignment.Left
        self.title!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
        self.title!.text = self.element!.title!
        self.title!.numberOfLines = 2
        self.title!.sizeToFit()
        scroll!.addSubview(self.title!)
        
        ypos += self.title!.frame.height + 2
        self.subTitle!.frame = CGRectMake(20, ypos, (frame.width - 40), (SharedUIManager.instance.elementView_subTitleSize + 2))
        self.subTitle!.textColor = UIColor.appTextColor()
        self.subTitle!.textAlignment = NSTextAlignment.Left
        self.subTitle!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_subTitleSize)
        self.subTitle!.text = self.element!.subTitle!
        scroll!.addSubview(self.subTitle!)
        self.subTitle!.numberOfLines = 2
        self.subTitle!.sizeToFit()
        
        ypos += self.subTitle!.frame.height + 5
 
        if detailsView != nil {
            detailsView!.removeFromSuperview()
            detailsView = nil
        }
        
        detailsView = ElementView_Details(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth), father: self, element:self.element)
        scroll!.addSubview(detailsView!)
       
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenWidth + detailsView!.frame.height))
    }

    func clean(){
        scroll!.setContentOffset(CGPointMake(0, 0), animated: false)
        detailsView!.removeFromSuperview()
        detailsView = nil
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareIt(self.element!._id!, isElement: true)
    }
    
    func likeit(sender:BNUIButton_BiinIt){
        self.element!.userLiked = !self.element!.userLiked
        BNAppSharedManager.instance.likeIt(self.element!._id!, isElement: true)
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        likeItButton!.changedIcon(self.element!.userLiked)
        likeItButton!.icon!.color = self.iconColor!
    }
    
    func collectIt(sender:BNUIButton_CollectionIt){
        
        self.element!.userCollected = !self.element!.userCollected

        updateCollectItBtn()
        animationView!.animate(self.element!.userCollected)
        
        if !self.element!.userCollected {
            BNAppSharedManager.instance.collectIt(self.element!._id!, isElement: true)
        } else {
            BNAppSharedManager.instance.unCollectit(self.element!._id!, isElement: true)
        }
    }
    
    func updateCollectItBtn(){
        collectItButton!.changeToCollectIcon(self.element!.userCollected)
        collectItButton!.icon!.color = self.iconColor!
        collectItButton!.setNeedsDisplay()
    }
    
    func updateShareBtn() {
        shareItButton!.icon!.color = self.iconColor!
        shareItButton!.setNeedsDisplay()
    }
    
    func updateBackBtn(){
        backBtn!.icon!.color = UIColor.whiteColor()//site!.media[0].vibrantDarkColor!
        backBtn!.layer.borderColor = decorationColor!.CGColor
        backBtn!.layer.backgroundColor = decorationColor!.CGColor
        backBtn!.setNeedsDisplay()
    }
    
    func getStringLength(text:String, fontName:String, fontSize:CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRectMake(0, 0, 0, 0))
        label.font = UIFont(name: fontName, size:fontSize)
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
}

@objc protocol ElementView_Delegate:NSObjectProtocol {
    optional func hideElementView(element:BNElement)
}
