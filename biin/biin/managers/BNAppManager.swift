//  BNAppManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNAppSharedManager { static let instance = BNAppManager() }

class BNAppManager {
    
    
    var imagesMB:CGFloat = 0
    
    var settings:BNSettings?
    
    //var IS_PRODUCTION_DATABASE = false
//    var IS_DEVELOPMENT_DATABASE = false
//    var IS_QA_DATABASE = true
//    var IS_DEMO_DATABASE = false
    
    var IS_DEVELOPMENT_BUILD = true

//    var IS_USING_CACHE = false
    
    var counter = 0
    var version = ""
    
    var delegate:BNAppManager_Delegate?
    
    var dataManager:BNDataManager
    var positionManager:BNPositionManager
    var networkManager:BNNetworkManager
    var errorManager:BNErrorManager
    var notificationManager:BNNotificationManager
    
    var areNewNotificationsPendingToShow = false
    
    var mainViewController:MainViewController?
    
    weak var appDelegate:AppDelegate?
    
    var IS_APP_UP:Bool = false
    var IS_APP_DOWN:Bool = false
    var IS_APP_READY_FOR_NEW_DATA_REQUEST = false
    var IS_APP_REQUESTING_NEW_DATA = false
    var isWaitingForLocationServicesPermision = false
    
    var elementColorIndex = 0
    var elementColors:Array<UIColor> = Array<UIColor>()
    
    var biinieCategoriesBckup = Dictionary<String, BNCategory>()
    
    let biinCacheImagesFolder = "/BiinCacheImages"
    
    
    init(){
        
        self.counter++

        if let settings = BNSettings.loadSaved() {
            NSLog("Loading settings")
            self.settings = settings
        } else {
            NSLog("Not settings available")
            self.settings = BNSettings()
        }
        
        
        if self.settings!.IS_QA_DATABASE {
            NSLog("QA DB")

        }
        
        errorManager = BNErrorManager()
        dataManager = BNDataManager(errorManager:errorManager)
        positionManager = BNPositionManager(errorManager:errorManager)
        networkManager = BNNetworkManager(errorManager:errorManager)
        positionManager.delegateNM = networkManager
        
        // Try loading a saved version first
        if let savedNotificationManager = BNNotificationManager.loadSaved() {
            
            notificationManager = savedNotificationManager
        } else {
            // Create a new Course List
            notificationManager = BNNotificationManager()
            notificationManager.save()
        }
        
        self.addElementColors()
        
        networkManager.delegateDM = dataManager
        dataManager.delegateNM = networkManager
        dataManager.delegatePM = positionManager
        positionManager.delegateDM = dataManager
        errorManager.delegateNM = networkManager

        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = myDict {
            version = dict.objectForKey("CFBundleShortVersionString") as! String
            version += " Development"
        }
        
    }
    
    func addImagesMB(size:CGFloat) {
        let nsize:CGFloat = CGFloat((size / 1000000))
        imagesMB += nsize
    }
    

