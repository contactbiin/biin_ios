//  BNRegion.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNRegion : NSObject
{
    var identifier:String?
    var radious:Int?
    var latitude:Float?
    var longitude:Float?
    var sites = Dictionary<String, BNSite>()
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
}