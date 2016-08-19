//  BNRequest_SendBiinieOnEnterSite.swift
//  Biin
//  Created by Esteban Padilla on 8/8/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiinieOnEnterSite:BNRequest {
    
    var isUpdate = false
    var time:NSDate?
    
    override init() { super.init() }
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?, biinie:Biinie?, time:NSDate?) {
        
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinieOnEnterSite
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.biinie  = biinie
        self.time = time
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        var model = Dictionary<String, Dictionary <String, AnyObject>>()
        var modelContent = Dictionary<String, AnyObject>()
        modelContent["timeClient"] = self.time!.bnDateFormattForNotification()
        model["model"] = modelContent
        
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            htttpBody = nil
        }
        
        self.networkManager!.epsNetwork!.post(self.identifier, url:self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                //if let registerData = data["data"] as? NSDictionary {
                    print("data:\(data)")
                    let result = BNParser.findBool("result", dictionary: data)
                    //let identifier = BNParser.findString("identifier", dictionary: registerData)
                    
                    if result {
                        
                        if !self.isUpdate {
//                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier: identifier)
                        }
                        
                        self.isCompleted = true
                        self.networkManager!.requestManager?.processCompletedRequest(self)
                        
                    } else {
                        self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                    }
                //}
            }
        })
    }
}