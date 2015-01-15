//  BNError.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNError:NSObject
{
    var code:String = ""
    var title:String = ""
    var errorDescription:String = ""
    var proximityUUID:String = ""
    var region:String = ""
    var errorType:BNErrorType?
    
    override init() {
        super.init()
    }
    
    convenience init(code:String, title:String, errorDescription:String, proximityUUID:String, region:String, errorType:BNErrorType){
        self.init()
        self.code = code
        self.title = title
        self.errorDescription = errorDescription
        self.proximityUUID = proximityUUID
        self.region = region
        self.errorType = errorType
    }
    
    deinit {
        
    }
}


enum BNErrorType
{
    case none
    case nilShowcase
}