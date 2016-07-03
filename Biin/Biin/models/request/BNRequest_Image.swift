//  BNRequest_Image.swift
//  biin
//  Created by Alison Padilla on 9/7/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Image: BNRequest {
    override init() {
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, image:BNUIImageView) {
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Image
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.image = image
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        if image != nil {
            
            self.networkManager!.epsNetwork!.getImage(requestString, image:self.image!, callback:{(error: NSError?) -> Void in
                
                if (error != nil)  {
                    if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                    self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                } else {
                    self.isCompleted = true
                    self.networkManager!.requestManager!.processCompletedRequest(self)
                    
                }
            })
        }
    }
}