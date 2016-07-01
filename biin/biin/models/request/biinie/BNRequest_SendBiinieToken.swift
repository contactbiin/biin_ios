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
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, user:Biinie) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps += 1
        
        
        if self.user!.identifier == "none" {
            isUpdate = false
        } else {
            isUpdate = true
        }
        
        var model = Dictionary<String, Dictionary <String, AnyObject>>()
        var modelContent = Dictionary<String, AnyObject>()
        modelContent["platform"] = "ios"
        modelContent["tokenId"] = self.user!.token!
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
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                /*
                if let registerData = data["data"] as? NSDictionary {
                    
                    let status = BNParser.findInt("status", dictionary: registerData)
                    let result = BNParser.findBool("result", dictionary: registerData)
                    
                    print("status: \(status)")
                    print("result: \(result)")
                }
                */
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}