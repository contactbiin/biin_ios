//  BNSite.swift
//  Biin
//  Created by Esteban Padilla on 9/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNSite:NSObject {
    
    //TODO: jsonUrl only for testing, remove later
    var jsonUrl:String?
    
    var identifier:String?
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
    var phoneNumber:String?
    var email:String?
    
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
    
    var isUserInside:Bool = false

    //Neighbors are set by geo distance on backend.
    var neighbors:Array<String>?
    
//    var showcases:Array<String>?
    var showcases:Array<BNShowcase>?

    
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
}