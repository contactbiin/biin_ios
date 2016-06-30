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
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps += 1
        
//        networkManager!.epsNetwork!.checkConnection(false, url:requestString, callback:{
//            (error: NSError?) -> Void in
//            
//            if (error != nil) {
//                self.networkManager!.handleFailedRequest(self, error: error )
//            } else {
//                self.inCompleted = true
//                self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedVersionStatus: true)
//                self.networkManager!.removeFromQueue(self)
//            }
//        })
        
        
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                let result = BNParser.findBool("result", dictionary: data)
                var needsUpdate = false
                
                if result {
            
                    if let versionData = data["data"] as? NSDictionary {
                        needsUpdate = BNParser.findBool("needsUpdate", dictionary: versionData)
                        self.networkManager!.rootURL = BNParser.findString("rootURL", dictionary: versionData)!
                    }
                    
                    if needsUpdate {
                        self.networkManager!.showVersionError(self)
                    } else {
                        self.inCompleted = true
                        self.networkManager!.delegateVC!.manager!(self.networkManager!, didReceivedVersionStatus:needsUpdate)
                        self.networkManager!.removeFromQueue(self)
                    }
                    
                }else {
                    self.networkManager!.handleFailedRequest(self, error:nil)
                }
            }
        })
    }
}