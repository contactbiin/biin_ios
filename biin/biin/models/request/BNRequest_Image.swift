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
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.image = image
    }
    
    override func run() {
        
        println("BNRequest_Image.run()")
        isRunning = true
        
        self.networkManager!.epsNetwork!.getImage(requestString, image:self.image!, callback:{(error: NSError?) -> Void in
           
            println("Image OK")
            
            if (error != nil)  {
                
                self.networkManager!.handleFailedRequest(self, error:error )
                
            } else {
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}