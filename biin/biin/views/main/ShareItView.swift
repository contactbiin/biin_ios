//  ShareItView.swift
//  biin
//  Created by Esteban Padilla on 4/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ShareItView:UIView {
    
    //var priceView:BNUIPricesView?
    var textColor:UIColor?
    var decorationColor:UIColor?
    var image:BNUIImageView?
    var percentageView:ElementMiniView_Precentage?
    var title:UILabel?
    var subTitle:UILabel?

    var lineView:UIView?
    
    var textPrice1:UILabel?// = UILabel(frame: CGRectZero)
    var textPrice2:UILabel?// = UILabel(frame: CGRectZero)
    var bg:UIView?
    var whiteBackground2:UIView?
    var siteLocation:SiteView_Location?
    var biinLogo:BNUIBiinMiniView?
    var downloadLbl:UILabel?
    
    var siteAvatar:BNUIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, element:BNElement, site:BNSite?) {
        self.init(frame:frame)
        
        self.backgroundColor = element.media[0].vibrantColor!
        
 
        if element.useWhiteText {
            textColor = UIColor.whiteColor()
            decorationColor = element.media[0].vibrantDarkColor
        } else {
            textColor = UIColor.whiteColor()
            decorationColor = element.media[0].vibrantDarkColor
        }

        self.layer.borderColor = element.media[0].vibrantColor!.CGColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        
        
        var ypos:CGFloat = 0
        image = BNUIImageView(frame: CGRectMake(0, ypos, 320, 320), color:element.media[0].vibrantColor!)
        self.addSubview(image!)
        
        if site!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(element.media[0].url!, image: image!)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
        
        if element.hasDiscount {
            let percentageViewSize:CGFloat = 60
            
            percentageView = ElementMiniView_Precentage(frame: CGRectMake((frame.width - percentageViewSize), ypos, percentageViewSize, percentageViewSize), text: "⁃\(element.discount!)⁒", textSize: 15, textColor: textColor!, color: decorationColor!, textPosition: CGPoint(x: 10, y: -10))
            
//            percentageView = ElementMiniView_Precentage(frame:CGRectMake((frame.width - percentageViewSize), ypos, percentageViewSize, percentageViewSize), text:"⁃\(element.discount!)⁒", textSize:15, color:decorationColor!, textPosition:CGPoint(x: 10, y: -10))
            
            self.addSubview(percentageView!)
        }

        ypos += 330
        
        title = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 23))
        title!.font = UIFont(name:"Lato-Regular", size:20)
        title!.numberOfLines = 0
        title!.textColor = textColor!
        title!.text = element.title
        title!.sizeToFit()
        self.addSubview(title!)
        
        ypos += (title!.frame.height + 2)
        subTitle = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 14))
        subTitle!.font = UIFont(name:"Lato-Light", size:12)
        subTitle!.numberOfLines = 0
        subTitle!.textColor = textColor!
        subTitle!.text = element.subTitle
        subTitle!.sizeToFit()
        self.addSubview(subTitle!)
        
        ypos += (subTitle!.frame.height + 10)
        
        //lineView = UIView(frame: CGRectMake(0, ypos, (frame.width), 1))
