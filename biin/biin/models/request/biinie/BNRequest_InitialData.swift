//  BNRequest_InitialData.swift
//  biin
//  Created by Esteban Padilla on 11/10/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit


class BNRequest_InitialData: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.InitialData
        self.errorManager = errorManager
        self.networkManager = networkManager

    }
    
    override func run() {
                
        self.start = NSDate()
        
        isRunning = true
        requestAttemps++
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let initialData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        
                        if let organizationsData = BNParser.findNSArray("organizations", dictionary: initialData) {
                            
                            NSLog("BIIN - Organization: \(organizationsData.count)")
                            
                            for var i = 0; i < organizationsData.count; i++ {
                                if let organizationData = organizationsData.objectAtIndex(i) as? NSDictionary {
                                    
                                    
                                    let identifier = BNParser.findString("identifier", dictionary: organizationData)
                                    
                                    if BNAppSharedManager.instance.dataManager.organizations[identifier!] == nil {
                                        
                                        let organization = BNOrganization()
                                        organization.identifier = identifier//BNParser.findString("identifier", dictionary: organizationData)
                                        organization.name = BNParser.findString("name", dictionary: organizationData)
                                        organization.brand = BNParser.findString("brand", dictionary: organizationData)
                                        organization.extraInfo = BNParser.findString("extraInfo", dictionary: organizationData)
                                        organization.organizationDescription = BNParser.findString("description", dictionary: organizationData)
                                        
                                        organization.hasNPS = BNParser.findBool("hasNPS", dictionary: organizationData)
                                        
                                        let mediaArray = BNParser.findNSArray("media", dictionary: organizationData)
                                        
                                        for var i = 0; i < mediaArray?.count; i++ {
                                            let mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                                            let url = BNParser.findString("url", dictionary:mediaData)
                                            let type = BNMediaType.Image// BNParser.findMediaType("mediaType", dictionary: mediaData)
                                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)
                                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)
                                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)
                                            let media = BNMedia(mediaType:type, url:url!, vibrantColor: vibrantColor!, vibrantDarkColor: vibrantDarkColor!, vibrantLightColor: vibrantLightColor!)
                                            organization.media.append(media)
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
                        
                        //Parse elements
                        if let elementsData = BNParser.findNSArray("elements", dictionary: initialData) {
                            
                            NSLog("BIIN - Elements: \(elementsData.count)")
                            
                            for var i = 0; i < elementsData.count; i++ {
                                let elementData = elementsData.objectAtIndex(i) as! NSDictionary
                                
                                let identifier = BNParser.findString("identifier", dictionary: elementData)
                                
                                if BNAppSharedManager.instance.dataManager.elements_by_identifier[identifier!] == nil {
                                    
                                    
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

                                    let mediaArray = BNParser.findNSArray("media", dictionary: elementData)
                                    
                                    if mediaArray!.count == 0 {
                                        print("element with not media:\(element.identifier)")
                                    }
                                    
                                    for var j = 0; j < mediaArray?.count; j++ {
                                        let mediaData = mediaArray!.objectAtIndex(j) as! NSDictionary
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
                                    
                                    let categories = BNParser.findNSArray("categories", dictionary: elementData)
                                    
                                    for var j = 0; j < categories?.count; j++ {
                                        let categoryData = categories!.objectAtIndex(j) as! NSDictionary
                                        let identifier = BNParser.findString("identifier", dictionary: categoryData)!
                                        BNAppSharedManager.instance.dataManager.addElementToCategory(identifier, element:element)
                                    }
                                    
                                    element.collectCount = BNParser.findInt("collectCount", dictionary: elementData)!
                                    element.userCollected = BNParser.findBool("userCollected", dictionary: elementData)
                                    element.userLiked = BNParser.findBool("userLiked", dictionary: elementData)
                                    element.userShared = BNParser.findBool("userShared", dictionary: elementData)
                                    element.userViewed = BNParser.findBool("userViewed", dictionary: elementData)
                                    
                                    BNAppSharedManager.instance.dataManager.receivedElement(element)
                                }
                            }
                        }
                        
                        if let sitesData = BNParser.findNSArray("sites", dictionary: initialData) {
                        
                            NSLog("BIIN - Sites: \(sitesData.count)")
                            
                            for var i = 0; i < sitesData.count; i++ {
                                if let siteData = sitesData.objectAtIndex(i) as? NSDictionary {
                                    
                                    
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
                                        
                                        let neighbors = BNParser.findNSArray("neighbors", dictionary: siteData)
                                        
                                        if neighbors?.count > 0{
                                            
                                            site.neighbors = Array<String>()
                                            
                                            for var i = 0; i < neighbors?.count; i++ {
                                                let neighborData = neighbors!.objectAtIndex(i) as! NSDictionary
                                                let neighbor = BNParser.findString("siteIdentifier", dictionary:neighborData)
                                                site.neighbors!.append(neighbor!)
                                            }
                                        }
                                        
                                        let mediaArray = BNParser.findNSArray("media", dictionary: siteData)
                                        
                                        for var i = 0; i < mediaArray?.count; i++ {
                                            let mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
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

                                        if let showcases = BNParser.findNSArray("showcases", dictionary: siteData) {
                                        
                                            site.showcases = Array<BNShowcase>()
                                            
                                            for var i = 0; i < showcases.count; i++ {
                                                if let showcaseData = showcases.objectAtIndex(i) as? NSDictionary {
                                                    
                                                    let showcase = BNShowcase()
                                                    showcase._id = BNParser.findString("_id", dictionary: showcaseData)
                                                    showcase.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                                                    showcase.title = BNParser.findString("title", dictionary: showcaseData)
                                                    showcase.subTitle = BNParser.findString("subTitle", dictionary: showcaseData)
                                                    showcase.elements_quantity = BNParser.findInt("elements_quantity", dictionary: showcaseData)!
                                                    
                                                    let elements = BNParser.findNSArray("elements", dictionary: showcaseData)
                                                    
                                                    for var i = 0; i < elements?.count; i++ {
                                                        
                                                        let elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                                                        let element = BNElement()
                                                        element._id = BNParser.findString("_id", dictionary: elementData)
                                                        element.identifier = BNParser.findString("identifier", dictionary: elementData)
                                                        //element.userViewed = BNParser.findBool("userViewed", dictionary: elementData)
                                                        element.showcase = showcase
                                                        showcase.elements.append(element)
                                                    }
                                                    
                                                    showcase.site = site
                                                    site.showcases!.append(showcase)
                                                    BNAppSharedManager.instance.dataManager.receivedShowcase(showcase)
                                                }
                                            }
                                        }
                                        
                                        let biins = BNParser.findNSArray("biins", dictionary: siteData)
                                        
                                        for var j = 0; j < biins?.count; j++ {
                                            if let biinData = biins!.objectAtIndex(j) as? NSDictionary {
                                                let biin = BNBiin()
                                                biin.identifier = BNParser.findString("identifier", dictionary: biinData)
                                                biin.major = site.major
                                                biin.minor = BNParser.findInt("minor", dictionary: biinData)
                                                biin.proximityUUID = site.proximityUUID
                                                biin.venue = BNParser.findString("venue", dictionary: biinData)
                                                biin.name = BNParser.findString("name", dictionary: biinData)
                                                biin.biinType = BNParser.findBNBiinType("biinType", dictionary: biinData)
                                                biin.site = site
                                                let children = BNParser.findNSArray("children", dictionary: biinData)
                                                
                                                if children?.count > 0 {
                                                    
                                                    biin.children = Array<Int>()
                                                    
                                                    for var i = 0; i < children?.count; i++ {
                                                        let child = Int(((children!.objectAtIndex(i) as? String))!)
                                                        biin.children!.append(child!)
                                                    }
                                                }
                                                
                                                let objects = BNParser.findNSArray("objects", dictionary: biinData)
                                                
                                                if objects!.count > 0 {
                                                    biin.objects = Array<BNBiinObject>()
                                                    for var k = 0; k < objects!.count; k++ {
                                                        if let objectData = objects!.objectAtIndex(k) as? NSDictionary {
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
                                                
                                                site.biins.append(biin)
                                            }
                                        }
                                    
                                        BNAppSharedManager.instance.dataManager.receivedSite(site)
                                    }
                                }
                            }
                        }
                        
                        //Parse categories
                        var categories = Array<BNCategory>()
                        if let categoriesData = BNParser.findNSArray("categories", dictionary: initialData) {
                        
                            NSLog("BIIN - Categories: \(categoriesData.count)")
                            
                            for var i = 0; i < categoriesData.count; i++ {
                                
                                let categoryData = categoriesData.objectAtIndex(i) as! NSDictionary
                                let category = BNCategory(identifier: BNParser.findString("identifier", dictionary: categoryData)!)

                                let elements = BNParser.findNSArray("elements", dictionary: categoryData)
                                
                                for var j = 0; j < elements?.count; j++ {
                                    
                                    let elementData = elements!.objectAtIndex(j) as! NSDictionary
                                    
                                    if let element_id = BNParser.findString("_id", dictionary: elementData) {
                                        category.elements[element_id] = BNAppSharedManager.instance.dataManager.elements_by_id[element_id]
                                    }
                                }
                                
                                categories.append(category)
                            }
                            
                            BNAppSharedManager.instance.dataManager.receivedCategories(categories)
                        }
                        
                        //Parse hightlights
                        if let hightlightsData = BNParser.findNSArray("highlights", dictionary: initialData) {
                        
                            var highlights = Array<BNElement>()
                            
                            for var i = 0; i < hightlightsData.count; i++ {
                                
                                let hightlightData = hightlightsData.objectAtIndex(i) as! NSDictionary
                                
                                if let element_id = BNParser.findString("_id", dictionary: hightlightData) {
                                    highlights.append(BNAppSharedManager.instance.dataManager.elements_by_id[element_id]!)
                                }
                            }
                            
                            BNAppSharedManager.instance.dataManager.receivedHightlight(highlights)
                            
                        }
                    }
                    
                    /*
                    let end = NSDate()
                    let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                    print("BNRequest_InitialData  \(timeInterval)  - \(self.requestString)")
                    */

                    self.inCompleted = true
                    self.networkManager!.removeFromQueue(self)
                    
                } else  {
                    
                    self.requestType = BNRequestType.ServerError
                    self.networkManager!.handleFailedRequest(self, error: error )
                }
            }
        })
    }
}
