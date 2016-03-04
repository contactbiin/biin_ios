//  BNSettings.swift
//  biin
//  Created by Esteban Padilla on 8/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNSettings:NSObject, NSCoding {

    var IS_USING_CACHE = false
    var IS_QA_DATABASE = false
    var IS_DEMO_DATABASE = false
    var IS_PRODUCTION_DATABASE = false
    var IS_DEVELOPMENT_DATABASE = true

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.IS_PRODUCTION_DATABASE  = aDecoder.decodeBoolForKey("IS_PRODUCTION_DATABASE")
        self.IS_DEVELOPMENT_DATABASE  = aDecoder.decodeBoolForKey("IS_DEVELOPMENT_DATABASE")
        self.IS_QA_DATABASE  = aDecoder.decodeBoolForKey("IS_QA_DATABASE")
        self.IS_DEMO_DATABASE  = aDecoder.decodeBoolForKey("IS_DEMO_DATABASE")
        self.IS_USING_CACHE  = aDecoder.decodeBoolForKey("IS_USING_CACHE")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(IS_PRODUCTION_DATABASE, forKey: "IS_PRODUCTION_DATABASE")
        aCoder.encodeBool(IS_DEVELOPMENT_DATABASE, forKey: "IS_DEVELOPMENT_DATABASE")
        aCoder.encodeBool(IS_QA_DATABASE, forKey: "IS_QA_DATABASE")
        aCoder.encodeBool(IS_DEMO_DATABASE, forKey: "IS_DEMO_DATABASE")
        aCoder.encodeBool(IS_USING_CACHE, forKey: "IS_USING_CACHE")
    }
    
    deinit { }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "bnSettings")
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("bnSettings")
    }
    
    class func loadSaved() -> BNSettings? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("bnSettings") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNSettings
        }
        
        return nil
    }
}