//        lineView!.backgroundColor = textColor
//        self.addSubview(lineView!)
        

        
        if element.hasPrice && !element.hasListPrice && !element.hasFromPrice {

            //var height:CGFloat = 0
//            let bg = UIView(frame: CGRectMake(0, ypos, (frame.width), 1))
//            bg.backgroundColor = decorationColor
//            self.addSubview(bg)
            //height += 10
            
            //ypos += 10
            textPrice1 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2)))
            textPrice1!.textColor = textColor
            textPrice1!.textAlignment = NSTextAlignment.Center
            textPrice1!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
            textPrice1!.text = NSLocalizedString("Price", comment: "Price")
            self.addSubview(textPrice1!)
            
            ypos += SharedUIManager.instance.elementView_titleSize
            textPrice2 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2)))
            textPrice2!.textColor = textColor
            textPrice2!.textAlignment = NSTextAlignment.Center
            textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
            textPrice2!.text = "\(element.currency!)\(element.price!)"
            self.addSubview(textPrice2!)
            ypos += 40
            
            //height += 60
            //bg.frame = CGRectMake(0, bg.frame.origin.y, bg.frame.width, height)
            
        } else if element.hasPrice && element.hasListPrice {
            
            //var height:CGFloat = 0
//            bg = UIView(frame: CGRectMake(0, ypos, (frame.width), 1))
//            bg!.backgroundColor = decorationColor
//            self.addSubview(bg!)
            //height += 10
            
            
            //ypos += 10
            let text1Length = SharedUIManager.instance.getStringLength("\(element.currency!)\(element.price!)", fontName: "Lato-Light", fontSize:SharedUIManager.instance.elementView_titleSize)
            let xposition:CGFloat = ( frame.width - text1Length ) / 2
            
            textPrice1 = UILabel(frame:CGRectMake(xposition, ypos, text1Length, (SharedUIManager.instance.elementView_titleSize + 2)))
            textPrice1!.textColor = textColor
            textPrice1!.textAlignment = NSTextAlignment.Center
            textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
            textPrice1!.text = "\(element.currency!)\(element.price!)"
            self.addSubview(textPrice1!)
            
            let lineView = UIView(frame: CGRectMake(xposition, (ypos + 20), (text1Length + 1), 1))
            lineView.backgroundColor = textColor
            self.addSubview(lineView)
            
            ypos += SharedUIManager.instance.elementView_titleSize
            textPrice2 = UILabel(frame: CGRectMake(0, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2)))
            textPrice2!.textColor = textColor
            textPrice2!.textAlignment = NSTextAlignment.Center
            textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
            textPrice2!.text = "\(element.currency!)\(element.listPrice!)"
            self.addSubview(textPrice2!)
            ypos += 40
            
            //height += 60
//            bg!.frame = CGRectMake(0, bg!.frame.origin.y, bg!.frame.width, height)
            
        } else if element.hasPrice && element.hasFromPrice {
            
            //var height:CGFloat = 0
//            bg = UIView(frame: CGRectMake(0, ypos, (frame.width), 1))
//            bg!.backgroundColor = decorationColor
//            self.addSubview(bg!)
            //height += 10
            
            //ypos += 10
            textPrice1 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_titleSize + 2)))
            textPrice1!.textColor = textColor
            textPrice1!.textAlignment = NSTextAlignment.Center
            textPrice1!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_titleSize)
            textPrice1!.text = NSLocalizedString("From", comment: "From")
            self.addSubview(textPrice1!)
            
            ypos += SharedUIManager.instance.elementView_titleSize
            textPrice2 = UILabel(frame: CGRectMake(5, ypos, frame.width, (SharedUIManager.instance.elementView_priceTitleSize + 2)))
            textPrice2!.textColor = textColor
            textPrice2!.textAlignment = NSTextAlignment.Center
            textPrice2!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_priceTitleSize)
            textPrice2!.text = "\(element.currency!)\(element.price!)"
            self.addSubview(textPrice2!)
            ypos += 40
            
            //height += 60
