//  BNRequest_ToS.swift
//  biin
//  Created by Esteban Padilla on 4/23/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_ToS: BNRequest {
    
    weak var viewController:SingupViewController?
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, viewController:SingupViewController ) {
        
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Biinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.viewController = viewController
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let rawData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        
                        BNAppSharedManager.instance.dataManager.termOfService = BNParser.findString("termsOfService", dictionary:rawData)
                        BNAppSharedManager.instance.dataManager.privacyPolicy = BNParser.findString("privacy", dictionary:rawData)
                        self.viewController!.loadToS_webViews()
                    }
                    
                    /*
                     let end = NSDate()
                     let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                     print("BNRequest_Biinie [\(timeInterval)] - \(self.requestString)")
                     */
                    
                    
                    self.inCompleted = true
                    self.networkManager!.removeFromQueue(self)
                    
                } else  {
                    
                    self.requestType = BNRequestType.ServerError
                    self.networkManager!.handleFailedRequest(self, error: error )
                }
            }
        })
    }
}
