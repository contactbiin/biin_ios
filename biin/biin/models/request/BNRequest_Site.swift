//  BNRequest_Site.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Site: BNRequest {
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, site:BNSite ){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.SiteData
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.site = site
    }

    override func run() {
        
        println("BNRequest_Site.run()")
        isRunning = true

        self.networkManager!.epsNetwork!.getJson(true, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestSiteData()")
                println("\(error!.description)")
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                var result = self.networkManager!.findBool("result", dictionary: data)
                
                if result {
                    if let siteData = data["data"] as? NSDictionary {
                        
                        var new_site = BNSite()
                        new_site.biinieProximity = self.site!.biinieProximity!
                        new_site.jsonUrl = self.requestString
                        new_site.identifier = self.networkManager!.findString("identifier", dictionary: siteData)
                        new_site.proximityUUID = self.networkManager!.findNSUUID("proximityUUID", dictionary: siteData)
                        new_site.major = self.networkManager!.findInt("major", dictionary: siteData)
                        new_site.title = self.networkManager!.findString("title", dictionary: siteData)
                        new_site.subTitle = self.networkManager!.findString("subTitle", dictionary: siteData)
                        new_site.titleColor = self.networkManager!.findUIColor("titleColor", dictionary: siteData)
                        new_site.country = self.networkManager!.findString("country", dictionary: siteData)
                        new_site.state = self.networkManager!.findString("state", dictionary: siteData)
                        new_site.city = self.networkManager!.findString("city", dictionary: siteData)
                        new_site.zipCode = self.networkManager!.findString("zipCode", dictionary: siteData)
                        new_site.streetAddress1 = self.networkManager!.findString("streetAddress1", dictionary: siteData)
                        new_site.ubication = self.networkManager!.findString("ubication", dictionary: siteData)
                        new_site.phoneNumber = self.networkManager!.findString("phoneNumber", dictionary: siteData)
                        new_site.email = self.networkManager!.findString("email", dictionary: siteData)
                        new_site.nutshell = self.networkManager!.findString("nutshell", dictionary: siteData)
                        new_site.organizationIdentifier = self.networkManager!.findString("organizationIdentifier", dictionary: siteData)
                        
                        
                        new_site.biinedCount = self.networkManager!.findInt("biinedCount", dictionary: siteData)!
                        //TODO: Pending "comments": "23", in web service
                        new_site.commentedCount = self.networkManager!.findInt("commentedCount", dictionary: siteData)!
                        new_site.userBiined = self.networkManager!.findBool("userBiined", dictionary: siteData)
                        new_site.userCommented = self.networkManager!.findBool("userCommented", dictionary: siteData)
                        new_site.userShared = self.networkManager!.findBool("userShared", dictionary: siteData)
                        
                        new_site.latitude = self.networkManager!.findFloat("latitude", dictionary:siteData)
                        new_site.longitude = self.networkManager!.findFloat("longitude", dictionary:siteData)
                        
                        var neighbors = self.networkManager!.findNSArray("neighbors", dictionary: siteData)
                        
                        if neighbors?.count > 0{
                            
                            new_site.neighbors = Array<String>()
                            
                            for var i = 0; i < neighbors?.count; i++ {
                                var neighborData = neighbors!.objectAtIndex(i) as! NSDictionary
                                var neighbor = self.networkManager!.findString("siteIdentifier", dictionary:neighborData)
                                new_site.neighbors!.append(neighbor!)
                            }
                        }
                        
                        var mediaArray = self.networkManager!.findNSArray("media", dictionary: siteData)
                        
                        for var i = 0; i < mediaArray?.count; i++ {
                            var mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            var url = self.networkManager!.findString("imgUrl", dictionary:mediaData)
                            var type = self.networkManager!.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = self.networkManager!.findUIColor("domainColor", dictionary: mediaData)
                            var media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                            new_site.media.append(media)
                        }
                        
                        var showcases = self.networkManager!.findNSArray("showcases", dictionary: siteData)
                        
                        if showcases?.count > 0 {
                            
                            new_site.showcases = Array<BNShowcase>()
                            
                            for var i = 0; i < showcases?.count; i++ {
                                var showcaseData = showcases!.objectAtIndex(i) as! NSDictionary
                                var identifier = self.networkManager!.findString("identifier", dictionary:showcaseData)
                                var showcase = BNShowcase()
                                showcase.identifier = identifier
                                showcase.siteIdentifier = new_site.identifier!
                                new_site.showcases!.append(showcase)
                            }
                        }
                        
                        var biins = self.networkManager!.findNSArray("biins", dictionary: siteData)
                        
                        for var j = 0; j < biins?.count; j++ {
                            if let biinData = biins!.objectAtIndex(j) as? NSDictionary {
                                var biin = BNBiin()
                                biin.identifier = self.networkManager!.findString("identifier", dictionary: biinData)
                                biin.accountIdentifier = self.networkManager!.findString("accountIdentifier", dictionary: biinData)
                                biin.siteIdentifier = self.networkManager!.findString("siteIdentifier", dictionary: biinData)
                                //                                biin.organizationIdentifier = self.findString("organizationIdentifier", dictionary: biinData)
                                biin.major = self.networkManager!.findInt("major", dictionary: biinData)
                                biin.minor = self.networkManager!.findInt("minor", dictionary: biinData)
                                biin.proximityUUID = self.networkManager!.findNSUUID("proximityUUID", dictionary: biinData)
                                biin.venue = self.networkManager!.findString("venue", dictionary: biinData)
                                biin.name = self.networkManager!.findString("name", dictionary: biinData)
                                biin.biinType = self.networkManager!.findBNBiinType("biinType", dictionary: biinData)
                                //biin.organizationIdentifier = self.findString("organizationIdentifier", dictionary: biinData)
                                
                                //REMOVE ->
                                biin.site = new_site
                                //biin.lastUpdate = self.findNSDate("lastUpdate", dictionary: biinData)
                                //REMOVE <-
                                
                                
                                var children = self.networkManager!.findNSArray("children", dictionary: biinData)
                                
                                if children?.count > 0 {
                                    
                                    biin.children = Array<Int>()
                                    
                                    for var i = 0; i < children?.count; i++ {
                                        var child = (children!.objectAtIndex(i) as? String)?.toInt()
                                        biin.children!.append(child!)
                                    }
                                }
                                
                                var objects = self.networkManager!.findNSArray("objects", dictionary: biinData)
                                
                                if objects!.count > 0 {
                                    biin.objects = Array<BNBiinObject>()
                                    for var k = 0; k < objects!.count; k++ {
                                        if let objectData = objects!.objectAtIndex(k) as? NSDictionary {
                                            var object = BNBiinObject()
                                            object._id = self.networkManager!.findString("_id", dictionary: objectData)
                                            object.identifier = self.networkManager!.findString("identifier", dictionary: objectData)
                                            object.isDefault = self.networkManager!.findBool("isDefault", dictionary: objectData)
                                            object.onMonday = self.networkManager!.findBool("onMonday", dictionary: objectData)
                                            object.onTuesday = self.networkManager!.findBool("onTuesday", dictionary: objectData)
                                            object.onWednesday = self.networkManager!.findBool("onWednesday", dictionary: objectData)
                                            object.onThursday = self.networkManager!.findBool("onThursday", dictionary: objectData)
                                            object.onFriday = self.networkManager!.findBool("onFriday", dictionary: objectData)
                                            object.onSaturday = self.networkManager!.findBool("onSaturday", dictionary: objectData)
                                            object.onSunday = self.networkManager!.findBool("onSunday", dictionary: objectData)
                                            object.startTime = self.networkManager!.findFloat("startTime", dictionary: objectData)!
                                            object.endTime = self.networkManager!.findFloat("endTime", dictionary: objectData)!
                                            object.hasTimeOptions = self.networkManager!.findBool("hasTimeOptions", dictionary: objectData)
                                            object.hasNotification = self.networkManager!.findBool("hasNotification", dictionary: objectData)
                                            object.notification = self.networkManager!.findString("notification", dictionary: objectData)
                                            object.isUserNotified = self.networkManager!.findBool("isUserNotified", dictionary: objectData)
                                            object.isBiined = self.networkManager!.findBool("isBiined", dictionary: objectData)
                                            object.objectType = self.networkManager!.findBiinObjectType("objectType", dictionary: objectData)
                                            
                                            //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
                                            object.major = biin.major!
                                            object.minor = biin.minor!
                                            
                                            biin.objects!.append(object)
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
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedSite:new_site)
                        self.inCompleted = true
                        self.networkManager!.removeFromQueue(self)
                        
//                        if self.isRequestTimerAllow {
//                            self.runRequest()
//                        }
                    }
                    
                    //self.removeRequestOnCompleted(request.identifier)
                    
                } else {
                    
                    //Remove site when is not downloaded from site list and user categories.
                    BNAppSharedManager.instance.dataManager.sites.removeValueForKey(self.site!.identifier!)
                    
                    for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
                        
                        if category.hasSites {
                            for var i = 0; i < category.sitesDetails.count; i++ {
                                if category.sitesDetails[i].identifier! == self.site!.identifier! {
                                    category.sitesDetails.removeAtIndex(i)
                                }
                            }
                        }
                    }
                    
                    self.inCompleted = true
                    self.networkManager!.removeFromQueue(self)
                }
            }
        })

        
        
    }
}