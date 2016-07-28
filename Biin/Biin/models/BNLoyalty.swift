//  BNLoyalty.swift
//  Biin
//  Created by Esteban Padilla on 12/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNLoyalty:NSObject {
    
    var organizationIdentifier:String?
    var isSubscribed:Bool = false
    var subscriptionDate:NSDate?
    var loyaltyCard:BNLoyaltyCard?
    
    override init() {
        super.init()
    }    
}