    func continueAppInitialization(){
        
        if !SimulatorUtility.isRunningSimulator {
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
                if dataManager.isUserLoaded {
                    isWaitingForLocationServicesPermision = true
                    errorManager.showLocationServiceError()
                }
            }
        } else {
            continueAfterIntialChecking()
        }
    }
    
    func continueAfterIntialChecking(){
        networkManager.checkConnectivity()
    }
    /*
    func biinit(identifier:String, isElement:Bool){
        
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
    }
    
    func unBiinit(identifier:String, isElement:Bool){
        
        if isElement {
            dataManager.elements[identifier]?.userBiined = false
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.elements[dataManager.elements[identifier]!.identifier!] = nil
            networkManager.sendUnBiinedElement(dataManager.bnUser!, elementIdentifier:dataManager.elements[identifier]!.identifier!, collectionIdentifier:dataManager.bnUser!.temporalCollectionIdentifier!)
        } else {
            dataManager.sites[identifier]?.userBiined = false
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.sites[identifier] = nil
            networkManager.sendUnBiinedSite(dataManager.bnUser!, siteIdentifier:identifier, collectionIdentifier:dataManager.bnUser!.temporalCollectionIdentifier!)
        }
    }
    */
    
    func collectIt(identifier:String, isElement:Bool){
        
        if isElement {
            dataManager.elements[identifier]?.collectCount++
            //dataManager.elements[identifier]?.userCollected = true
            
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.elements[identifier] = dataManager.elements[identifier]!
            
            networkManager.sendCollectedElement(dataManager.bnUser!, element:dataManager.elements[identifier]!, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
            
        } else {
            dataManager.sites[identifier]?.collectCount++
            //dataManager.sites[identifier]?.userCollected = true
            
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.sites[identifier] =  dataManager.sites[identifier]!
            
            networkManager.sendCollectedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
        }
    }
    
    func unCollectit(identifier:String, isElement:Bool){
        
        if isElement {
//            dataManager.elements[identifier]?.userCollected = false
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.elements[dataManager.elements[identifier]!.identifier!] = nil
            networkManager.sendUnCollectedElement(dataManager.bnUser!, element:dataManager.elements[identifier]!, collectionIdentifier:dataManager.bnUser!.temporalCollectionIdentifier!)
        } else {
//            dataManager.sites[identifier]?.userCollected = false
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.sites[identifier] = nil
            networkManager.sendUnCollectedSite(dataManager.bnUser!, site:dataManager.sites[identifier]!, collectionIdentifier:dataManager.bnUser!.temporalCollectionIdentifier!)
        }
    }
    
    func likeIt(identifier:String, isElement:Bool){
        
        if isElement {
            //dataManager.elements[identifier]?.userLiked = true
            networkManager.sendLikedElement(dataManager.bnUser!, element: dataManager.elements[identifier]!, value: dataManager.elements[identifier]!.userLiked)
        } else {
            //dataManager.sites[identifier]?.userLiked = true
            networkManager.sendLikedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, value:dataManager.sites[identifier]!.userLiked)
        }
    }
    
//    func unLikeit(identifier:String, isElement:Bool){
//        
//        if isElement {
//            networkManager.sendLikedElement(dataManager.bnUser!, element: dataManager.elements[identifier]!, value: false)
//        } else {
//            networkManager.sendLikedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, value: false)
//        }
//    }
    
    func followIt(identifier:String ){
        networkManager.sendFollowedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, value:dataManager.sites[identifier]!.userFollowed)
    }
//    
//    func unFollowit(identifier:String ){
//        networkManager.sendFollowedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, value:false )
//    }

    func shareIt(identifier:String, isElement:Bool, shareView:ShareItView?){
        
        if isElement {
            dataManager.elements[identifier]?.userShared = true
            networkManager.sendSharedElement(dataManager.bnUser!, element:dataManager.elements[identifier]!)
            mainViewController?.shareElement(dataManager.elements[identifier]!, shareView:shareView)
            
        } else {
            dataManager.sites[identifier]?.userShared = true
            networkManager.sendSharedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!)
            mainViewController?.shareSite(dataManager.sites[identifier]!, shareView:shareView)
        }
    }
    
    func commentit(identifier:String, comment:String){
        
    }
    
    func processNotification(notification:BNNotification){
        areNewNotificationsPendingToShow = true
        dataManager.bnUser!.newNotificationCount!++
        dataManager.bnUser!.notificationIndex! = notification.identifier
        //notificationManager.notifications.append(notification)

        //Notify main view to show circle
        delegate!.manager!(showNotifications: true)
    }
    
    func addElementColors(){
        elementColors.append(UIColor.bnBlue())
        elementColors.append(UIColor.bnGreen())
        elementColors.append(UIColor.bnOrange())
        elementColors.append(UIColor.bnBlue())
        elementColors.append(UIColor.bnCyan())
        elementColors.append(UIColor.bnBrownLight())
        elementColors.append(UIColor.bnPurple())
        elementColors.append(UIColor.bnGreenDark())
        elementColors.append(UIColor.bnBlueDark())
    }
    
    /*
    +(BOOL) runningInBackground
    {
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateBackground);
    
    return result;
    }
    
    +(BOOL) runningInForeground
    {
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateActive);
    
    return result;
    }
*/
    func runningInBackground()->Bool {
        let state = UIApplication.sharedApplication().applicationState
        return state == UIApplicationState.Background
    }
    
    func runningInForeground()->Bool {
        let state = UIApplication.sharedApplication().applicationState
        return state == UIApplicationState.Active
    }
    
    func saveSettings(){
        self.settings!.save()
    }
    
    func clean(){
        imagesMB = 0
    }
    
    func show(){ }
}

@objc protocol BNAppManager_Delegate:NSObjectProtocol {
    optional func manager(showNotifications value:Bool)
    optional func manager(hideNotifications value:Bool)
}
