//  BNSite.swift
//  Biin
//  Created by Esteban Padilla on 9/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNSite:BNObject {
    
    //TODO: jsonUrl only for testing, remove later
    var jsonUrl:String?
    
    var organizationIdentifier:String?
    weak var organization:BNOrganization?
    var proximityUUID:NSUUID?
    var major:Int?
    
    //Details
    var title:String?
    var subTitle:String?
    
    //Color
    var titleColor:UIColor?
    var stars:Float = 0
    
    //Location
    var country:String?
    var state:String?
    var city:String?
    var zipCode:String?
    var streetAddress1:String?
    var streetAddress2:String?
    //var ubication:String?
    var phoneNumber:String?
    var email:String?
    var nutshell:String?
    //Gallery
    var media:Array<BNMedia> = Array<BNMedia>()
//    var images:Array<UIImageView> = Array<UIImageView>()
    
    //Biins
    var biins = Array<BNBiin>()
    var useWhiteText = false
    //Loyalty
    //var loyalty:BNLoyalty?

    //Social interaction
    //var biinedCount:Int = 0   //How many time users have biined this element.
    var collectCount:Int = 0   //How many time users have collect this site.
    var commentedCount:Int = 0    //How many time users have commented this element.
    
    //var userBiined = false
    var userCommented = false
    
    var userShared = false
    var userFollowed = false
    var userCollected = false
    var userLiked = false
    var surveyCompleted = false
    
    var latitude:Float?
    var longitude:Float?
    var biinieProximity:Float?
    
    var isUserInside:Bool = false

    //Neighbors are set by geo distance on backend.
    var neighbors:Array<String>?
    
//    var showcases:Array<String>?
    var showcases:Array<String> = Array<String>()
    var notices:Array<String> = Array<String>()
    
    var showInView = true
    
    var siteSchedule:String?
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String){
        self.init()
        self.identifier = identifier
    }

    deinit{
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
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