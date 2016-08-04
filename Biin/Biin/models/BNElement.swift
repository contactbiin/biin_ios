//  BNElement.swift
//  Biin
//  Created by Esteban Padilla on 8/23/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNElement:NSObject {
    
    //Nutshell
    //var _id:String?
    var identifier:String?
    var position:Int?
    var title:String?
    var subTitle:String?
    var nutshellDescriptionTitle:String?
    var nutshellDescription:String?

    //Hightlights - Price
    var isTaxIncludedInPrice = false
    var hasFromPrice = false
    var fromPrice:String?
    var hasListPrice:Bool = false
    var listPrice:String?
    var hasDiscount = false
    var discount:String?
    var hasPrice = false //after discount applied
    var price:String? //after discount applied
    var hasSaving = false
    var savings:String?
    var currency:String?
    
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
    var stars:Float = 0
    var useWhiteText = false
    
    //Gallery
    var media:Array<BNMedia> = Array<BNMedia>()
    var gallery:Array<UIImageView> = Array<UIImageView>()

    //Notification
    //var activateNotification = false
    //var notifications:Array<BNNotification>?
    
    //Social interaction
    //var biinedCount:Int = 0       //How many time users have biined this element.
    var collectCount:Int = 0   //How many time users have collect this element.
    var commentedCount:Int = 0    //How many time users have commented this element.
    
    //var userBiined = false
    var userCommented = false
    var userViewed = false
    var userShared = false
    var userCollected = false
    var userLiked = false
    
    //Download management
    var isDownloadCompleted = false
    var isHighlight:Bool = false
//    var siteIdentifier:String?
    var categoriesIdentifiers:Array<String>?
    var showcase:BNShowcase?
    
    var detailsHtml:String?
    
    var hasCallToAction = false
    var callToActionURL:String?
    var callToActionTitle:String?
    var isRemovedFromShowcase = false
    
    //var biinieProximity:Float? //same as the site where it belongs
    
    override init() {
        super.init()
    }
    
    deinit {
        
    }
    
    func clone()->BNElement {
        let clone = BNElement()

        //if let value = self._id { clone._id = value }
        if let value = self.identifier { clone.identifier = value }
        if let value = self.position { clone.position = value }
        if let value = self.title { clone.title = value }
        if let value = self.subTitle { clone.subTitle = value }
        if let value = self.nutshellDescriptionTitle { clone.nutshellDescriptionTitle = value }
        if let value = self.nutshellDescription { clone.nutshellDescription = value }
        clone.hasCallToAction = self.hasCallToAction
        if let value = self.callToActionURL { clone.callToActionURL = value }
        if let value = self.callToActionTitle { clone.callToActionTitle = value }
        clone.isTaxIncludedInPrice = self.isTaxIncludedInPrice
        clone.hasFromPrice = self.hasFromPrice
        if let value = self.fromPrice { clone.fromPrice = value }
        clone.hasListPrice = self.hasListPrice
        if let value = self.listPrice { clone.listPrice = value }
        clone.hasDiscount = self.hasDiscount
        if let value = self.discount { clone.discount = value }
        clone.hasPrice = self.hasPrice
        if let value = self.price { clone.price = value }
        clone.hasSaving = self.hasSaving
        if let value = self.savings { clone.savings = value }
        if let value = self.currency { clone.currency = value }
        clone.hasTimming = self.hasTimming
        if let value = self.initialDate { clone.initialDate = value }
        if let value = self.expirationDate { clone.expirationDate = value }
        clone.hasQuantity = self.hasQuantity
        if let value = self.quantity { clone.quantity = value }
        if let value = self.reservedQuantity { clone.reservedQuantity = value }
        if let value = self.claimedQuantity { clone.claimedQuantity = value }
        if let value = self.actualQuantity { clone.actualQuantity = value }
        clone.media = self.media
        //clone.activateNotification = self.activateNotification
        //if let value = self.notifications { clone.notifications = value }
        clone.collectCount = self.collectCount
        clone.commentedCount = self.commentedCount
        clone.userShared = self.userShared
        clone.userCommented = self.userCommented
        clone.userViewed = self.userViewed
        clone.userCollected = self.userCollected
        clone.userLiked = self.userLiked
        clone.isHighlight = self.isHighlight
        clone.isRemovedFromShowcase = self.isRemovedFromShowcase
//        if let value = self.siteIdentifier { clone.siteIdentifier = value }
        if let value = self.showcase { clone.showcase = value }
        clone.stars = self.stars
        clone.useWhiteText = self.useWhiteText
        if let value = self.categoriesIdentifiers { clone.categoriesIdentifiers = value }
        if let value = self.detailsHtml { clone.detailsHtml = value }

        return clone
    }
}

struct BNElementRelationShip {
    var identifier = "", showcase = "", site = ""
}