//            bg!.frame = CGRectMake(0, bg!.frame.origin.y, bg!.frame.width, height)
        }
        
        
        whiteBackground2 = UIView(frame: CGRectMake(0, ypos, frame.width, 125))
        whiteBackground2!.backgroundColor = UIColor.whiteColor()
        self.addSubview(whiteBackground2!)
        
        
        
        var siteAvatarSize:CGFloat = 50
        siteAvatar = BNUIImageView(frame: CGRectMake(5, (5), siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        self.addSubview(siteAvatar!)
        
        if let organization = site!.organization {
            if organization.media.count > 0 {
                BNAppSharedManager.instance.networkManager.requestImageData(site!.organization!.media[0].url!, image: siteAvatar)
                siteAvatar!.cover!.backgroundColor = site!.organization!.media[0].vibrantColor!
            } else {
                siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
                siteAvatar!.showAfterDownload()
            }
        } else  {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        siteAvatarSize = 0
        siteLocation = SiteView_Location(frame: CGRectMake((siteAvatarSize + 5), ypos, (frame.width - (siteAvatarSize + 20)), 0), father: nil)
        siteLocation!.updateForSite(site!)
        siteLocation!.map!.alpha = 0
        siteLocation!.backgroundColor = UIColor.clearColor()
        self.addSubview(siteLocation!)
        
        ypos += siteLocation!.yStop
        whiteBackground2!.frame = CGRectMake(0, whiteBackground2!.frame.origin.y, frame.width, siteLocation!.yStop)
        
        biinLogo = BNUIBiinMiniView(frame: CGRectMake((frame.width - 50), ypos, 100, 30), color:textColor!)
        self.addSubview(biinLogo!)
        
        downloadLbl = UILabel(frame: CGRectMake(10, (ypos - 2), (self.frame.width - 20), 30))
        downloadLbl!.font = UIFont(name: "Lato-Light", size: 14)
        downloadLbl!.textColor = UIColor.whiteColor()
        downloadLbl!.text = NSLocalizedString("Download", comment: "Download")
        self.addSubview(downloadLbl!)
        
        ypos += 30
        self.frame = CGRectMake(80, 50, frame.width, ypos)
    }
    
    convenience init(frame: CGRect, site:BNSite) {
        self.init(frame:frame)
        
        self.backgroundColor = site.media[0].vibrantColor!
        
        
        if site.useWhiteText {
            textColor = UIColor.whiteColor()
            decorationColor = site.media[0].vibrantDarkColor
        } else {
            textColor = UIColor.whiteColor()
            decorationColor = site.media[0].vibrantDarkColor
        }
        
        self.layer.borderColor = site.media[0].vibrantColor!.CGColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        
        
        var ypos:CGFloat = 0
        image = BNUIImageView(frame: CGRectMake(0, ypos, 320, 320), color:site.media[0].vibrantColor!)
        self.addSubview(image!)
        
        if site.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site.media[0].url!, image: image!)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
        
        ypos += 320
        
        whiteBackground2 = UIView(frame: CGRectMake(0, ypos, frame.width, 125))
        whiteBackground2!.backgroundColor = UIColor.whiteColor()
        self.addSubview(whiteBackground2!)
        
        
        
        var siteAvatarSize:CGFloat = 50
        siteAvatar = BNUIImageView(frame: CGRectMake(5, (5), siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        self.addSubview(siteAvatar!)
        
        if let organization = site.organization {
            if organization.media.count > 0 {
                BNAppSharedManager.instance.networkManager.requestImageData(site.organization!.media[0].url!, image: siteAvatar)
                siteAvatar!.cover!.backgroundColor = site.organization!.media[0].vibrantColor!
            } else {
                siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
                siteAvatar!.showAfterDownload()
            }
        } else  {
            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        siteAvatarSize = 0
        siteLocation = SiteView_Location(frame: CGRectMake((siteAvatarSize + 5), ypos, (frame.width - (siteAvatarSize + 20)), 0), father: nil)
        siteLocation!.updateForSite(site)
        siteLocation!.map!.alpha = 0
        siteLocation!.backgroundColor = UIColor.clearColor()
        self.addSubview(siteLocation!)
        
        ypos += siteLocation!.yStop
        whiteBackground2!.frame = CGRectMake(0, whiteBackground2!.frame.origin.y, frame.width, siteLocation!.yStop)
        
        biinLogo = BNUIBiinMiniView(frame: CGRectMake((frame.width - 50), ypos, 100, 30), color:textColor!)
        self.addSubview(biinLogo!)
        
        downloadLbl = UILabel(frame: CGRectMake(10, (ypos - 2), (self.frame.width - 20), 30))
        downloadLbl!.font = UIFont(name: "Lato-Light", size: 14)
        downloadLbl!.textColor = UIColor.whiteColor()
        downloadLbl!.text = NSLocalizedString("Download", comment: "Download")
        self.addSubview(downloadLbl!)
        
        ypos += 30
        self.frame = CGRectMake(80, 50, frame.width, ypos)
    }
    
    func clean() {
        
        textColor = nil
        decorationColor = nil
        image?.removeFromSuperview()
        percentageView?.removeFromSuperview()
        title?.removeFromSuperview()
        subTitle?.removeFromSuperview()
        
        lineView?.removeFromSuperview()
        siteAvatar?.removeFromSuperview()
        
        textPrice1?.removeFromSuperview()
        textPrice2?.removeFromSuperview()
        bg?.removeFromSuperview()
        whiteBackground2?.removeFromSuperview()
        siteLocation?.clean()
        siteLocation?.removeFromSuperview()
        biinLogo?.removeFromSuperview()
        downloadLbl!.removeFromSuperview()
    }
}
