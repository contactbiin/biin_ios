//  BNLocalNotification.swift
//  biin
//  Created by Esteban Padilla on 6/18/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNLocalNotification:NSObject, NSCoding {

    var key:String?
    var text:String?
    var notificationType:BNLocalNotificationType?
    var itemIdentifier:String?
    
    override init() {
        super.init()
    }
    
    convenience init( key:String, text:String, notificationType:BNLocalNotificationType, itemIdentifier:String ) {
        self.init()
        self.key = key
        self.text = text
        self.notificationType = notificationType
        self.itemIdentifier = itemIdentifier
        
    }
    
    required init(coder aDecoder: NSCoder) {
        self.key  = aDecoder.decodeObjectForKey("key") as? String
        self.text = aDecoder.decodeObjectForKey("text") as? String
        self.itemIdentifier = aDecoder.decodeObjectForKey("itemIdentifier") as? String
        
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
        if let key = self.key {
            aCoder.encodeObject(key, forKey: "key")
        }
        
        if let text = self.text {
            aCoder.encodeObject(text, forKey: "text")
        }
        
        if let notificationType = self.notificationType?.hashValue {
            aCoder.encodeInteger(notificationType, forKey: "notificationType")
        }
        
        if let itemIdentifier = self.itemIdentifier {
            aCoder.encodeObject(itemIdentifier, forKey: "itemIdentifier")
        }
    }
    
    deinit {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:self.key!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.key!)
    }
    
    class func loadSaved(key:String) -> BNLocalNotification? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSData {
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