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
        self.requestType = BNRequestType.Showcase
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
        self.showcase = showcase
    }
    
    override func run() {
        
        NSLog("BNRequest_Showcase.run()")
        isRunning = true
        requestAttemps++
        
        self.networkManager!.epsNetwork!.getJson(true, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                print("Error on showcase data")
                self.networkManager!.handleFailedRequest(self, error: error)
            } else {
                
                if let showcaseData = data["data"] as? NSDictionary {
                    
                    //var status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        self.showcase!.identifier = BNParser.findString("identifier", dictionary: showcaseData)
                        self.showcase!.lastUpdate = BNParser.findNSDate("lastUpdate", dictionary: showcaseData)
                        //self.showcase!.theme = BNParser.findBNShowcaseTheme("theme", dictionary: showcaseData)
                        self.showcase!.showcaseType = BNParser.findBNShowcaseType("showcaseType", dictionary: showcaseData)
                        self.showcase!.title = BNParser.findString("title", dictionary: showcaseData)
                        self.showcase!.subTitle = BNParser.findString("subTitle", dictionary: showcaseData)
                        self.showcase!.titleColor = BNParser.findUIColor("titleColor", dictionary: showcaseData)!
                        let elements = BNParser.findNSArray("elements", dictionary: showcaseData)
                        
                        for var i = 0; i < elements?.count; i++ {
                            
                            let elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                            let element = BNElement()
                            element._id = BNParser.findString("_id", dictionary: elementData)
                            element.identifier = BNParser.findString("elementIdentifier", dictionary: elementData)
                            element.jsonUrl = BNParser.findString("jsonUrl", dictionary: elementData)
                            element.userViewed = BNParser.findBool("hasBeenSeen", dictionary: elementData)
                            element.color = UIColor.elementColor()
                            //element.siteIdentifier = self.showcase!.site!.identifier!// .siteIdentifier!
                            element.showcase = self.showcase
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