//  BNRequest_Login.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Login: BNRequest {
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?){
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Login
        self.errorManager = errorManager
        self.networkManager = networkManager
        
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url:requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                if let loginData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)

                    if result {
                        
                        let identifier = BNParser.findString("identifier", dictionary: loginData)
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier:identifier)
                        
                        self.isCompleted = true
                        self.networkManager!.requestManager!.processCompletedRequest(self)
                        
                    } else {
                        
                        self.requestError = BNRequestError.Login_Failed
                        self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                    }
                } else {
                    self.requestType = BNRequestType.ServerError
                    self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                }
            }
        })
    }
}