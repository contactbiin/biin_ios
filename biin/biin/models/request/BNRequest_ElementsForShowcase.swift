//  BNRequest_ElementsForShowcase.swift
//  biin
//  Created by Esteban Padilla on 11/19/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_ElementsForShowcase: BNRequest {

    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, showcase:BNShowcase, user:Biinie, view:BNView) {
        
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.ElementsForShowcase
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
        self.showcase = showcase
        self.view = view
    }
    
    override func run() {
        
        self.start = NSDate()
        
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
                        
                        //Parse showcase element list.
                        
                        self.showcase!.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                        self.showcase!.lastUpdate = BNParser.findNSDate("lastUpdate", dictionary: showcaseData)
                        self.showcase!.title = BNParser.findString("title", dictionary: showcaseData)
                        self.showcase!.subTitle = BNParser.findString("subTitle", dictionary: showcaseData)
                        self.showcase!.elements_quantity = BNParser.findInt("elements_quantity", dictionary: showcaseData)!
                        
                        let elements = BNParser.findNSArray("elements", dictionary: showcaseData)
                        
                        for var i = 0; i < elements?.count; i++ {
                            
                            let elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                            let element = BNElement()
                            element._id = BNParser.findString("_id", dictionary: elementData)
                            element.identifier = BNParser.findString("elementIdentifier", dictionary: elementData)
                            element.userViewed = BNParser.findBool("hasBeenSeen", dictionary: elementData)
                            element.showcase = self.showcase
                            self.showcase!.elements.append(element)
                        }
                        
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedShowcase: self.showcase!)
                        
                    }
                }
                
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_ElementsForShowcase [\(timeInterval)] - \(self.requestString)")
                
                
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}
