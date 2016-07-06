//  BNBiin.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation


class BNBiin:NSObject
{
    //Identification properties
    var identifier:String?
    var name:String?
    var lastUpdate:NSDate?
    var venue:String?
    var proximityUUID:NSUUID?
    var major:Int?
    var minor:Int?

    //Relationship properties
    var accountIdentifier:String?
    var site:BNSite?
    //var siteIdentifier:String?
    //var organizationIdentifier:String?
    var biinType = BNBiinType.NONE
    
    var isBiinDataCorrupted:Bool = false
    var isBiinDetected:Bool = false
    
    
    //REMOVE ->
    var showcase:BNShowcase?
    var showcases:Array<BNShowcase>?//REMOVE LATER
    var currentShowcaseIndex:Int = 0
    //REMOVE <-
    
    var objects:Array<BNBiinObject>?
    var currentObjectIndex:Int = 0
    
    var proximity = BNBiinProximityType.NA
    var children:Array<Int>?
    
    override init() {
        super.init()
        self.isBiinDataCorrupted = false
        self.isBiinDetected = false
    }
    
    deinit{
        
    }
    
    func currectShowcase()->BNShowcase {
        //assingCurrectShowcase()
        return showcases![currentShowcaseIndex]
    }
    
    func currectObject() ->BNBiinObject {
        assingCurrectObject()
        return objects![currentObjectIndex]
    }
    

    func assingCurrectShowcase(){
        //TODO: get the correct showcase depending on the time
        currentShowcaseIndex = 0
    }
    
    func didUserBiinedSomethingInShowcase()->Bool{
        
        /*
        for element in showcases![currentShowcaseIndex].elements {
            if element.userBiined {
                return true
            }
        }
        */
        return false
    }
    
    func assingCurrectObject(){
        //TODO: get the correct object depending on the time and properties.
        var isCurrentObjectSet = false
        
        if self.objects != nil {
            if self.objects!.count > 0 {
                
                let date = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components([.Hour, .Minute], fromDate: date)
                let hour = components.hour
                let minutes = components.minute
                let currentTime:Float = Float(hour) + (Float(minutes) * 0.01)
                
                var isAvailableToday = false
                
                let dayNumber = getDayOfWeek()
                
                var i:Int = 0
                for _ in self.objects! {
//                for var i = 0; i < self.objects!.count; i++ {
                    
                    if currentTime >= self.objects![i].startTime {
                        if currentTime <= self.objects![i].endTime {

                            switch dayNumber {
                            case 1://Sunday
                                if self.objects![i].onSunday {
                                    isAvailableToday = true
                                }
                                break
                            case 2://Monday
                                if self.objects![i].onMonday {
                                    isAvailableToday = true
                                }
                                break
                            case 3://Tuesday
                                if self.objects![i].onTuesday {
                                    isAvailableToday = true
                                }
                                break
                            case 4://Wednesday
                                if self.objects![i].onWednesday {
                                    isAvailableToday = true
                                }
                                break
                            case 5://Thurday
                                if self.objects![i].onThursday {
                                    isAvailableToday = true
                                }
                                break
                            case 6://Friday
                                if self.objects![i].onFriday {
                                    isAvailableToday = true
                                }
                                break
                            case 7://Saturday
                                if self.objects![i].onSaturday {
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
                            } else {
                                currentObjectIndex = 0
                                isCurrentObjectSet = true
                            }
                        }
                    }
                    
                    i += 1
                }
            }
        }
        
        if !isCurrentObjectSet {
            currentObjectIndex = 0
        }
    }
    
    func getDayOfWeek()->Int {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = NSDate().bnShortDateFormat()
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return 0
        }
    }
    
    func didUserBiinedSomethingInBiinObjects()->Bool {
        
        for object in self.objects! {
         
            switch object.objectType {
            case .ELEMENT:
                break
            case .SHOWCASE:
                break
            default:
                break
            }
        }
        
        /*
        for element in showcases![currentShowcaseIndex].elements {
            if element.userBiined {
                return true
            }
        }
        */
        
        return false
    }
    
    func context(){
    
    }
    
    func updateBiinType(){
        switch minor! {
        case 1:
            biinType = BNBiinType.EXTERNO
        case 2:
            biinType = BNBiinType.INTERNO
        case 3:
            biinType = BNBiinType.PRODUCT
        default:
            break
        }
    }
}

enum BNBiinType {
    case NONE       //0
    case EXTERNO    //1
    case INTERNO    //2
    case PRODUCT    //3
    
}

enum BNBiinProximityType {
    case NA   //0
    case INM    //1
    case NEAR   //2
}