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
    
    var dataManager:BNDataManager!
    var positionManager:BNPositionManager!
    var networkManager:BNNetworkManager!
    var errorManager:BNErrorManager!
    var notificationManager:BNNotificationManager!
    
    var areNewNotificationsPendingToShow = false
    
    var mainViewController:MainViewController?
    
    weak var appDelegate:AppDelegate?
    
    var IS_APP_UP = false
    var IS_APP_DOWN = false
    var IS_APP_READY_FOR_NEW_DATA_REQUEST = false
    var IS_APP_REQUESTING_NEW_DATA = false
    var isWaitingForLocationServicesPermision = true
    var IS_BLUETOOTH_ENABLED = false
    var IS_MAINVIEW_ON = false
    var isOpeningForLocalNotification = false
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
            
            print("-------------------------------------")
            print("Comment this lines for build")
            version = "1.1.6"
            print("-------------------------------------")
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
                
//                if positionManager.checkHardwareStatus() {
                
                    if positionManager.checkBluetoothServicesStatus() {
                        BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED = true
                        //continueAfterIntialChecking()
                    } else {
                        
                        if BNAppSharedManager.instance.dataManager.isUserLoaded {
                            errorManager.showBluetoothError()
                        }
                        //continueAfterIntialChecking()
                    }
                    
//                } else  {
//                    errorManager.showHardwareNotSupportedError()
//                }
                
            } else {
                if dataManager.isUserLoaded {
                    isWaitingForLocationServicesPermision = true
                    errorManager.showLocationServiceError()
                }
            }
        } else {
            //continueAfterIntialChecking()
        }
    }
    
    func continueAfterIntialChecking(){
        //print("FLOW 1 - continueAfterIntialChecking")
//        networkManager.checkConnectivity()
        //networkManager.checkVersion()
    }
    
    func likeElement(element:BNElement?){
        dataManager.applyLikeElement(element)
        networkManager.sendLikedElement(dataManager.biinie, element:element)
        mainViewController!.mainView!.updateAllCollectedView()
    }

    func likeSite(site:BNSite?){
        networkManager.sendLikedSite(dataManager.biinie, site:site)
        mainViewController!.mainView!.refresh_favoritesSitesContaier(site)
    }
    
    func shareSite(site:BNSite?, shareView:ShareItView?){
        site!.userShared = true
        networkManager.sendSharedSite(dataManager.biinie, site: site)
        mainViewController?.shareSite(site, shareView:shareView)
    }
    
    func shareElement(element:BNElement?, shareView:ShareItView?){
        element!.userShared = true
        networkManager.sendSharedElement(dataManager.biinie, element:element)
        mainViewController?.shareElement(element, shareView:shareView)
        dataManager.applyShareElement(element)
    }
    
//    func processNotification(notification:BNNotification){
//        areNewNotificationsPendingToShow = true
//        dataManager.biinie!.newNotificationCount! += 1
//        dataManager.biinie!.notificationIndex! = notification.identifier
//
//        //Notify main view to show circle
//        delegate!.manager!(showNotifications: true)
//    }
    
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
        
        mainViewController?.mainView!.createAndAddView()

        if notificationManager.currentNotification != nil && notificationManager.didSendNotificationOnAppDown {
            //mainViewController?.mainView?.showNotificationContext()
        }
    }
    
    //UI Mehtods
    func updateGiftCounter(){
        mainViewController!.updateGiftCounter()
    }
    
    func updateNotificationCounter(){
        mainViewController!.updateNotificationCounter()
    }
    
    func proccessGiftDelivered(identifier:String?) {
        dataManager.biinie!.proccessGiftDelivered(identifier)
        
        if IS_MAINVIEW_ON {
            mainViewController!.mainView!.proccessGiftDelivered(identifier)
        }
    }
}

@objc protocol BNAppManager_Delegate:NSObjectProtocol {
    optional func manager(showNotifications value:Bool)
    optional func manager(hideNotifications value:Bool)
}
