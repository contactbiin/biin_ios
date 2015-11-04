//  BNRequest_ConnectivityCheck.swift
//  biin
//  Created by Alison Padilla on 9/1/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_ConnectivityCheck: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, dataIdentifier:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        self.identifier = BNRequestData.requestCounter++

        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.ConnectivityCheck
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {

        
        isRunning = true
        requestAttemps++
        
        networkManager!.epsNetwork!.checkConnection(false, url:requestString, callback:{
            (error: NSError?) -> Void in
            
            if (error != nil) {
                

                self.networkManager!.handleFailedRequest(self, error: error )
//                self.networkManager!.requests.removeAll(keepCapacity: false)
            } else {
                
                self.inCompleted = true
                self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedConnectionStatus: true)
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}