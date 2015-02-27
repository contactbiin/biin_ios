//  BNUser.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUser:NSObject, NSCoding {
    
    var identifier:String?
    var biinName:String?
    var firstName:String?
    var lastName:String?
    var email:String?
    var birthDate:NSDate?
    var password:String?
    var gender:String?
    var friends:Array<BNUser>?
    var imgUrl:String?
    //var avatarImage:UIImageView? = UIImageView(image: UIImage(named:"view640X2.jpg"))
    var biins:Int?
    var following:Int?
    var followers:Int?
    var jsonUrl:String?
    
    var categories = Array<BNCategory>()
    var collections:Dictionary<String, BNCollection>?
    var temporalCollectionIdentifier:String?
    
    var isEmailVerified:Bool?
    
    override init() {
        super.init()
    }
    
    convenience init(identifier:String, firstName:String, lastName:String, email:String) {
        self.init()
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    convenience init(identifier:String, firstName:String, lastName:String, email:String, gender:String) {
        self.init()
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
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
    
    class func loadSaved() -> BNUser? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("user") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNUser
        }
        
        return nil
    }
}
