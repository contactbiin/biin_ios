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
                    
                    var result = self.networkManager!.findBool("result", dictionary: data)
                    
                    if result {
                        var organizationData = self.networkManager!.findNSDictionary("organization", dictionary: dataData)
                        
                        
                        self.organization!.name = self.networkManager!.findString("name", dictionary: organizationData!)
                        self.organization!.brand = self.networkManager!.findString("brand", dictionary: organizationData!)
                        self.organization!.extraInfo = self.networkManager!.findString("extraInfo", dictionary: organizationData!)
                        self.organization!.organizationDescription = self.networkManager!.findString("description", dictionary: organizationData!)
                        
                        var mediaArray = self.networkManager!.findNSArray("media", dictionary: organizationData!)
                        
                        for var i = 0; i < mediaArray?.count; i++ {
                            var mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            var url = self.networkManager!.findString("imgUrl", dictionary:mediaData)
                            var type = self.networkManager!.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = self.networkManager!.findUIColor("domainColor", dictionary: mediaData)
                            var media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                            self.organization!.media.append(media)
                        }
                        
                        var loyaltyData = self.networkManager!.findNSDictionary("loyalty", dictionary: dataData)
                        var loyalty = BNLoyalty()
                        loyalty.isSubscribed = self.networkManager!.findBool("isSubscribed", dictionary: loyaltyData!)
                        
                        loyalty.isSubscribed = true
                        
                        if loyalty.isSubscribed {
                            loyalty.points = self.networkManager!.findInt("points", dictionary:loyaltyData!)!
                            loyalty.subscriptionDate = self.networkManager!.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                            loyalty.level = self.networkManager!.findInt("level", dictionary:loyaltyData!)!
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