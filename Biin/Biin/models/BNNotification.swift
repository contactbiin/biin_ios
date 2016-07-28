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

class BNNotification:BNObject {

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
        self.identifier = NSUUID().UUIDString
        self.title = title
        self.text = text
        self.notificationType = notificationType
        self.receivedDate = receivedDate
        //let timestamp = NSDateFormatter.localizedStringFromDate(time, dateStyle: .MediumStyle, timeStyle: .MediumStyle)
    }
    
    deinit {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.identifier = aDecoder.decodeObjectForKey("identifier") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.text = aDecoder.decodeObjectForKey("text") as? String
        
        let value = aDecoder.decodeIntegerForKey("notificationType")
     
        switch value {
        case 0:
            self.notificationType = BNNotificationType.NONE
        case 1:
            self.notificationType = BNNotificationType.STIMULUS
        case 2:
            self.notificationType = BNNotificationType.ENGAGE
        case 3:
            self.notificationType = BNNotificationType.CONVERT
        case 4:
            self.notificationType = BNNotificationType.GIFT
        case 5:
            self.notificationType = BNNotificationType.LOCAL
        case 6:
            self.notificationType = BNNotificationType.PUSH
        default:
            self.notificationType = BNNotificationType.NONE
        }
        
        self.receivedDate = aDecoder.decodeObjectForKey("receivedDate") as? NSDate
        self.isViewed = aDecoder.decodeBoolForKey("isViewed")
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
        if let identifier = self.identifier {
            aCoder.encodeObject(identifier, forKey: "identifier")
        }
        
        if let title = self.title {
            aCoder.encodeObject(title, forKey: "title")
        }
        
        if let text = self.text {
            aCoder.encodeObject(text, forKey: "text")
        }
        
        if let notificationType = self.notificationType {
            aCoder.encodeInteger(notificationType.hashValue, forKey: "notificationType")
        }
        
        if let receivedDate = self.receivedDate {
            aCoder.encodeObject(receivedDate, forKey: "receivedDate")
        }
        
        aCoder.encodeBool(isViewed, forKey: "isViewed")
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:self.identifier!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.identifier!)
    }
    
    class func loadSaved(key:String) -> BNNotification? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNNotification
        }
        
        return nil
    }
}

enum BNNotificationType {
    case NONE
    case STIMULUS
    case ENGAGE
    case CONVERT
    case GIFT
    case LOCAL
    case PUSH
}