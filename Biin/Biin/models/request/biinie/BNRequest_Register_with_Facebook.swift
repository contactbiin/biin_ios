//  BNRequest_Register_with_Facebook.swift
//  biin
//  Created by Esteban Padilla on 2/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Register_with_Facebook: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Register
        self.errorManager = errorManager
        self.networkManager = networkManager
        
    }
    
    override func run() {
        
        //print("BNRequest_Register_with_Facebook - \(requestString)")
        
        isRunning = true
        attemps += 1
        
        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let registerData = data["data"] as? NSDictionary {
                    
                    let status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    let identifier = BNParser.findString("identifier", dictionary: registerData)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier: identifier)
                        
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                        
                    }
                    
                    self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedRegisterConfirmation: response)
                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}
