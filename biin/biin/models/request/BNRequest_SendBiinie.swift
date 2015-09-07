//  BNRequest_SendBiinie.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiinie:BNRequest {
    
    override init() {
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, user:Biinie) {
        
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
    }
    
    override func run() {
        
        println("BNRequest_SendBiinie.run()")
        isRunning = true
        
        var model = Dictionary<String, Dictionary <String, String>>()
        var modelContent = Dictionary<String, String>()
        modelContent["firstName"] = self.user!.firstName!
        modelContent["lastName"] = self.user!.lastName!
        modelContent["email"] = self.user!.email!
        modelContent["gender"] = self.user!.gender!
        modelContent["birthDate"] = self.user!.birthDate!.bnDateFormatt()
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.post(self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("ERROR on sendBiinie()")
                self.networkManager!.handleFailedRequest(self, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = BNParser.findInt("status", dictionary: data)
                    var result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedUpdateConfirmation: response)
         
                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}