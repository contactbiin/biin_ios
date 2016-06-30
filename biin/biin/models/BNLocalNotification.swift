//  BNLocalNotification.swift
//  biin
//  Created by Esteban Padilla on 6/18/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNLocalNotification:NSObject, NSCoding {

    var object_id:String?
    var objectIdentifier:String?
    var notificationText:String?
    var notificationType:BNLocalNotificationType?
    var siteIdentifier:String?
    var biinIdentifier:String?
    //var elementIdentifier:String?
    
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
    
    convenience init( object_id:String, objectIdentifier:String, notificationText:String, notificationType:BNLocalNotificationType, siteIdentifier:String, biinIdentifier:String, elementIdentifier:String ) {
        self.init()
        self.object_id = object_id
        self.objectIdentifier = objectIdentifier
        self.notificationText = notificationText
        self.notificationType = notificationType
        self.siteIdentifier = siteIdentifier
        self.biinIdentifier = biinIdentifier
        //self.elementIdentifier = elementIdentifier
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.object_id  = aDecoder.decodeObjectForKey("object_id") as? String

        if let object_identifier  = aDecoder.decodeObjectForKey("objectIdentifier") as? String {
            self.objectIdentifier  = object_identifier
        } else {
            self.objectIdentifier = ""
        }
        
        self.notificationText = aDecoder.decodeObjectForKey("notificationText") as? String
        self.siteIdentifier = aDecoder.decodeObjectForKey("siteIdentifier") as? String
        self.biinIdentifier = aDecoder.decodeObjectForKey("biinIdentifier") as? String
        //self.elementIdentifier = aDecoder.decodeObjectForKey("elementIdentifier") as? String
        
        let value = aDecoder.decodeIntForKey("notificationType")
        switch value {
        case 0:
            self.notificationType = .NONE
        case 1:
            self.notificationType = .EXTERNAL
        case 2:
            self.notificationType = .INTERNAL
        case 3:
            self.notificationType = .PRODUCT
        default:
            break
        }
        
        //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
        self.onMonday = aDecoder.decodeBoolForKey("onMonday")
        self.onTuesday = aDecoder.decodeBoolForKey("onTuesday")
        self.onWednesday = aDecoder.decodeBoolForKey("onWednesday")
        self.onThursday = aDecoder.decodeBoolForKey("onThursday")
        self.onFriday = aDecoder.decodeBoolForKey("onFriday")
        self.onSaturday = aDecoder.decodeBoolForKey("onSaturday")
        self.onSunday = aDecoder.decodeBoolForKey("onSunday")
        self.hasTimeOptions = aDecoder.decodeBoolForKey("hasTimeOptions")
        self.endTime = aDecoder.decodeFloatForKey("endTime")
        self.startTime = aDecoder.decodeFloatForKey("startTime")
        self.isUserNotified = aDecoder.decodeBoolForKey("isUserNotified")
        self.major = aDecoder.decodeIntegerForKey("major")
        self.minor = aDecoder.decodeIntegerForKey("minor")
        self.fireDate = aDecoder.decodeObjectForKey("fireDate") as? NSDate
}
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let object_id = self.object_id {
            aCoder.encodeObject(object_id, forKey: "object_id")
        }
        
        if let objectIdentifier = self.objectIdentifier {
            aCoder.encodeObject(objectIdentifier, forKey: "objectIdentifier")
        }
        
        if let notificationText = self.notificationText {
            aCoder.encodeObject(notificationText, forKey: "notificationText")
        }
        
        if let notificationType = self.notificationType?.hashValue {
            aCoder.encodeInteger(notificationType, forKey: "notificationType")
        }
        
        if let siteIdentifier = self.siteIdentifier {
            aCoder.encodeObject(siteIdentifier, forKey: "siteIdentifier")
        }
        
        if let biinIdentifier = self.biinIdentifier {
            aCoder.encodeObject(biinIdentifier, forKey: "biinIdentifier")
        }
        
//        if let elementIdentifier = self.elementIdentifier {
//            aCoder.encodeObject(elementIdentifier, forKey: "elementIdentifier")
//        }
        
        aCoder.encodeBool(self.onMonday, forKey: "onMonday")
        aCoder.encodeBool(self.onTuesday, forKey: "onTuesday")
        aCoder.encodeBool(self.onWednesday, forKey: "onWednesday")
        aCoder.encodeBool(self.onThursday, forKey: "onThursday")
        aCoder.encodeBool(self.onFriday, forKey: "onFriday")
        aCoder.encodeBool(self.onSaturday, forKey: "onSaturday")
        aCoder.encodeBool(self.onSunday, forKey: "onSunday")
        aCoder.encodeBool(self.hasTimeOptions, forKey: "hasTimeOptions")
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
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:self.object_id!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.object_id!)
    }
    
    class func loadSaved(objectIdentifier:String) -> BNLocalNotification? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(objectIdentifier) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNLocalNotification
        }
        return nil
    }
}

enum BNLocalNotificationType {
    case NONE
    case EXTERNAL
    case INTERNAL
    case PRODUCT
}