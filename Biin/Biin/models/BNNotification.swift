//  BNNotification.swift
//  Biin
//  Created by Esteban Padilla on 11/27/14.
//  Copyright (c) 2014 Biin. All rights reserved.

//  Use this class to store information about the notification received on the app.
import Foundation

struct BNNotificationData
{
    static var notificationCounter = 1
}

class BNNotification:NSObject {

    var identifier:Int = 1
    var title:String?
    var text:String?
    var notificationType:BNNotificationType?
    var receivedDate:NSDate?
    var isViewed = false
    
    override init(){
        super.init()
    }
    
    convenience init(title:String, text:String, notificationType:BNNotificationType, receivedDate:NSDate){
        self.init()
        //self.identifier = BNNotificationData.notificationCounter += 1
        self.title = title
        self.text = text
        self.notificationType = notificationType
        self.receivedDate = receivedDate
        //let timestamp = NSDateFormatter.localizedStringFromDate(time, dateStyle: .MediumStyle, timeStyle: .MediumStyle)
    }
    
    deinit {
        
    }
}

enum BNNotificationType {
    case NONE
    case STIMULUS
    case ENGAGE
    case CONVERT
}