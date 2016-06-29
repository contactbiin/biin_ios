//  BNRequest_InitialData.swift
//  biin
//  Created by Esteban Padilla on 11/10/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit


class BNRequest_InitialData: BNRequest {
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.InitialData
        self.errorManager = errorManager
        self.networkManager = networkManager

    }
    
    override func run() {
                
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps += 1
        
        //print("INITIAL REQUEST: \(self.requestString)")
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let initialData = data["data"] as? NSDictionary {
                    
                    
                    if BNParser.findBool("result", dictionary: data) {
                        
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
                        
                        //Parse categories
                        if let categoriesData = BNParser.findNSArray("categories", dictionary: initialData) {
                            BNParser.parseCategories(categoriesData)
                        }
                        
                        //ONLY ON INITIAL DATA
                        //Parse hightlights
                        if let hightlightsData = BNParser.findNSArray("highlights", dictionary: initialData) {
                            BNParser.parseHightlights(hightlightsData)
                        }
                        
                        if let nearbySitesData = BNParser.findNSArray("nearbySites", dictionary: initialData) {
                            BNParser.parseNearbySites(nearbySitesData)
                        }
                        
                        if let favoritesData = BNParser.findNSDictionary("favorites", dictionary: initialData) {
                            BNParser.parseFavorites(favoritesData)
                        }
                        
                        if let noticesData = BNParser.findNSArray("notices", dictionary: initialData) {
                            BNParser.parseNotices(noticesData)
                        }
                    }
                    
                    /*
                    let end = NSDate()
                    let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                    print("BNRequest_InitialData  \(timeInterval)  - \(self.requestString)")
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
