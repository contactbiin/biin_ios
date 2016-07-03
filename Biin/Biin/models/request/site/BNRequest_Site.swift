//  BNRequest_Site.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_Site: BNRequest {
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, site:BNSite ){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.Site
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.site = site
    }

    override func run() {
        
        //self.start = NSDate()

        isRunning = true
        requestAttemps += 1

        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                let result = BNParser.findBool("result", dictionary: data)
                
                if result {
                    if let siteData = data["data"] as? NSDictionary {
                        
                        let new_site = BNSite()
                        new_site.biinieProximity = self.site!.biinieProximity!
                        new_site.jsonUrl = self.requestString
                        new_site.identifier = BNParser.findString("identifier", dictionary: siteData)
                        new_site.proximityUUID = BNParser.findNSUUID("proximityUUID", dictionary: siteData)
                        new_site.major = BNParser.findInt("major", dictionary: siteData)
                        new_site.title = BNParser.findString("title", dictionary: siteData)
                        new_site.subTitle = BNParser.findString("subTitle", dictionary: siteData)
                        new_site.titleColor = BNParser.findUIColor("titleColor", dictionary: siteData)
                        new_site.country = BNParser.findString("country", dictionary: siteData)
                        new_site.state = BNParser.findString("state", dictionary: siteData)
                        new_site.city = BNParser.findString("city", dictionary: siteData)
                        new_site.zipCode = BNParser.findString("zipCode", dictionary: siteData)
                        new_site.streetAddress1 = BNParser.findString("streetAddress1", dictionary: siteData)
                        new_site.streetAddress2 = BNParser.findString("streetAddress1", dictionary: siteData)
                        new_site.phoneNumber = BNParser.findString("phoneNumber", dictionary: siteData)
                        new_site.email = BNParser.findString("email", dictionary: siteData)
                        new_site.nutshell = BNParser.findString("nutshell", dictionary: siteData)
                        new_site.organizationIdentifier = BNParser.findString("organizationIdentifier", dictionary: siteData)
                        
                        new_site.commentedCount = BNParser.findInt("commentedCount", dictionary: siteData)!
                        new_site.userCommented = BNParser.findBool("userCommented", dictionary: siteData)
                        
                        new_site.collectCount = BNParser.findInt("collectCount", dictionary: siteData)!
                        new_site.userCollected = BNParser.findBool("userCollected", dictionary: siteData)
                        new_site.userShared = BNParser.findBool("userShared", dictionary: siteData)
                        new_site.userFollowed = BNParser.findBool("userFollowed", dictionary: siteData)
                        new_site.userLiked = BNParser.findBool("userLiked", dictionary: siteData)
                        new_site.latitude = BNParser.findFloat("latitude", dictionary:siteData)
                        new_site.longitude = BNParser.findFloat("longitude", dictionary:siteData)
                        new_site.stars = BNParser.findFloat("stars", dictionary: siteData)!
                        
                        if let neighbors = BNParser.findNSArray("neighbors", dictionary: siteData) {
                        
                            if neighbors.count > 0 {
                                 
                                new_site.neighbors = Array<String>()
                                
                                for a in (0..<neighbors.count){
                                    
                                    let neighborData = neighbors.objectAtIndex(a) as! NSDictionary
                                    let neighbor = BNParser.findString("siteIdentifier", dictionary:neighborData)
                                    new_site.neighbors!.append(neighbor!)
                                }
                            }
                        }

                        if let mediaArray = BNParser.findNSArray("media", dictionary: siteData) {
                        
                            for b in (0..<mediaArray.count) {
                                let mediaData = mediaArray.objectAtIndex(b) as! NSDictionary
                                let url = BNParser.findString("url", dictionary:mediaData)!
                                let type = BNParser.findMediaType("mediaType", dictionary: mediaData)
                                let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)!
                                let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)!
                                let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)!
                                
                                var white:CGFloat = 0.0
                                var alpha:CGFloat = 0.0
                                _ = vibrantColor.getWhite(&white, alpha: &alpha)
                                
                                if white <= 0.7 {
                                    new_site.useWhiteText = true
                                }
                                
                                let media = BNMedia(mediaType: type, url:url, vibrantColor: vibrantColor, vibrantDarkColor: vibrantDarkColor, vibrantLightColor:vibrantLightColor)
                                new_site.media.append(media)
                            }
                        }
                        
                        if let showcases = BNParser.findNSArray("showcases", dictionary: siteData) {
                        
                            if showcases.count > 0 {
                                /*
                                new_site.showcases = Array<BNShowcase>()
                                
                                for c in (0..<showcases.count){
                                    let showcaseData = showcases.objectAtIndex(c) as! NSDictionary
                                    let identifier = BNParser.findString("identifier", dictionary:showcaseData)
                                    let showcase = BNShowcase()
                                    showcase.identifier = identifier
                                    //showcase.siteIdentifier = new_site.identifier!
                                    showcase.site = new_site
                                    new_site.showcases!.append(showcase)
                                }
                                 */
                            }
                        }
                        
                        if let biins = BNParser.findNSArray("biins", dictionary: siteData) {
                        
                            for d in (0..<biins.count){
                                if let biinData = biins.objectAtIndex(d) as? NSDictionary {
                                    let biin = BNBiin()
                                    biin.identifier = BNParser.findString("identifier", dictionary: biinData)
                                    biin.accountIdentifier = BNParser.findString("accountIdentifier", dictionary: biinData)
                                    //biin.siteIdentifier = BNParser.findString("siteIdentifier", dictionary: biinData)
                                    //                                biin.organizationIdentifier = self.findString("organizationIdentifier", dictionary: biinData)
                                    biin.major = BNParser.findInt("major", dictionary: biinData)
                                    biin.minor = BNParser.findInt("minor", dictionary: biinData)
                                    biin.proximityUUID = BNParser.findNSUUID("proximityUUID", dictionary: biinData)
                                    biin.venue = BNParser.findString("venue", dictionary: biinData)
                                    biin.name = BNParser.findString("name", dictionary: biinData)
                                    biin.biinType = BNParser.findBNBiinType("biinType", dictionary: biinData)
                                    //biin.organizationIdentifier = self.findString("organizationIdentifier", dictionary: biinData)
                                    
                                    //REMOVE ->
                                    biin.site = new_site
                                    //biin.lastUpdate = self.findNSDate("lastUpdate", dictionary: biinData)
                                    //REMOVE <-
                                    
                                    
                                    if let children = BNParser.findNSArray("children", dictionary: biinData) {
                                    
                                        if children.count > 0 {
                                            
                                            biin.children = Array<Int>()
                                            
                                            for e in (0..<children.count) {
                                                let child = Int(((children.objectAtIndex(e) as? String))!)
                                                biin.children!.append(child!)
                                            }
                                        }
                                    }
                                    
                                    if let objects = BNParser.findNSArray("objects", dictionary: biinData) {
                                    
                                        if objects.count > 0 {
                                            biin.objects = Array<BNBiinObject>()
                                            for f in (0..<objects.count){

                                                if let objectData = objects.objectAtIndex(f) as? NSDictionary {
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
                                    
                                    /*
                                    var showcases = self.findNSArray("showcases", dictionary: biinData)
                                    
                                    if showcases?.count > 0 {
                                    
                                    biin.showcases = Array<BNShowcase>()
                                    
                                    for var k = 0; k < showcases?.count; k++ {
                                    if let showcaseData = showcases!.objectAtIndex(k) as? NSDictionary {
                                    
                                    var showcase = BNShowcase()
                                    showcase.identifier = self.findString("showcaseIdentifier", dictionary: showcaseData)
                                    showcase.endTime = self.findNSDate("endTime", dictionary: showcaseData)
                                    showcase.startTime = self.findNSDate("startTime", dictionary: showcaseData)
                                    showcase.isDefault = self.findBool("isDefault", dictionary: showcaseData)
                                    showcase.isUserNotified = self.findBool("isUserNotified", dictionary: showcaseData)
                                    biin.showcases!.append(showcase)
                                    
                                    }
                                    }
                                    }
                                    */
                                    new_site.biins.append(biin)
                                }
                            }
                        }
                    
                        /*
                        var loyaltyData = self.findNSDictionary("loyalty", dictionary: dataData)
                        var loyalty = BNLoyalty()
                        loyalty.isSubscribed = self.findBool("isSubscribed", dictionary: loyaltyData!)
                        
                        loyalty.isSubscribed = true
                        if loyalty.isSubscribed {
                        loyalty.points = 100// self.findInt("points", dictionary:loyaltyData!)!
                        //loyalty.subscriptionDate = self.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                        loyalty.level = self.findInt("level", dictionary:loyaltyData!)!
                        //TODO: Add achievements and badges.
                        }
                        
                        site.loyalty = loyalty
                        */
                        
                        //let end = NSDate()
                        //let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                        //print("BNRequest_Site [\(timeInterval)] - \(self.requestString)")
                        
                        
                        
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedSite:new_site)
                        self.inCompleted = true
                        self.networkManager!.removeFromQueue(self)
                    }
                    
                    //self.removeRequestOnCompleted(request.identifier)
                    
                } else {
                    
                    //Remove site when is not downloaded from site list and user categories.
                    BNAppSharedManager.instance.dataManager.sites.removeValueForKey(self.site!.identifier!)
                    
                    for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
                        
                        if category.hasSites {
                            for g in (0..<category.sitesDetails.count) {
                                if category.sitesDetails[g].identifier! == self.site!.identifier! {
                                    category.sitesDetails.removeAtIndex(g)
                                }
                            }
                        }
                    }
                    
                    self.inCompleted = true
                    //self.clean()
                    self.networkManager!.removeFromQueue(self)
                }
            }
        })
    }
}