//  BNRequest_Categories.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Categories: BNRequest {
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Categories
        self.errorManager = errorManager
        self.networkManager = networkManager
        
    }
    
    override func run() {
        

        isRunning = true
        requestAttemps++
        
        self.networkManager!.epsNetwork!.getJson(false, url:self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var categories = Array<BNCategory>()
                    let categoriesData = BNParser.findNSArray("categories", dictionary: dataData)
                    
                    for var i = 0; i < categoriesData?.count; i++ {
                        
                        let categoryData = categoriesData!.objectAtIndex(i) as! NSDictionary
                        let category = BNCategory(identifier: BNParser.findString("identifier", dictionary: categoryData)!)
                        
                        category.name = BNParser.findString("name", dictionary: categoryData)
                        //category.priority = BNParser.findInt("priority", dictionary: categoryData)!
                        category.hasSites = BNParser.findBool("hasSites", dictionary: categoryData)
                        
                        if category.hasSites {
                            let sites = BNParser.findNSArray("sites", dictionary: categoryData)
                            
                            for var j = 0; j < sites?.count; j++ {
                                
                                let siteData = sites!.objectAtIndex(j) as! NSDictionary
                                
                                
                                if let siteIdentifier = BNParser.findString("identifier", dictionary: siteData) {
                                    var siteDetails = BNCategorySiteDetails()
                                    siteDetails.identifier = siteIdentifier
                                    siteDetails.json = BNParser.findString("jsonUrl", dictionary: siteData)
                                    siteDetails.biinieProximity = BNParser.findFloat("biinieProximity", dictionary: siteData)
                                    category.sitesDetails.append(siteDetails)
                                }
                            }
                        }
                        
                        if category.sitesDetails.count == 0 {
                            
                        }
                        
                        categories.append(category)
                    }
   
                    self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserCategories:categories)
                    self.inCompleted = true
                    self.networkManager!.removeFromQueue(self)
                }
            }
        })
    }
    
    
}