//  BNBiinObject.swift
//  biin
//  Created by Alison Padilla on 5/29/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNBiinObject:NSObject
{
    var _id:String?
    var identifier:String?
    var isDefault = false
    
    var onMonday = false
    var onTuesday = false
    var onWednesday = false
    var onThursday = false
    var onFriday = false
    var onSaturday = false
    var onSunday = false
    
    var endTime:Float = 0.0
    var startTime:Float = 0.0
    
    var hasTimeOptions = false
    var hasNotification = false
    var notification:String?
    var isUserNotified = false
    var isBiined = false
    
    var objectType = BNBiinObjectType.NONE
    
    override init() {
        super.init()
    }
    
    deinit{
        
    }
}

enum BNBiinObjectType {
    case NONE       //0
    case ELEMENT    //1
    case SHOWCASE   //2
    
}