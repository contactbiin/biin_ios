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
        
        println("BNRequest_Organization.run()")
        isRunning = true
        self.networkManager!.epsNetwork!.getJson(true, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestOrganizationData()")
                println("\(error!.description)")
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        var organizationData = BNParser.findNSDictionary("organization", dictionary: dataData)
                        
                        
                        self.organization!.name = BNParser.findString("name", dictionary: organizationData!)
                        self.organization!.brand = BNParser.findString("brand", dictionary: organizationData!)
                        self.organization!.extraInfo = BNParser.findString("extraInfo", dictionary: organizationData!)
                        self.organization!.organizationDescription = BNParser.findString("description", dictionary: organizationData!)
                        
                        var mediaArray = BNParser.findNSArray("media", dictionary: organizationData!)
                        
                        for var i = 0; i < mediaArray?.count; i++ {
                            var mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            var url = BNParser.findString("imgUrl", dictionary:mediaData)
                            var type = BNParser.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = BNParser.findUIColor("domainColor", dictionary: mediaData)
                            var media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                            self.organization!.media.append(media)
                        }
                        
                        var loyaltyData = BNParser.findNSDictionary("loyalty", dictionary: dataData)
                        var loyalty = BNLoyalty()
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