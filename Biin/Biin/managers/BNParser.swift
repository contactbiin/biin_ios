//  BNParser.swift
//  biin
//  Created by Alison Padilla on 9/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNParser {
    
    init(){
    
    }

    class func findBool(name:String, dictionary:NSDictionary) -> Bool {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return true
        } else {
            return false
        }
    }
    
    class func findInt(name:String, dictionary:NSDictionary) ->Int? {
        if let intString = dictionary[name]  {
            return Int(intString as! String)
        }
        
        return 0
    }
    
    class func findFloat(name:String, dictionary:NSDictionary) ->Float? {
        return NSString(string:(dictionary[name] as? String)!).floatValue
    }
    
    class func findString(name:String, dictionary:NSDictionary) ->String? {
        return dictionary[name] as? String
    }
    
    class func findNSDictionary(name:String, dictionary:NSDictionary) ->NSDictionary? {
        return dictionary[name] as? NSDictionary
    }
    
    class func findNSArray(name:String, dictionary:NSDictionary) ->NSArray? {
        return dictionary[name] as? NSArray
    }
    
    class func findNSUUID(name:String, dictionary:NSDictionary) ->NSUUID? {
        var uuid:NSUUID?
        uuid = NSUUID(UUIDString:(dictionary[name] as? String)!)
        return uuid
    }
    
    class func findNSDate(name:String, dictionary:NSDictionary) ->NSDate? {
         let value = dictionary[name] as? String
        
        if value != "none" {
            let date:NSDate? = NSDate(dateString:value!)
            return date
        } else  {
            return nil
        }
    }
    
    class func findNSDateWithBiinFormat(name:String, dictionary:NSDictionary) ->NSDate? {
        let value = dictionary[name] as? String
        
        if value != "none" {
            let date:NSDate? = NSDate(dateString_yyyyMMddZ: value!)
            return date
        } else  {
            return nil
        }
    }
    
    class func findBNBiinType(name:String, dictionary:NSDictionary) -> BNBiinType {
        let value:Int = self.findInt(name, dictionary: dictionary)!
        switch value {
        case 0:
            return BNBiinType.NONE
        case 1:
            return BNBiinType.EXTERNO
        case 2:
            return BNBiinType.INTERNO
        case 3:
            return BNBiinType.PRODUCT
        default:
            return BNBiinType.NONE
        }
    }
    
    class func findBNElementDetailType(name:String, dictionary:NSDictionary) -> BNElementDetailType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNElementDetailType.Title
        } else if value == 2 {
            return BNElementDetailType.Paragraph
        } else if value == 3 {
            return BNElementDetailType.Quote
        } else if value == 4 {
            return BNElementDetailType.ListItem
        } else if value == 5 {
            return BNElementDetailType.Link
        } else if value == 6 {
            return BNElementDetailType.PriceList
        } else {
            return BNElementDetailType.Title
        }
    }
    
    class func findBNStickerType(name:String, dictionary:NSDictionary) -> BNStickerType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNStickerType.CIRCLE_FREE
        } else if value == 2 {
            return BNStickerType.CIRCLE_SALE
        } else if value == 3 {
            return BNStickerType.CIRCLE_BEST_OFFER
        } else if value == 4 {
            return BNStickerType.CIRCLE_FREE_GIFT
        } else {
            return BNStickerType.NONE
        }
    }
    
    class func findNotificationType(name:String, dictionary:NSDictionary) -> BNNotificationType {
        let value = self.findInt(name, dictionary: dictionary)
        if value == 1 {
            return BNNotificationType.STIMULUS
        } else if value == 2 {
            return BNNotificationType.ENGAGE
        } else if value == 3{
            return BNNotificationType.CONVERT
        } else {
            return BNNotificationType.STIMULUS
        }
    }
    
    class func findMediaType(name:String, dictionary:NSDictionary) -> BNMediaType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNMediaType.Image
        } else if value == 2 {
            return BNMediaType.Video
        } else {
            return BNMediaType.Image
        }
    }
    
    class func findBNGiftStatue(name:String, dictionary:NSDictionary) -> BNGiftStatus {
        let value = self.findString(name, dictionary: dictionary)
        
        switch value! {
        case "SENT": return BNGiftStatus.SENT
        case "REFUSED": return .REFUSED
        case "SHARED": return .SHARED
        case "CLAIMED": return .CLAIMED
        case "APPROVED": return .APPROVED
        case "DELIVERED": return .DELIVERED
        default: return BNGiftStatus.NONE
        }
    }
    
    class func findBiinObjectType(name:String, dictionary:NSDictionary) -> BNBiinObjectType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNBiinObjectType.ELEMENT
        } else if value == 2 {
            return BNBiinObjectType.SHOWCASE
        } else {
            return BNBiinObjectType.NONE
        }
    }
    
    class func findUIColor(name:String, dictionary:NSDictionary) ->UIColor? {
        return self.colorFromString(dictionary[name] as? String)
    }
    
    class func findCurrency(name:String, dictionary:NSDictionary) -> String {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return "$"
        } else if value == 2 {
            return "￠"
        } else if value ==  3 {
            return "€"
        } else {
            return "$"
        }
    }
    
    class func colorFromString(color:String?)->UIColor? {
        
        if color == nil || color == "" {
            return UIColor.appTextColor()
        }
        
        var r = ""
        var g = ""
        var b = ""
    
        var counter = 0
        
        for c in (color!).characters {
            
            switch (c) {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if counter == 0 {
                    r.append(c)
                } else if counter == 1 {
                    g.append(c)
                } else if counter == 2 {
                    b.append(c)
                }
                continue
            case ",":
                counter += 1
                continue
            default:
                break
            }
        }
        
        return UIColor(red: (CGFloat(Int(r)!) / 255), green: (CGFloat(Int(g)!) / 255), blue:(CGFloat(Int(b)!) / 255), alpha: 1.0)
    }
    
    class func parseOrganizations(organizationsData:NSArray){
        
        for a in (0..<organizationsData.count) {
            
            if let organizationData = organizationsData.objectAtIndex(a) as? NSDictionary {
                
                let identifier = BNParser.findString("identifier", dictionary: organizationData)
                
                if BNAppSharedManager.instance.dataManager.organizations[identifier!] == nil {
                    
                    let organization = BNOrganization()
                    organization.identifier = identifier//BNParser.findString("identifier", dictionary: organizationData)
                    organization.name = BNParser.findString("name", dictionary: organizationData)
                    organization.brand = BNParser.findString("brand", dictionary: organizationData)
                    organization.extraInfo = BNParser.findString("extraInfo", dictionary: organizationData)
                    organization.organizationDescription = BNParser.findString("description", dictionary: organizationData)
                    organization.primaryColor = BNParser.findUIColor("primaryColor", dictionary:organizationData)
                    organization.secondaryColor = BNParser.findUIColor("secondaryColor", dictionary:organizationData)
                    
                    organization.hasNPS = BNParser.findBool("hasNPS", dictionary: organizationData)
                    
                    
                    if let mediaArray = BNParser.findNSArray("media", dictionary: organizationData) {
                        
                        
                        for b in (0..<mediaArray.count) {
                            //                                        for var i = 0; i < mediaArray?.count; i++ {
                            let mediaData = mediaArray.objectAtIndex(b) as! NSDictionary
                            let url = BNParser.findString("url", dictionary:mediaData)
                            let type = BNMediaType.Image// BNParser.findMediaType("mediaType", dictionary: mediaData)
                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)
                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)
                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)
                            let media = BNMedia(mediaType:type, url:url!, vibrantColor: vibrantColor!, vibrantDarkColor: vibrantDarkColor!, vibrantLightColor: vibrantLightColor!)
                            organization.media.append(media)
                        }
                    }
                    
                    organization.isLoyaltyEnabled = BNParser.findBool("isLoyaltyEnabled", dictionary: organizationData)
                    
                    if organization.isLoyaltyEnabled {
                        let loyalty = BNLoyalty()
                        let loyaltyData = BNParser.findNSDictionary("loyalty", dictionary: organizationData)
                        loyalty.isSubscribed = BNParser.findBool("isSubscribed", dictionary: loyaltyData!)
                        loyalty.points = BNParser.findInt("points", dictionary:loyaltyData!)!
                        loyalty.subscriptionDate = BNParser.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                        loyalty.level = BNParser.findInt("level", dictionary:loyaltyData!)!
                        organization.loyalty = loyalty
                    }
                    
                    BNAppSharedManager.instance.dataManager.receivedOrganization(organization)
                }
            }
        }
    }
    
    class func parseElements(elementsData:NSArray){
        
        for c in (0..<elementsData.count) {
            
            let elementData = elementsData.objectAtIndex(c) as! NSDictionary
            
            if let identifier = BNParser.findString("identifier", dictionary: elementData) {
            
                if BNAppSharedManager.instance.dataManager.elements[identifier] == nil {
                
                
                    let element = BNElement()
                    element.isDownloadCompleted = true
                    element.identifier = identifier//BNParser.findString("identifier", dictionary: elementData)
                    element.title = BNParser.findString("title", dictionary: elementData)
                    element.subTitle = BNParser.findString("subTitle", dictionary: elementData)
                    element.currency = BNParser.findCurrency("currencyType", dictionary: elementData)
                    element.detailsHtml = BNParser.findString("detailsHtml", dictionary: elementData)
                    
                    element.hasCallToAction = BNParser.findBool("hasCallToAction", dictionary: elementData)
                    if element.hasCallToAction {
                        element.callToActionURL = BNParser.findString("callToActionURL", dictionary: elementData)
                        element.callToActionTitle = BNParser.findString("callToActionTitle", dictionary: elementData)
                    }
                    
                    element.isTaxIncludedInPrice = BNParser.findBool("isTaxIncludedInPrice", dictionary: elementData)
                    
                    element.hasFromPrice = BNParser.findBool("hasFromPrice", dictionary: elementData)
                    if element.hasFromPrice {
                        element.fromPrice = BNParser.findString("fromPrice", dictionary: elementData)
                    }
                    
                    element.hasListPrice = BNParser.findBool("hasListPrice", dictionary: elementData)
                    if element.hasListPrice {
                        element.listPrice = BNParser.findString("listPrice", dictionary: elementData)
                    }
                    
                    element.hasDiscount = BNParser.findBool("hasDiscount", dictionary: elementData)
                    if element.hasDiscount {
                        element.discount = BNParser.findString("discount", dictionary: elementData)
                    }
                    
                    element.hasPrice = BNParser.findBool("hasPrice", dictionary: elementData)
                    if element.hasPrice {
                        element.price = BNParser.findString("price", dictionary: elementData)
                    }
                    
                    element.hasSaving = BNParser.findBool("hasSaving", dictionary: elementData)
                    if element.hasSaving {
                        element.savings = BNParser.findString("savings", dictionary: elementData)
                    }
                    
                    element.hasTimming = BNParser.findBool("hasTimming", dictionary: elementData)
                    if element.hasTimming {
                        element.initialDate = BNParser.findNSDate("initialDate", dictionary: elementData)
                        element.expirationDate = BNParser.findNSDate("expirationDate", dictionary: elementData)
                    }
                    
                    element.hasQuantity = BNParser.findBool("hasQuantity", dictionary: elementData)
                    if element.hasQuantity {
                        element.quantity = BNParser.findString("quantity", dictionary: elementData)
                        element.reservedQuantity = BNParser.findString("reservedQuantity", dictionary: elementData)
                        element.claimedQuantity = BNParser.findString("claimedQuantity", dictionary: elementData)
                        element.actualQuantity = BNParser.findString("actualQuantity", dictionary: elementData)
                    }
                    
                    element.isHighlight = BNParser.findBool("isHighlight", dictionary: elementData)
                    
                    if let mediaArray = BNParser.findNSArray("media", dictionary: elementData){
                        
                        if mediaArray.count == 0 {
                            //print("element with not media:\(element.identifier)")
                        }
                        
                        
                        for d in (0..<mediaArray.count) {
                            //                                    for var j = 0; j < mediaArray?.count; j++ {
                            let mediaData = mediaArray.objectAtIndex(d) as! NSDictionary
                            let url = BNParser.findString("url", dictionary: mediaData)!
                            let type = BNParser.findMediaType("mediaType", dictionary: mediaData)
                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)!
                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)!
                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)!
                            
                            var white:CGFloat = 0.0
                            var alpha:CGFloat = 0.0
                            _ = vibrantColor.getWhite(&white, alpha: &alpha)
                            
                            if white <= 0.7 {
                                element.useWhiteText = true
                                
                            }
                            
                            let media = BNMedia(mediaType: type, url:url, vibrantColor: vibrantColor, vibrantDarkColor: vibrantDarkColor, vibrantLightColor:vibrantLightColor)
                            element.media.append(media)
                        }
                    }
                    
//                    if let categories = BNParser.findNSArray("categories", dictionary: elementData){
//                        
//                        
//                        for e in (0..<categories.count) {
//                            //                                    for var j = 0; j < categories?.count; j++ {
//                            let categoryData = categories.objectAtIndex(e) as! NSDictionary
//                            let identifier = BNParser.findString("identifier", dictionary: categoryData)!
//                            //BNAppSharedManager.instance.dataManager.addElementToCategory(identifier, element:element)
//                        }
//                    }
                    
                    element.collectCount = BNParser.findInt("collectCount", dictionary: elementData)!
                    element.userCollected = BNParser.findBool("userCollected", dictionary: elementData)
                    element.userLiked = BNParser.findBool("userLiked", dictionary: elementData)
                    element.userShared = BNParser.findBool("userShared", dictionary: elementData)
                    element.userViewed = BNParser.findBool("userViewed", dictionary: elementData)
                    
                    BNAppSharedManager.instance.dataManager.receivedElement(element)
                }
            }
        }
    }
    
    class func parseSites(sitesData:NSArray) {
        
        for f in (0..<sitesData.count) {
            //                            for var i = 0; i < sitesData.count; i++ {
            if let siteData = sitesData.objectAtIndex(f) as? NSDictionary {
                
                
                let identifier = BNParser.findString("identifier", dictionary: siteData)
                
                if !BNAppSharedManager.instance.dataManager.isSiteStored(identifier!) {
                    
                    
                    let site = BNSite()
                    site.identifier = identifier//BNParser.findString("identifier", dictionary: siteData)
                    site.organizationIdentifier = BNParser.findString("organizationIdentifier", dictionary: siteData)
                    site.proximityUUID = BNParser.findNSUUID("proximityUUID", dictionary: siteData)
                    site.major = BNParser.findInt("major", dictionary: siteData)
                    site.title = BNParser.findString("title", dictionary: siteData)
                    site.subTitle = BNParser.findString("subTitle", dictionary: siteData)
                    site.country = BNParser.findString("country", dictionary: siteData)
                    site.state = BNParser.findString("state", dictionary: siteData)
                    site.city = BNParser.findString("city", dictionary: siteData)
                    site.zipCode = BNParser.findString("zipCode", dictionary: siteData)
                    site.streetAddress1 = BNParser.findString("streetAddress1", dictionary: siteData)
                    site.streetAddress2 = BNParser.findString("streetAddress2", dictionary: siteData)
                    site.phoneNumber = BNParser.findString("phoneNumber", dictionary: siteData)
                    site.email = BNParser.findString("email", dictionary: siteData)
                    site.nutshell = BNParser.findString("nutshell", dictionary: siteData)
                    site.showInView = true
                    site.userShared = BNParser.findBool("userShared", dictionary: siteData)
                    site.userFollowed = BNParser.findBool("userFollowed", dictionary: siteData)
                    site.userLiked = BNParser.findBool("userLiked", dictionary: siteData)
                    site.latitude = BNParser.findFloat("latitude", dictionary:siteData)
                    site.longitude = BNParser.findFloat("longitude", dictionary:siteData)
                    site.siteSchedule = BNParser.findString("siteSchedule", dictionary: siteData)
                    
                    
                    
                    //print("site:\(site.identifier!), name:\(site.title!), location:\(site.city!), major:\(site.major!)")
                    
                    
                    if let neighbors = BNParser.findNSArray("neighbors", dictionary: siteData){
                        
                        if neighbors.count > 0{
                            
                            site.neighbors = Array<String>()
                            for g in (0..<neighbors.count) {
                                //                                            for var i = 0; i < neighbors?.count; i++ {
                                let neighborData = neighbors.objectAtIndex(g) as! NSDictionary
                                let neighbor = BNParser.findString("siteIdentifier", dictionary:neighborData)
                                site.neighbors!.append(neighbor!)
                            }
                        }
                    }
                    
                    if let mediaArray = BNParser.findNSArray("media", dictionary: siteData) {
                        
                        
                        for h in (0..<mediaArray.count) {
                            
                            let mediaData = mediaArray.objectAtIndex(h) as! NSDictionary
                            let url = BNParser.findString("url", dictionary:mediaData)!
                            let type = BNMediaType.Image// BNParser.findMediaType("mediaType", dictionary: mediaData)
                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)!
                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)!
                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)!
                            
                            var white:CGFloat = 0.0
                            var alpha:CGFloat = 0.0
                            _ = vibrantColor.getWhite(&white, alpha: &alpha)
                            
                            if white <= 0.7 {
                                site.useWhiteText = true
                            }
                            
                            let media = BNMedia(mediaType: type, url:url, vibrantColor: vibrantColor, vibrantDarkColor: vibrantDarkColor, vibrantLightColor:vibrantLightColor)
                            site.media.append(media)
                        }
                    }
                    
                    if let showcases = BNParser.findNSArray("showcases", dictionary: siteData) {
                        
                        //site.showcases = Array<BNShowcase>()
                        
                        
                        for i in (0..<showcases.count) {
                            if let showcaseData = showcases.objectAtIndex(i) as? NSDictionary {
                                
//                                let showcase = BNShowcase()
//                                showcase._id = BNParser.findString("_id", dictionary: showcaseData)
                                
                                if let showcase_identifier = BNParser.findString("identifier", dictionary: showcaseData) {
                                    site.showcases.append(showcase_identifier)
                                }
                                /*
                                showcase.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                                showcase.title = BNParser.findString("title", dictionary: showcaseData)
                                showcase.subTitle = BNParser.findString("subTitle", dictionary: showcaseData)
                                showcase.elements_quantity = BNParser.findInt("elements_quantity", dictionary: showcaseData)!
                                
                                if let elements = BNParser.findNSArray("elements", dictionary: showcaseData) {
                                    
                                    for j in (0..<elements.count) {
                                        
                                        let elementData:NSDictionary = elements.objectAtIndex(j) as! NSDictionary
                                        let element = BNElement()
                                        element._id = BNParser.findString("_id", dictionary: elementData)
                                        element.identifier = BNParser.findString("identifier", dictionary: elementData)
                                        //element.userViewed = BNParser.findBool("userViewed", dictionary: elementData)
                                        element.showcase = showcase
                                        showcase.elements.append(element)
                                    }
                                }
                                
                                showcase.site = site
                                site.showcases!.append(showcase)
                                BNAppSharedManager.instance.dataManager.receivedShowcase(showcase)
                                 */
                            }
                        }
                        
                    }
                    
                    if let notices = BNParser.findNSArray("notices", dictionary: siteData) {
                        for notice in (0..<notices.count) {
                            site.notices.append((notices[notice] as! String))
                        }
                    }
                    
                    if let biins = BNParser.findNSArray("biins", dictionary: siteData) {
                        
                        
                        for k in (0..<biins.count) {
                            //                                        for var j = 0; j < biins?.count; j++ {
                            if let biinData = biins.objectAtIndex(k) as? NSDictionary {
                                let biin = BNBiin()
                                biin.identifier = BNParser.findString("identifier", dictionary: biinData)
                                biin.major = site.major
                                biin.minor = BNParser.findInt("minor", dictionary: biinData)
                                biin.proximityUUID = site.proximityUUID
                                biin.venue = BNParser.findString("venue", dictionary: biinData)
                                biin.name = BNParser.findString("name", dictionary: biinData)
                                biin.biinType = BNParser.findBNBiinType("biinType", dictionary: biinData)
                                biin.site = site
                                
                                if let children = BNParser.findNSArray("children", dictionary: biinData){
                                    
                                    if children.count > 0 {
                                        
                                        biin.children = Array<Int>()
                                        
                                        for m in (0..<children.count) {
                                            let child = Int(((children.objectAtIndex(m) as? String))!)
                                            biin.children!.append(child!)
                                        }
                                    }
                                }
                                
                                if let objects = BNParser.findNSArray("objects", dictionary: biinData){
                                    
                                    if objects.count > 0 {
                                        
                                        biin.objects = Array<BNBiinObject>()
                                        
                                        for n in (0..<objects.count) {
                                            //                                                    for var k = 0; k < objects!.count; k++ {
                                            if let objectData = objects.objectAtIndex(n) as? NSDictionary {
                                                let object = BNBiinObject()
                                                object._id = BNParser.findString("_id", dictionary: objectData)
                                                object.identifier = BNParser.findString("identifier", dictionary: objectData)
                                                object.isDefault = BNParser.findBool("isDefault", dictionary: objectData)
                                                object.onMonday = BNParser.findBool("onMonday", dictionary: objectData)
                                                object.onTuesday = BNParser.findBool("onTuesday", dictionary: objectData)
                                                object.onWednesday = BNParser.findBool("onWednesday", dictionary: objectData)
                                                object.onThursday = BNParser.findBool("onThursday", dictionary: objectData)
                                                object.onFriday = BNParser.findBool("onFriday", dictionary: objectData)
                                                object.onSaturday = BNParser.findBool("onSaturday", dictionary: objectData)
                                                object.onSunday = BNParser.findBool("onSunday", dictionary: objectData)
                                                object.startTime = BNParser.findFloat("startTime", dictionary: objectData)!
                                                object.endTime = BNParser.findFloat("endTime", dictionary: objectData)!
                                                object.hasTimeOptions = BNParser.findBool("hasTimeOptions", dictionary: objectData)
                                                object.hasNotification = BNParser.findBool("hasNotification", dictionary: objectData)
                                                object.notification = BNParser.findString("notification", dictionary: objectData)
                                                object.isUserNotified = BNParser.findBool("isUserNotified", dictionary: objectData)
                                                object.isCollected = BNParser.findBool("isCollected", dictionary: objectData)
                                                object.objectType = BNParser.findBiinObjectType("objectType", dictionary: objectData)
                                                
                                                //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
                                                object.major = biin.major!
                                                object.minor = biin.minor!
                                                
                                                biin.objects!.append(object)
                                            }
                                        }
                                    }
                                }
                                site.biins.append(biin)
                            }
                        }
                        
                    }
                    
                    BNAppSharedManager.instance.dataManager.receivedSite(site)
                }
            }
        }
    }
    
    class func parseCategories(categoriesData:NSArray) {
        
        var categories = Array<BNCategory>()
        
        for o in (0..<categoriesData.count) {
            
            let categoryData = categoriesData.objectAtIndex(o) as! NSDictionary
            let category = BNCategory(identifier: BNParser.findString("identifier", dictionary: categoryData)!)
            
            if let elements = BNParser.findNSArray("elements", dictionary: categoryData) {
                for p in (0..<elements.count) {
                    
                    let elementData = elements.objectAtIndex(p) as! NSDictionary
                    
                    if let identifier = BNParser.findString("identifier", dictionary: elementData) {
                        if let showcaseIdentifier = BNParser.findString("showcaseIdentifier", dictionary: elementData) {
                            if let siteIdentifier = BNParser.findString("siteIdentifier", dictionary: elementData) {
                                let highlight = BNElementRelationShip(identifier: identifier, showcase: showcaseIdentifier, site: siteIdentifier)
                                category.elements.append(highlight)
                            }
                        }
                    }
                }
            }
            
            categories.append(category)
        }
        
        BNAppSharedManager.instance.dataManager.receivedCategories(categories)
    }
    
    class func parseHightlights(hightlightsData:NSArray) {
        
        var highlights = Array<BNElementRelationShip>()
        
        for q in (0..<hightlightsData.count){
            
            let hightlightData = hightlightsData.objectAtIndex(q) as! NSDictionary
            
            if let identifier = BNParser.findString("identifier", dictionary: hightlightData) {
                if let showcaseIdentifier = BNParser.findString("showcaseIdentifier", dictionary: hightlightData) {
                    if let siteIdentifier = BNParser.findString("siteIdentifier", dictionary: hightlightData) {
                        let highlight = BNElementRelationShip(identifier: identifier, showcase: showcaseIdentifier, site: siteIdentifier)
                        highlights.append(highlight)
                    }
                }
            }
        }
        
        BNAppSharedManager.instance.dataManager.receivedHightlight(highlights)
    }
    
    class func parseNearbySites(nearbySitesData:NSArray) {
        for r in (0..<nearbySitesData.count) {
            if let nearbySiteData = nearbySitesData.objectAtIndex(r) as? NSDictionary {
                let identifier = BNParser.findString("identifier", dictionary: nearbySiteData)
                BNAppSharedManager.instance.dataManager.nearbySites.append(identifier!)
            }
        }
    }
    
    class  func parseFavorites(favoritesData:NSDictionary) {
        if let sitesData = BNParser.findNSArray("sites", dictionary: favoritesData) {
            for s in (0..<sitesData.count) {
                if let siteData = sitesData.objectAtIndex(s) as? NSDictionary {
                    let identifier = BNParser.findString("identifier", dictionary: siteData)
                    BNAppSharedManager.instance.dataManager.favoritesSites.append(identifier!)
                }
            }
        }
        
        if let elementsData = BNParser.findNSArray("elements", dictionary: favoritesData) {
            for t in (0..<elementsData.count) {
                if let elementData = elementsData.objectAtIndex(t) as? NSDictionary {
                    if let identifier = BNParser.findString("identifier", dictionary: elementData) {
                        if let showcaseIdentifier = BNParser.findString("showcaseIdentifier", dictionary: elementData) {
                            if let siteIdentifier = BNParser.findString("siteIdentifier", dictionary: elementData) {
                                let elementReleationShip = BNElementRelationShip(identifier: identifier, showcase: showcaseIdentifier, site: siteIdentifier)
                                BNAppSharedManager.instance.dataManager.favoritesElements.append(elementReleationShip)
                            }
                        }
                    }
                }
            }
        }
    }
    
    class func parseShowcases(showcasesData:NSArray){
        for u in (0..<showcasesData.count) {
            if let showcaseData = showcasesData.objectAtIndex(u) as? NSDictionary {
                let showcase = BNShowcase()
                showcase.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                showcase.title = BNParser.findString("title", dictionary: showcaseData)
                if let elementsData = BNParser.findNSArray("elements", dictionary: showcaseData) {
                    for v in (0..<elementsData.count) {
                        if let elementData = elementsData.objectAtIndex(v) as? NSDictionary {
                            if let elementIdentifier = BNParser.findString("identifier", dictionary: elementData) {
                                showcase.elements.append(elementIdentifier)
                            }
                        }
                    }
                }
                BNAppSharedManager.instance.dataManager.receivedShowcase(showcase)
            }
        }
    }
    
    class func parseNotices(noticesData:NSArray) {
        if noticesData.count > 0 {
            
            var notices = Array<BNNotice>()
            
            for nd in (0..<noticesData.count) {
                if let noticeData = noticesData.objectAtIndex(nd) as? NSDictionary {
                    
                    let identifier = BNParser.findString("identifier", dictionary: noticeData)
                    let elementIdentifier = BNParser.findString("elementIdentifier", dictionary: noticeData)
                    let name = BNParser.findString("name", dictionary: noticeData)
                    let message = BNParser.findString("message", dictionary: noticeData)
                
                    let notice = BNNotice(identifier:identifier!, elementIdentifier: elementIdentifier!, name: name!, message: message!)
                    notice.onMonday = BNParser.findBool("onMonday", dictionary: noticeData)
                    notice.onTuesday = BNParser.findBool("onTuesday", dictionary: noticeData)
                    notice.onWednesday = BNParser.findBool("onWednesday", dictionary: noticeData)
                    notice.onThursday = BNParser.findBool("onThursday", dictionary: noticeData)
                    notice.onFriday = BNParser.findBool("onFriday", dictionary: noticeData)
                    notice.onSaturday = BNParser.findBool("onSaturday", dictionary: noticeData)
                    notice.onSunday = BNParser.findBool("onSunday", dictionary: noticeData)
                    
                    notice.startTime = BNParser.findFloat("startTime", dictionary: noticeData)!
                    notice.endTime = BNParser.findFloat("endTime", dictionary: noticeData)!
                    
                    notices.append(notice)
                }
            }
            //Save or update notices.
            BNAppSharedManager.instance.notificationManager.addNotices(notices)
        }
    }
}