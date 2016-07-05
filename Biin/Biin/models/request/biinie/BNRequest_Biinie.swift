//  BNRequest_Biinie.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Biinie: BNRequest {
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, user:Biinie? ) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Biinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user = user
    }
    
    override func run() {
        
        //self.start = NSDate()

        isRunning = true
        attemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                //var response:BNResponse?
                
                if let biinieData = data["data"] as? NSDictionary {
                    
                    //let status = BNParser.findInt("status", dictionary: data)
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        //response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        
                        self.user!.identifier = BNParser.findString("identifier", dictionary:biinieData)
                        self.user!.biinName = BNParser.findString("biinName", dictionary: biinieData)
                        self.user!.firstName = BNParser.findString("firstName", dictionary: biinieData)
                        self.user!.lastName = BNParser.findString("lastName", dictionary: biinieData)
                        self.user!.email = BNParser.findString("email", dictionary: biinieData)
//                        self.user!.imgUrl = BNParser.findString("imgUrl", dictionary: biinieData)
                        self.user!.gender = BNParser.findString("gender", dictionary: biinieData)
                        self.user!.isEmailVerified = BNParser.findBool("isEmailVerified", dictionary: biinieData)
                        self.user!.birthDate = BNParser.findNSDate("birthDate", dictionary: biinieData)
                        self.user!.facebookAvatarUrl = BNParser.findString("facebookAvatarUrl", dictionary: biinieData)
                        //var friends = BNParser.findNSArray("friends", dictionary: biinieData)
                        
                        /*
                        var categories = Array<BNCategory>()
                        let categoriesData = BNParser.findNSArray("categories", dictionary: biinieData)
                        
                        if categoriesData!.count > 0 {
                            var i:Int = 0
                            for _ in categoriesData! {
                                
                                let categoryData = categoriesData!.objectAtIndex(i) as! NSDictionary
                                let category = BNCategory(identifier: BNParser.findString("identifier", dictionary: categoryData)!)
                                
                                category.name = BNParser.findString("name", dictionary: categoryData)
                                
                                categories.append(category)
                                i += 1
                            }
                        } else {

                        }
                        
                        self.user!.categories = categories
                        */
                        self.isCompleted = true
                        self.networkManager!.requestManager!.processCompletedRequest(self)
//                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedBiinieData:self.user!, isBiinieOnBD:true)
                        
                    } else {
                        self.requestError = BNRequestError.Biinie_NotRegistered
                        self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                        //self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedBiinieData:self.user!, isBiinieOnBD:false)
                    }
                    
                    /*
                    let end = NSDate()
                    let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                    print("BNRequest_Biinie [\(timeInterval)] - \(self.requestString)")
                    */
                    
                    
                } else  {
                    self.requestError = BNRequestError.Server
                    self.networkManager!.requestManager!.processFailedRequest(self, error: error)
                }
            }
        })
    }
}