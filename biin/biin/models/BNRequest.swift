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
    case ConnectivityCheck
    case TimeNone
    case Network
    case Regions                //request regions on BNNetworkManager
    case RegionData             //request region data on BNNetworkManager
    case UserCategories         //request user categories data on BNNetworkManager
    case SiteData
    case ShowcaseData           //request showcase data on BNNetworkManager
    case ElementData     //request element data for a user
    case SaveError              //save error on server on BNNetworkManager
    case ImageData
    case InitialData
    case RemoveShowcase
    case BiinieData
    case SharedBiins
    case BiinedElements //Elements biined by user
    case Boards //User boards
}

class BNRequest:NSObject {
    
    var identifier:Int = 0
    var requestString:String = ""
    var dataIdentifier:String = ""//identifier for the object data is requested for.
    var requestType:BNRequestType = BNRequestType.None
    
    override init() {
        super.init()
    }
    
    convenience init(requestString:String, dataIdentifier:String, requestType:BNRequestType){
        self.init()
        self.identifier = BNRequestData.requestCounter++
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = requestType
    }
    
    deinit{
        
    }
}
