//  BNRequest_Sites.swift
//  biin
//  Created by Esteban Padilla on 12/1/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_Sites: BNRequest {
    
    override init(){ super.init() }
    var category:BNCategory?
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, view:BNView?){
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Sites
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.view = view
    }
    
    
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                if let initialData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        
                        if let showcasesData = BNParser.findNSArray("showcases", dictionary: initialData) {
                            BNParser.parseShowcases(showcasesData)
                        }
                        
                        if let organizationsData = BNParser.findNSArray("organizations", dictionary: initialData) {
                            BNParser.parseOrganizations(organizationsData)
                        }
                        
                        //Parse elements
                        if let elementsData = BNParser.findNSArray("elements", dictionary: initialData) {
                            BNParser.parseElements(elementsData)
                        }
                        
                        if let sitesData = BNParser.findNSArray("sites", dictionary: initialData) {
                            BNParser.parseSites(sitesData)
                        }
                        
                        if let noticesData = BNParser.findNSArray("notices", dictionary: initialData) {
                            BNParser.parseNotices(noticesData)
                        }
                    }
                    
                    self.view!.requestCompleted()
                    self.isCompleted = true
                    self.networkManager!.requestManager!.processCompletedRequest(self)
                    
                } else  {
                    self.requestError = BNRequestError.DoNotShowError
                    self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                }
            }
        })
    }
}
