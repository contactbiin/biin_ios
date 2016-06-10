//  BNRequest_CollectionsForBiinie.swift
//  biin
//  Created by Esteban Padilla on 12/4/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNRequest_CollectionsForBiinie: BNRequest {
    
    override init(){ super.init() }
    var category:BNCategory?
    
    deinit { }
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        //self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.CollectionsForBiinie
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    
    
    override func run() {
        
        //self.start = NSDate()
        
        isRunning = true
        requestAttemps += 1
        
        self.networkManager!.epsNetwork!.getJson(self.identifier, url: self.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.networkManager!.handleFailedRequest(self, error: error )
            } else {
                
                if let initialData = data["data"] as? NSDictionary {
                    
                    if BNParser.findBool("result", dictionary: data) {
                        
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
                        
                        //Parse collection
                        var collectionList = Array<BNCollection>()
                        
                        if let collections = BNParser.findNSArray("collections", dictionary: initialData) {
                            
                            for o in (0..<collections.count) {
                                
                                let collectionData = collections.objectAtIndex(o) as! NSDictionary
                                let collection = BNCollection()
                                collection.identifier = BNParser.findString("identifier", dictionary: collectionData)
                                collection.title = NSLocalizedString("CollectionTitle", comment: "CollectionTitle")
                                collection.subTitle = NSLocalizedString("CollectionSubTitle", comment: "CollectionSubTitle")
                                
                                if let elements = BNParser.findNSArray("elements", dictionary: collectionData) {
                                //collection.items = Array<String>()
                                
                                    if elements.count > 0 {
                                    
                                        collection.elements = Dictionary<String, BNElement>()
                                        
                                        for p in (0..<elements.count){
                                            let elementData = elements.objectAtIndex(p) as! NSDictionary
                                            
                                            
                                            let _id = BNParser.findString("_id", dictionary: elementData)
                                            let showcase_id = BNParser.findString("showcase_id", dictionary: elementData)
                                            let identifier = BNParser.findString("identifier", dictionary: elementData)
                                            
//                                        print("element for category")
//                                        print("id:\(_id)")
//                                        print("identifier:\(identifier!)")
//                                        print("showcase:\(showcase_id!)")
                                            
                                            let element = BNElement()
                                            element.identifier = identifier
//                                            element._id = _id
                                            element.isRemovedFromShowcase = BNParser.findBool("isRemovedFromShowcase", dictionary: elementData)
                                            let showcase = BNShowcase()
                                            showcase._id = showcase_id
                                            element.showcase = showcase
//                                            collection.elements[element._id!] = element
                                            //collection.items.append(element.identifier!)
                                        }
                                    }
                                
                                }
                                collectionList.append(collection)
                            }
                            
                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedCollections: collectionList)
                            
                        }
                    }
                    
                    /*
                    let end = NSDate()
                    let timeInterval: Double = end.timeIntervalSinceDate(self.start!)
                    print("BNRequest_CollectionsForBiinie  \(timeInterval)  - \(self.requestString)")
                    */
                    
                    //self.view!.requestCompleted()
                    self.inCompleted = true
                    self.networkManager!.removeFromQueue(self)
                    
                } else  {
                    
                    self.requestType = BNRequestType.ServerError
                    self.networkManager!.handleFailedRequest(self, error: NSError(domain: "none", code: 0, userInfo: nil) )
                }
            }
        })
    }
}

