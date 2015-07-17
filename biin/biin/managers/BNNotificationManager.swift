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
    //var notifications = Array<BNNotification>()//[BiinieAction]()
    var localNotifications:[BNLocalNotification] = [BNLocalNotification]()
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
//    func removeNotification(identifier:Int){
//        for var i = 0; i < notifications.count; i++ {
//            if notifications[i].identifier == identifier {
//                notifications.removeAtIndex(i)
//                return
//            }
//        }
//    }
    
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
    func addLocalNotification(object:BNBiinObject, notificationText:String, notificationType:BNLocalNotificationType, siteIdentifier:String, biinIdentifier:String, elementIdentifier:String){
        
        var isNotificationSaved = false

        
        for var i = 0; i < localNotifications.count; i++ {
            println(localNotifications[i].objectIdentifier!)
            if localNotifications[i].objectIdentifier == object._id! {
                localNotifications[i].notificationText = notificationText
                
                //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
                localNotifications[i].onMonday = object.onMonday
                localNotifications[i].onTuesday = object.onTuesday
                localNotifications[i].onWednesday = object.onWednesday
                localNotifications[i].onThursday = object.onThursday
                localNotifications[i].onFriday = object.onFriday
                localNotifications[i].onSaturday = object.onSaturday
                localNotifications[i].onSunday = object.onSunday
                localNotifications[i].endTime = object.endTime
                localNotifications[i].startTime = object.startTime
                localNotifications[i].isUserNotified = object.isUserNotified
                localNotifications[i].major = object.major
                localNotifications[i].minor = object.minor
                
                break
            }
        }
        
        if !isNotificationSaved {
            var notification = BNLocalNotification(objectIdentifier:object._id!, notificationText:notificationText, notificationType:notificationType, siteIdentifier:siteIdentifier, biinIdentifier:biinIdentifier, elementIdentifier:elementIdentifier)
            
            //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
            notification.onMonday = object.onMonday
            notification.onTuesday = object.onTuesday
            notification.onWednesday = object.onWednesday
            notification.onThursday = object.onThursday
            notification.onFriday = object.onFriday
            notification.onSaturday = object.onSaturday
            notification.onSunday = object.onSunday
            notification.endTime = object.endTime
            notification.startTime = object.startTime
            notification.isUserNotified = object.isUserNotified
            notification.major = object.major
            notification.minor = object.minor
            
            localNotifications.append(notification)
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

    func activateNotificationForSite(siteIdentifier:String, major:Int) {
        
        NSLog("activateNotificationForSite()")
        var msj = "localNotifications: \(localNotifications.count)"
        NSLog(msj)
        
        self.currentNotification = nil
        
        
        if BNAppSharedManager.instance.IS_APP_DOWN {
            NSLog("activateNotificationForSite() - WHEN APP IS DOWN")
            setCurrentNotificationWhenAppIsDown(siteIdentifier, major: major)
        } else {
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
        
        if BNAppSharedManager.instance.IS_APP_DOWN {

        } else {
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
        }
    
        sendCurrentNotification()
    }
    
    func setCurrentNotificationWhenAppIsDown(siteIdentifier:String, major:Int){
        NSLog("BIIN - setCurrentNotificationWhenAppIsDown()")
       
        NSLog("BIIN - ")
        for notification in localNotifications {
            if notification.notificationType == .EXTERNAL && major == notification.major {
                NSLog("Site identifier: \(notification.siteIdentifier!)")
                NSLog("major: \(notification.major)")
                NSLog("minor: \(notification.minor)")
            }
        }
    }
    
    /*
    func assingCurrectNotificationByDate(){
        //TODO: get the correct object depending on the time and properties.
        var isCurrentObjectSet = false
        
//        if objects!.count > 0 {
        
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
            let hour = components.hour
            let minutes = components.minute
            let currentTime:Float = Float(hour) + (Float(minutes) * 0.01)
            
            var isAvailableToday = false
            
            var dayNumber = getDayOfWeek()
            for var i = 0; i < objects?.count; i++ {
                
                //                println("Day:\(getDayOfWeek())")
                //                println("CUrrent object:\(objects![i].identifier!) index;\(i)")
                //                println("Start time:\(objects![i].startTime)")
                //                println("End time: \(objects![i].endTime)")
                
                if currentTime >= objects![i].startTime {
                    if currentTime <= objects![i].endTime {
                        
                        switch dayNumber {
                        case 1://Sunday
                            if objects![i].onSunday {
                                isAvailableToday = true
                            }
                            break
                        case 2://Monday
                            if objects![i].onMonday {
                                isAvailableToday = true
                            }
                            break
                        case 3://Tuesday
                            if objects![i].onTuesday {
                                isAvailableToday = true
                            }
                            break
                        case 4://Wednesday
                            if objects![i].onWednesday {
                                isAvailableToday = true
                            }
                            break
                        case 5://Thurday
                            if objects![i].onThursday {
                                isAvailableToday = true
                            }
                            break
                        case 6://Friday
                            if objects![i].onFriday {
                                isAvailableToday = true
                            }
                            break
                        case 7://Saturday
                            if objects![i].onSaturday {
                                isAvailableToday = true
                            }
                            break
                        default:
                            isAvailableToday = false
                            break
                        }
                        
                        
                        if isAvailableToday {
                            currentObjectIndex = i
                            isCurrentObjectSet = true
                            //                            println("Day:\(getDayOfWeek())")
                            //                            println("CUrrent object:\(objects![i].identifier!) index;\(currentObjectIndex)")
                            //                            println("Start time:\(objects![currentObjectIndex].startTime)")
                            //                            println("End time: \(objects![currentObjectIndex].endTime)")
                            
                        } else {
                            currentObjectIndex = 0
                            isCurrentObjectSet = true
                            //                            println("Day:\(getDayOfWeek())")
                            //                            println("CUrrent object index;\(currentObjectIndex)")
                            //                            println("Start time:\(objects![currentObjectIndex].startTime)")
                            //                            println("End time: \(objects![currentObjectIndex].endTime)")
                        }
                    }
                }
//            }
        }
        
        if !isCurrentObjectSet {
            println("Setting defaul!")
            currentObjectIndex = 0
            println("CUrrent object index;\(currentObjectIndex)")
            println("Start time:\(objects![currentObjectIndex].startTime)")
            println("End time: \(objects![currentObjectIndex].endTime)")
        }
    }
    */
    
    func getDayOfWeek()->Int {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var today = NSDate().bnShortDateFormat()
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.CalendarUnitWeekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return 0
        }
    }
    
    func sendCurrentNotification(){
        
        if self.currentNotification != nil {
            
            var time:NSTimeInterval = 0
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertBody = currentNotification!.notificationText
            localNotification.alertTitle = "Alert title here!"
            //localNotification.alertLaunchImage = "biinLogoLS"
            
            
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
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.BIIN_NOTIFIED, to:currentNotification!.objectIdentifier!)
        }

    }
}


