//  BNRequest_Collections.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Collections: BNRequest {

    override init(){ super.init() }
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.Collections
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps++
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url:requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)
                    
                    if result {
                        
                        var collectionList = Array<BNCollection>()
                        let collections = BNParser.findNSArray("biinieCollections", dictionary: dataData)
                        
                        for var i = 0; i < collections?.count; i++ {
                            
                            let collectionData = collections!.objectAtIndex(i) as! NSDictionary
                            let collection = BNCollection()
                            collection.identifier = BNParser.findString("identifier", dictionary: collectionData)
                            collection.title = NSLocalizedString("CollectionTitle", comment: "CollectionTitle")
                            collection.subTitle = NSLocalizedString("CollectionSubTitle", comment: "CollectionSubTitle")
                            
                            let elements = BNParser.findNSArray("elements", dictionary: collectionData)
                            //collection.items = Array<String>()
                            
                            if elements?.count > 0 {
                                
                                collection.elements = Dictionary<String, BNElement>()
                                
                                for ( var j = 0; j < elements?.count; j++ ) {
                                    let elementData = elements!.objectAtIndex(j) as! NSDictionary
                                    let element = BNElement()
                                    element.identifier = BNParser.findString("identifier", dictionary: elementData)
                                    element._id = BNParser.findString("_id", dictionary: elementData)
                                    collection.elements[element.identifier!] = element
                                    //collection.items.append(element.identifier!)
                                }
                            }
                            
                            collectionList.append(collection)
                        }
                        
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedCollections: collectionList)
                    }
                    
                } else {
                    
                }
                
                /*
                let end = NSDate()
                let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                print("BNRequest_Collections [\(timeInterval)] - \(self.requestString)")
                */
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)

            }
        })
    }
}