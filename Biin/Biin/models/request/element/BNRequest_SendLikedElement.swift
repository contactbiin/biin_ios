//  BNRequest_SendLikedElement.swift
//  biin
//  Created by Alison Padilla on 9/7/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendLikedElement: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?, element:BNElement? ){
        self.init()
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.SendLikedElement
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.element = element
    }
    
    override func run() {
    
        isRunning = true
        attemps += 1
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["identifier"] = self.element!.identifier!
        modelContent["showcaseIdentifier"] = self.element!.showcase!.identifier!
        modelContent["siteIdentifier"] = self.element!.showcase!.site!.identifier!
        modelContent["type"] = "element"
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
