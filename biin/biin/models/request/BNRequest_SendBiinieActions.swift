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
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, user:Biinie) {
        
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinieActions
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
    }
    
    override func run() {
        
        NSLog("BNRequest_SendBiinieActions.run()")
        isRunning = true

        var model = ["model":["actions":Array<Dictionary<String, String>>()]] as Dictionary<String, Dictionary<String, Array<Dictionary <String, String>>>>
        
        for value in self.user!.actions {
            var action = Dictionary <String, String>()
            action["whom"]  = self.user!.identifier!
            action["at"]    = value.at!.bnDateFormattForActions()
            action["did"]   = "\(value.did!.hashValue)"
            action["to"]    = value.to!
            model["model"]!["actions"]?.append(action)
        }
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.put(requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on posting categoies")
                self.networkManager!.handleFailedRequest(self, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.networkManager!.findInt("status", dictionary: data)
                    var result = self.networkManager!.findBool("result", dictionary: data)
                    
                    if result {
                        //response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        self.user!.deleteAllActions()
                    } else {
                        //response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    BNAppSharedManager.instance.dataManager.bnUser!.actions.removeAll(keepCapacity: false)

                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })

    }
}