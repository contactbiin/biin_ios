//  BNNotification.swift
//  Biin
//  Created by Esteban Padilla on 11/27/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNNotification:NSObject {
    
    var isActive:Bool?
    var notificationType:BNNotificationType?
    var text:String?
 
    override init(){
        super.init()
    }
    
    convenience init(isActive:Bool, notificationType:BNNotificationType, text:String){
        self.init()
        self.isActive = isActive
        self.notificationType = notificationType
        self.text = text
    }
    
    deinit {
        
    }
}

enum BNNotificationType {
    case STIMULUS
    case ENGAGE
    case CONVERT
}