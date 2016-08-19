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
    var backBtn_Bg:UIView? //UIVisualEffectView?
    
    var scroll:UIScrollView?
    
    var imagesScrollView:BNUIScrollView?
    
//    var fade:UIView?
    
    var shareItButton:BNUIButton_ShareIt?
    var likeItButton:BNUIButton_LikeIt?
    var showSiteBtn:UIButton?
    
    var percentageView:ElementMiniView_Precentage?    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    var text_before:UILabel?
    var text_now:UILabel?
    
    var lineView:UIView?
    
    var textColor:UIColor?
    var bgColor:UIColor?
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
    
    var ypos:CGFloat = 0
    
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
        let scrollHeight:CGFloat = (screenHeight - (SharedUIManager.instance.mainView_StatusBarHeight + SharedUIManager.instance.mainView_HeaderSize))
        
        scroll = UIScrollView(frame: CGRectMake(0, SharedUIManager.instance.mainView_HeaderSize, screenWidth, scrollHeight))
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.whiteColor()
        scroll!.pagingEnabled = false
        self.addSubview(scroll!)
        
        imagesScrollView = BNUIScrollView(frame: CGRectMake(0, 0, screenWidth, screenWidth))
        scroll!.addSubview(imagesScrollView!)
        
        
        backBtn_Bg = UIView(frame: CGRectMake(0, 0, screenWidth, SharedUIManager.instance.mainView_HeaderSize))//UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        backBtn_Bg!.backgroundColor = UIColor.appBackground()
