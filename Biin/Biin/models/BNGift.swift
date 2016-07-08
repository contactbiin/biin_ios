//  BNGift.swift
//  Biin
//  Created by Esteban Padilla on 7/5/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.
import Foundation

class BNGift:BNObject {
    
    var elementIdentifier:String?
    var organizationIdentifier:String?
    
    var name:String?
    var message:String?
    
    var hasExpirationDate = false
    var expirationDate:NSDate?
    var receivedDate:NSDate?
    
    var sites:Array<String>?
    
    var status:BNGiftStatus?
    var media:Array<BNMedia>?
    
    override init() {
        super.init()
        sites = Array<String>()
        media = Array<BNMedia>()
    }
}

enum BNGiftStatus {
    case NONE
    case SENT
    case REFUSED
    case SHARED
    case CLAIMED
    case APPROVED
    case DELIVERED
}

