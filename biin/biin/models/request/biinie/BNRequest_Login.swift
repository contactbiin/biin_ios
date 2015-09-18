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
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Login
        self.errorManager = errorManager
        self.networkManager = networkManager
        
    }
    
    override func run() {
        
        print("BNRequest_Login.run()")
        isRunning = true
        
        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.getJson(false, url:requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                
                self.networkManager!.handleFailedRequest(self, error: error)
                
                response = BNResponse(code:9, type: BNResponse_Type.RequestFailed)
                self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedLoginValidation: response)
                
            } else {
                
                if let loginData = data["data"] as? NSDictionary {
                    
                    let status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    let identifier = BNParser.findString("identifier", dictionary: loginData)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier:identifier)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedLoginValidation: response)
                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}