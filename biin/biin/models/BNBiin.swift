//  BNBiin.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation


class BNBiin:NSObject
{
    var identifier:String?
    var minor:Int?

    var isBiinDataCorrupted:Bool = false
    var isBiinDetected:Bool = false
    
    weak var site:BNSite?
    var showcase:BNShowcase?

    
    var isWebBiin = false
    
    //TODO: Remove biin type and
    var bnBiinType = BNBiinType.Web
    
    var state:Biin_State?
    
    override init() {
        super.init()
        self.isBiinDataCorrupted = false
        self.isBiinDetected = false
    }
    
    deinit{
        
    }
}

enum BNBiinType {
    case Web    //1
    case Beacon //2
}