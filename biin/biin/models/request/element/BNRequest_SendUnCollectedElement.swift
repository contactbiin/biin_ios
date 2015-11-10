//  BNRequest_SendUnCollectedElement.swift
//  biin
//  Created by Alison Padilla on 9/7/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendUnCollectedElement: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager ){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.SendUnCollectedElement
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {
        print("BNRequest_SendUnCollectedElement - \(requestString)")


        isRunning = true
        requestAttemps++
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["type"] = "element"
        model["model"] = modelContent
        
        //var httpError: NSError?
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            //httpError = error
            htttpBody = nil
        }
        
        self.networkManager!.epsNetwork!.delete(self.identifier, url:self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}