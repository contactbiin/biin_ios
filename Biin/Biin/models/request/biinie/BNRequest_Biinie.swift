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
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, biinie:Biinie? ) {
        
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Biinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.biinie = biinie
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
                        
                        self.biinie!.identifier = BNParser.findString("identifier", dictionary:biinieData)
                        self.biinie!.biinName = BNParser.findString("biinName", dictionary: biinieData)
                        self.biinie!.firstName = BNParser.findString("firstName", dictionary: biinieData)
                        self.biinie!.lastName = BNParser.findString("lastName", dictionary: biinieData)
                        self.biinie!.email = BNParser.findString("email", dictionary: biinieData)
//                        self.user!.imgUrl = BNParser.findString("imgUrl", dictionary: biinieData)
                        self.biinie!.gender = BNParser.findString("gender", dictionary: biinieData)
                        self.biinie!.isEmailVerified = BNParser.findBool("isEmailVerified", dictionary: biinieData)
                        self.biinie!.birthDate = BNParser.findNSDate("birthDate", dictionary: biinieData)
                        self.biinie!.facebookAvatarUrl = BNParser.findString("facebookAvatarUrl", dictionary: biinieData)
                        self.biinie!.friends = BNParser.parseFriends(biinieData) as! Array<Biinie>//BNParser.findNSArray("facebookFriends", dictionary: biinieData)
                        
                        
                        let giftsData = BNParser.findNSArray("gifts", dictionary: biinieData)
        
                        if giftsData?.count > 0 {
                            BNParser.parseGifts(giftsData, biinie: self.biinie)
                        }
                
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