//  StickerView.swift
//  Biin
//  Created by Esteban Padilla on 8/5/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class StickerView:UIView {
    
    //var type:BNStickerType = BNStickerType.Bottom
    var message = BNStickerMessage.Sale
    var tagLbl:UILabel?
    var text:String?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, position:CGPoint, type:BNStickerType, message:BNStickerMessage, text:String? ) {
        
        self.init(frame:frame)
        //self.type = type
        self.message = message
        self.text = text
        //setSignType(position)
//        self.backgroundColor = color
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
    }
    
    /*
    func setSignType(position:CGPoint) {
        switch type {
        case .Bottom:
            self.frame = CGRectMake(position.x, position.y, 65, 25)
            setSignMessage(CGRectMake(0, 0, 65, 25), size:12)

        case .Top:
            self.frame = CGRectMake(position.x, position.y, 100, 35)
            setSignMessage(CGRectMake(0, 0, 100, 35), size:20)

        case .Element:
            self.frame = CGRectMake(position.x, position.y, 100, 30)
            setSignMessage(CGRectMake(0, 0, 100, 30), size:15)
        default:
            break
        }
    }
    */
    
    func setSignMessage(frame:CGRect, size:CGFloat){
        
        tagLbl = UILabel(frame: frame)
        self.addSubview(tagLbl!)
        tagLbl!.textAlignment = NSTextAlignment.Center
        tagLbl!.font = UIFont(name: "Lato-Black", size:size)

        switch message {
        case .Custom:
                tagLbl!.text = self.text
                tagLbl!.textColor = UIColor.whiteColor()
                self.backgroundColor = UIColor.bnSignRed()
        case .Sale:
            tagLbl!.text = "SALE"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignRed()
        case .Gift:
            tagLbl!.text = "GIFT"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignBlue()
        case .Free:
            tagLbl!.text = "FREE"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignRed()
        case .TopDeals:
            tagLbl!.text = "TOP DEALS"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignGreen()
        case .MostPopular:
            tagLbl!.text = "MOST POPULAR"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignBlue()
        case .TodayOnly:
            tagLbl!.text = "TODAY ONLY"
            tagLbl!.textColor = UIColor.bnBlack()
            self.backgroundColor = UIColor.bnSignYellow()
        case .BestPrice:
            tagLbl!.text = "BEST PRICE"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignBlue()
        case .BestDeal:
            tagLbl!.text = "BEST DEAL"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignOrange()
        case .BuyNow:
            tagLbl!.text = "BUY NOW"
            tagLbl!.textColor = UIColor.bnBlack()
            self.backgroundColor = UIColor.bnSignYellow()
        case .Hot:
            tagLbl!.text = "HOT"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignRed()
        case .FreeGift:
            tagLbl!.text = "FREE GIFT"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignGreen()
        case .SpecialOffer:
            tagLbl!.text = "SPECIAL OFFER"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignOrange()
        case .Discounts:
            tagLbl!.text = "DISCOUNTS"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignRed()
        case .CrazyPrice:
            tagLbl!.text = "CRAZY PRICE"
            tagLbl!.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor.bnSignRed()
        default:
            break
        }
        
        tagLbl!.sizeToFit()
        var width = tagLbl!.frame.width + 30
        var height = self.frame.height
        
        var xpos:CGFloat = 0.0
        /*
        if type == BNStickerType.Bottom {
            xpos = 150.0 - width
        } else {
//            xpos = 320.0 - width
        }
        */
        
        var ypos = self.frame.origin.y
        self.frame = CGRectMake(xpos, ypos, width, height)
        tagLbl!.frame = CGRectMake(0, 0, width, height)
    }
}

//enum BNStickerType {
//    case Bottom
//    case Top
//    case Element
//}

enum BNStickerMessage {
    case Custom
    case Sale
    case Gift
    case Free
    case TopDeals
    case MostPopular
    case TodayOnly
    case BestPrice
    case BestDeal
    case BuyNow
    case Hot
    case FreeGift
    case SpecialOffer
    case Discounts
    case CrazyPrice
}