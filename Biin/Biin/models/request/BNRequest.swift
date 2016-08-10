//  BNRequest.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

struct BNRequestData { static var requestCounter:Int = 0 }

enum BNRequestError
{
    case None
    case Login_Failed
    case Login_Facebook_Failed
    case Register_Failed
    case Register_Facebook_Failed
    case Biinie_Failed
    case SendBiinie_Failed
    case SendBiinieActions //NOT IN USE
    case SendBiinieToken_Failed
    case SendBiinieOnEnterSite_Failed
    case SendBiinieOnExitSite_Failed
    
    case InitialData_Failed
    case VersionCheck_NeedsUpdate
    
    case ElementsForCategory_Failed
    case ElementsForShowcase_Failed
    
    case Biinie_NotRegistered
    
    case SendClaimedGift_Failed
    case SendRefusedGift_Failed
    
    case DoNotShowError
    case Internet_Failed
    case Server
    
    case SendLoyaltyCompleted_Failed
    case SendLoyaltyEnroll_Failed
    case SendLoyaltyStar_Failed
}

enum BNRequestType
{
    case None
    case Login
    case Login_Facebook
    case Register
    case Register_Facebook
    case Biinie
    case SendBiinie
    case SendBiinie_Update
    case SendBiinieActions
    case SendBiinieToken
    case SendBiinieOnEnterSite
    case SendBiinieOnExitSite
    
    case InitialData
    case VersionCheck
    
    
    case SendLikedElement
    case SendSharedElement
    
    case SendLikedSite
    case SendSharedSite

    case Sites
    case Image
    
    case SendSurvey
    case ServerError
    
    case ElementsForCategory
    case ElementsForShowcase
    
    case SendClaimedGift
    case SendRefusedGift
    
    case SendLoyaltyCompleted
    case SendLoyaltyEnroll
    case SendLoyaltyStar
}



class BNRequest:NSObject {
    
    var start:NSDate?
    
    static var requestCounter:Int = 0
    
    var isRunning = false
    var isCompleted = false
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
    weak var biinie:Biinie?
    weak var gift:BNGift?
    weak var loyalty:BNLoyalty?
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
        biinie = nil
        categories?.removeAll()
        categories = nil
        errorManager = nil
        networkManager = nil
    }
    
    func get_request_identifier() -> Int {
        struct Holder {
            static var timesCalled = 0
        }
        
        Holder.timesCalled += 1
        
        return Holder.timesCalled
    }
}
