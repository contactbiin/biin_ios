//
//  BNNotificationManager.swift
//  biin
//
//  Created by Esteban Padilla on 6/18/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class BNNotificationManager:NSObject, NSCoding {

    var currentNotification:BNLocalNotification?
    var notifications = Array<BNNotification>()//[BiinieAction]()
    var localNotifications:[BNLocalNotification] = [BNLocalNotification]()
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
    func removeNotification(identifier:Int){
        for var i = 0; i < notifications.count; i++ {
            if notifications[i].identifier == identifier {
                notifications.removeAtIndex(i)
                return
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.localNotifications =  aDecoder.decodeObjectForKey("localNotifications") as! [BNLocalNotification]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(localNotifications, forKey: "localNotifications")
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:"notificationManager")
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("notificationManager")
    }
    
    class func loadSaved() -> BNNotificationManager? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("notificationManager") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BNNotificationManager
        }
        return nil
    }
    
    func addLocalNotification(key:String, text:String, notificationType:BNLocalNotificationType, itemIdentifier:String){
        
        var isNotificationSaved = false

        
        for var i = 0; i < localNotifications.count; i++ {
            println(localNotifications[i].key!)
            if localNotifications[i].key == key {
                localNotifications[i].text = text
                isNotificationSaved = true
                break
            }
        }
        
        
        if !isNotificationSaved {
            localNotifications.append(BNLocalNotification(key: key, text: text, notificationType:notificationType, itemIdentifier:itemIdentifier ))
        }
        
        save()
        
        println("localNotification count: \(localNotifications.count)")
    }
    
    func removeLocalNotification(key:String) {
        for var i = 0; i < localNotifications.count; i++ {
            if localNotifications[i].key == key {
                localNotifications.removeAtIndex(i)
                return
            }
        }
        save()
    }
    
    func clearLocalNotifications() {
        localNotifications.removeAll(keepCapacity: false)
        save()
    }
    
    func activateNotification(key:String) {
        
        if currentNotification != nil {
            if currentNotification!.key == key {
                return
            }
        }
        
        var isNotificationSent = false

        for var i = 0; i < localNotifications.count; i++ {
            if localNotifications[i].key == key {

                self.currentNotification = localNotifications[i]
                
                var time:NSTimeInterval = 0
                var localNotification:UILocalNotification = UILocalNotification()
                localNotification.alertBody = localNotifications[i].text
                localNotification.alertTitle = "Alert title here!"
                localNotification.alertLaunchImage = "biinLogoLS"

                println("\(localNotifications[i].notificationType!)")
                
                switch localNotifications[i].notificationType! {
                case .EXTERNAL:
                    println("Activating notification \(localNotifications[i].key!), EXTERNAL")
                    //localNotification.alertAction = "externalAction"
                    time = 1
                    break
                case .INTERNAL:
                    println("Activating notification \(localNotifications[i].key!), INTERNAL")
                    //localNotification.alertAction = "internalAction"
                    time = 10
                    break
                case .PRODUCT:
                    println("Activating notification \(localNotifications[i].key!), PRODUCT")
                    //localNotification.alertAction = "productAction"
                    time = 10
                    break
                default:
                    break
                }

                localNotification.fireDate = NSDate(timeIntervalSinceNow: time)
//                localNotification.category = "biinNotificationCategory"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
                isNotificationSent = true
                break
            }
        }
        
        if !isNotificationSent {
            println("NOTIFICATION NOT FOUND \(key)")
        }

    }
}


