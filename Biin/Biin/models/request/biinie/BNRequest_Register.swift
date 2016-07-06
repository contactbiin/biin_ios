//  BNRequest_Register.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Register: BNRequest {

    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Register
        self.errorManager = errorManager
        self.networkManager = networkManager
        
    }
    
    override func run() {
        
        //print("BNRequest_Register - \(requestString)")

        isRunning = true
        attemps += 1

        self.networkManager!.epsNetwork!.getJson(self.identifier, url: requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                if let registerData = data["data"] as? NSDictionary {
                    let result = BNParser.findBool("result", dictionary: data)
                    let identifier = BNParser.findString("identifier", dictionary: registerData)
                    self.isCompleted = true
                    
                    if result {
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier: identifier)
                        self.networkManager!.requestManager!.processCompletedRequest(self)
                        
                    } else {
                        self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                    }
                }
            }
        })
    }
}