//  BNRequest_ConnectivityCheck.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_ConnectivityCheck: BNRequest {
    
    override init() { super.init() }
    
    deinit { }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
//        self.identifier = get_request_identifier()
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.ConnectivityCheck
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {
        
        //self.start = NSDate()

        isRunning = true
        requestAttemps += 1
        
        networkManager!.epsNetwork!.checkConnection(false, url:requestString, callback:{
            (error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                /*
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_ConnectivityCheck [\(timeInterval)] - \(self.requestString)")
                */
                
                self.inCompleted = true
                self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedConnectionStatus: true)
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}