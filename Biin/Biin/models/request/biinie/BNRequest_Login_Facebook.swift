//  BNRequest_Login_Facebook.swift
//  biin
//  Created by Esteban Padilla on 2/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Login_Facebook: BNRequest {
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
        self.requestType = BNRequestType.Login_Facebook
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
                    
                    self.isCompleted = true
                    
                    if result {
                        
                        let identifier = BNParser.findString("identifier", dictionary: loginData)
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier:identifier)
                        
                        self.networkManager!.requestManager!.processCompletedRequest(self)
                        
                    } else {
                        self.requestError = BNRequestError.Login_Facebook_Failed
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
