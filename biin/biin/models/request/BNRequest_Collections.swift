//  BNRequest_Collections.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_Collections: BNRequest {

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
        self.requestType = BNRequestType.Collections
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    override func run() {
        
        println("BNRequest_Collections.run()")
        isRunning = true
        
        
        self.networkManager!.epsNetwork!.getJson(true, url:requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var result = self.networkManager!.findBool("result", dictionary: data)
                    
                    if result {
                        
                        var collectionList = Array<BNCollection>()
                        var collections = self.networkManager!.findNSArray("biinieCollections", dictionary: dataData)
                        
                        println("number of collections: \(collections?.count)")
                        
                        for var i = 0; i < collections?.count; i++ {
                            
                            var collectionData = collections!.objectAtIndex(i) as! NSDictionary
                            var collection = BNCollection()
                            collection.identifier = self.networkManager!.findString("identifier", dictionary: collectionData)
                            collection.title = NSLocalizedString("CollectionTitle", comment: "CollectionTitle")
                            collection.subTitle = NSLocalizedString("CollectionSubTitle", comment: "CollectionSubTitle")
                            
                            var elements = self.networkManager!.findNSArray("elements", dictionary: collectionData)
                            collection.items = Array<String>()
                            
                            if elements?.count > 0 {
                                
                                collection.elements = Dictionary<String, BNElement>()
                                
                                for ( var j = 0; j < elements?.count; j++ ) {
                                    var elementData = elements!.objectAtIndex(j) as! NSDictionary
                                    var element = BNElement()
                                    element.identifier = self.networkManager!.findString("identifier", dictionary: elementData)
                                    element._id = self.networkManager!.findString("_id", dictionary: elementData)
                                    collection.elements[element.identifier!] = element
                                    collection.items.append(element.identifier!)
                                }
                            }
                            
                            var sites = self.networkManager!.findNSArray("sites", dictionary: collectionData)
                            
                            if sites?.count > 0 {
                                
                                collection.sites = Dictionary<String, BNSite>()
                                
                                for ( var i = 0; i < sites?.count; i++ ) {
                                    var siteData = sites!.objectAtIndex(i) as! NSDictionary
                                    var site = BNSite()
                                    site.identifier = self.networkManager!.findString("identifier", dictionary: siteData)
                                    collection.sites[site.identifier!] = site
                                    collection.items.append(site.identifier!)
                                }
                            }
                            
                            collectionList.append(collection)
                            
                        }
                        
                        self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedCollections: collectionList)
                    }
                    
                } else {
                    println("NOT COLLECTION FOR \(self.requestString)")
                }
                
                self.inCompleted = true
                self.networkManager!.removeFromQueue(self)

            }
        })


    }

}