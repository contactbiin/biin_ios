//  BNAppManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNAppSharedManager { static let instance = BNAppManager() }

class BNAppManager {
    
    var settings:BNSettings?
    var IS_DEVELOPMENT_BUILD = false

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
    
    var IS_APP_UP = false
    var IS_APP_DOWN = false
    var IS_APP_READY_FOR_NEW_DATA_REQUEST = false
    var IS_APP_REQUESTING_NEW_DATA = false
    var isWaitingForLocationServicesPermision = false
    var IS_BLUETOOTH_ENABLED = false
    var IS_MAINVIEW_ON = false
    var isOpeningForLocalNotification = false
    
//    var elementColorIndex = 0
//    var elementColors:Array<UIColor> = Array<UIColor>()
    
    var biinieCategoriesBckup = Dictionary<String, BNCategory>()
    
    let biinCacheImagesFolder = "/BiinCacheImages"
    
    
    init(){
        
        self.counter += 1

        if let settings = BNSettings.loadSaved() {
            self.settings = settings
        } else {
            self.settings = BNSettings()
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
//            if IS_DEVELOPMENT_BUILD {
//                version += " Development"
//            }
        }
        
    }
    
    /*
    func addImagesMB(size:CGFloat) {
        let nsize:CGFloat = CGFloat((size / 1000000))
    }
    */
    
    func continueAppInitialization(){
        
        //NSLog("BIIN - continueAppInitialization()")
        
        if !SimulatorUtility.isRunningSimulator {
            if positionManager.checkLocationServicesStatus() {
        
                isWaitingForLocationServicesPermision = false
                
                if positionManager.checkHardwareStatus() {
                    
                    if positionManager.checkBluetoothServicesStatus() {
                        BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED = true
                        continueAfterIntialChecking()
                    } else {
                        errorManager.showBluetoothError()
                        //continueAfterIntialChecking()
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
        //print("FLOW 1 - continueAfterIntialChecking")
        networkManager.checkConnectivity()
    }

    func unCollectElement(element:BNElement?){

        dataManager.applyUnCollectedElement(element)
        networkManager.sendUnCollectedElement(dataManager.bnUser!, element: element, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
        mainViewController!.mainView!.updateAllCollectedView()
    }
    
    func collectElement(element:BNElement?){
        dataManager.applyCollectedElement(element)
        networkManager.sendCollectedElement(dataManager.bnUser!, element:element, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
    }
    
    func likeElement(element:BNElement?){
        dataManager.applyLikeElement(element)
        networkManager.sendLikedElement(dataManager.bnUser!, element:element)
    }

    func likeSite(site:BNSite?){
        networkManager.sendLikedSite(dataManager.bnUser!, site:site)
        mainViewController!.mainView!.refresh_favoritesSitesContaier(site)
    }
    
    func followSite(site:BNSite? ){
        networkManager.sendFollowedSite(dataManager.bnUser!, site:site)
    }

    func shareSite(site:BNSite?, shareView:ShareItView?){
        site!.userShared = true
        networkManager.sendSharedSite(dataManager.bnUser!, site: site)
        mainViewController?.shareSite(site, shareView:shareView)
    }
    
    func shareElement(element:BNElement?, shareView:ShareItView?){
        element!.userShared = true
        networkManager.sendSharedElement(dataManager.bnUser!, element:element)
        mainViewController?.shareElement(element, shareView:shareView)
        dataManager.applyShareElement(element)
    }
    
    func processNotification(notification:BNNotification){
        areNewNotificationsPendingToShow = true
        dataManager.bnUser!.newNotificationCount! += 1
        dataManager.bnUser!.notificationIndex! = notification.identifier

        //Notify main view to show circle
        delegate!.manager!(showNotifications: true)
    }
    
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
    
    func clean(){ }
    
    func show(){
        
        mainViewController?.mainView!.show()

        if notificationManager.currentNotification != nil && notificationManager.didSendNotificationOnAppDown {
            //mainViewController?.mainView?.showNotificationContext()
        }
    }
}

@objc protocol BNAppManager_Delegate:NSObjectProtocol {
    optional func manager(showNotifications value:Bool)
    optional func manager(hideNotifications value:Bool)
}
