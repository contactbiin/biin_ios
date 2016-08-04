//  BNLoyaltyCard.swift
//  Biin
//  Created by Esteban Padilla on 7/27/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNLoyaltyCard:NSObject {
    
    var title:String?
    var rule:String?
    var goal:String?
    
    var elementIdentifier:String?
    
    var isEnabled = false
    var startDate:NSDate?
    var endDate:NSDate?
    var slots:Array<BNLoyaltyCard_Slot> = Array<BNLoyaltyCard_Slot>()
    
    override init() {
        super.init()
    }
}

struct BNLoyaltyCard_Slot {
    init(){ }
    var isFilled:Bool?
}
