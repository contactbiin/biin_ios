//  BNSite.swift
//  Biin
//  Created by Esteban Padilla on 9/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNSite:NSObject, NSCoding {
    
    //TODO: jsonUrl only for testing, remove later
    var jsonUrl:String?
    
    var identifier:String?
    var organizationIdentifier:String?
    weak var organization:BNOrganization?
    var proximityUUID:NSUUID?
    var major:Int?
    
    //Details
    var title:String?
    var subTitle:String?
    
    //Color
    var titleColor:UIColor?
    
    //Location
    var country:String?
    var state:String?
    var city:String?
    var zipCode:String?
    var streetAddress1:String?
    var streetAddress2:String?
    var ubication:String?
    var phoneNumber:String?
    var email:String?
    var nutshell:String?
    //Gallery
    var media:Array<BNMedia> = Array<BNMedia>()
//    var images:Array<UIImageView> = Array<UIImageView>()
    
    //Biins
    var biins = Array<BNBiin>()
    
    //Loyalty
    var loyalty:BNLoyalty?

    //Social interaction
    var biinedCount:Int = 0   //How many time users have biined this element.
    var commentedCount:Int = 0    //How many time users have commented this element.
    
    var userBiined = false
    var userCommented = false
    var userShared = false
    
    var latitude:Float?
    var longitude:Float?
    var biinieProximity:Float?
    
    var isUserInside:Bool = false

    //Neighbors are set by geo distance on backend.
    var neighbors:Array<String>?
    
//    var showcases:Array<String>?
    var showcases:Array<BNShowcase>?
    
    var showInView = true
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String){
        self.init()
        self.identifier = identifier
    }

    deinit{
        
    }
    
    func setBiinsStates(){
        for biin in biins {
            biin.setBiinState()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
//        self.identifier  = aDecoder.decodeObjectForKey("identifier") as? String
//        self.biinName = aDecoder.decodeObjectForKey("biinName") as? String
//        self.firstName  = aDecoder.decodeObjectForKey("firstName") as? String
//        self.lastName  = aDecoder.decodeObjectForKey("lastName") as? String
//        self.email  = aDecoder.decodeObjectForKey("email") as? String
//        self.birthDate = aDecoder.decodeObjectForKey("birthDate") as? NSDate
//        self.isEmailVerified = aDecoder.decodeBoolForKey("isEmailVerified")
//        self.actions =  aDecoder.decodeObjectForKey("actions") as! [BiinieAction]
//        self.gender  = aDecoder.decodeObjectForKey("gender") as? String
//        self.actionCounter = aDecoder.decodeIntegerForKey("actionCounter")
//        self.newNotificationCount = 0
//        self.notificationIndex = 0
//        self.storedElementsViewed = aDecoder.decodeObjectForKey("storedElementsViewed") as! [String]
//        
//        println("**** Action: \(actions.count)")
//        
//        for _id in storedElementsViewed {
//            elementsViewed[_id] = _id
//        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:self.identifier!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.identifier!)
    }
    
    class func loadSaved(identifier:String) -> BNSite? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNSite
        }
        
        return nil
    }
}