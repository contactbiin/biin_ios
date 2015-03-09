//  BNNotification.swift
//  Biin
//  Created by Esteban Padilla on 11/27/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

struct BNNotificationData
{
    static var notificationCounter = 1
}

class BNNotification:NSObject {

    var identifier:Int = 1
    var title:String?
    var text:String?
    weak var biin:BNBiin?
    var notificationType:BNNotificationType?
    var time:NSDate?

    override init(){
        super.init()
    }
    
    convenience init(title:String, text:String, biin:BNBiin, notificationType:BNNotificationType, time:NSDate){
        self.init()
        self.identifier = BNNotificationData.notificationCounter++
        self.title = title
        self.text = text
        self.biin = biin
        self.notificationType = notificationType
        self.time = time
        
        let timestamp = NSDateFormatter.localizedStringFromDate(time, dateStyle: .MediumStyle, timeStyle: .MediumStyle)
        println("---- Notification at: \(timestamp)")
    }
    
    deinit {
        
    }
}

enum BNNotificationType {
    case STIMULUS
    case ENGAGE
    case CONVERT
}