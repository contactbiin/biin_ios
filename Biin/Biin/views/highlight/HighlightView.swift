//  HighlightView.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class HighlightView: BNView {
    
    var siteAvatar:BNUIImageView?
    var delegate:HightlightView_Delegate?
    var element:BNElement?
    var site:BNSite?
    var image:BNUIImageView?
    
    var imageRequested = false
    var percentageView:ElementMiniView_Precentage?
    
    var textPrice1:UILabel?
    var textPrice2:UILabel?
    
    var likeItButton:BNUIButton_LikeIt?
    var shareItButton:BNUIButton_ShareIt?
    var decorationColor:UIColor?
    var iconColor:UIColor?
    var animationView:BiinItAnimationView?

    var shareView:ShareItView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }

    convenience init(frame:CGRect, father:BNView?, element:BNElement){
        
        self.init(frame: frame, father:father )
        self.layer.masksToBounds = true
        self.element = element

        
//        var textColor:UIColor?
//        if self.element!.useWhiteText {
//            textColor = self.element!.showcase!.site!.organization!.secondaryColor
//            iconColor = self.element!.showcase!.site!.organization!.secondaryColor
//            decorationColor = self.element!.showcase!.site!.organization!.primaryColor//self.element!.media[0].vibrantDarkColor
//        } else {
//            textColor = UIColor.bnGrayDark()
//            decorationColor = self.element!.media[0].vibrantLightColor
//            iconColor = self.element!.media[0].vibrantLightColor
//        }
        
        
        
        let textColor = self.element!.showcase!.site!.organization!.secondaryColor
        iconColor = self.element!.showcase!.site!.organization!.secondaryColor
        decorationColor = self.element!.showcase!.site!.organization!.primaryColor//
        
        var ypos:CGFloat = 0
        let imageSize:CGFloat = frame.width
        
        //Positioning image
        image = BNUIImageView(frame: CGRectMake(0, ypos, imageSize, imageSize), color:self.element!.showcase!.site!.organization!.primaryColor!)
        self.addSubview(image!)
        

        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
//        visualEffectView.frame = CGRectMake(0, (frame.height - SharedUIManager.instance.highlightView_headerHeight), frame.width, SharedUIManager.instance.highlightView_headerHeight)
//        self.addSubview(visualEffectView)
        
        animationView = BiinItAnimationView(frame:CGRectMake(0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth, 0))
        self.addSubview(animationView!)

        animationView!.updateAnimationView(decorationColor, textColor: textColor)

        let containerView = UIView(frame: CGRectMake(0, (frame.height - SharedUIManager.instance.highlightView_headerHeight), frame.width, SharedUIManager.instance.highlightView_headerHeight))
        containerView.backgroundColor = decorationColor// self.element!.media[0].vibrantColor!
        self.addSubview(containerView)
        
        let siteAvatarSize = (SharedUIManager.instance.highlightView_headerHeight - 8)
        siteAvatar = BNUIImageView(frame: CGRectMake(4, 4, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        containerView.addSubview(siteAvatar!)
        
        site = BNAppSharedManager.instance.dataManager.sites[self.element!.showcase!.site!.identifier!]
        
        
        ypos = 6
        let xpos:CGFloat = siteAvatarSize + 10
        
        let title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - (20 + siteAvatarSize + 16)), (SharedUIManager.instance.highlightView_titleSize + 3)))
        title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.highlightView_titleSize)
        title.textColor = textColor
        title.text = self.element!.title!
        containerView.addSubview(title)
        
        ypos += title.frame.height
        let subTitle = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 20), (SharedUIManager.instance.highlightView_subTitleSize + 4)))
        subTitle.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.highlightView_subTitleSize)
        subTitle.textColor = textColor
        subTitle.text = "\(self.site!.title!) "
        containerView.addSubview(subTitle)
        
        let subTitleLength = SharedUIManager.instance.getStringLength("\(self.site!.title!) ", fontName: "Lato-Regular", fontSize:SharedUIManager.instance.highlightView_subTitleSize)
        
        
        let location = UILabel(frame: CGRectMake((xpos + (subTitleLength)), ypos, (frame.width - (20 + subTitleLength)), (SharedUIManager.instance.highlightView_subTitleSize + 4)))
        location.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.highlightView_subTitleSize)
        location.textColor = textColor
        location.text = " \(self.site!.subTitle!)"
        containerView.addSubview(location)
        
        if self.element!.hasDiscount {
            let percentageViewSize:CGFloat = 60
            
            percentageView = ElementMiniView_Precentage(frame: CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text: "⁃\(self.element!.discount!)⁒", textSize: 15, textColor: textColor!, color: decorationColor!, textPosition: CGPoint(x: 10, y: -10))
            
//            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), 0, percentageViewSize, percentageViewSize), text:"⁃\(self.element!.discount!)⁒", textSize:15, textcolor:textColor?, color:decorationColor!, textPosition:CGPoint(x: 10, y: -10))

            
            
            self.addSubview(percentageView!)
        }
        
        ypos += (subTitle.frame.height + 2)
        if self.element!.hasPrice && !self.element!.hasListPrice && !self.element!.hasFromPrice {
            
            let text1Length = SharedUIManager.instance.getStringLength(NSLocalizedString("Price", comment: "Price"), fontName: "Lato-Regular", fontSize:SharedUIManager.instance.highlightView_priceSize)
            
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = NSLocalizedString("Price", comment: "Price")
            containerView.addSubview(self.textPrice1!)
            
            var price = "\(self.element!.currency!)\(self.element!.price!)"
            if element.isTaxIncludedInPrice {
                price += " i.i."
            }
            
            self.textPrice2 = UILabel(frame: CGRectMake((xpos + text1Length + 7), ypos, frame.width, (SharedUIManager.instance.miniView_titleSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = price
            containerView.addSubview(self.textPrice2!)
            
//            
//            //ypos += (subTitle.frame.height + 1)
//            self.textPrice1 = UILabel(frame: CGRectMake(xpos, ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
//            self.textPrice1!.textColor = textColor
//            self.textPrice1!.textAlignment = NSTextAlignment.Left
//            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
//            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
//            containerView.addSubview(self.textPrice1!)
            
        } else if self.element!.hasPrice && self.element!.hasListPrice {
            
            let text1Length = SharedUIManager.instance.getStringLength("\(self.element!.currency!)\(self.element!.price!)", fontName: "Lato-Regular", fontSize:SharedUIManager.instance.highlightView_priceSize)
            
            //ypos += subTitle.frame.height
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = "\(self.element!.currency!)\(self.element!.price!)"
            containerView.addSubview(self.textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(xpos, (ypos + 7), (text1Length + 1), 1.5))
            lineView.backgroundColor = textColor
            containerView.addSubview(lineView)
            
            var price = "\(self.element!.currency!)\(self.element!.listPrice!)"
            if element.isTaxIncludedInPrice {
                price += " i.i."
            }
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + xpos + 5), ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = price//"\(self.element!.currency!)\(self.element!.listPrice!)"
            containerView.addSubview(self.textPrice2!)
            
        } else if self.element!.hasPrice &&  self.element!.hasFromPrice {
            
            let text1Length = SharedUIManager.instance.getStringLength(NSLocalizedString("From", comment: "From"), fontName: "Lato-Regular", fontSize:SharedUIManager.instance.highlightView_priceSize)
            
            //ypos += subTitle.frame.height
            self.textPrice1 = UILabel(frame:CGRectMake(xpos, ypos, text1Length, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice1!.textColor = textColor
            self.textPrice1!.textAlignment = NSTextAlignment.Left
            self.textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice1!.text = NSLocalizedString("From", comment: "From")
            containerView.addSubview(self.textPrice1!)
            
            var price = "\(self.element!.currency!)\(self.element!.price!)"
            if element.isTaxIncludedInPrice {
                price += " i.i."
            }
            
            self.textPrice2 = UILabel(frame: CGRectMake((text1Length + xpos + 5), ypos, frame.width, (SharedUIManager.instance.highlightView_priceSize + 2)))
            self.textPrice2!.textColor = textColor
            self.textPrice2!.textAlignment = NSTextAlignment.Left
            self.textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.highlightView_priceSize)
            self.textPrice2!.text = price//"\(self.element!.currency!)\(self.element!.price!)"
            containerView.addSubview(self.textPrice2!)
        }
        
        if shareView != nil {
            shareView = nil
        }
        
        shareView  = ShareItView(frame: CGRectMake(0, 0, 320, 450), element: element, site:site)
        /*
        var buttonSpace:CGFloat = 30
        //Share button
        buttonSpace += 5
        shareItButton = BNUIButton_ShareIt(frame: CGRectMake((frame.width - buttonSpace), (SharedUIManager.instance.highlightView_headerHeight - 27), 25, 25))
        shareItButton!.addTarget(self, action: "shareit:", forControlEvents: UIControlEvents.TouchUpInside)
        shareItButton!.icon!.color = iconColor
        containerView.addSubview(shareItButton!)
        
        //Like button
        buttonSpace += 27
        likeItButton = BNUIButton_LikeIt(frame: CGRectMake((frame.width - buttonSpace), (SharedUIManager.instance.highlightView_headerHeight - 27), 25, 25))
        likeItButton!.addTarget(self, action: "likeit:", forControlEvents: UIControlEvents.TouchUpInside)
        likeItButton!.changedIcon(self.element!.userLiked)
        likeItButton!.icon!.color = iconColor
        containerView.addSubview(likeItButton!)
        
        //Collect button
        buttonSpace += 27
        collectItButton = BNUIButton_CollectionIt(frame: CGRectMake((frame.width - buttonSpace), (SharedUIManager.instance.highlightView_headerHeight - 27), 25, 25))
        collectItButton!.addTarget(self, action: "collectIt:", forControlEvents: UIControlEvents.TouchUpInside)
        collectItButton!.changeToCollectIcon(self.element!.userCollected)
        collectItButton!.icon!.color = iconColor
        containerView.addSubview(collectItButton!)
        */
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
            
            

            
            /*
            let ssView = UIView(frame: CGRectMake(0, 0, frame.width, SharedUIManager.instance.highlightView_headerHeight))
            
            let ssYpos:CGFloat = (SharedUIManager.instance.screenWidth - SharedUIManager.instance.highlightView_headerHeight) * -1
            
            let ssImageToRender = UIImageView(image:self.image!.image!)
            ssImageToRender.frame = CGRectMake(0, ssYpos, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenWidth)
            ssView.addSubview(ssImageToRender)
            
            let imageSS = imageFromView(ssView)

            let imageView = UIImageView(image: imageSS)
            imageView.frame = CGRectMake(0, 100, frame.width, SharedUIManager.instance.highlightView_headerHeight)
            self.addSubview(imageView)
            
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            visualEffectView.frame = CGRectMake(0, 100, frame.width, SharedUIManager.instance.highlightView_headerHeight)
            self.addSubview(visualEffectView)
            */
            
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
        
        
        if let organization  = site!.organization {
            if organization.media.count > 0 {
                BNAppSharedManager.instance.networkManager.requestImageData(self.site!.organization!.media[0].url!, image: siteAvatar)
                siteAvatar!.cover!.backgroundColor = self.site!.organization!.primaryColor!
            } else {
                siteAvatar!.image = UIImage(contentsOfFile: "noImage.jpg")
                siteAvatar!.showAfterDownload()
            }
        } else {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        delegate!.showElementViewFromHighlight!(self.element!)

        //delegate!.showElementViewForHighlight!(self, position:CGRectMake(0, 0, 0, 0))
    }
    
    func userViewedElement(){
//        element!.userViewed  = true
        
//        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.VIEWED_ELEMENT, to:element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.addElementView(element!._id!)
//        BNAppSharedManager.instance.dataManager.bnUser!.save()
    }
    
    

    func shareit(sender:BNUIButton_ShareIt){
        BNAppSharedManager.instance.shareElement(self.element, shareView: self.shareView)
    }
    
    func likeit(sender:BNUIButton_BiinIt){
        self.element!.userLiked = !self.element!.userLiked
        
        if self.element!.userLiked {
            animationView!.animateWithText(NSLocalizedString("LikeTxt", comment: "LikeTxt"))
        } else {
            animationView!.animateWithText(NSLocalizedString("NotLikeTxt", comment: "NotLikeTxt"))
        }

        BNAppSharedManager.instance.likeElement(self.element)
        
        updateLikeItBtn()
    }
    
    func updateLikeItBtn() {
        likeItButton!.changedIcon(self.element!.userLiked)
        likeItButton!.icon!.color = self.iconColor!
    }
    
    func updateShareBtn() {
        shareItButton!.icon!.color = self.iconColor!
        shareItButton!.setNeedsDisplay()
    }
    
    override func refresh() {
        
        //        if element!.userCollected {
        //            header!.updateSocialButtonsForElement(element!)
        //            biinItButton?.showDisable()
        //        }
    }
    
    func imageFromView(view:UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        _ = UIImageJPEGRepresentation(image, 1)
        //let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate()).jpg"
        //let path = BNAppSharedManager.instance.mainViewController!.documentsPathForFileName(relativePath)
        //imageData!.writeToFile(path, atomically: true)
       // NSUserDefaults.standardUserDefaults().setObject(relativePath, forKey: "path")
       // NSUserDefaults.standardUserDefaults().synchronize()
        
        return image
    }
    
    override func clean(){
        
        siteAvatar?.removeFromSuperview()
        siteAvatar?.image = nil
        
        delegate = nil
        element = nil
        site = nil
        image?.removeFromSuperview()
        
        percentageView?.removeFromSuperview()
        
        textPrice1?.removeFromSuperview()
        textPrice2?.removeFromSuperview()
        
        likeItButton?.removeFromSuperview()
        shareItButton?.removeFromSuperview()
        decorationColor = nil
        iconColor = nil
        animationView?.removeFromSuperview()
        shareView?.removeFromSuperview()
        
    }
}

@objc protocol HightlightView_Delegate:NSObjectProtocol {
    optional func showElementViewFromHighlight(element:BNElement)
}