//        backBtn_Bg!.frame = CGRectMake(0, 0, screenWidth, SharedUIManager.instance.mainView_HeaderSize)
        self.addSubview(backBtn_Bg!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(5,15, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(backBtn!)
//        
//        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
//        fade!.backgroundColor = UIColor.blackColor()
//        fade!.alpha = 0
//        self.addSubview(fade!)
//        
//        addFade()
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, SharedUIManager.instance.mainView_HeaderSize, screenWidth, 0))
        self.addSubview(animationView!)

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
        titlesBackground!.layer.shadowColor = UIColor.blackColor().CGColor
        titlesBackground!.layer.shadowOffset = CGSize(width: 0, height: 2)
        titlesBackground!.layer.shadowOpacity = 0.5
        //scroll!.addSubview(titlesBackground!)
        
        lineView = UIView(frame: CGRectMake(0, 0, screenWidth, 2))
        lineView!.alpha = 0
        scroll!.addSubview(lineView!)
        
        self.title = UILabel(frame: CGRectMake(20, 30, (frame.width - 40), 20))
        self.subTitle = UILabel(frame: CGRectMake(20, 50, (frame.width - 40), 20))
        self.title!.textColor = UIColor.appTextColor()
        self.title!.textAlignment = NSTextAlignment.Left
        self.title!.font = UIFont(name: "Lato-Black", size:SharedUIManager.instance.elementView_titleSize)
        self.title!.text = "title"
        scroll!.addSubview(self.title!)
        
        self.subTitle!.textColor = UIColor.appTextColor()
        self.subTitle!.textAlignment = NSTextAlignment.Left
        self.subTitle!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_subTitleSize)
        self.subTitle!.text = "Subtitle"
        scroll!.addSubview(self.subTitle!)

        butonContainer = UIView(frame: CGRectMake(0, screenWidth, screenWidth, 30))
        scroll!.addSubview(butonContainer!)
        
        var buttonSpace:CGFloat = 65
        let ypos:CGFloat = 25//screenWidth + 2
        
        //Like button
        //buttonSpace += 35
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake(buttonSpace, ypos, 40, 40), isBig: true)
        likeItButton!.addTarget(self, action: #selector(self.likeit(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(likeItButton!)

        buttonSpace += 65
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake(buttonSpace,  ypos, 40, 40))
        shareItButton!.addTarget(self, action: #selector(self.shareit(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(shareItButton!)
        
        showSiteBtn = UIButton(frame: CGRectMake((screenWidth / 2), 0, (screenWidth / 2), 35))
        showSiteBtn!.setTitle("More from Site name.", forState: UIControlState.Normal)
        showSiteBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 12)
        showSiteBtn!.titleLabel!.textAlignment = NSTextAlignment.Right
        showSiteBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        showSiteBtn!.addTarget(self, action: #selector(self.showSiteBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn_Bg!.addSubview(showSiteBtn!)
        
        callToActionBtn = UIButton(frame: CGRectMake(5,  (screenWidth + 30), (screenWidth - 10), 50))
        callToActionBtn!.backgroundColor = UIColor.bnVisitSiteColor()
        //callToActionBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        callToActionBtn!.addTarget(self, action: #selector(self.openUrl(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        callToActionBtn!.layer.cornerRadius = 2
//        callToActionBtn!.layer.shadowColor = UIColor.blackColor().CGColor
//        callToActionBtn!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        callToActionBtn!.layer.shadowOpacity = 0.25
        scroll!.addSubview(callToActionBtn!)
        
        
        callToActionTitle = UILabel(frame: CGRectMake(0, 0, screenWidth, 50))
        callToActionTitle!.textColor = UIColor.whiteColor()
        callToActionTitle!.font = UIFont(name: "Lato-Black", size: 16)
        callToActionTitle!.textAlignment =  NSTextAlignment.Center
        callToActionBtn!.addSubview(callToActionTitle!)
        
        addFade()

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
        let targetURL = NSURL(string:"\(self.element!.callToActionURL!)")
        let application = UIApplication.sharedApplication()
        application.openURL(targetURL!)
    }
    
    func backBtnAction(sender:UIButton) {
        
        BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.EXIT_ELEMENT_VIEW, to:self.element!.identifier!, by:self.element!.showcase!.site!.identifier!)
        
        if isElementViewFromSite {
            delegate!.hideElementViewFromSite!(self.element!)
        } else {
            delegate!.hideElementView!(self.element!)
        }
    }
    
    func isSameElement(element:BNElement?)->Bool {
        if self.element != nil {
            if element!.identifier! == self.element!.identifier! {
                return true
            }
        }
        
        self.element = element
        return false
    }
    
    func updateElementData(element:BNElement, showSiteBtn:Bool) {
        
        if !isSameElement(element) {
            
            BNAppSharedManager.instance.dataManager.applyViewedElement(element)
            SharedAnswersManager.instance.logContentView_Element(element)
            scroll!.setContentOffset(CGPoint(x: 0, y: 0), animated: false)

            if showSiteBtn && !self.element!.isRemovedFromShowcase {

                self.showSiteBtn!.alpha = 1
                self.showSiteBtn!.enabled = true
                
                //weak var site = BNAppSharedManager.instance.dataManager.sites[self.element!.showcase!.site!.identifier!]
                let showSiteBtnText = "\(NSLocalizedString("MoreFrom", comment: "MoreFrom")) \(self.element!.showcase!.site!.title!)"
                
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
//            
//            if self.element!.useWhiteText {
//                textColor = self.element!.showcase!.site!.organization!.secondaryColor// self.element!.media[0].vibrantColor//UIColor.whiteColor()
//                iconColor = self.element!.showcase!.site!.organization!.primaryColor//self.element!.media[0].vibrantColor//UIColor.whiteColor()
//                decorationColor = self.element!.showcase!.site!.organization!.primaryColor//self.element!.media[0].vibrantDarkColor
//            } else {
//                textColor = self.element!.showcase!.site!.organization!.secondaryColor//self.element!.media[0].vibrantColor
//                decorationColor = self.element!.showcase!.site!.organization!.primaryColor//self.element!.media[0].vibrantDarkColor
//                iconColor = self.element!.showcase!.site!.organization!.primaryColor//UIColor.darkGrayColor()// self.element!.media[0].vibrantDarkColor
//            }
            
 
            var white:CGFloat = 0.0
            var alpha:CGFloat = 0.0
            _ = self.element!.showcase!.site!.organization!.secondaryColor!.getWhite(&white, alpha: &alpha)
            
            if white >= 0.95 {
                //print("Is white")
                textColor = self.element!.showcase!.site!.organization!.primaryColor
                bgColor = self.element!.showcase!.site!.organization!.secondaryColor
            } else {
                textColor = self.element!.showcase!.site!.organization!.secondaryColor
                bgColor = self.element!.showcase!.site!.organization!.primaryColor
            }
            
            animationView!.updateAnimationView(textColor, textColor: UIColor.whiteColor())
            butonContainer!.backgroundColor = UIColor.clearColor()//self.element!.media[0].vibrantColor
            
            //updateBackBtn()
            updateLikeItBtn()
            //updateShareBtn()
                        
            ypos = SharedUIManager.instance.screenWidth

            if percentageView != nil {
                percentageView!.removeFromSuperview()
                percentageView = nil
            }
            
            if self.element!.hasDiscount {
                
                let percentageViewSize:CGFloat = 60
                percentageView = ElementMiniView_Precentage(frame: CGRectMake((frame.width - percentageViewSize), SharedUIManager.instance.screenWidth, percentageViewSize, percentageViewSize), text: "⁃\(self.element!.discount!)⁒", textSize: 16, textColor: self.element!.showcase!.site!.organization!.secondaryColor!, color: self.element!.showcase!.site!.organization!.primaryColor!, textPosition: CGPoint(x: 10, y: -8))
                scroll!.addSubview(percentageView!)
            }
            
            self.textPrice1!.text = ""
            self.textPrice2!.text = ""
            self.text_before!.text = ""
//            self.text_before!.alpha = 0.7
            self.text_now!.text = ""
//            self.text_now!.alpha = 0.7

            
            self.lineView!.alpha = 0
            
            if self.element!.hasPrice && !self.element!.hasListPrice && !self.element!.hasFromPrice {
                ypos += 30
                self.textPrice1!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2))
                self.textPrice1!.textColor = textColor
                self.textPrice1!.textAlignment = NSTextAlignment.Center
                self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
                self.textPrice1!.text = NSLocalizedString("Price", comment: "Price")
                
                
                var price = "\(self.element!.currency!)\(self.element!.price!)"
                
                if element.isTaxIncludedInPrice {
                    price += " i.i."
                }
                
                ypos += (SharedUIManager.instance.elementView_titleSize + 5)
                self.textPrice2!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2))
                self.textPrice2!.textColor = textColor
                self.textPrice2!.textAlignment = NSTextAlignment.Center
                self.textPrice2!.font = UIFont(name: "Lato-Black", size:SharedUIManager.instance.elementView_priceTitleSize)
                self.textPrice2!.text = price
                ypos += (SharedUIManager.instance.elementView_priceTitleSize + 30)
                
            } else if self.element!.hasPrice && self.element!.hasListPrice {
                
                var text_Length = SharedUIManager.instance.getStringLength(NSLocalizedString("Before", comment: "Before"), fontName: "Lato-Light", fontSize:SharedUIManager.instance.elementView_titleSize)
                
                var price_Length = SharedUIManager.instance.getStringLength("\(self.element!.currency!)\(self.element!.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.elementView_titleSize)
                
//                let xposition:CGFloat = ( frame.width - price_Length ) / 2
                var xposition:CGFloat = ((frame.width - (text_Length + 10 + price_Length)) / 2)

                ypos += 30
                
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
                lineView!.frame = CGRectMake(xposition, (ypos + 16), price_Length, 1)
                lineView!.backgroundColor = textColor!.colorWithAlphaComponent(0.5)
                
                text_Length = SharedUIManager.instance.getStringLength(NSLocalizedString("Now", comment: "Now"), fontName: "Lato-Black", fontSize:SharedUIManager.instance.elementView_titleSize)
                
                
                
                var price = "\(self.element!.currency!)\(self.element!.listPrice!)"
                
                if element.isTaxIncludedInPrice {
                    price += " i.i."
                }
                
                price_Length = SharedUIManager.instance.getStringLength(price, fontName: "Lato-Black", fontSize:SharedUIManager.instance.elementView_titleSize)
                
                xposition = ((frame.width - (text_Length + 10 + price_Length)) / 2)

                ypos += (SharedUIManager.instance.elementView_titleSize + 5)
                
                self.text_now!.frame = CGRectMake(xposition, ypos, text_Length, (SharedUIManager.instance.elementView_titleSize + 2))
                self.text_now!.textColor = textColor
                self.text_now!.textAlignment = NSTextAlignment.Left
                self.text_now!.font = UIFont(name: "Lato-Black", size:SharedUIManager.instance.elementView_titleSize)
                self.text_now!.text = NSLocalizedString("Now", comment: "Now")
                xposition += text_Length
                xposition += 10
                
                self.textPrice2!.frame = CGRectMake(xposition, ypos, price_Length, (SharedUIManager.instance.elementView_priceTitleSize + 2))
                self.textPrice2!.textColor = textColor
                self.textPrice2!.textAlignment = NSTextAlignment.Left
                self.textPrice2!.font = UIFont(name: "Lato-Black", size:SharedUIManager.instance.elementView_priceTitleSize)
                self.textPrice2!.text = price
                //self.scroll!.addSubview(self.textPrice2!)
                ypos += (SharedUIManager.instance.elementView_priceTitleSize + 30)

            } else if self.element!.hasPrice &&  self.element!.hasFromPrice {
                ypos += 30
                self.textPrice1!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2))
                self.textPrice1!.textColor = textColor
                self.textPrice1!.textAlignment = NSTextAlignment.Center
                self.textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
                self.textPrice1!.text = NSLocalizedString("From", comment: "From")
                ypos += (SharedUIManager.instance.elementView_titleSize + 5)
                
                var price = "\(self.element!.currency!)\(self.element!.price!)"
                
                if element.isTaxIncludedInPrice {
                    price += " i.i."
                }
                
                self.textPrice2!.frame = CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2))
                self.textPrice2!.textColor = textColor
                self.textPrice2!.textAlignment = NSTextAlignment.Center
                self.textPrice2!.font = UIFont(name: "Lato-Black", size:SharedUIManager.instance.elementView_priceTitleSize)
                self.textPrice2!.text = price
                ypos += (SharedUIManager.instance.elementView_priceTitleSize + 30)
                
            } else {
                ypos += 30
            }
            
            self.title!.frame = CGRectMake(10, ypos, (frame.width - 20), 0)
            self.title!.textColor = UIColor.appTextColor()
            self.title!.textAlignment = NSTextAlignment.Left
            self.title!.font = UIFont(name: "Lato-Black", size:SharedUIManager.instance.elementView_titleSize)
            self.title!.text = self.element!.title!
            self.title!.numberOfLines = 0
            self.title!.sizeToFit()
            
            
            ypos += title!.frame.height + 5
            self.subTitle!.frame = CGRectMake(10,ypos, (frame.width - 20), 0)
            self.subTitle!.textColor = UIColor.appTextColor()
            self.subTitle!.textAlignment = NSTextAlignment.Left
            self.subTitle!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_subTitleSize)
            self.subTitle!.text = self.element!.subTitle!
            self.subTitle!.numberOfLines = 0
            self.subTitle!.sizeToFit()
            
            ypos += subTitle!.frame.height
            
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
                shareView!.clean()
                shareView!.removeFromSuperview()
                shareView = nil
            }
            
            
            let siteForSharing = BNAppSharedManager.instance.dataManager.sites[self.element!.showcase!.site!.identifier!]
            shareView  = ShareItView(frame: CGRectMake(0, 0, 320, 450), element: element, site:siteForSharing)
            //self.addSubview(shareView!)
        }
    }

    override func clean(){
        
        delegate = nil
        element = nil
        
        backBtn?.removeFromSuperview()
        
        fade?.removeFromSuperview()
        
        shareItButton?.removeFromSuperview()
        likeItButton?.removeFromSuperview()
        showSiteBtn?.removeFromSuperview()
        
        percentageView?.removeFromSuperview()
        textPrice1?.removeFromSuperview()
        textPrice2?.removeFromSuperview()
        
        lineView?.removeFromSuperview()
        
        textColor = nil
        bgColor = nil
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
        BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.SHARE_ELEMENT, to:self.element!.identifier!, by:self.element!.showcase!.site!.identifier!)
        SharedAnswersManager.instance.logShare_Element(element)
    }
    
    func likeit(sender:BNUIButton_BiinIt){
        
        self.element!.userLiked = !self.element!.userLiked
        
        if self.element!.userLiked {
            animationView!.animateWithText(NSLocalizedString("LikeTxt", comment: "LikeTxt"))
            BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.LIKE_ELEMENT, to:self.element!.identifier!, by:self.element!.showcase!.site!.identifier!)
            SharedAnswersManager.instance.logLike_Element(element)
        } else {
            animationView!.animateWithText(NSLocalizedString("NotLikeTxt", comment: "NotLikeTxt"))
            BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.UNLIKE_ELEMENT, to:self.element!.identifier!, by:self.element!.showcase!.site!.identifier!)
            SharedAnswersManager.instance.logUnLike_Element(element)

        }
        
        BNAppSharedManager.instance.likeElement(self.element)
        
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        likeItButton!.changedIcon(self.element!.userLiked)
        //likeItButton!.icon!.color = UIColor.grayColor()//self.iconColor!
    }
    
    func updateShareBtn() {
        shareItButton!.icon!.color = UIColor.grayColor()//self.iconColor!
        shareItButton!.setNeedsDisplay()
    }
    
    func updateBackBtn(){
        
        backBtn!.icon!.color = self.element!.showcase!.site!.organization!.secondaryColor//UIColor.whiteColor()
        backBtn!.layer.borderColor = self.element!.showcase!.site!.organization!.primaryColor!.CGColor//decorationColor!.CGColor
        backBtn!.layer.backgroundColor = self.element!.showcase!.site!.organization!.primaryColor!.CGColor//decorationColor!.CGColor
        backBtn!.setNeedsDisplay()
    }
    
    func showSiteBtnAction(sender:UIButton){
        delegate!.showSiteFromElement!(self.element!)
    }
    
