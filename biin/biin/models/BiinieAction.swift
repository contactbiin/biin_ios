//
//  BiinieAction.swift
//  biin
//
//  Created by Esteban Padilla on 3/24/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation

struct BiinieActionData
{
    static var actionCounter = 0
}

class BiinieAction:NSObject, NSCoding {

    var key:String?
    var at:NSDate?
    var did:Int?
    var to:String?

    override init() {
        super.init()
    }
    
    convenience init(at:NSDate, did:Int, to:String) {
        self.init()
        var actionCounter = BiinieActionData.actionCounter++
        self.key = "key\(actionCounter)"
        self.at = at
        self.did = did
        self.to = to
    }
    
    required init(coder aDecoder: NSCoder) {
        self.key = aDecoder.decodeObjectForKey("key") as? String
        self.at  = aDecoder.decodeObjectForKey("at") as? NSDate
        self.did = aDecoder.decodeIntegerForKey("did")
        self.to  = aDecoder.decodeObjectForKey("to") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let key = self.key {
            aCoder.encodeObject(key, forKey: "key")
        }
        
        if let at = self.at {
            aCoder.encodeObject(at, forKey: "at")
        }
        
        if let did = self.did {
            aCoder.encodeObject(did, forKey: "did")
        }
        
        if let to = self.did {
            aCoder.encodeObject(to, forKey: "to")
        }
    }
    
    deinit {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: self.key!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.key!)
    }
    
    class func loadSaved(key:String) -> BiinieAction? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BiinieAction
        }
        
        return nil
    }


}
