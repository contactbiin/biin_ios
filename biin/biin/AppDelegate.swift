//  AppDelegate.swift
//  biin
//  Created by Esteban Padilla on 1/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import UIKit
import CoreData
import Fabric
import Crashlytics
import UberRides

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appManager = BNAppSharedManager.instance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {// Override point for customization a fter application launch.
        
        //NSLog("BIIN - didFinishLaunchingWithOptions()")
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.blackColor()
        self.window!.makeKeyAndVisible()
        
        appManager.appDelegate = self
        appManager.networkManager.setRootURLForRequest()
        appManager.IS_APP_READY_FOR_NEW_DATA_REQUEST = false
        appManager.IS_APP_REQUESTING_NEW_DATA = false
        
        switch application.applicationState {
        case .Active:
            //NSLog("BIIN - didFinishLaunchingWithOptions - ACTIVE")
            appManager.IS_APP_UP = true
            appManager.IS_APP_DOWN = false
            break
        case .Background:
            //NSLog("BIIN - didFinishLaunchingWithOptions - BACKGROUND")
            appManager.IS_APP_UP = false
            appManager.IS_APP_DOWN = true
            break
        case .Inactive:
            //NSLog("BIIN - didFinishLaunchingWithOptions - INACTIVE")
            appManager.IS_APP_UP = false
            appManager.IS_APP_DOWN = true
            break
//        default:
//            NSLog("BIIN - didFinishLaunchingWithOptions - DEFAULT")
//            break
        }
        
        
        setDeviceType(window!.screen.bounds.width, screenHeight: window!.screen.bounds.height)
        
        if BNAppSharedManager.instance.dataManager.isUserLoaded {
            //NSLog("Stating LoadingViewController()")
            let lvc = LoadingViewController()
            self.window!.rootViewController = lvc
            //appManager.networkManager.delegateVC = lvc
        } else {
            
            let lvc = SingupViewController()
            self.window!.rootViewController = lvc
            //appManager.networkManager.delegateVC = lvc
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

        } else {
            
            let selectedImage = UIImage(named:"loading1.jpg")
            let imageData = UIImagePNGRepresentation(selectedImage!)

            let imagePath = biinCacheImagesFolder.stringByAppendingPathComponent("loading1.jpg")
            
            if NSFileManager.defaultManager().fileExistsAtPath(imagePath) == false {
                
                if !imageData!.writeToFile(imagePath, atomically: false) {
                } else {
                    NSUserDefaults.standardUserDefaults().setObject(imagePath, forKey: "loading1.jpg")
                }
                
            } else {
                
            }
        }
        
        setupNotificationSettings()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleModifyListNotification), name: "modifyListNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleDeleteListNotification), name: "deleteListNotification", object: nil)
        
        Fabric.with([Crashlytics.self])
        
        RidesClient.sharedInstance.configureClientID("Kvswd-Zkg5J9xNnMHZIxUQ1nPiIc5Tid")
//        return true

        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }

    func setupNotificationSettings() {
        
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        let notificationSettings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        /*
        return
        //let notificationSettings: UIUserNotificationSettings! = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        
        
        if (notificationSettings.types == UIUserNotificationType.None){
            
            // Specify the notification types.
            var notificationTypes: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Sound
            
            // Specify the notification actions.
            var externalAction = UIMutableUserNotificationAction()
            externalAction.identifier = "externalAction"
            externalAction.title = "Visit Site!"
            externalAction.activationMode = UIUserNotificationActivationMode.Background
            externalAction.destructive = false
            externalAction.authenticationRequired = false
            
            var internalAction = UIMutableUserNotificationAction()
            internalAction.identifier = "internalAction"
            internalAction.title = "Visit Site!"
            internalAction.activationMode = UIUserNotificationActivationMode.Foreground
            internalAction.destructive = false
            internalAction.authenticationRequired = false
            
            var productAction = UIMutableUserNotificationAction()
            productAction.identifier = "productAction"
            productAction.title = "See product!"
            productAction.activationMode = UIUserNotificationActivationMode.Background
            productAction.destructive = false
            productAction.authenticationRequired = false
            
            let actionsArray = NSArray(objects: externalAction, internalAction, productAction)
            //let actionsArrayMinimal = NSArray(objects: productAction, internalAction)
            
            // Specify the category related to the above actions.
            var biinNotificationCategory = UIMutableUserNotificationCategory()
            biinNotificationCategory.identifier = "biinNotificationCategory"
            biinNotificationCategory.setActions(actionsArray as [AnyObject], forContext: UIUserNotificationActionContext.Default)
            //biinNotificationCategory.setActions(actionsArrayMinimal as [AnyObject], forContext: UIUserNotificationActionContext.Minimal)
//
            
            let categoriesForSettings = NSSet(objects: biinNotificationCategory)

            // Register the notification settings.
            let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings as Set<NSObject>)
            UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
        }

        */
    }

    func applicationWillResignActive(application: UIApplication) {
        appManager.IS_APP_UP = false
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        appManager.IS_APP_UP = false
        appManager.positionManager.start_SITES_MONITORING()
        //NSLog("BIIN - applicationDidEnterBackground: sites:\(BNAppSharedManager.instance.dataManager.sites_ordered.count)")

        //BNAppSharedManager.instance.positionManager.locationManager!.delegate!.locationManager!(BNAppSharedManager.instance.positionManager.locationManager!, didUpdateLocations:[])
        

        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        appManager.IS_APP_UP = true

        appManager.positionManager.start_BEACON_RANGING()

        //BNAppSharedManager.instance.show()
        
        //NSLog("BIIN - applicationWillEnterForeground: sites:\(BNAppSharedManager.instance.dataManager.sites_ordered.count)")
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {

        NSLog("BIIN - applicationDidBecomeActive")
        
        appManager.IS_APP_UP = true
        
        if appManager.dataManager.bnUser != nil {
            appManager.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
        }
        
        if BNAppSharedManager.instance.notificationManager.currentNotification != nil && BNAppSharedManager.instance.notificationManager.didSendNotificationOnAppDown {
            BNAppSharedManager.instance.mainViewController?.mainView?.showNotificationContext()
        }
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        
        appManager.IS_APP_UP = false
        appManager.positionManager.start_SITES_MONITORING()
        appManager.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.CLOSE_APP, to:"biin_ios")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "BN.biin" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("biin", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("biin.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            //error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as [NSObject : AnyObject])
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            //var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch _ as NSError {
                    //error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
    //App methods
    func setDeviceType(screenWidth:CGFloat, screenHeight:CGFloat){
        
        let uiManager = SharedUIManager.instance
        uiManager.screenWidth = screenWidth
        uiManager.screenHeight = screenHeight
        uiManager.setDeviceVariables()
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // Do something serious in a real app.
//        if appManager.notificationManager.currentNotification != nil {
//            appManager.mainViewController!.mainView!.showNotificationContext()
//        }
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if identifier == "externalAction" {
            NSNotificationCenter.defaultCenter().postNotificationName("modifyListNotification", object: nil)
        }
        else if identifier == "internalAction" {
            NSNotificationCenter.defaultCenter().postNotificationName("deleteListNotification", object: nil)
        }
        
        completionHandler()
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