//    func showFade(){
//        UIView.animateWithDuration(0.2, animations: {()-> Void in
//            self.fade!.alpha = 0.5
//        })
//    }
//    
//    func hideFade(){
//        UIView.animateWithDuration(0.5, animations: {()-> Void in
//            self.fade!.alpha = 0
//        })
//    }
    
    func getHtmlBody(element:BNElement?) ->String {

        var html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><head>"
        html += "<style>"
        html += getBiinCSS(element)
        html += "</style></head>"
        html += "<body>"
        html += element!.detailsHtml!
        //html += "<br><br><br><br>"
        html += "</body></html>"
        return html
    }
    
    func getBiinCSS(element:BNElement?) -> String {
        
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 0.0
        _ = element!.showcase!.site!.organization!.primaryColor!.getRed(&r, green: &g, blue: &b, alpha: &a)
        
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
        
        
        var rt:CGFloat = 0.0
        var gt:CGFloat = 0.0
        var bt:CGFloat = 0.0
        var at:CGFloat = 0.0
        _ = UIColor.appTextColor().getRed(&rt, green: &gt, blue: &bt, alpha: &at)
        
        let rtInt:Int = Int(rt * 255)
        let gtInt:Int = Int(gt * 255)
        let btInt:Int = Int(bt * 255)
        let textColor = "rgb(\(rtInt), \(gtInt), \(btInt))"
        
        
        var css = ""
        css += "html { font-family: Lato, Helvetica, sans-serif; background-color: rgb(255,255,255); color:\(textColor); margin-left: 5px; margin-right: 5px;}"
        css += "p { font-size: 14px; font-weight:300 !important;}"
        css += "b { font-size: 14px; font-weight:500 !important;}"
        css += "li { font-size: 14px; font-weight:300 !important; margin-bottom: 5px; margin-left: -15px !important; }"
        css += "h1 { font-size: 25px; }"
        css += "h2 { font-size: 20px; }"
        css += ".biin_html{ display:table; }"
        css += ".listPrice_Table { display:table; margin:0 auto; width: 95%; }"
        css += ".listPrice_Title h2 { color:\(colorDark); font-size: 20px; font-weight:300; margin-bottom: 5px; !important;}"
        css += ".listPrice { width: 100%; }"
        css += ".listPrice_Left { width: 80%; float: left; }"
        css += ".listPrice_Left_Top p{ font-size: 17px; font-weight:400; text-align: left; margin-top: 0px; margin-bottom: 0px; }"
        css += ".listPrice_Left_Bottom p{ font-size: 14px; font-weight: 200; text-align: left; color: #707070; text-overflow: ellipsis; margin-top: 0px; margin-bottom: 10px; }"
        css += ".listPrice_Right p{ width: 20%; float: right; font-size: 17px; font-weight:400; text-align: right; margin-top: 0px; margin-bottom: 0px; }"
        
        css += ".highlight { display:table; text-align: center; width: 100%; margin-top: 10px; }"
        css += ".highlight_title p { font-size: 20px; font-weight:300; margin-top: 0px; margin-bottom: 0px; }"
        css += ".highlight_text p { font-size: 60px; font-weight:600 !important; margin-top: -5px; margin-bottom: 20px; color:\(color);  line-height: 105%;}"
        css += ".highlight_subtext p { font-size: 15px; font-weight:300; margin-top: -10px; margin-bottom: 0px; }"
        
        css += ".biin_h2 { font-size: 25px; font-weight:500 !important; margin-top: 15px;}"
        css += ".biin_h1 { font-size: 30px; font-weight:600 !important; margin-top: 45px; margin-bottom: 10px;}"
        css += ".biin_h6 { font-size: 18px; font-weight:500 !important; }"
        css += ".biin_p { font-size: 15px; font-weight: 300 !important; }"
        css += "blockquote { border-left: 4px solid \(color); margin: 1.5em 10px; padding: 0.5em 10px; quotes:none;}"
        css += "blockquote:before { content: open-quote; vertical-align:middle; }"
        css += "blockquote p { font-size:25px; font-weight: 300; display: inline; }"
        return css
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        
        if self.element!.detailsHtml! != "" {

            
            webView.alpha = 1
            var frame:CGRect = webView.frame
            frame.size.height = 1
            webView.frame = frame
            let fittingSize:CGSize = webView.sizeThatFits(CGSizeZero)
            frame.size = fittingSize
            webView.frame = frame
            ypos += fittingSize.height
            
            
//            
//            webView.alpha = 0
//            
//            if (ypos + 70) < (SharedUIManager.instance.screenHeight - 55) {
//                scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight - 55))
//            } else {
//                
//                scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
//            }


        } else {
            
            webView.alpha = 0
//            var frame:CGRect = webView.frame
//            frame.size.height = 1
//            webView.frame = frame
//            let fittingSize:CGSize = webView.sizeThatFits(CGSizeZero)
//            frame.size = fittingSize
//            webView.frame = frame
//            ypos += fittingSize.height
//            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (ypos))
        }
        
        if self.element!.hasCallToAction {
            
            var white:CGFloat = 0.0
            var alpha:CGFloat = 0.0
            _ = self.element!.showcase!.site!.organization!.primaryColor!.getWhite(&white, alpha: &alpha)
            var textColorCA:UIColor?
            var bgColorCA:UIColor?
            
            
            if white >= 0.95 {
                textColorCA = self.element!.showcase!.site!.organization!.primaryColor!
                bgColorCA = self.element!.showcase!.site!.organization!.secondaryColor!
            } else {
                textColorCA = self.element!.showcase!.site!.organization!.secondaryColor!
                bgColorCA = self.element!.showcase!.site!.organization!.primaryColor
            }

            
            //ypos += 60
            callToActionBtn!.alpha = 1
            callToActionBtn!.backgroundColor = bgColorCA!
            callToActionTitle!.alpha = 1
            callToActionTitle!.text = self.element!.callToActionTitle!
            callToActionTitle!.textColor = textColorCA!
            callToActionBtn!.enabled = true
        } else {
            callToActionBtn!.alpha = 0
            callToActionTitle!.alpha = 0
            callToActionBtn!.enabled = false
        }
        
        if (ypos + 25) < (SharedUIManager.instance.screenHeight - 55) {
            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight - 55))
        } else {

            scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (ypos + 75))
        }
        
        
//        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, (ypos))
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
