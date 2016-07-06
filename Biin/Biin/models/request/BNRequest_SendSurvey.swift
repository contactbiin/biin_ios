//  BNRequest_SendSurvey.swift
//  biin
//  Created by Esteban Padilla on 1/20/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendSurvey: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, site:BNSite?, rating:Int, comment:String, biinie:Biinie? ){
        self.init()
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.SendSurvey
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.site = site
        self.biinie = biinie
        self.rating = rating
        self.comment = comment
    }
    
    override func run() {

        isRunning = true
        attemps += 1
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["siteId"] = self.site!.identifier!
        modelContent["userId"] = self.biinie!.identifier!
        modelContent["rating"] = "\(self.rating)"
        modelContent["comment"] = self.comment
        model["model"] = modelContent
        
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            htttpBody = nil
        }
        
        self.networkManager!.epsNetwork!.put(self.identifier, url:self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {

                self.isCompleted = true
                self.networkManager!.requestManager!.processCompletedRequest(self)
            }
        })
    }
}

