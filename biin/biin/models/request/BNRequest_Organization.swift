//  BNRequest_Organization.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Organization: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, organization:BNOrganization ){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.OrganizationData
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.organization = organization
    }
    
    override func run() {
        
        print("BNRequest_Organization.run()")
        isRunning = true
        self.networkManager!.epsNetwork!.getJson(true, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                print("Error on requestOrganizationData()")
                print("\(error!.description)")
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
                        
                        let mediaArray = BNParser.findNSArray("media", dictionary: organizationData!)
                        
                        for var i = 0; i < mediaArray?.count; i++ {
                            let mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            let url = BNParser.findString("url", dictionary:mediaData)
                            let type = BNParser.findMediaType("mediaType", dictionary: mediaData)
                            let domainColor = BNParser.findUIColor("domainColor", dictionary: mediaData)
                            let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)
                            let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)
                            let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)
                            let media = BNMedia(mediaType:type, url:url!, domainColor: domainColor!, vibrantColor: vibrantColor!, vibrantDarkColor: vibrantDarkColor!, vibrantLightColor: vibrantLightColor!)
//                            let media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                            self.organization!.media.append(media)
                        }
                        
                        self.organization!.isLoyaltyEnabled = BNParser.findBool("isLoyaltyEnabled", dictionary: organizationData!)
                        let loyaltyData = BNParser.findNSDictionary("loyalty", dictionary: organizationData!)
                        let loyalty = BNLoyalty()
                        loyalty.isSubscribed = BNParser.findBool("isSubscribed", dictionary: loyaltyData!)
                        
                        loyalty.isSubscribed = true
                        
                        if loyalty.isSubscribed {
                            loyalty.points = BNParser.findInt("points", dictionary:loyaltyData!)!
                            loyalty.subscriptionDate = BNParser.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                            loyalty.level = BNParser.findInt("level", dictionary:loyaltyData!)!
                        }
                        
                        self.organization!.loyalty = loyalty
                    }
                }
                
                //self.removeRequestOnCompleted(request.identifier)
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
                
            }
        })

    }
}