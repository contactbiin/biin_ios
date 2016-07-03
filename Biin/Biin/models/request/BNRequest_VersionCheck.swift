//  BNRequest_VersionCheck.swift
//  biin
//  Created by Esteban Padilla on 6/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_VersionCheck: BNRequest {
    
    override init() { super.init() }
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        self.requestString = requestString
        self.requestType = BNRequestType.VersionCheck
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                let result = BNParser.findBool("result", dictionary: data)
                var needsUpdate = false
                
                if result {
            
                    if let versionData = data["data"] as? NSDictionary {
                        needsUpdate = BNParser.findBool("needsUpdate", dictionary: versionData)
                        self.networkManager!.rootURL = BNParser.findString("rootURL", dictionary: versionData)!
                    }
                    
                    if needsUpdate {
                        self.requestError = BNRequestError.VersionCheck_NeedsUpdate
                        self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                    } else {
                        self.isCompleted = true
                        self.networkManager!.requestManager!.processCompletedRequest(self)
                    }
                    
                } else {
                    self.requestError = BNRequestError.Server
                    self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                }
            }
        })
    }
}