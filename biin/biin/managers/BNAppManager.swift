//  BNAppManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNAppSharedManager { static let instance = BNAppManager() }

class BNAppManager {
    
    var IS_PRODUCTION_RELEASE = true
    
    var counter = 0
    var version = "0.1.8"
    
    var delegate:BNAppManager_Delegate?
    
    var dataManager:BNDataManager
    var positionManager:BNPositionManager
    var networkManager:BNNetworkManager
    var errorManager:BNErrorManager
    
    var areNewNotificationsPendingToShow = false
    
    var mainViewController:MainViewController?
    
    weak var appDelegate:AppDelegate?
    
    var IS_APP_UP:Bool = false
    var isWaitingForLocationServicesPermision = false
    
    var elementColorIndex = 0
    var elementColors:Array<UIColor> = Array<UIColor>()
    
    var biinieCategoriesBckup = Dictionary<String, BNCategory>()
    
    init(){
        self.counter++
        
        errorManager = BNErrorManager()
        dataManager = BNDataManager(errorManager:errorManager)
        positionManager = BNPositionManager(errorManager:errorManager)
        networkManager = BNNetworkManager(errorManager:errorManager)
        
        self.addElementColors()
        
        networkManager.delegateDM = dataManager
        dataManager.delegateNM = networkManager
        dataManager.delegatePM = positionManager
        positionManager.delegateDM = dataManager
        errorManager.delegateNM = networkManager

    }
    

    func continueAppInitialization(){
        
        if positionManager.checkLocationServicesStatus() {
            //errorManager.showAlertOnStart(NSError(domain: "Location serives ENABLED", code: 1, userInfo: nil))
            isWaitingForLocationServicesPermision = false
            
            if positionManager.checkHardwareStatus() {
                if positionManager.checkBluetoothServicesStatus() {
                    continueAfterIntialChecking()
                } else {
                    errorManager.showBluetoothError()
                }
            } else  {
                errorManager.showHardwareNotSupportedError()
            }
            
        } else {
            isWaitingForLocationServicesPermision = true
            errorManager.showLocationServiceError()
        }
    }
    
    func continueAfterIntialChecking(){
        
        println("continueAfterIntialChecking()")
        networkManager.checkConnectivity()
    }
    
    func biinit(identifier:String, isElement:Bool){

        println("Biinit: \(identifier)")
        
        if isElement {
            dataManager.elements[identifier]?.userBiined = true
            dataManager.elements[identifier]?.biinedCount++
            
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.elements[identifier] = dataManager.elements[identifier]!
     
            networkManager.sendBiinedElement(dataManager.bnUser!, element:dataManager.elements[identifier]!, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
        } else {
            dataManager.sites[identifier]?.userBiined = true
            dataManager.sites[identifier]?.biinedCount++
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.sites[identifier] =  dataManager.sites[identifier]!
            networkManager.sendBiinedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
        }
        
        //dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.items.append(identifier)
    }
    
    func shareIt(identifier:String, isElement:Bool){
        println("Shareit: \(identifier)")
//        mainViewController!.shareIt(identifier, view: view)
        
        if isElement {
            dataManager.elements[identifier]?.userShared = true
//            dataManager.elements[identifier]?.biinedCount++
            
            //dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.elements[identifier] = dataManager.elements[identifier]!
            
            networkManager.sendSharedElement(dataManager.bnUser!, element:dataManager.elements[identifier]!)

            mainViewController?.shareElement(dataManager.elements[identifier]!)
            
        } else {
            dataManager.sites[identifier]?.userShared = true
//            dataManager.sites[identifier]?.biinedCount++
//            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.sites[identifier] =  dataManager.sites[identifier]!
            networkManager.sendSharedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!)
            mainViewController?.shareSite(dataManager.sites[identifier]!)
        }
    }
    
    func commentit(identifier:String, comment:String){
        println("Commentit: \(identifier) comment: \(comment)")
    }
    
    func unBiinit(identifier:String, isElement:Bool){
        
        //The identifier parameter is actually the _id of the element.
        //On site is the identifier.
        println("unBiinit: \(identifier)")
        
        if isElement {
            dataManager.elements[identifier]?.userBiined = false
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.elements[dataManager.elements[identifier]!.identifier!] = nil
            networkManager.sendUnBiinedElement(dataManager.bnUser!, elementIdentifier:dataManager.elements[identifier]!.identifier!, collectionIdentifier:dataManager.bnUser!.temporalCollectionIdentifier!)
        } else {
            dataManager.sites[identifier]?.userBiined = false
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.sites[identifier] = nil
            networkManager.sendUnBiinedSite(dataManager.bnUser!, siteIdentifier:identifier, collectionIdentifier:dataManager.bnUser!.temporalCollectionIdentifier!)
        }

        /*
        if dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.items.count > 0 {
            var index:Int = 0
            for item in dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.items {

                if item == identifier {
                    break
                }
                
                index++
            }
            
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.items.removeAtIndex(index)
        }
        */
        //TODO: inform backend the user remove biined element
    }
    
    func processNotification(notification:BNNotification){
        areNewNotificationsPendingToShow = true
        dataManager.bnUser!.newNotificationCount!++
        dataManager.bnUser!.notificationIndex! = notification.identifier
        dataManager.notifications.append(notification)

        //Notify main view to show circle
        delegate!.manager!(showNotifications: true)
    }
    
    func addElementColors(){
        elementColors.append(UIColor.bnBlue())
        elementColors.append(UIColor.bnGreen())
        elementColors.append(UIColor.bnOrange())
        elementColors.append(UIColor.bnBlue())
        elementColors.append(UIColor.bnCyan())
        elementColors.append(UIColor.bnRed())
        elementColors.append(UIColor.bnPurple())
        elementColors.append(UIColor.bnGreenDark())
        elementColors.append(UIColor.bnBlueDark())
        elementColors.append(UIColor.bnOrangeBase())
    }
}

@objc protocol BNAppManager_Delegate:NSObjectProtocol {
    optional func manager(showNotifications value:Bool)
    optional func manager(hideNotifications value:Bool)
}
