//  BNBiin.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation


class BNBiin:NSObject
{
    //Relationship properties
    var accountIdentifier:String?
    var siteIdentifier:String?
    var organizationIdentifier:String?

    var isBiinDataCorrupted:Bool = false
    var isBiinDetected:Bool = false
    
    weak var site:BNSite?
    //var showcase:BNShowcase?
    var showcases:Array<BNShowcase>?//REMOVE LATER
    var currentShowcaseIndex:Int = 0
    
    var objects:Array<BNBiinObject>?
    var currentObjectIndex:Int = 0
    
    var biinType = BNBiinType.NONE
    
    var state:Biin_State?
    var lastUpdate:NSDate?
    var venue:String?
    var proximityUUID:NSUUID?
    var major:Int?
    var minor:Int?
    
    //Identification properties
    var name:String?
    var identifier:String?
    
    override init() {
        super.init()
        self.isBiinDataCorrupted = false
        self.isBiinDetected = false
    }
    
    deinit{
        
    }
    
    func currectShowcase()->BNShowcase {
        assingCurrectShowcase()
        return showcases![currentShowcaseIndex]
    }
    
    func setBiinState(){
        
        
        if let objectsList = objects {
            if objectsList.count > 0 {
                assingCurrectObject()
            } else {
                currentObjectIndex = 0
            }
            
            if didUserBiinedSomethingInShowcase() {
                
            }
            
        }
        
        
        
        //TODO: set biin state depending on showcase.
        //1. Check if showcases is not empty
        if let showcasesList = showcases {
            
            //2. Set current showcase
            if showcases!.count > 0 {
                //a. There are many showcases in biin
                assingCurrectShowcase()
            } else {
                //b. There is only one showcase in biin
                currentShowcaseIndex = 0
            }
            
            if didUserBiinedSomethingInShowcase() {
                if showcases![currentShowcaseIndex].isUserNotified {
                    //State id 2
                    self.state = Biined_Not_Notified_State(biin: self)
                }else {
                    //State id 1
                    self.state = Biined_Notified_State(biin: self)
                }
            } else {
                if showcases![currentShowcaseIndex].isUserNotified {
                    //State id 4
                    self.state = Biin_Notified_State(biin: self)
                }else {
                    //State id 3
                    self.state = Biin_Not_Notified_State(biin: self)
                }
            }
        }
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
        currentObjectIndex = 0
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
        
        for element in showcases![currentShowcaseIndex].elements {
            if element.userBiined {
                return true
            }
        }
        return false
    }
    
    
    func context(){
        state!.action()
    }
}

enum BNBiinType {
    case NONE       //0
    case EXTERNO    //1
    case INTERNO    //2
    case PRODUCT    //3
    
}