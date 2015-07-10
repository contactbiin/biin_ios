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
    
    
    ///identifier: object identifier on the biin.
    ///
    func addLocalNotification(objectIdentifier:String, notificationText:String, notificationType:BNLocalNotificationType, siteIdentifier:String, biinIdentifier:String, elementIdentifier:String){
        
        var isNotificationSaved = false

        
        for var i = 0; i < localNotifications.count; i++ {
            println(localNotifications[i].objectIdentifier!)
            if localNotifications[i].objectIdentifier == objectIdentifier {
                localNotifications[i].notificationText = notificationText
                isNotificationSaved = true
                break
            }
        }
        
        if !isNotificationSaved {
            localNotifications.append(BNLocalNotification(objectIdentifier:objectIdentifier, notificationText:notificationText, notificationType:notificationType, siteIdentifier:siteIdentifier, biinIdentifier:biinIdentifier, elementIdentifier:elementIdentifier ))
        }
        
        save()
        
        println("localNotification count: \(localNotifications.count)")
    }
    
    func removeLocalNotification(objectIdentifier:String) {
        for var i = 0; i < localNotifications.count; i++ {
            if localNotifications[i].objectIdentifier == objectIdentifier {
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

    func activateNotificationForSite(siteIdentifier:String) {
        
        NSLog("activateNotificationForSite()")

        
        self.currentNotification = nil
        
        //FALLO
        if let site = BNAppSharedManager.instance.dataManager.sites[siteIdentifier] {
            NSLog("site: \(site.title!)")
            
            for biin in site.biins {
                NSLog("biin: \(biin.identifier!)")
                if biin.biinType == BNBiinType.EXTERNO {
                    for localNotification in localNotifications {
                        NSLog("notification id: \(localNotification.objectIdentifier!)")
                        NSLog("current biin object: \(biin.currectObject()._id!)")
                        if localNotification.objectIdentifier == biin.currectObject()._id! {
                            self.currentNotification = localNotification
                            sendCurrentNotification()
                            return
                        }
                    }
                }
            }
        }
        
        if  self.currentNotification == nil {
            NSLog("NOTIFICATION NOT FOUND FOR BIIN in SITE: \(siteIdentifier)")
            self.currentNotification = BNLocalNotification(objectIdentifier: "TEST", notificationText: "TEST", notificationType: BNLocalNotificationType.EXTERNAL, siteIdentifier: "TEST", biinIdentifier: "TEST", elementIdentifier: "TEST")
            sendCurrentNotification()
        }
    }
    
    
    func activateNotificationForBiin(biinIdentifier:String) {
        
        NSLog("BIIN - activateNotificationForBiin - \(biinIdentifier)")

        //Get the closes local notification asociates to the biin
        for localNotification in localNotifications {

            NSLog("biin: \(biinIdentifier)")
            NSLog("notification-biin: \(localNotification.biinIdentifier!)")

            
            if localNotification.biinIdentifier == biinIdentifier {
                self.currentNotification = localNotification
                break
            } else {
                self.currentNotification = nil
                NSLog("NOTIFICATION NOT FOUND FOR BIIN: \(biinIdentifier)")
            }
        }
        
        if currentNotification != nil {
            if let site = BNAppSharedManager.instance.dataManager.sites[self.currentNotification!.siteIdentifier!] {
                for biin in site.biins {
                    if biin.identifier! == biinIdentifier {
                        
                        for localNotification in localNotifications {
                            if localNotification.objectIdentifier == biin.currectObject()._id! {
                                self.currentNotification = localNotification
                                break
                            }
                        }
                        
                        break
                    }
                }
            }
        }
    
        sendCurrentNotification()
    }
    
    func sendCurrentNotification(){
        
        if self.currentNotification != nil {
            
            var time:NSTimeInterval = 0
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertBody = currentNotification!.notificationText
            localNotification.alertTitle = "Alert title here!"
            localNotification.alertLaunchImage = "biinLogoLS"
            
            
            switch self.currentNotification!.notificationType! {
            case .EXTERNAL:
                println("Activating notification \(self.currentNotification!.biinIdentifier!), EXTERNAL")
                //localNotification.alertAction = "externalAction"
                time = 1
                break
            case .INTERNAL:
                println("Activating notification \(self.currentNotification!.biinIdentifier!), INTERNAL")
                //localNotification.alertAction = "internalAction"
                time = 1
                break
            case .PRODUCT:
                println("Activating notification \(self.currentNotification!.biinIdentifier!), PRODUCT")
                //localNotification.alertAction = "productAction"
                time = 1
                break
            default:
                break
            }
            
            localNotification.fireDate = NSDate(timeIntervalSinceNow: time)
            //                localNotification.category = "biinNotificationCategory"
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
        }

    }
}


