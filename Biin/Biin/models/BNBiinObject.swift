//  BNBiinObject.swift
//  biin
//  Created by Alison Padilla on 5/29/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNBiinObject:NSObject
{
    var _id:String? // _id of the object related to a biin.
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
    var isCollected = false
    
    var objectType = BNBiinObjectType.NONE
    
    //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
    var minor:Int = 0
    var major:Int = 0
    
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