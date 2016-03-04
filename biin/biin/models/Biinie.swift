//  Biinie.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class Biinie:NSObject, NSCoding {
    
    var facebook_id:String?
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
    var actionCounter:Int = 0
    var storedElementsViewed:[String] = [String]()
    var elementsViewed = Dictionary<String, String>()
    
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
    
    required init?(coder aDecoder: NSCoder) {
//        
//        if let facebook_id_stored = aDecoder.decodeObjectForKey("facebook_id") {
//            self.facebook_id = facebook_id_stored as? String
//        }
//        
        self.facebook_id = aDecoder.decodeObjectForKey("facebook_id") as? String
        self.identifier  = aDecoder.decodeObjectForKey("identifier") as? String
        self.biinName = aDecoder.decodeObjectForKey("biinName") as? String
        self.firstName  = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName  = aDecoder.decodeObjectForKey("lastName") as? String
        self.email  = aDecoder.decodeObjectForKey("email") as? String
        self.birthDate = aDecoder.decodeObjectForKey("birthDate") as? NSDate
        self.isEmailVerified = aDecoder.decodeBoolForKey("isEmailVerified")
        self.actions =  aDecoder.decodeObjectForKey("actions") as! [BiinieAction]
        self.gender  = aDecoder.decodeObjectForKey("gender") as? String
        self.actionCounter = aDecoder.decodeIntegerForKey("actionCounter")
        self.newNotificationCount = 0
        self.notificationIndex = 0
        self.storedElementsViewed = aDecoder.decodeObjectForKey("storedElementsViewed") as! [String]
        self.temporalCollectionIdentifier = "collection1"
        for _id in storedElementsViewed {
            elementsViewed[_id] = _id
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let facebook_id = self.facebook_id {
            aCoder.encodeObject(facebook_id, forKey: "facebook_id")
        }
        
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
        
        aCoder.encodeInteger(actionCounter, forKey: "actionCounter")

        storedElementsViewed.removeAll(keepCapacity: false)
        
        for (_, element_id) in elementsViewed {
            storedElementsViewed.append(element_id)
        }
        
        aCoder.encodeObject(storedElementsViewed, forKey: "storedElementsViewed")

    }
    
    deinit { }
    
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
    
    func addAction(at:NSDate, did:BiinieActionType, to:String) {
        
        //NSLog("BIIN - addAction: \(at.bnDateFormatt()), did:\(did.hashValue), to:\(to)")
        
        var isActionReadyToAdd = false
        
        if actions.count > 0 {
        
            for action in actions {
                
//                NSLog("BIIN 0 - action: \(action.at!.bnDateFormatt()), did:\(action.did!.hashValue), to:\(action.to!)")
                
                if action.did! == did {
                    
//                    NSLog("BIIN 1 - new: \(at.bnDateFormatt()), did:\(did.hashValue), to:\(to)")
//                    NSLog("BIIN 1 - old: \(action.at!.bnDateFormatt()), did:\(action.did!.hashValue), to:\(action.to!)")
                    
                    if action.to! == to {
                        
//                        NSLog("BIIN 2 - new: \(at.bnDateFormatt()), did:\(did.hashValue), to:\(to)")
//                        NSLog("BIIN 2 - old: \(action.at!.bnDateFormatt()), did:\(action.did!.hashValue), to:\(action.to)")
                        
                        let seconds = Int(at.timeIntervalSinceDate(action.at!))
                        let minutes = Int( seconds / 60 )
                        
//                        NSLog("BIIN - seconds: \(seconds)")
//                        NSLog("BIIN - minutes: \(minutes)")
                        
                        if minutes > 30 {
//                            NSLog("BIIN - added: \(at.bnDateFormatt()), did:\(did.hashValue), to:\(to)")
                            isActionReadyToAdd = true
                            break
                        }
                    } else {
                        isActionReadyToAdd = true
                    }
                    
                } else {
                    isActionReadyToAdd = true
                }
            }
        } else {
            isActionReadyToAdd = true
        }
        
        if isActionReadyToAdd {
        //if true {
            
            self.actionCounter++
            self.actions.append(BiinieAction(at:at, did:did, to:to, actionCounter:actionCounter))
            save()
//            NSLog("BIIN - add first action: \(at.bnDateFormatt()), did:\(did), to:\(to)")
            
        }
    }
    
    func deleteAllActions(){
        self.actionCounter = 0
        self.actions.removeAll(keepCapacity: false)
        save()
    }
    
    func addElementView(_id:String){
        if elementsViewed[_id] == nil {
            elementsViewed[_id] = _id
        } else {
            elementsViewed[_id] = _id
        }
    }
    
    func addCategory(category:BNCategory) {
        self.categories.append(category)
    }
}
