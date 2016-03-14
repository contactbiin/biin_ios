//  BNRequest_Organization.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Organization: BNRequest {
    
    override init(){ super.init() }
    
    deinit{ }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, organization:BNOrganization ){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.Organization
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.organization = organization
    }
    
    override func run() {

        //self.start = NSDate()
        
        isRunning = true
        requestAttemps++
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        
                        let organizationData = BNParser.findNSDictionary("organization", dictionary: dataData)
                        self.organization!.name = BNParser.findString("name", dictionary: organizationData!)
                        self.organization!.brand = BNParser.findString("brand", dictionary: organizationData!)
                        self.organization!.extraInfo = BNParser.findString("extraInfo", dictionary: organizationData!)
                        self.organization!.organizationDescription = BNParser.findString("description", dictionary: organizationData!)
                        self.organization!.primaryColor = BNParser.findUIColor("primaryColor", dictionary:organizationData!)
                        self.organization!.secundaryColor = BNParser.findUIColor("secundaryColor", dictionary:organizationData!)
                        
                        
                        let mediaArray = BNParser.findNSArray("media", dictionary: organizationData!)
                        
                        for var i = 0; i < mediaArray?.count; i++ {
                            let mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            let url = BNParser.findString("url", dictionary:mediaData)
                            let type = BNParser.findMediaType("mediaType", dictionary: mediaData)
                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)
                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)
                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)
                            let media = BNMedia(mediaType:type, url:url!, vibrantColor: vibrantColor!, vibrantDarkColor: vibrantDarkColor!, vibrantLightColor: vibrantLightColor!)
                            self.organization!.media.append(media)
                        }
                        
                        self.organization!.isLoyaltyEnabled = BNParser.findBool("isLoyaltyEnabled", dictionary: organizationData!)

                        if self.organization!.isLoyaltyEnabled {
                            let loyalty = BNLoyalty()
                            let loyaltyData = BNParser.findNSDictionary("loyalty", dictionary: organizationData!)
                            loyalty.isSubscribed = BNParser.findBool("isSubscribed", dictionary: loyaltyData!)
                            loyalty.points = BNParser.findInt("points", dictionary:loyaltyData!)!
                            loyalty.subscriptionDate = BNParser.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                            loyalty.level = BNParser.findInt("level", dictionary:loyaltyData!)!
                            self.organization!.loyalty = loyalty
                        }
                    }
                }
                
                /*
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_Organization [\(timeInterval)] - \(self.requestString)")
                */
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
                
            }
        })
    }
}