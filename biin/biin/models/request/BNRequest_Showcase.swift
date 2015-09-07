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
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinieActions
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
        self.showcase = showcase
    }
    
    override func run() {
        
        NSLog("BNRequest_Showcase.run()")
        isRunning = true
        
        self.networkManager!.epsNetwork!.getJson(true, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on showcase data")
                self.networkManager!.handleFailedRequest(self, error: error)
            } else {
                
                if let showcaseData = data["data"] as? NSDictionary {
                    
                    var status = BNParser.findInt("status", dictionary: data)
                    var result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        self.showcase!.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                        self.showcase!.lastUpdate = BNParser.findNSDate("lastUpdate", dictionary: showcaseData)
                        self.showcase!.theme = self.networkManager!.findBNShowcaseTheme("theme", dictionary: showcaseData)
                        self.showcase!.showcaseType = self.networkManager!.findBNShowcaseType("showcaseType", dictionary: showcaseData)
                        self.showcase!.title = self.networkManager!.findString("title", dictionary: showcaseData)
                        self.showcase!.subTitle = self.networkManager!.findString("subTitle", dictionary: showcaseData)
                        self.showcase!.titleColor = self.networkManager!.findUIColor("titleColor", dictionary: showcaseData)!
                        var elements = self.networkManager!.findNSArray("elements", dictionary: showcaseData)
                        
                        for var i = 0; i < elements?.count; i++ {
                            
                            var elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                            var element = BNElement()
                            element._id = self.networkManager!.findString("_id", dictionary: elementData)
                            element.identifier = self.networkManager!.findString("elementIdentifier", dictionary: elementData)
                            element.jsonUrl = self.networkManager!.findString("jsonUrl", dictionary: elementData)
                            element.userViewed = self.networkManager!.findBool("hasBeenSeen", dictionary: elementData)
                            element.color = UIColor.elementColor()
                            element.siteIdentifier = self.showcase!.siteIdentifier!
                            self.showcase!.elements.append(element)
                        }
                        
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedShowcase: self.showcase!)
                 
                    }
                }
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)
            }
        })
    }
}