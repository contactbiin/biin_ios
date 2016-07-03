//  BNRequest_ElementsForCategory.swift
//  biin
//  Created by Esteban Padilla on 11/23/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_ElementsForCategory: BNRequest {
    
    override init(){ super.init() }
    var category:BNCategory?
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, category:BNCategory?, view:BNView?){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.ElementsForCategory
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.category = category
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
                    
                    if BNParser.findBool("result", dictionary: data) {
                        
                        //Parse categories
                        if let categoryData = BNParser.findNSArray("elementsForCategory", dictionary: initialData) {
                            
                            if categoryData.count > 0 {
                            
                                for o in (0..<categoryData.count) {
                                    
                                    let elementData = categoryData.objectAtIndex(o) as! NSDictionary
                                    
                                    if let identifier = BNParser.findString("identifier", dictionary: elementData) {
                                        if let showcaseIdentifier = BNParser.findString("showcaseIdentifier", dictionary: elementData) {
                                            if let siteIdentifier = BNParser.findString("siteIdentifier", dictionary: elementData) {
                                                let highlight = BNElementRelationShip(identifier: identifier, showcase: showcaseIdentifier, site: siteIdentifier)
                                                self.category!.elements.append(highlight)
                                            }
                                        }
                                    }
                                }
                                
                                if let showcasesData = BNParser.findNSArray("showcases", dictionary: initialData) {
                                    BNParser.parseShowcases(showcasesData)
                                }
                                
                                if let noticesData = BNParser.findNSArray("notices", dictionary: initialData) {
                                    BNParser.parseNotices(noticesData)
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
                                
                                self.view!.requestCompleted()
                                
                            } else  {
                                self.view!.isAllDownloaded = true
                            }
                        }
                    }
                
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
