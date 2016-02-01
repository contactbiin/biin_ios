//  ElementView.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementView: BNView, UIWebViewDelegate {
    
    var delegate:ElementView_Delegate?
    var element:BNElement?
    
    var backBtn:BNUIButton_Back?
    var backBtn_Bg:UIVisualEffectView?
    
    var scroll:UIScrollView?
    
    var imagesScrollView:BNUIScrollView?
    
    var fade:UIView?
    
    var shareItButton:BNUIButton_ShareIt?
    var likeItButton:BNUIButton_LikeIt?
    var collectItButton:BNUIButton_CollectionIt?
    var showSiteBtn:UIButton?
    
    var percentageView:ElementMiniView_Precentage?    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    var text_before:UILabel?
    var text_now:UILabel?
    
    var lineView:UIView?
    
    var textColor:UIColor?
    var decorationColor:UIColor?
    var iconColor:UIColor?
    var animationView:BiinItAnimationView?

    var butonContainer:UIView?
    
    var isElementViewFromSite:Bool = false
    
    var shareView:ShareItView?
    
    var webView:UIWebView?
    
    var titlesBackground:UIView?
    
    var title:UILabel?
    var subTitle:UILabel?
    
    var callToActionTitle:UILabel?
    var callToActionBtn:UIButton?
    
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
        
        scroll = UIScrollView(frame: CGRectMake(0, 0, screenWidth, (screenHeight - 20)))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.pagingEnabled = false
        self.addSubview(scroll!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        
        backBtn_Bg = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        backBtn_Bg!.frame = CGRectMake(0, 0, screenWidth, 35)
//        self.addSubview(visualEffectView)
        
//        backBtn_Bg = UIView(frame: CGRectMake(0, 0, screenWidth, 35))
        self.addSubview(backBtn_Bg!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 0, 35, 35))
        backBtn!.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(backBtn!)
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, screenWidth, screenWidth, 0))
        scroll!.addSubview(animationView!)
        
        lineView = UIView(frame: CGRectMake(0, 0, 0, 0))
        lineView!.alpha = 0
        scroll!.addSubview(lineView!)

        self.textPrice1 = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.textPrice2 = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.text_before = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.text_now = UILabel(frame: CGRectMake(0, 0, 0, 0))
        
        scroll!.addSubview(textPrice1!)
        scroll!.addSubview(textPrice2!)
        scroll!.addSubview(text_before!)
        scroll!.addSubview(text_now!)
        
        
        titlesBackground = UIView(frame: CGRectMake(0, screenWidth, screenWidth, 30))
        titlesBackground!.backgroundColor = UIColor.whiteColor()
        scroll!.addSubview(titlesBackground!)
        
        self.title = UILabel(frame: CGRectMake(20, 30, (frame.width - 40), 20))
        self.subTitle = UILabel(frame: CGRectMake(20, 50, (frame.width - 40), 20))
        self.title!.textColor = UIColor.appTextColor()
        self.title!.textAlignment = NSTextAlignment.Left
        self.title!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
        self.title!.text = "title"
        titlesBackground!.addSubview(self.title!)
        
        self.subTitle!.textColor = UIColor.appTextColor()
        self.subTitle!.textAlignment = NSTextAlignment.Left
        self.subTitle!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_subTitleSize)
        self.subTitle!.text = "Subtitle"
        titlesBackground!.addSubview(self.subTitle!)

        butonContainer = UIView(frame: CGRectMake(0, screenWidth, screenWidth, 30))
        scroll!.addSubview(butonContainer!)
        
        var buttonSpace:CGFloat = 40
        let ypos:CGFloat = 5//screenWidth + 2
        
        collectItButton = BNUIButton_CollectionIt(frame: CGRectMake(buttonSpace, ypos, 25, 25))
        collectItButton!.addTarget(self, action: "collectIt:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(collectItButton!)
        
        //Like button
        buttonSpace += 30
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(buttonSpace, ypos, 25, 25))
        likeItButton!.addTarget(self, action: "likeit:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(likeItButton!)

        buttonSpace += 30
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake(buttonSpace,  ypos, 25, 25))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(shareItButton!)
        
        showSiteBtn = UIButton(frame: CGRectMake((screenWidth / 2), ypos, (screenWidth / 2), 27))
        showSiteBtn!.setTitle("More from Site name.", forState: UIControlState.Normal)
        showSiteBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 12)
        showSiteBtn!.titleLabel!.textAlignment = NSTextAlignment.Right
        showSiteBtn!.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        showSiteBtn!.addTarget(self, action: "showSiteBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(showSiteBtn!)
        
        callToActionBtn = UIButton(frame: CGRectMake(5,  (screenWidth + 30), (screenWidth - 10), 50))
        callToActionBtn!.backgroundColor = UIColor.clearColor()
        callToActionBtn!.addTarget(self, action: "openUrl:", forControlEvents: UIControlEvents.TouchUpInside)
        scroll!.addSubview(callToActionBtn!)
        
        callToActionTitle = UILabel(frame: CGRectMake(0, 0, screenWidth, 50))
        callToActionTitle!.textColor = UIColor.whiteColor()
        callToActionTitle!.font = UIFont(name: "Lato-Regular", size: 20)
        callToActionTitle!.textAlignment =  NSTextAlignment.Center
        callToActionBtn!.addSubview(callToActionTitle!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        
        if !isElementViewFromSite {
            if state!.stateType != BNStateType.SiteState {
                UIView.animateWithDuration(0.3, animations: {()-> Void in
                    self.frame.origin.x = SharedUIManager.instance.screenWidth
                })
            }
        } else {

            UIView.animateWithDuration(1.0, animations: {()->Void in
                }, completion: {(completed:Bool)->Void in
                    UIView.animateWithDuration(0.3, animations: {()-> Void in
                        self.frame.origin.x = SharedUIManager.instance.screenWidth
                    })
            })

        }
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
    
    //Instance Methods
    func openUrl(sender:UIButton) {
        let targetURL = NSURL(string:"http://\(self.element!.callToActionURL!)")
        let application = UIApplication.sharedApplication()
        application.openURL(targetURL!)
    }
    
    func backBtnAction(sender:UIButton) {
        
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.EXIT_ELEMENT_VIEW, to:self.element!.identifier!)
        
        if isElementViewFromSite {
            delegate!.hideElementViewFromSite!(self.element!)
        } else {
            delegate!.hideElementView!(self.element!)
        }
    }
    
    func isSameElement(element:BNElement?)->Bool {
        if self.element != nil {
            if element!._id! == self.element!._id! {
                return true
            }
        }
        
        self.element = element
        return false
    }
    
    var ypos:CGFloat = 0
    
    func updateElementData(element:BNElement, showSiteBtn:Bool) {
        
        if !isSameElement(element) {
            
            BNAppSharedManager.instance.dataManager.applyViewedElement(element)
            
            if showSiteBtn && !self.element!.isRemovedFromShowcase {

                self.showSiteBtn!.alpha = 1
                self.showSiteBtn!.enabled = true
                
                //weak var site = BNAppSharedManager.instance.dataManager.sites[self.element!.showcase!.site!.identifier!]
                var showSiteBtnText = NSLocalizedString("MoreFrom", comment: "MoreFrom")
                showSiteBtnText += " \(self.element!.showcase!.site!.title!)"
                
                let textLenght = SharedUIManager.instance.getStringLength(showSiteBtnText, fontName: "Lato-Regular", fontSize: 12)
                
                self.showSiteBtn!.frame = CGRectMake((SharedUIManager.instance.screenWidth - (textLenght + 20)), self.showSiteBtn!.frame.origin.y, (textLenght + 20), self.showSiteBtn!.frame.height)
                self.showSiteBtn!.setTitle(showSiteBtnText, forState: UIControlState.Normal)
                
            } else {
                self.showSiteBtn!.alpha = 0
                self.showSiteBtn!.enabled = false
            }
            
            imagesScrollView!.updateImages(self.element!.media, isElement:true)
            imagesScrollView!.backgroundColor = self.element!.media[0].vibrantColor
            scroll!.backgroundColor = UIColor.whiteColor()//self.element!.media[0].vibrantColor
            
            if self.element!.useWhiteText {
                textColor = self.element!.media[0].vibrantColor//UIColor.whiteColor()
                iconColor = UIColor.darkGrayColor()//self.element!.media[0].vibrantColor//UIColor.whiteColor()
                decorationColor = self.element!.media[0].vibrantDarkColor
            } else {
                textColor = self.element!.media[0].vibrantColor
                decorationColor = self.element!.media[0].vibrantDarkColor
                iconColor = UIColor.darkGrayColor()// self.element!.media[0].vibrantDarkColor
            }
            
            animationView!.updateAnimationView(decorationColor, textColor: textColor)
            butonContainer!.backgroundColor = UIColor.clearColor()//self.element!.media[0].vibrantColor
            
            updateBackBtn()
            updateLikeItBtn()
            updateCollectItBtn()
            updateShareBtn()
                        
            ypos = SharedUIManager.instance.screenWidth

            if percentageView != nil {
                percentageView!.removeFromSuperview()
                percentageView = nil
            }
            
            if self.element!.hasDiscount {
                let percentageViewSize:CGFloat = 60
                percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text:"⁃\(self.element!.discount!)⁒", textSize:15, color:decorationColor!, textPosition:CGPoint(x: 10, y: -10))

                
                //scroll!.addSubview(percentageView!)
            }
            
            self.textPrice1!.text = ""
            self.textPrice2!.text = "HOLA"
            self.text_before!.text = ""
//            self.text_before!.alpha = 0.7
            self.text_now!.text = ""
//            self.text_now!.alpha = 0.7

            
            self.lineView!.alpha = 0
            
            if self.element!.hasPrice && !self.element!.hasListPrice && !self.element!.hasFromPrice {
                ypos += 35
                self.textPrice1!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2))
                self.textPrice1!.textColor = textColor
                self.textPrice1!.textAlignment = NSTextAlignment.Center
                self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
                self.textPrice1!.text = NSLocalizedString("Price", comment: "Price")
                //scroll!.addSubview(self.textPrice1!)
                
                ypos += SharedUIManager.instance.elementView_titleSize
                self.textPrice2!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2))
                self.textPrice2!.textColor = textColor
                self.textPrice2!.textAlignment = NSTextAlignment.Center
                self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
                self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.price!)"
                //scroll!.addSubview(self.textPrice2!)
                ypos += 40
                
                //butonContainer!.frame = CGRectMake(0, butonContainer!.frame.origin.y, butonContainer!.frame.width, 90)
                
            } else if self.element!.hasPrice && self.element!.hasListPrice {
                
                var text_Length = SharedUIManager.instance.getStringLength(NSLocalizedString("Before", comment: "Before"), fontName: "Lato-Light", fontSize:SharedUIManager.instance.elementView_titleSize)
                
                var price_Length = SharedUIManager.instance.getStringLength("\(self.element!.currency!)\(self.element!.listPrice!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.elementView_titleSize)
                
//                let xposition:CGFloat = ( frame.width - price_Length ) / 2
                var xposition:CGFloat = ((frame.width - (text_Length + 10 + price_Length)) / 2)

                ypos += 35
                
                self.text_before!.frame = CGRectMake(xposition, ypos, text_Length, (SharedUIManager.instance.elementView_titleSize + 2))
                self.text_before!.textColor = textColor!.colorWithAlphaComponent(0.75)
                self.text_before!.textAlignment = NSTextAlignment.Left
                self.text_before!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
                self.text_before!.text = NSLocalizedString("Before", comment: "Before")
                xposition += text_Length
                xposition += 10

                self.textPrice1!.frame = CGRectMake(xposition, ypos, price_Length, (SharedUIManager.instance.elementView_titleSize + 2))
                self.textPrice1!.textColor = textColor!.colorWithAlphaComponent(0.75)
                self.textPrice1!.textAlignment = NSTextAlignment.Left
                self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
                self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
                //self.scroll!.addSubview(self.textPrice1!)
                
                lineView!.alpha = 1
                lineView!.frame = CGRectMake(xposition, (ypos + 16), (price_Length + 1), 1)
                lineView!.backgroundColor = textColor!.colorWithAlphaComponent(0.75)
                //self.scroll!.addSubview(lineView!)
               
                
                
                
                text_Length = SharedUIManager.instance.getStringLength(NSLocalizedString("Now", comment: "Now"), fontName: "Lato-Regular", fontSize:SharedUIManager.instance.elementView_titleSize)
                
                price_Length = SharedUIManager.instance.getStringLength("\(self.element!.currency!)\(self.element!.listPrice!)", fontName: "Lato-Regular", fontSize:SharedUIManager.instance.elementView_titleSize)
                
                xposition = ((frame.width - (text_Length + 10 + price_Length)) / 2)

                ypos += (SharedUIManager.instance.elementView_titleSize + 5)
                
                self.text_now!.frame = CGRectMake(xposition, ypos, text_Length, (SharedUIManager.instance.elementView_titleSize + 2))
                self.text_now!.textColor = textColor
                self.text_now!.textAlignment = NSTextAlignment.Left
                self.text_now!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
                self.text_now!.text = NSLocalizedString("Now", comment: "Now")
                xposition += text_Length
                xposition += 10
                
                self.textPrice2!.frame = CGRectMake(xposition, ypos, price_Length, (SharedUIManager.instance.elementView_priceTitleSize + 2))
                self.textPrice2!.textColor = textColor
                self.textPrice2!.textAlignment = NSTextAlignment.Left
                self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
                self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.listPrice!)"
                //self.scroll!.addSubview(self.textPrice2!)
                ypos += 45
                
                //butonContainer!.frame = CGRectMake(0, butonContainer!.frame.origin.y, butonContainer!.frame.width, 90)

                
            } else if self.element!.hasPrice &&  self.element!.hasFromPrice {
                ypos += 35
                self.textPrice1!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2))
                self.textPrice1!.textColor = textColor
                self.textPrice1!.textAlignment = NSTextAlignment.Center
                self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
                self.textPrice1!.text = NSLocalizedString("From", comment: "From")
                //scroll!.addSubview(self.textPrice1!)
                
                ypos += SharedUIManager.instance.elementView_titleSize
                self.textPrice2!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2))
                self.textPrice2!.textColor = textColor
                self.textPrice2!.textAlignment = NSTextAlignment.Center
                self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
                self.textPrice2!.text = "\(self.element!.currency!)\(self.element!.price!)"
                //scroll!.addSubview(self.textPrice2!)
                ypos += 40
                
                //butonContainer!.frame = CGRectMake(0, butonContainer!.frame.origin.y, butonContainer!.frame.width, 90)

                
            } else {
                ypos += 30
                //butonContainer!.frame = CGRectMake(0, butonContainer!.frame.origin.y, butonContainer!.frame.width, 30)

            }
            
            self.title!.frame = CGRectMake(10, 20, (frame.width - 20), 0)
            self.title!.textColor = self.element!.media[0].vibrantDarkColor!//UIColor.appTextColor()
            self.title!.textAlignment = NSTextAlignment.Left
            self.title!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
            self.title!.text = self.element!.title!
            self.title!.numberOfLines = 2
            self.title!.sizeToFit()
            
            self.subTitle!.frame = CGRectMake(10, (20 + self.title!.frame.height + 2), (frame.width - 20), (SharedUIManager.instance.elementView_subTitleSize + 2))
            self.subTitle!.textColor = self.element!.media[0].vibrantDarkColor!// UIColor.appTextColor()
            self.subTitle!.textAlignment = NSTextAlignment.Left
            self.subTitle!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_subTitleSize)
            self.subTitle!.text = self.element!.subTitle!
            self.subTitle!.numberOfLines = 2
            self.subTitle!.sizeToFit()
            
            var height:CGFloat = 0
            
            if self.element!.detailsHtml == "" {
                height = self.subTitle!.frame.height + self.title!.frame.height + 130//(SharedUIManager.instance.screenHeight - (ypos))
                if (ypos + height) < SharedUIManager.instance.screenHeight {
                    height = (SharedUIManager.instance.screenHeight - (ypos + 20))
                }
            } else {
                height = 20 + self.subTitle!.frame.height + 5 + self.title!.frame.height + 2
            }
            
            
 
            
            titlesBackground!.frame =  CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, height)
            ypos += titlesBackground!.frame.height

            if webView != nil {
                webView!.removeFromSuperview()
                webView = nil
            }
            
            webView = UIWebView(frame:CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, 100 ))
            webView!.delegate = self
            webView!.loadHTMLString(getHtmlBody(self.element!), baseURL: nil)
            webView!.scrollView.userInteractionEnabled = true
            scroll!.addSubview(webView!)

            if shareView != nil {
                shareView = nil
            }
            
            
            let siteForSharing = BNAppSharedManager.instance.dataManager.sites[self.element!.showcase!.site!.identifier!]
            shareView  = ShareItView(frame: CGRectMake(0, 0, 320, 450), element: element, site:siteForSharing)
            //self.addSubview(shareView!)
        }
    }

    func clean(){
        
        delegate = nil
        element = nil
        
        backBtn?.removeFromSuperview()
        
        fade?.removeFromSuperview()
        
        shareItButton?.removeFromSuperview()
        likeItButton?.removeFromSuperview()
        collectItButton?.removeFromSuperview()
        showSiteBtn?.removeFromSuperview()
        
        percentageView?.removeFromSuperview()
        textPrice1?.removeFromSuperview()
        textPrice2?.removeFromSuperview()
        
        lineView?.removeFromSuperview()
        
        textColor = nil
        decorationColor = nil
        iconColor = nil
        animationView?.clean()
        animationView?.removeFromSuperview()
        
        butonContainer?.removeFromSuperview()
        
        shareView?.clean()
        shareView?.removeFromSuperview()
        
        titlesBackground?.removeFromSuperview()
        
        webView?.removeFromSuperview()
        
        scroll?.removeFromSuperview()
        imagesScrollView?.clean()
        imagesScrollView?.removeFromSuperview()
    }
    
    func shareit(sender:BNUIButton_ShareIt){
        //self.bringSubviewToFront(shareView!)
        BNAppSharedManager.instance.shareElement(self.element, shareView: self.shareView)
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.SHARE_ELEMENT, to:self.element!.identifier!)
    }
    
    func likeit(sender:BNUIButton_BiinIt){
        
        self.element!.userLiked = !self.element!.userLiked
        
        if self.element!.userLiked {
            animationView!.animateWithText(NSLocalizedString("LikeTxt", comment: "LikeTxt"))
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.LIKE_ELEMENT, to:self.element!.identifier!)
        } else {
            animationView!.animateWithText(NSLocalizedString("NotLikeTxt", comment: "NotLikeTxt"))
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.UNLIKE_ELEMENT, to:self.element!.identifier!)
        }
        
        BNAppSharedManager.instance.likeElement(self.element)
        
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
        
        BNAppSharedManager.instance.collectElement(self.element)
        
        if self.element!.userCollected {
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.COLLECTED_ELEMENT, to:self.element!.identifier!)
        } else {
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.UNCOLLECTED_ELEMENT, to:self.element!.identifier!)
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
        
        backBtn!.icon!.color = UIColor.whiteColor()
        backBtn!.layer.borderColor = decorationColor!.CGColor
        backBtn!.layer.backgroundColor = decorationColor!.CGColor
        backBtn!.setNeedsDisplay()
    }
    
    func showSiteBtnAction(sender:UIButton){
        delegate!.showSiteFromElement!(self.element!)
    }
    
    func showFade(){
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.fade!.alpha = 0.5
        })
    }
    
    func hideFade(){
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.fade!.alpha = 0
        })
    }
    
    func getHtmlBody(element:BNElement?) ->String {

        var html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><head>"
        html += "<style>"
        html += getBiinCSS(element)
        html += "</style></head>"
        html += "<body>"
        html += element!.detailsHtml!
        html += "<br><br><br><br>"
        html += "</body></html>"
        return html
    }
    
    func getBiinCSS(element:BNElement?) -> String {
        
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 0.0
        _ = element!.media[0].vibrantColor!.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rInt:Int = Int(r * 255)
        let gInt:Int = Int(g * 255)
        let bInt:Int = Int(b * 255)
        let color = "rgb(\(rInt), \(gInt), \(bInt))"
        
        var rd:CGFloat = 0.0
        var gd:CGFloat = 0.0
        var bd:CGFloat = 0.0
        var ad:CGFloat = 0.0
        _ = element!.media[0].vibrantDarkColor!.getRed(&rd, green: &gd, blue: &bd, alpha: &ad)
        
        let rdInt:Int = Int(rd * 255)
        let gdInt:Int = Int(gd * 255)
        let bdInt:Int = Int(bd * 255)
        let colorDark = "rgb(\(rdInt), \(gdInt), \(bdInt))"
        
        var css = ""
        css += "html { font-family: Lato, Helvetica, sans-serif; }"
        css += "p { font-size: 14px; font-weight:300 !important;}"
        css += "b { font-size: 14px; font-weight:500 !important;}"
        css += "li { font-size: 14px; font-weight:300 !important; margin-bottom: 5px; margin-left: -15px !important; }"
        css += "h1 { font-size: 30px; }"
        css += "h2 { font-size: 25px; }"
        css += ".biin_html{ display:table; }"
        css += ".listPrice_Table { display:table; margin:0 auto; width: 95%; }"
        css += ".listPrice_Title h2 { color:\(colorDark); font-size: 25px; font-weight:300; margin-bottom: 5px; !important;}"
        css += ".listPrice { width: 100%; }"
        css += ".listPrice_Left { width: 80%; float: left; }"
        css += ".listPrice_Left_Top p{ font-size: 17px; font-weight:400; text-align: left; margin-top: 0px; margin-bottom: 0px; }"
        css += ".listPrice_Left_Bottom p{ font-size: 14px; font-weight: 200; text-align: left; color: #707070; text-overflow: ellipsis; margin-top: 0px; margin-bottom: 10px; }"
        css += ".listPrice_Right p{ width: 20%; float: right; font-size: 17px; font-weight:400; text-align: right; margin-top: 0px; margin-bottom: 0px; }"
        css += ".highlight { display:table; text-align: center; width: 100%; margin-top: 20px; }"
        css += ".highlight_title p { font-size: 20px; font-weight:300; margin-top: 0px; margin-bottom: 0px; }"
        css += ".highlight_text p { font-size: 80px; font-weight:300; margin-top: -15px; margin-bottom: 0px; color:\(color);}"
        css += ".highlight_subtext p { font-size: 12px; font-weight:300; margin-top: -10px; margin-bottom: 0px; }"
        css += ".biin_h2 { font-size: 25px; font-weight:300 !important; }"
        css += ".biin_h1 { font-size: 30px; font-weight:300 !important; }"
        css += ".biin_h6 { font-size: 12px; font-weight:300 !important; }"
        css += ".biin_p { font-size: 14px; font-weight: 300 !important; }"
        css += "blockquote { border-left: 2px solid \(color); margin: 1.5em 10px; padding: 0.5em 10px; quotes:none;}"
        css += "blockquote:before { content: open-quote; vertical-align:middle; }"
        css += "blockquote p { font-size:25px; font-weight: 300; display: inline; }"
        return css
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        
        if self.element!.detailsHtml! == "" {
            
            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)

        } else {
            var frame:CGRect = webView.frame
            frame.size.height = 1
            webView.frame = frame
            let fittingSize:CGSize = webView.sizeThatFits(CGSizeZero)
            frame.size = fittingSize
            webView.frame = frame
            ypos += fittingSize.height
            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (ypos))
        }
        
        if self.element!.hasCallToAction {
            callToActionBtn!.alpha = 1
            callToActionBtn!.backgroundColor = self.element!.media[0].vibrantDarkColor
            callToActionTitle!.alpha = 1
            callToActionTitle!.text = self.element!.callToActionTitle!
            callToActionBtn!.enabled = true
        } else {
            callToActionBtn!.alpha = 0
            callToActionTitle!.alpha = 0
            callToActionBtn!.enabled = false
        }
        
        scroll!.bringSubviewToFront(callToActionBtn!)
        callToActionBtn!.frame.origin.y = (scroll!.contentSize.height - 55)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        if navigationType == UIWebViewNavigationType.LinkClicked {
            let application=UIApplication.sharedApplication()
            application.openURL(request.URL!)
            return false
        }
        return true
    }
    
}

@objc protocol ElementView_Delegate:NSObjectProtocol {
    optional func hideElementView(element:BNElement)
    optional func hideElementViewFromSite(element:BNElement)
    optional func showSiteFromElement(element:BNElement)
}
