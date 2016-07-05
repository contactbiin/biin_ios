//  BNGift.swift
//  Biin
//  Created by Esteban Padilla on 7/5/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.
import Foundation

class BNGift:NSObject, NSCoding {
    
    var identifier:String?
    var elementIdentifier:String?
    var name:String?
    var message:String?
    
    var hasTimeOptions = false
    var endTime:Float = 0.0
    var startTime:Float = 0.0
    
    var receivedDate:NSDate?
    
    var sites:Array<String> = Array<String>()
    
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
        self.name  = aDecoder.decodeObjectForKey("name") as? String
        self.message  = aDecoder.decodeObjectForKey("message") as? String
        
        //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
        self.hasTimeOptions = aDecoder.decodeBoolForKey("hasTimeOptions")
        self.endTime = aDecoder.decodeFloatForKey("endTime")
        self.startTime = aDecoder.decodeFloatForKey("startTime")
        self.receivedDate = aDecoder.decodeObjectForKey("receivedDate") as? NSDate
        
        if let sites = aDecoder.decodeObjectForKey("sites") as? [String] {
            self.sites = sites
        }
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let identifier = self.identifier {
            aCoder.encodeObject(identifier, forKey: "identifier")
        }
        
        if let elementIdentifier = self.elementIdentifier {
            aCoder.encodeObject(elementIdentifier, forKey: "elementIdentifier")
        }
        
        if let name = self.name {
            aCoder.encodeObject(name, forKey: "name")
        }
        
        if let message = self.message {
            aCoder.encodeObject(message, forKey: "message")
        }
        
        aCoder.encodeBool(self.hasTimeOptions, forKey: "hasTimeOptions")
        aCoder.encodeFloat(self.startTime, forKey: "startTime")
        aCoder.encodeFloat(self.endTime, forKey: "endTime")
        
        aCoder.encodeObject(sites, forKey: "sites")

        
        if let receivedDate = self.receivedDate {
            aCoder.encodeObject(receivedDate, forKey: "receivedDate")
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
    
    class func loadSaved(identifier:String) -> BNGift? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNGift
        }
        return nil
    }
}

