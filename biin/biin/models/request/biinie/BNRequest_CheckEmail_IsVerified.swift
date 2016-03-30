//  BNRequest_CheckEmail_IsVerified.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_CheckEmail_IsVerified: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager ) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.CheckEmail_IsVerified
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {
                
        isRunning = true
        requestAttemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url:requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                //if let dataData = data["data"] as? NSDictionary {
                    
                    //var status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedEmailVerification: result)
      
                //}
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}