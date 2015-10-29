//  BNRequest_SendBiiniePoints.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiiniePoints: BNRequest {
    override init() {
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, user:Biinie, organization:BNOrganization, points:Int) {
        
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiiniePoints
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
        self.organization = organization
        self.points = points
    }
    
    override func run() {
        
        print("BNRequest_SendBiiniePoints.run()")
        isRunning = true
        requestAttemps++
        
        var model = Dictionary<String, Dictionary <String, Int>>()
        
        var modelContent = Dictionary<String, Int>()
        modelContent["points"] = points
        model["model"] = modelContent
        
        //var httpError: NSError?
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            //httpError = error
            htttpBody = nil
        }
        
        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.put(requestString, htttpBody:htttpBody, callback: {
            
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