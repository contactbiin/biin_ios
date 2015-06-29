//  ShareItView.swift
//  biin
//  Created by Esteban Padilla on 4/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ShareItView:UIView {
    
//    override init() {
//        super.init()
//    }
    
    var priceView:BNUIPricesView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, element:BNElement, site:BNSite?) {
        self.init(frame:frame)
        
        //var newElement = BNAppSharedManager.instance.dataManager.elements[element._id!]
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.appButtonColor().CGColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true

        var ypos:CGFloat = 30
        var hasPrice = false
        
        var image = BNUIImageView(frame: CGRectMake(0, ypos, 320, 320))
        
        if site!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(element.media[0].url!, image: image)
        } else {
            image.image =  UIImage(named: "noImage.jpg")
            image.showAfterDownload()
        }
        
        self.addSubview(image)

        ypos = 65
        if priceView != nil {
            priceView!.removeFromSuperview()
            priceView = nil
        }
        
        
        /*
        if element.hasPrice && !element.hasListPrice && !element.hasFromPrice {
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 40), price: "\(element.currency!)\(element.price!)", isMini:false)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
            
        } else if element.hasPrice && element.hasListPrice {
            
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 65), oldPrice:"\(element.currency!)\(element.listPrice!)", newPrice:"\(element.currency!)\(element.price!)", percentage:"\(element.discount!)%", isMini:false)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
        } else if element.hasPrice &&  element.hasFromPrice {
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 60), price: "\(element.currency!)\(element.price!)", from:     NSLocalizedString("From", comment: "From")
                , isMini:false)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
        }
        */
        
        
        
        
        if !element.hasPrice && element.hasDiscount {
            
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 40), price: "\(element.discount!)%", isMini:false, isDiscount:true)
            self.addSubview(priceView!)
            ypos += 40
            
        } else if element.hasPrice && !element.hasListPrice && !element.hasFromPrice {
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 40), price: "\(element.currency!)\(element.price!)", isMini:false, isDiscount:false)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
            
        } else if element.hasPrice && element.hasListPrice && element.hasDiscount {
            
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 65), oldPrice:"\(element.currency!)\(element.price!)", newPrice:"\(element.currency!)\(element.listPrice!)", percentage:"\(element.discount!)%", isMini:false, isHighlight:element.isHighlight)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
            
        } else if element.hasPrice && element.hasListPrice && element.hasDiscount {
            //TODO
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 65), oldPrice:"\(element.currency!)\(element.price!)", newPrice:"\(element.currency!)\(element.listPrice!)", isMini:false, isHighlight:element.isHighlight)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
            
        } else if element.hasPrice && element.hasFromPrice {
            
            //priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 70), oldPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.listPrice!)", newPrice:"\(elementMiniView!.element!.currency!)\(elementMiniView!.element!.price!)")
            priceView = BNUIPricesView(frame: CGRectMake(5, ypos, 100, 60), price: "\(element.currency!)\(element.price!)", from:NSLocalizedString("From", comment: "From")
                , isMini:false, isHighlight:element.isHighlight)
            self.addSubview(priceView!)
            hasPrice = true
            ypos += 40
        }

        
        
        

        
        ypos = 0
        var whiteBackground = UIView(frame: CGRectMake(0, ypos, frame.width, 60))
        whiteBackground.backgroundColor = UIColor.appMainColor()
        
        self.addSubview(whiteBackground)

        ypos += 6
        var title = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 28))
        title.font = UIFont(name:"Lato-Black", size:25)
        title.textColor = element.titleColor!
        title.text = element.title
        self.addSubview(title)
        
        ypos += 28
        var subTitle = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 16))
        subTitle.font = UIFont(name:"Lato-Light", size:13)
        subTitle.textColor = UIColor.appTextColor()
        subTitle.text = element.subTitle
        self.addSubview(subTitle)
        
        ypos = 360
        //var pricingDetails = ElementMiniView_PricingDetails(frame: CGRectMake(0, ypos, frame.width, 0), father: nil, element: element)
        //self.addSubview(pricingDetails)
        //pricingDetails.frame.origin.y = 350
        //ypos += pricingDetails.frame.height + 10
        
        var siteLocation = SiteView_Location(frame: CGRectMake(0, 330, 0, 0), father: nil)
        siteLocation.updateForSite(site!)
        siteLocation.map!.alpha = 0
        siteLocation.frame.origin.y = ypos
        self.addSubview(siteLocation)
        
        ypos += siteLocation.yStop
        ypos += 40
        
        var whiteBackground2 = UIView(frame: CGRectMake(0, ypos, frame.width, 35))
        whiteBackground2.backgroundColor = UIColor.biinColor()
        self.addSubview(whiteBackground2)
        
        var biinLogo = BNUIBiinMiniView(frame: CGRectMake((frame.width - 50), 3.5, 100, 30))
        whiteBackground2.addSubview(biinLogo)
        
        ypos += 35
        self.frame = CGRectMake(0, 0, frame.width, ypos)
    }
    
    convenience init(frame: CGRect, site:BNSite) {
        self.init(frame:frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.appBackground().CGColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        
        var ypos:CGFloat = 30
        var image = ShareEPSNetworking.cacheImages[site.media[0].url!]!
        var imageView = UIImageView(image: image)
        self.addSubview(imageView)
        imageView.frame = CGRectMake(0, ypos, 320, 320)
        
        ypos = 0
        var whiteBackground = UIView(frame: CGRectMake(0, ypos, frame.width, 60))
        whiteBackground.backgroundColor = UIColor.appMainColor()
        self.addSubview(whiteBackground)
        
        ypos += 6
        var title = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 28))
        title.font = UIFont(name:"Lato-Black", size:25)
        title.textColor = site.titleColor!
        title.text = site.title
        self.addSubview(title)
        
        ypos += 28
        var subTitle = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 16))
        subTitle.font = UIFont(name:"Lato-Light", size:13)
        subTitle.textColor = UIColor.appTextColor()
        subTitle.text = site.subTitle
        self.addSubview(subTitle)
        
        ypos = 370
        var siteLocation = SiteView_Location(frame: CGRectMake(0, ypos, 0, 0), father: nil)
        siteLocation.updateForSite(site)
        siteLocation.map!.alpha = 0
        siteLocation.frame.origin.y = ypos
        self.addSubview(siteLocation)
        
        ypos += 110
        var whiteBackground2 = UIView(frame: CGRectMake(0, ypos, frame.width, 35))
        whiteBackground2.backgroundColor = UIColor.biinColor()
        self.addSubview(whiteBackground2)
        
        var biinLogo = BNUIBiinMiniView(frame: CGRectMake((frame.width - 50), 3.5, 100, 30))
        whiteBackground2.addSubview(biinLogo)
        
        ypos += 35
        self.frame = CGRectMake(0, 0, frame.width, ypos)
    }
}
