//  BNElement.swift
//  Biin
//  Created by Esteban Padilla on 8/23/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNElement:NSObject {
    
    
    //TODO: jsonUrl only for testing, remove later
    var jsonUrl:String?
    
    //Element type
    var elementType:BNElementType?
    
    //Nutshell
    var _id:String?
    var identifier:String?
    var position:Int?
    var title:String?
    var subTitle:String?
    var nutshellDescriptionTitle:String?
    var nutshellDescription:String?
    
    //Colours
    var titleColor:UIColor?
//    var socialButtonsColor = UIColor.whiteColor()
    
    //Hightlights - Price
    var hasListPrice:Bool = false
    var listPrice:String?
    var hasDiscount:Bool = false
    var discount:String?
    var price:String?
    var savings:String?
    
   //Hightlights - Limited Time
    var hasTimming = false
    var initialDate:NSDate?
    var expirationDate:NSDate?
    
   //Hightlights - Quantity
    var hasQuantity = false
    var quantity:String?
    var reservedQuantity:String?
    var claimedQuantity:String?
    var actualQuantity:String?
    
    //Details
    var details:Array<BNElementDetail> = Array<BNElementDetail>()
    
    //Gallery
    var media:Array<BNMedia> = Array<BNMedia>()
    var gallery:Array<UIImageView> = Array<UIImageView>()

    //Sticker
    var hasSticker = false
    var sticker:BNSticker?
    
    //Notification
    var activateNotification = false
    var notifications:Array<BNNotification>?
    
    //Social interaction
    var biinedCount:Int = 0       //How many time users have biined this element.
    var commentedCount:Int = 0    //How many time users have commented this element.
    
    var userBiined = false
    var userCommented = false
    var userViewed = false
    var userShared = false
    
    //Download management
    var isDownloadCompleted = false
    
    override init() {
        super.init()
    }
    
    deinit {
        
    }
    
    func clone()->BNElement {
        var clone = BNElement()
        clone.jsonUrl = self.jsonUrl
        clone.elementType = self.elementType?
        clone._id = self._id?
        clone.identifier = self.identifier?
        clone.position = self.position?
        clone.title = self.title?
        clone.subTitle = self.subTitle?
        clone.nutshellDescriptionTitle = self.nutshellDescriptionTitle?
        clone.nutshellDescription = self.nutshellDescription?
        clone.titleColor = self.titleColor?
        clone.hasListPrice = self.hasListPrice
        clone.listPrice = self.listPrice?
        clone.hasDiscount = self.hasDiscount
        clone.discount = self.discount?
        clone.price = self.price?
        clone.savings = self.savings?
        clone.hasTimming = self.hasTimming
        clone.initialDate = self.initialDate?
        clone.expirationDate = self.expirationDate?
        clone.hasQuantity = self.hasQuantity
        clone.quantity = self.quantity?
        clone.reservedQuantity = self.reservedQuantity?
        clone.claimedQuantity = self.claimedQuantity?
        clone.actualQuantity = self.actualQuantity?
        clone.details = self.details
        clone.media = self.media
        clone.hasSticker = self.hasSticker
        clone.sticker = self.sticker?
        clone.activateNotification = self.activateNotification
        clone.notifications = self.notifications?
        clone.biinedCount = self.biinedCount
        clone.commentedCount = self.commentedCount
        clone.userBiined = self.userBiined
        clone.userShared = self.userShared
        clone.userCommented = self.userCommented
        clone.userViewed = self.userViewed
        return clone
    }
}

enum BNElementType {
    case Simple         //1
    case Informative    //2
    case Benefit        //3
}