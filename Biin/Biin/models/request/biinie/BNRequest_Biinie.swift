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
                        //var friends = BNParser.findNSArray("friends", dictionary: biinieData)
                        
                        
                        let giftsData = BNParser.findNSArray("gifts", dictionary: biinieData)
                        
                        if giftsData?.count > 0 {
                            
                            self.biinie!.gifts = Array<BNGift>()
                            
                            for i in (0..<giftsData!.count) {
                                let gift = BNGift()
                                
                                let giftData = giftsData!.objectAtIndex(i) as! NSDictionary
                                gift.identifier = BNParser.findString("identifier", dictionary: giftData)
                                gift.elementIdentifier = BNParser.findString("productIdentifier", dictionary: giftData)
                                gift.organizationIdentifier = BNParser.findString("organizationIdentifier", dictionary: giftData)
                                gift.name = BNParser.findString("name", dictionary: giftData)
                                gift.message = BNParser.findString("message", dictionary: giftData)
                                gift.status = BNParser.findBNGiftStatue("status", dictionary: giftData)
                                gift.receivedDate = BNParser.findNSDateWithBiinFormat("receivedDate", dictionary: giftData)
                                gift.hasExpirationDate = BNParser.findBool("hasExpirationDate", dictionary: giftData)
                                
                                if gift.hasExpirationDate {
                                    gift.expirationDate = BNParser.findNSDateWithBiinFormat("expirationDate", dictionary: giftData)
                                }
                                
                                if let sitesData = BNParser.findNSArray("sites", dictionary: giftData) {
                                    if sitesData.count > 0 {
                                        for j in (0..<sitesData.count) {
                                            gift.sites!.append(sitesData.objectAtIndex(j) as! String)
                                        }
                                    }
                                }
                                
                                if let mediaArray = BNParser.findNSArray("media", dictionary: giftData) {
                                    for b in (0..<mediaArray.count) {
                                        let mediaData = mediaArray.objectAtIndex(b) as! NSDictionary
                                        let url = BNParser.findString("url", dictionary:mediaData)
                                        let type = BNMediaType.Image
                                        let vibrantColor = BNParser.findUIColor("vibrantColor", dictionary: mediaData)
                                        let vibrantDarkColor = BNParser.findUIColor("vibrantDarkColor", dictionary: mediaData)
                                        let vibrantLightColor = BNParser.findUIColor("vibrantLightColor", dictionary: mediaData)
                                        let media = BNMedia(mediaType:type, url:url!, vibrantColor: vibrantColor!, vibrantDarkColor: vibrantDarkColor!, vibrantLightColor: vibrantLightColor!)
                                        gift.media!.append(media)
                                    }
                                }
                                
                                self.biinie!.gifts.append(gift)
                            }
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