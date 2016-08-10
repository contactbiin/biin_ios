//  BNRequest_SendLoyaltyCompleted.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendLoyaltyCardCompleted:BNRequest {
    
    var isUpdate = false
    
    override init() { super.init() }
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?, biinie:Biinie?, loyalty:BNLoyalty?) {
        
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendLoyaltyCompleted
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.biinie  = biinie
        self.loyalty = loyalty
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        attemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                //var response:BNResponse?
                
                if let biinieData = data["data"] as? NSDictionary {
                    
                    //let status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        
                        self.isCompleted = true
                        self.networkManager!.requestManager!.processCompletedRequest(self)
                        
                    } else {
                        self.requestError = BNRequestError.SendLoyaltyCompleted_Failed
                        self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                    }
                    
                    /*
                     let end = NSDate()
                     let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                     print("BNRequest_Biinie [\(timeInterval)] - \(self.requestString)")
                     */
                    
                } else  {
                    self.requestError = BNRequestError.Server
                    self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                }
            }
        })
    }

}