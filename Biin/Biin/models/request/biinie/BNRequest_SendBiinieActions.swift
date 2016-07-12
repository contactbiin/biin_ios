//  BNRequest_SendBiinieActions.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiinieActions: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?, biinie:Biinie?) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinieActions
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.biinie  = biinie
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        var model = ["model":["actions":Array<Dictionary<String, String>>()]] as Dictionary<String, Dictionary<String, Array<Dictionary <String, String>>>>
        
        for value in self.biinie!.actions {
            var action = Dictionary <String, String>()
            action["whom"]  = self.biinie!.identifier!
            action["at"]    = value.at!.bnDateFormattForActions()
            action["did"]   = "\(value.did!.hashValue)"
            action["to"]    = value.to!
            action["by"]    = value.by!
            model["model"]!["actions"]?.append(action)
        }
        
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            htttpBody = nil
        }
        
        self.networkManager!.epsNetwork!.put(self.identifier, url:requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {

                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.DoNotShowError }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                
            } else {
                self.isCompleted = true
                self.networkManager!.requestManager!.processCompletedRequest(self)

            }
        })

    }
}