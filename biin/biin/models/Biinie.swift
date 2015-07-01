//  Biinie.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class Biinie:NSObject, NSCoding {
    
    var identifier:String?
    var biinName:String?
    var firstName:String?
    var lastName:String?
    var email:String?
    var birthDate:NSDate?
    var password:String?
    var gender:String?
    var friends:Array<Biinie>?
    var imgUrl:String?
    //var avatarImage:UIImageView? = UIImageView(image: UIImage(named:"view640X2.jpg"))
    var biins:Int?
    var following:Int?
    var followers:Int?
    var jsonUrl:String?
    
    var categories = Array<BNCategory>()
    var collections:Dictionary<String, BNCollection>?
    var temporalCollectionIdentifier:String?
    var actions:[BiinieAction] = [BiinieAction]()
    
    var isEmailVerified:Bool?
    
    var newNotificationCount:Int?
    var notificationIndex:Int?
    
    var isInStore = false
    
    override init() {
        super.init()
        
        self.newNotificationCount = 0
        self.notificationIndex = 0
    }
    
    convenience init(identifier:String, firstName:String, lastName:String, email:String) {
        self.init()
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        newNotificationCount = 0
        notificationIndex = 0
    }
    
    convenience init(identifier:String, firstName:String, lastName:String, email:String, gender:String) {

        self.init(identifier:identifier, firstName:firstName, lastName:lastName, email:email)
        
        self.gender = gender
    }
    
    required init(coder aDecoder: NSCoder) {
        self.identifier  = aDecoder.decodeObjectForKey("identifier") as? String
        self.biinName = aDecoder.decodeObjectForKey("biinName") as? String
        self.firstName  = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName  = aDecoder.decodeObjectForKey("lastName") as? String
        self.email  = aDecoder.decodeObjectForKey("email") as? String
        self.birthDate = aDecoder.decodeObjectForKey("birthDate") as? NSDate
        self.isEmailVerified = aDecoder.decodeBoolForKey("isEmailVerified")
        self.actions =  aDecoder.decodeObjectForKey("actions") as! [BiinieAction]
        self.gender  = aDecoder.decodeObjectForKey("gender") as? String
        
        self.newNotificationCount = 0
        self.notificationIndex = 0
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let identifier = self.identifier {
            aCoder.encodeObject(identifier, forKey: "identifier")
        }
        
        if let biinName = self.biinName {
            aCoder.encodeObject(biinName, forKey: "biinName")
        }
        
        if let firstName = self.firstName {
            aCoder.encodeObject(firstName, forKey: "firstName")
        }
        
        if let lastName = self.lastName {
            aCoder.encodeObject(lastName, forKey: "lastName")
        }
        
        if let email = self.email {
            aCoder.encodeObject(email, forKey: "email")
        }
        
        if let birthDate = self.birthDate {
            aCoder.encodeObject(birthDate, forKey: "birthDate")
        }
        
        if let isEmailVerified = self.isEmailVerified {
            aCoder.encodeBool(isEmailVerified, forKey: "isEmailVerified")
        }
        
        if let gender = self.gender {
            aCoder.encodeObject(gender, forKey: "gender")
        }
        
        aCoder.encodeObject(actions, forKey: "actions")
        
        println("")
    }
    
    deinit {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "user")
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user")
    }
    
    class func loadSaved() -> Biinie? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("user") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Biinie
        }
        
        return nil
    }
}
