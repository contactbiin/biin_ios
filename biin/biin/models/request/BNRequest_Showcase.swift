//  BNRequest_Showcase.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_Showcase: BNRequest {
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, showcase:BNShowcase, user:Biinie) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Showcase
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
        self.showcase = showcase
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps++
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {

                self.networkManager!.handleFailedRequest(self, error: error)
            } else {
                
                if let showcaseData = data["data"] as? NSDictionary {
                    
                    //var status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        self.showcase!.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                        self.showcase!.lastUpdate = BNParser.findNSDate("lastUpdate", dictionary: showcaseData)
                        self.showcase!.title = BNParser.findString("title", dictionary: showcaseData)
                        self.showcase!.subTitle = BNParser.findString("subTitle", dictionary: showcaseData)
                        self.showcase!.elements_quantity = BNParser.findInt("elements_quantity", dictionary: showcaseData)!
                        
                        let elements = BNParser.findNSArray("elements", dictionary: showcaseData)
                        
                        var i:Int = 0
                        for _ in elements! {
//                        for var i = 0; i < elements?.count; i++ {
                            
                            let elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                            let element = BNElement()
                            element._id = BNParser.findString("_id", dictionary: elementData)
                            element.identifier = BNParser.findString("elementIdentifier", dictionary: elementData)
                            element.userViewed = BNParser.findBool("hasBeenSeen", dictionary: elementData)
                            element.showcase = self.showcase
                            self.showcase!.elements.append(element)
                            i += 1
                        }
                        
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedShowcase: self.showcase!)
                 
                    }
                }
                
                /*
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_Showcase [\(timeInterval)] - \(self.requestString)")
                */
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}