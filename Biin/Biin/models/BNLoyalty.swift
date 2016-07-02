//  BNLoyalty.swift
//  Biin
//  Created by Esteban Padilla on 12/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNLoyalty:NSObject {
    
    var isSubscribed:Bool = false
    var subscriptionDate:NSDate?
    var points:Int = 0
    var level:Int = 0
    var achievements:Array<BNAchievement>?
    var badges:Array<BNBadge>?
    
    override init() {
        super.init()
    }    
}
