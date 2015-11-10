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
        
        self.start = NSDate()
        
        isRunning = true
        requestAttemps++
        
        var model = ["model":["actions":Array<Dictionary<String, String>>()]] as Dictionary<String, Dictionary<String, Array<Dictionary <String, String>>>>
        
        for value in self.user!.actions {
            var action = Dictionary <String, String>()
            action["whom"]  = self.user!.identifier!
            action["at"]    = value.at!.bnDateFormattForActions()
            action["did"]   = "\(value.did!.hashValue)"
            action["to"]    = value.to!
            model["model"]!["actions"]?.append(action)
        }
        
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
                //response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
//                if let dataData = data["data"] as? NSDictionary {
//                    
//                    var status = BNParser.findInt("status", dictionary: data)
//                    let result = BNParser.findBool("result", dictionary: data)
//                    
//                    if result {
//                        //response = BNResponse(code:status!, type: BNResponse_Type.Cool)
//                        self.user!.deleteAllActions()
//                    } else {
//                        //response = BNResponse(code:status!, type: BNResponse_Type.Suck)
//                    }
//                    
                
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_SendBiinieActions [\(timeInterval)] - \(self.requestString)")
                
                
                BNAppSharedManager.instance.dataManager.bnUser!.actions.removeAll(keepCapacity: false)

//                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })

    }
}