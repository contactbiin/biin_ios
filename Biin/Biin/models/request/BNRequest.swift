//  BNRequest.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

struct BNRequestData { static var requestCounter:Int = 0 }

enum BNRequestError
{
    case None
    case InitialData_Failed
    case VersionCheck_NeedsUpdate
    case Biinie_Failed
    case Biinie_NotRegistered
    case SendBiinieToken_Failed
    case DoNotShowError
    case Internet_Failed
    case Server
}

enum BNRequestType
{
    case None
    case Login
    case Register
    case Biinie
    case SendBiinie
    case SendBiinieActions
    case SendBiinieToken
    
    case SendCollectedElement
    case SendUnCollectedElement
    case SendLikedElement
    case SendSharedElement
    case SendCollectedSite
    case SendUnCollectedSite
    case SendFollowedSite
    case SendLikedSite
    case SendSharedSite

    case VersionCheck
    
    case Site
    case Sites
    case Showcase
    case Element
    case Image
    case Categories
    case Organization

    case ServerError
    case InitialData
    case ElementsForShowcase
    
    case SendSurvey
    
    case ElementsForCategory
}



class BNRequest:NSObject {
    
    var start:NSDate?
    
    static var requestCounter:Int = 0
    
    var isRunning = false
    var inCompleted = false
    var identifier:Int = 0
    var requestString:String = ""
    var dataIdentifier:String = ""//identifier for the object data is requested for.
    var requestType:BNRequestType = BNRequestType.None
    var requestError:BNRequestError = BNRequestError.None
    var rating:Int = 0
    var comment:String = ""
    
    weak var showcase:BNShowcase?
    weak var element:BNElement?
    weak var organization:BNOrganization?
    weak var site:BNSite?
    weak var user:Biinie?
    weak var image:BNUIImageView?
    weak var view:BNView?
    
    var points:Int = 0
    var categories:Dictionary<String, String>?
    
    var attemps:Int = 0
    var attempsLimit:Int = 5
    
    weak var errorManager:BNErrorManager?
    weak var networkManager:BNNetworkManager?
    
    override init() {
        super.init()
        identifier = get_request_identifier()
    }
    
    convenience init(requestString:String, dataIdentifier:String, requestType:BNRequestType){
        self.init()
        //self.identifier = BNRequestData.requestCounter +Int(1)
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = requestType
    }
    
    convenience init(requestString:String, dataIdentifier:String, requestType:BNRequestType, errorManager:BNErrorManager, networkManager:BNNetworkManager){
        self.init()
        //self.identifier = BNRequestData.requestCounter += 1
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = requestType
        self.errorManager = errorManager
        self.networkManager = networkManager
    }
    
    deinit { }
    
    func run() { }
    
    func reset() {
        self.requestError = .None
        self.isRunning = false
        self.attemps = 0
    }
    
    func clean() {
        showcase = nil
        element = nil
        organization = nil
        site = nil
        user = nil
        categories?.removeAll()
        categories = nil
    }
    
    func get_request_identifier() -> Int {
        struct Holder {
            static var timesCalled = 0
        }
        
        Holder.timesCalled += 1
        
        return Holder.timesCalled
    }
}
