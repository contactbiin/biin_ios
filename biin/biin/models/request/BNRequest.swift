//  BNRequest.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

struct BNRequestData
{
    static var requestCounter = 0
}

enum BNRequestType
{
    case None
    case Login
    case Register
    case Biinie
    case SendBiinie
    case SendBiiniePoints
    case SendBiinieActions
    case SendBiinieCategories
    case SendCollectedElement
    case SendUnCollectedElement
    case SendLikedElement
    case SendSharedElement
    case SendCollectedSite
    case SendUnCollectedSite
    case SendFollowedSite
    case SendLikedSite
    case SendSharedSite
    
    case CheckEmail_IsVerified
    case ConnectivityCheck
    
    case Site
    case Showcase
    case Element
    case Image
    case Categories
    case Organization
    case Collections
}

class BNRequest:NSObject {
    
    var isRunning = false
    var inCompleted = false
    var identifier:Int = 0
    var requestString:String = ""
    var dataIdentifier:String = ""//identifier for the object data is requested for.
    var requestType:BNRequestType = BNRequestType.None
    
    weak var showcase:BNShowcase?
    weak var element:BNElement?
    weak var organization:BNOrganization?
    weak var site:BNSite?
    weak var user:Biinie?
    weak var image:BNUIImageView?
    
    var points:Int = 0
    var categories:Dictionary<String, String>?
    
    var requestAttemps:Int = 0
    
    weak var errorManager:BNErrorManager?
    weak var networkManager:BNNetworkManager?
    
    override init() {
        super.init()
    }
    
    convenience init(requestString:String, dataIdentifier:String, requestType:BNRequestType){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        //println("NEW REQUEST \(self.identifier) for \(requestString)")
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = requestType
    }
    
    convenience init(requestString:String, dataIdentifier:String, requestType:BNRequestType, errorManager:BNErrorManager, networkManager:BNNetworkManager){

        self.init()
        self.identifier = BNRequestData.requestCounter++
        //println("NEW REQUEST \(self.identifier) for \(requestString)")
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = requestType
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    deinit{
        
    }
    
    func run() { }
    
    func clean() {
    
        print("BNRequest clean() = \(requestString)")
        
        showcase = nil
        element = nil
        organization = nil
        site = nil
        user = nil
        //image?.removeFromSuperview()
        categories?.removeAll()
        categories = nil

    }
}