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
    //var showcase:BNShowcase?
    var showcases = Array<BNShowcase>()
    
    //TODO: Remove biin type and
    var bnBiinType = BNBiinType.PRODUCT
    
    var state:Biin_State?
    
    override init() {
        super.init()
        self.isBiinDataCorrupted = false
        self.isBiinDetected = false
    }
    
    deinit{
        
    }
    
    func currectShowcase()->BNShowcase {
        //TODO: get the correct showcase depending on the time
        return showcases[0]
    }
}

enum BNBiinType {
    case EXTERNO    //1
    case INTERNO    //2
    case PRODUCT    //3
}