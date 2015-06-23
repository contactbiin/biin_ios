//  BNLocalNotification.swift
//  biin
//  Created by Esteban Padilla on 6/18/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNLocalNotification:NSObject, NSCoding {

    var objectIdentifier:String?
    var notificationText:String?
    var notificationType:BNLocalNotificationType?
    var siteIdentifier:String?
    var biinIdentifier:String?
    var elementIdentifier:String?
    
    override init() {
        super.init()
    }
    
    convenience init( objectIdentifier:String, notificationText:String, notificationType:BNLocalNotificationType, siteIdentifier:String, biinIdentifier:String, elementIdentifier:String ) {
        self.init()
        self.objectIdentifier = objectIdentifier
        self.notificationText = notificationText
        self.notificationType = notificationType
        self.siteIdentifier = siteIdentifier
        self.biinIdentifier = biinIdentifier
        self.elementIdentifier = elementIdentifier
        
    }
    
    required init(coder aDecoder: NSCoder) {
        self.objectIdentifier  = aDecoder.decodeObjectForKey("objectIdentifier") as? String
        self.notificationText = aDecoder.decodeObjectForKey("notificationText") as? String
        self.siteIdentifier = aDecoder.decodeObjectForKey("siteIdentifier") as? String
        self.biinIdentifier = aDecoder.decodeObjectForKey("biinIdentifier") as? String
        self.elementIdentifier = aDecoder.decodeObjectForKey("elementIdentifier") as? String
        
        var value = aDecoder.decodeIntForKey("notificationType")
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
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
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
        
        if let elementIdentifier = self.elementIdentifier {
            aCoder.encodeObject(elementIdentifier, forKey: "elementIdentifier")
        }
    }
    
    deinit {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:self.objectIdentifier!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.objectIdentifier!)
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