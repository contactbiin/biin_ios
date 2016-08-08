//  BNNotice.swift
//  biin
//  Created by Esteban Padilla on 6/8/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

// This class is only to store information about the notices trigger by the ibeacons.

import Foundation

class BNNotice:NSObject, NSCoding {
    
    var identifier:String?
    var elementIdentifier:String?
    var name:String?
    var message:String?

    var siteIdentifier:String?
    
    //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
    var onMonday = false
    var onTuesday = false
    var onWednesday = false
    var onThursday = false
    var onFriday = false
    var onSaturday = false
    var onSunday = false
    
    var hasTimeOptions = false
    
    var endTime:Float = 0.0
    var startTime:Float = 0.0
    var isUserNotified = false
    
    var minor:Int = 0
    var major:Int = 0
    
    var fireDate:NSDate?
    
    override init() {
        super.init()
    }
    
    convenience init( identifier:String, elementIdentifier:String, name:String, message:String) {
        self.init()
        self.identifier = identifier
        self.elementIdentifier = elementIdentifier
        self.name = name
        self.message = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.identifier  = aDecoder.decodeObjectForKey("identifier") as? String
        self.elementIdentifier  = aDecoder.decodeObjectForKey("elementIdentifier") as? String
        self.siteIdentifier = aDecoder.decodeObjectForKey("siteIdentifier") as? String
        
        self.name  = aDecoder.decodeObjectForKey("name") as? String
        self.message  = aDecoder.decodeObjectForKey("message") as? String
        
        

        //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
        self.onMonday = aDecoder.decodeBoolForKey("onMonday")
        self.onTuesday = aDecoder.decodeBoolForKey("onTuesday")
        self.onWednesday = aDecoder.decodeBoolForKey("onWednesday")
        self.onThursday = aDecoder.decodeBoolForKey("onThursday")
        self.onFriday = aDecoder.decodeBoolForKey("onFriday")
        self.onSaturday = aDecoder.decodeBoolForKey("onSaturday")
        self.onSunday = aDecoder.decodeBoolForKey("onSunday")
        self.endTime = aDecoder.decodeFloatForKey("endTime")
        self.startTime = aDecoder.decodeFloatForKey("startTime")
        self.isUserNotified = aDecoder.decodeBoolForKey("isUserNotified")
        self.major = aDecoder.decodeIntegerForKey("major")
        self.minor = aDecoder.decodeIntegerForKey("minor")
        self.fireDate = aDecoder.decodeObjectForKey("fireDate") as? NSDate
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let identifier = self.identifier {
            aCoder.encodeObject(identifier, forKey: "identifier")
        }
        
        if let elementIdentifier = self.elementIdentifier {
            aCoder.encodeObject(elementIdentifier, forKey: "elementIdentifier")
        }
        
        if let siteIdentifier = self.siteIdentifier {
            aCoder.encodeObject(siteIdentifier, forKey: "siteIdentifier")
        }
        
        if let name = self.name {
            aCoder.encodeObject(name, forKey: "name")
        }
        
        if let message = self.message {
            aCoder.encodeObject(message, forKey: "message")
        }
        
        aCoder.encodeBool(self.onMonday, forKey: "onMonday")
        aCoder.encodeBool(self.onTuesday, forKey: "onTuesday")
        aCoder.encodeBool(self.onWednesday, forKey: "onWednesday")
        aCoder.encodeBool(self.onThursday, forKey: "onThursday")
        aCoder.encodeBool(self.onFriday, forKey: "onFriday")
        aCoder.encodeBool(self.onSaturday, forKey: "onSaturday")
        aCoder.encodeBool(self.onSunday, forKey: "onSunday")
        aCoder.encodeBool(self.isUserNotified, forKey: "isUserNotified")
        aCoder.encodeFloat(self.startTime, forKey: "startTime")
        aCoder.encodeFloat(self.endTime, forKey: "endTime")
        
        aCoder.encodeInteger(self.major, forKey: "major")
        aCoder.encodeInteger(self.minor, forKey: "minor")
        
        if let fireDate = self.fireDate {
            aCoder.encodeObject(fireDate, forKey: "fireDate")
        }
    }
    
    deinit {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:self.identifier!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.identifier!)
    }
    
    class func loadSaved(identifier:String) -> BNNotice? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNNotice
        }
        return nil
    }
}
