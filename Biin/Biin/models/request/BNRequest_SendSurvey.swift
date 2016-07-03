//  BNRequest_SendSurvey.swift
//  biin
//  Created by Esteban Padilla on 1/20/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendSurvey: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, site:BNSite?, rating:Int, comment:String, user:Biinie? ){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.SendSurvey
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.site = site
        self.user = user
        self.rating = rating
        self.comment = comment
    }
    
    override func run() {
        /*
        
        {
        "data":{
        "siteId":"testSiteId",
        "userId":"testUserId",
        "rating":"1",
        "comment":"comment test"
        }
        }
*/
        
        isRunning = true
        attemps += 1
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["siteId"] = self.site!.identifier!
        modelContent["userId"] = self.user!.identifier!
        modelContent["rating"] = "\(self.rating)"
        modelContent["comment"] = self.comment
        model["model"] = modelContent
        
        //var httpError: NSError?
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            //httpError = error
            htttpBody = nil
        }
        
        //        var response:BNResponse?
        
        self.networkManager!.epsNetwork!.put(self.identifier, url:self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
                
            } else {
                
                //if let dataData = data["data"] as? NSDictionary {
                
                //                    let status = BNParser.findInt("status", dictionary: data)
                //                    let result = BNParser.findBool("result", dictionary: data)
                //
                //                    if result {
                //                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                //                    } else {
                //                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                //                    }
                //
                //                    self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedUpdateConfirmation: response)
                //}
                
                self.isCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}

