//  BNRequest_SendBiinieToken.swift
//  biin
//  Created by Esteban Padilla on 7/1/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiinieToken:BNRequest {
    
    var isUpdate = false
    
    override init() {
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?, biinie:Biinie?) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinieToken
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.biinie = biinie
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        attemps += 1
        
        
        if self.biinie!.identifier == "none" {
            isUpdate = false
        } else {
            isUpdate = true
        }
        
        var model = Dictionary<String, Dictionary <String, AnyObject>>()
        var modelContent = Dictionary<String, AnyObject>()
        modelContent["platform"] = "ios"
        modelContent["tokenId"] = self.biinie!.token!
        model["model"] = modelContent
        
        //var httpError: NSError?
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            //httpError = error
            htttpBody = nil
        }
        
        //var response:BNResponse?
        
        self.networkManager!.epsNetwork!.put(self.identifier, url:requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.SendBiinieToken_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                self.isCompleted = true
                self.networkManager!.requestManager!.processCompletedRequest(self)
            }
        })
    }
}