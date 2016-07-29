//  AppDelegate.swift
//  biin
//  Created by Esteban Padilla on 6/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import UIKit
import FBSDKCoreKit
import UberRides
import Fabric
import Crashlytics
import Firebase
import FirebaseInstanceID
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appManager = BNAppSharedManager.instance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.whiteColor()
        
        print("\(launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey])")
        
        setDeviceType(window!.screen.bounds.width, screenHeight: window!.screen.bounds.height)
        
        //Sets first view controller
        let vc = VersionCheckViewController()
        self.window?.rootViewController = vc
        
        //Initiliaze app managers
        appManager.appDelegate = self
        appManager.networkManager.setRootURLForRequest()
        appManager.IS_APP_READY_FOR_NEW_DATA_REQUEST = false
        appManager.IS_APP_REQUESTING_NEW_DATA = false
        
        
        switch application.applicationState {
        case .Active:
            appManager.IS_APP_UP = true
            appManager.IS_APP_DOWN = false
            break
        case .Background:
            appManager.IS_APP_UP = false
            appManager.IS_APP_DOWN = true
            break
        case .Inactive:
            appManager.IS_APP_UP = false
            appManager.IS_APP_DOWN = true
            break
        }

        
        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).first
        
        // create the custom folder path
        let biinCacheImagesFolder = documentDirectoryPath!.stringByAppendingPathComponent(appManager.biinCacheImagesFolder)
        
        // check if directory does not exist
        if NSFileManager.defaultManager().fileExistsAtPath(biinCacheImagesFolder) == false {
            
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(biinCacheImagesFolder, withIntermediateDirectories: false, attributes: nil)
            } catch _ as NSError {
                
            }
            
        }
