//  BNRequest_SendBiinieCategories.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiinieCategories: BNRequest {

    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, categories:Dictionary<String, String> ){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinieCategories
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.categories = categories
    }
    
    override func run() {
        
        //print("BNRequest_SendBiinieCategories - \(requestString)")

        isRunning = true
        requestAttemps += 1
        
        var model = ["model":Array<Dictionary <String, String>>()] as Dictionary<String, Array<Dictionary <String, String>>>
        
        for (_, value) in self.categories! {
            model["model"]?.append(["identifier":value])
        }
        
        //var httpError: NSError?
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            //httpError = error
            htttpBody = nil
        }
        
        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.post(self.identifier, url:self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            
            if (error != nil) {
                
                self.networkManager!.handleFailedRequest(self, error: error )
//                response = BNResponse(code:10, type: BNResponse_Type.Suck)
                
            } else {
                
                //if let dataData = data["data"] as? NSDictionary {
                    
                    let status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)

                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)

                    }
                    
                    self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedCategoriesSavedConfirmation: response)
        
                //}
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
                
            }
        })
    }
}