//        else
//        {
//            
//            let selectedImage = UIImage(named:"loading1.jpg")
//            let imageData = UIImagePNGRepresentation(selectedImage!)
//            
//            let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent("loading1.jpg")
//            
//            if NSFileManager.defaultManager().fileExistsAtPath(imagePath) == false {
//                
//                if !imageData!.writeToFile(imagePath, atomically: false) {
//                } else {
//                    NSUserDefaults.standardUserDefaults().setObject(imagePath, forKey: "loading1.jpg")
//                }
//                
//            } else {
//                
//            }
//        }
        
        //Setup notifications
        setupNotificationSettings()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleModifyListNotification), name: "modifyListNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleDeleteListNotification), name: "deleteListNotification", object: nil)
        // Add observer for InstanceID token refresh callback.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.tokenRefreshNotification), name: kFIRInstanceIDTokenRefreshNotification, object: nil)
        
        //Initialize 3rd party frameworks
        Fabric.with([Crashlytics.self])
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        Configuration.setRegion(.Default)
        Configuration.setSandboxEnabled(true)
        Configuration.setFallbackEnabled(false)
        
        FIRApp.configure()
        
        appManager.networkManager!.checkVersion()
        
        return true
        
    }
    
    
    // [START refresh_token]
    func tokenRefreshNotification(notification: NSNotification) {
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]
    
    // [START connect_to_fcm]
    func connectToFcm() {
        FIRMessaging.messaging().connectWithCompletion { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
        
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            
            //print("Current Token:\(refreshedToken)")
            
            if appManager.dataManager!.biinie!.token! == "" {
                appManager.dataManager!.biinie!.token = refreshedToken
                appManager.dataManager!.biinie!.needsTokenUpdate = true
                print("Token asignado: \(appManager.dataManager!.biinie!.token!)")
                
            } else {
                if appManager.dataManager!.biinie!.token! != refreshedToken {
                    appManager.dataManager!.biinie!.token = refreshedToken
                    appManager.dataManager!.biinie!.needsTokenUpdate = true
                    print("User NEW Token: \(appManager.dataManager!.biinie!.token!)")
                } else {
                    print("User Token: \(appManager.dataManager!.biinie!.token!)")
                }
            }
        } else  {
            //print("not token available")
        }

    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application( application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        appManager.IS_APP_UP = false
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        appManager.IS_APP_UP = false
        appManager.positionManager.start_SITES_MONITORING()
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        appManager.IS_APP_UP = true
        appManager.positionManager.start_BEACON_RANGING()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        appManager.IS_APP_UP = true
        
        if BNAppSharedManager.instance.isOpeningForLocalNotification || BNAppSharedManager.instance.notificationManager.lastNotice_identifier != "" {
            BNAppSharedManager.instance.mainViewController?.mainView?.showNotificationContext()
            BNAppSharedManager.instance.isOpeningForLocalNotification = false
        }
        
        connectToFcm()
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        appManager.IS_APP_UP = false
        appManager.positionManager.start_SITES_MONITORING()
        appManager.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.CLOSE_APP, to:"biin_ios", by:"")

    }

    //App methods
    func setDeviceType(screenWidth:CGFloat, screenHeight:CGFloat){
        
        let uiManager = SharedUIManager.instance
        uiManager.screenWidth = screenWidth
        uiManager.screenHeight = screenHeight
        uiManager.setDeviceVariables()
    }
    
    
    func setupNotificationSettings() {
        let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // Do something serious in a real app.
        BNAppSharedManager.instance.notificationManager.lastNotice_identifier = (notification.userInfo!["UUID"] as? String)!
        BNAppSharedManager.instance.notificationManager.save()
        BNAppSharedManager.instance.isOpeningForLocalNotification = true
        UIApplication.sharedApplication().applicationIconBadgeNumber = 1

    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject],
                     fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print message ID.
        //print("Message ID: \(userInfo["gcm.message_id"]!)")
        
        // Print full message.
        print("%@", userInfo)
        
        var isGiftNotification = false
        
        if let data = userInfo["data"] {
            
            var jsonData = BNAppSharedManager.instance.networkManager!.epsNetwork!.parseJson(data as! String)
            
            let type = jsonData["type"] as? String
            
            if type == "gift" || type == "giftassigned" {
                if (jsonData["gift"] as? NSDictionary) != nil {
                    if let giftData = jsonData["gift"] as? NSDictionary {
                        if BNParser.parseGift(giftData, biinie: appManager.dataManager.biinie) {
                            isGiftNotification = true
                            if appManager.IS_MAINVIEW_ON {
                                appManager.mainViewController!.updateGiftsView()
                            }
                        }
                    }
                }
            } else if type == "giftdelivered" {
                let giftIdentifier = jsonData["giftIdentifier"] as? String
                BNAppSharedManager.instance.proccessGiftDelivered(giftIdentifier)
            }
        }
        
        
        //Parse notification data if needed.
        if !isGiftNotification {
            if let notification = userInfo["aps"] as? NSDictionary {
                
                if let alert = notification["alert"] as? NSDictionary {
                    
                    BNParser.parseNotification(alert, biinie: appManager.dataManager.biinie)
                    if appManager.IS_MAINVIEW_ON {
                        appManager.mainViewController!.updateNotificationsView()
                    }
                }
            }
        }
        
        completionHandler(UIBackgroundFetchResult.NoData)
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        //NSLog("BIIN - handleActionWithIdentifier")
        
        if identifier == "externalAction" {
            NSNotificationCenter.defaultCenter().postNotificationName("modifyListNotification", object: nil)
        }
        else if identifier == "internalAction" {
            NSNotificationCenter.defaultCenter().postNotificationName("deleteListNotification", object: nil)
        }
        
        completionHandler()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        if appManager.settings!.IS_PRODUCTION_DATABASE {
            FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.Prod)
        } else {
            FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.Sandbox)
        }
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if !appManager.dataManager!.isUserLoaded {
            appManager.positionManager!.startLocationService()
        }
    }
    
    func handleModifyListNotification() {
    }
    
    func handleDeleteListNotification() {
    }
    
    func application(application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: () -> Void) {
        
        let config = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(identifier)
        let session = NSURLSession(configuration: config, delegate:nil, delegateQueue:NSOperationQueue.mainQueue() )
        session.getTasksWithCompletionHandler { (dataTasks, uploadTaks, downloadTaks) -> Void in
            
        }
        
    }

}

