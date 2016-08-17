//  BNPositionManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import CoreLocation
import CoreBluetooth
import UIKit
import KontaktSDK

class BNPositionManager:NSObject, CLLocationManagerDelegate, BNDataManagerDelegate, CBCentralManagerDelegate, KTKDevicesManagerDelegate
{
    let beaconManagerDidEnterRegionsNotification = "beaconManagerDidEnterRegionsNotification"
    let beaconManagerDidExitRegionsNotification = "beaconManagerDidExitRegionsNotification"
    let beaconManagerUserInfoEnteredRegionsKey = "enteredRegions"
    let beaconManagerUserInfoExitedRegionsKey = "exitedRegions"
    
    var locationManager:CLLocationManager?// = CLLocationManager()
    var bluetoothManager:CBCentralManager?
    
    var errorManager:BNErrorManager
    
    var delegateDM:BNPositionManagerDelegate?
    var delegateNM:BNPositionManagerDelegate?
    var delegateView:BNPositionManagerDelegate?
    
    //objective c implementation
    var firstBeacon:CLBeacon?
    var firstBeaconUUID:String?
    
    var refreshCalls = 0
    
    var counter = 0
    var counterLimmit = 10
    
//    var firstBeaconProximity = BNProximity.None
//    var counterProximity = 0
//    var counterProximityLimit = 60
    
    var myBeacons = Array<CLBeacon>()
    var myBeaconsPrevious = Array<CLBeacon>()
    
    var biins = Array<BNBiin>()
    var rangedRegions:NSMutableDictionary = NSMutableDictionary();
    
    //var currentSiteUUID:NSUUID?
    var locationFixAchieved = false
    var userCoordinates:CLLocationCoordinate2D?
    
    //Biin notification variables.
    var BIIN_COMMERCIAL = "BIIN_COMMERCIAL"
    var areOtherBiinsAvailable = false
    var waitingTimeOnOtherBiinsAvailable = 30
    var waitingTimeWithNotOtherBiinsAvaialble = 10
    var isIN_BIIN_COMMERCIAL = false
    
    var monitoredBeaconRegions:Dictionary<Int, CLBeaconRegion>?
    
    var nowMonitoring:BNRegionMonitoringType = BNRegionMonitoringType.SITES_MONITORING
//    var is_SITES_MONITORING = false
//    var is_SITE_EXTERIOR_MONITORING = false
//    var is_SITE_INTERIOR_MONITORING = false
    
    var biinRegion:CLBeaconRegion?
    var currentNoticeMajor:Int = 0
    
    var currentBeaconRegion:CLBeaconRegion?
    var currentExteriorRegion:CLBeaconRegion?
    var currentInteriorRegion:CLBeaconRegion?
    var currentProductRegion:CLBeaconRegion?
    
    let MAX_NUMBER_OF_REGIONS = 20
    
    var isBiinsViewContainerEmpty = true
    
    var currentSite:BNSite?
    
    var devicesManager:KTKDevicesManager?
    
    private(set) var currentRegions = Set<CLBeaconRegion>()

    
    init(errorManager:BNErrorManager){
        
        self.errorManager = errorManager

        super.init()
    }
    
    func startLocationService() {
        
        if self.locationManager == nil {
            Kontakt.setAPIKey("HIMVKoKndBpLfFsOqRXCrsizRqsJcGDU")
            devicesManager = KTKDevicesManager(delegate: self)
            devicesManager!.startDevicesDiscoveryWithInterval(120.0)

            monitoredBeaconRegions = Dictionary<Int, CLBeaconRegion>()
            
            self.locationManager = CLLocationManager()
            
            self.locationManager!.delegate = self
            self.locationManager!.pausesLocationUpdatesAutomatically = true
            self.locationManager!.activityType = CLActivityType.OtherNavigation
            self.locationManager!.distanceFilter = kCLLocationAccuracyNearestTenMeters
            self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager!.requestAlwaysAuthorization()
            self.locationManager!.requestWhenInUseAuthorization()
            self.locationManager!.startMonitoringSignificantLocationChanges()
            
            if self.bluetoothManager == nil {
                self.bluetoothManager = CBCentralManager(delegate: self, queue: nil, options: nil)
                self.bluetoothManager!.delegate = self
            }
        }
    }
    
//    func getCurrentLocation(){
//        
//        if self.locationManager == nil {
//            startLocationService()
//        }
//        
//        locationFixAchieved = false
//        locationManager!.startUpdatingLocation()
//    }
    
    func devicesManager(manager: KTKDevicesManager, didDiscoverDevices devices: [KTKNearbyDevice]?) {
        if devices!.count > 0 {
            for device in devices! {
                
                print("Battery: \(device.uniqueID!)")
                print("Battery: \(device.batteryLevel)")
                
                if device.batteryLevel <= 50 {
                    //print("Add battery waring action")
                    BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did: BiinieActionType.BEACON_BATTERY, to: device.uniqueID!, by:"" )
                }
            }
        }
        
        devicesManager!.stopDevicesDiscovery()
    }
    
    //CLLocationManagerDelegate - Responding to Authorization Changes
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            //BNAppSharedManager.instance.continueAppInitialization()
    
            break
        case .Denied, .Restricted, .NotDetermined:
            BNAppSharedManager.instance.continueAppInitialization()
            break
        }
        
//        if BNAppSharedManager.instance.isWaitingForLocationServicesPermision {
//            BNAppSharedManager.instance.continueAppInitialization()
//        }
    }
    
    func checkLocationServicesStatus()-> Bool{
        
        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            return true
        case .Denied, .Restricted, .NotDetermined:
            return false
        }
    }
    
   
    
    //CLLocationManagerDelegate - Responding to Location Events
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        print("didUpdateLocations")
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as? CLLocation
            userCoordinates = locationObj!.coordinate
//            locationManager!.stopUpdatingLocation()
//            self.locationManager!.startMonitoringSignificantLocationChanges()
        }

        
        if BNAppSharedManager.instance.IS_APP_UP {
            //NSLog("BIIN - Request initialData background when user moved!")
        /*
            locationFixAchieved = true
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as? CLLocation
             userCoordinates = locationObj!.coordinate

            NSLog("LAT on background:  \(userCoordinates!.latitude)")
            NSLog("LONG on background: \(userCoordinates!.longitude)")

//            var time:NSTimeInterval = 1
//            var localNotification:UILocalNotification = UILocalNotification()
//            localNotification.alertBody = "Request user categories on background!"
//            localNotification.alertTitle = "Report location change."
//            localNotification.fireDate = NSDate(timeIntervalSinceNow: time)
//            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

            BNAppSharedManager.instance.dataManager.requestInitialData()
        */
            if BNAppSharedManager.instance.mainViewController != nil {
                if refreshCalls < 5 {
                    refreshCalls += 1
                } else {
                    refreshCalls += 1
                    BNAppSharedManager.instance.mainViewController!.show_refreshButton()
                }
            }
        }

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

    }
    
    
    //CLLocationManagerDelegate - Responding to Region Events
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {

    }
    
    
    func manager(manager: BNDataManager, startCommercialBiinMonitoring proximityUUID: NSUUID) {
        
        start_BEACON_RANGING()
        
    }
    
    func stop_REGION_MONITORING(){
        nowMonitoring = .NONE
        stop_SITES_MONITORING()
        currentExteriorRegion = nil
        currentInteriorRegion = nil
        currentProductRegion = nil

    }
    
    func start_SITES_MONITORING(){
        
        print("start_SITES_MONITORING")
        
        if BNAppSharedManager.instance.IS_APP_UP  || !BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED {
            return
        }

        stop_BEACON_RANGING()
        
        //Stop Monitoring all
        if nowMonitoring == .SITES_MONITORING {
            stop_SITES_MONITORING()
        }
        
        if biinRegion == nil {
            
            let nsuuid = NSUUID(UUIDString:"AABBCCDD-A101-B202-C303-AABBCCDDEEFF")
            biinRegion = CLBeaconRegion(proximityUUID:nsuuid! , identifier: "biinRegion")
            biinRegion!.notifyEntryStateOnDisplay = true
        }
        
        
        if biinRegion != nil {
            self.locationManager!.startMonitoringForRegion(biinRegion!)
            self.locationManager!.requestAlwaysAuthorization()
            self.locationManager!.requestStateForRegion(biinRegion!)
        }
        
        
        /*
        //STAGE 1-5 / SITES_MONITORING
        var site_counter = 0
        for site in BNAppSharedManager.instance.dataManager.sites_ordered {
            if site.showInView {
                if self.monitoredBeaconRegions![site.major!] == nil {
                    if site_counter < MAX_NUMBER_OF_REGIONS {
                        
                        for biin in site.biins {
                            if biin.biinType == BNBiinType.EXTERNO {
                                nowMonitoring = .SITES_MONITORING
                                
                                let exteriorBeaconRegion = CLBeaconRegion(proximityUUID:site.proximityUUID!, major:CLBeaconMajorValue(site.major!), minor:CLBeaconMajorValue(biin.minor!), identifier:biin.identifier!)
                                exteriorBeaconRegion.notifyEntryStateOnDisplay = true

                                self.monitoredBeaconRegions![site.major!] = exteriorBeaconRegion
                                self.locationManager!.startMonitoringForRegion(exteriorBeaconRegion)
                                self.locationManager!.requestAlwaysAuthorization()
                                self.locationManager!.requestStateForRegion(exteriorBeaconRegion)
                                site_counter += 1
                            }
                        }
                    }
                }
            }
        }
        */
        

    }
    
    
    
    
    func stop_SITES_MONITORING() {
        //Stop monitoring all sites regions
        for (_, region) in monitoredBeaconRegions! {
            self.locationManager!.stopMonitoringForRegion(region)
            //self.locationManager!.requestStateForRegion(region)
        }
        
        //Clean all monitor regions
        nowMonitoring = .NONE
        self.monitoredBeaconRegions!.removeAll(keepCapacity: false)
    }
    /*
    //When entering an EXT beacon  region.
    func start_SITE_EXTERIOR_MONITORING(beaconRegion:CLBeaconRegion){
        NSLog("BIIN - start_SITE_EXTERIOR_MONITORING")
        if BNAppSharedManager.instance.IS_APP_UP {
            return
        }
        
        //Stop Monitoring all
        if nowMonitoring == .SITES_MONITORING {
            stop_SITES_MONITORING()
        }
        
        if nowMonitoring == .SITE_EXTERIOR_MONITORING {
            stop_SITE_EXTERIOR_MONITORING()
        }
        
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN_REGION, to:beaconRegion.identifier)
        
        //Add all site exterior monitoring regions (neighbors and interior)
        var region_counter = 0
        var neighbors_counter = 0
        var regions_available = 20
        
//        NSLog("loking for site \(beaconRegion.identifier)")
        
        if let site = BNAppSharedManager.instance.dataManager.sites[beaconRegion.identifier] {
            if site.showInView {
//            NSLog("Add neighbors ext regions")
                if let neighbors = site.neighbors {
                    for neighbor in neighbors {
                        if let neighborSite = BNAppSharedManager.instance.dataManager.sites[neighbor] {
                            
//                            NSLog("Monitoring neighborBeaconRegion major: \(neighborSite.major!)")
                            let neighborBeaconRegion = CLBeaconRegion(proximityUUID:neighborSite.proximityUUID!, major:CLBeaconMajorValue(neighborSite.major!), identifier:neighborSite.identifier!)
                            neighborBeaconRegion.notifyEntryStateOnDisplay = true
                            self.monitoredBeaconRegions![neighborSite.major!] = neighborBeaconRegion
                            self.locationManager!.startMonitoringForRegion(neighborBeaconRegion)
                            self.locationManager!.requestAlwaysAuthorization()
                            region_counter++
                            neighbors_counter++
                        }
                    }
                }
                
                //Add site exterior region
//                NSLog("Monitoring site exterior region: \(site.major!) major")
                let exteriorBeaconRegion = CLBeaconRegion(proximityUUID:site.proximityUUID!, major:CLBeaconMajorValue(site.major!), identifier:site.identifier!)
                exteriorBeaconRegion.notifyEntryStateOnDisplay = true
                self.monitoredBeaconRegions![site.major!] = exteriorBeaconRegion
                self.locationManager!.startMonitoringForRegion(exteriorBeaconRegion)
                self.locationManager!.requestAlwaysAuthorization()
                region_counter++
                neighbors_counter++
                
                regions_available = regions_available - (region_counter + neighbors_counter)
                
                //Add site interior regions
                for biin in site.biins {
                    if region_counter < regions_available {
                        if biin.biinType == BNBiinType.INTERNO {
//                            NSLog("Monitoring site interior region: \(biin.minor!) minor, biin identifier:\(biin.identifier!)")
                            let interiorBeaconRegion = CLBeaconRegion(proximityUUID: site.proximityUUID!, major: CLBeaconMajorValue(site.major!), minor: CLBeaconMinorValue(biin.minor!), identifier: biin.identifier!)
                            interiorBeaconRegion.notifyEntryStateOnDisplay = true
                            self.monitoredBeaconRegions![biin.minor!] = interiorBeaconRegion
                            self.locationManager!.startMonitoringForRegion(interiorBeaconRegion)
                            self.locationManager!.requestAlwaysAuthorization()
                            region_counter++
                        }
                    }
                }
                nowMonitoring = .SITE_EXTERIOR_MONITORING
            }
        }
    }
    */
    /*
    func stop_SITE_EXTERIOR_MONITORING(){
        //Stop monitoring all sites regions
        for (_, region) in monitoredBeaconRegions! {
            self.locationManager!.stopMonitoringForRegion(region)
            self.locationManager!.requestStateForRegion(region)
        }
        
        //Clean all monitor regions
//        is_SITE_EXTERIOR_MONITORING = false
        self.monitoredBeaconRegions!.removeAll(keepCapacity: false)
    }
    */
    
    /*
    //When entering an interior region start monitoring for its children.
    func start_SITE_INTERIOR_MONITORING(interiorBeaconRegion:CLBeaconRegion){
        
        NSLog("start_SITE_INTERIOR_MONITORING")
        
        if BNAppSharedManager.instance.IS_APP_UP {
            return
        }
        
        //Enter an interior site
        if nowMonitoring == .SITE_EXTERIOR_MONITORING {
            
            stop_SITE_EXTERIOR_MONITORING()
            
            //Add all site exterior monitoring regions (neighbors and interior)
            var region_counter = 0
            var neighbors_counter = 0
            var regions_available = 20
            
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN_REGION, to:interiorBeaconRegion.identifier)
            
            if let site = BNAppSharedManager.instance.dataManager.sites[currentExteriorRegion!.identifier] {
                if site.showInView {
                    //Add neighbors ext regions
                    if let neighbors = site.neighbors {
                        for neighbor in neighbors {
                            if let neighborSite = BNAppSharedManager.instance.dataManager.sites[neighbor] {
                                
                                
                                let neighborBeaconRegion = CLBeaconRegion(proximityUUID:neighborSite.proximityUUID!, major:CLBeaconMajorValue(neighborSite.major!), identifier:neighborSite.identifier!)
                                neighborBeaconRegion.notifyEntryStateOnDisplay = true
                                self.monitoredBeaconRegions![neighborSite.major!] = neighborBeaconRegion
                                self.locationManager!.startMonitoringForRegion(neighborBeaconRegion)
                                self.locationManager!.requestAlwaysAuthorization()
                                region_counter++
                                neighbors_counter++
                            }
                        }
                    }
                    
                    //Add site exterior region
                    
                    let exteriorBeaconRegion = CLBeaconRegion(proximityUUID:site.proximityUUID!, major:CLBeaconMajorValue(site.major!), identifier:site.identifier!)
                    exteriorBeaconRegion.notifyEntryStateOnDisplay = true
                    self.monitoredBeaconRegions![site.major!] = exteriorBeaconRegion
                    self.locationManager!.startMonitoringForRegion(exteriorBeaconRegion)
                    self.locationManager!.requestAlwaysAuthorization()
                    region_counter++
                    neighbors_counter++
                    
                    regions_available = regions_available - (region_counter + neighbors_counter)
                    
                    //Add site interior regions
                    
                    var interiorBiin:BNBiin?
                    
                    for biin in site.biins {
                        if region_counter < regions_available {
                            if biin.biinType == BNBiinType.INTERNO {
                                if biin.minor! == interiorBeaconRegion.minor! {
                                    //Get current biin to monitor his children later
                                    interiorBiin = biin
                                    
                                    let interiorBeaconRegion = CLBeaconRegion(proximityUUID: site.proximityUUID!, major: CLBeaconMajorValue(site.major!), minor: CLBeaconMinorValue(biin.minor!), identifier: biin.identifier!)
                                    interiorBeaconRegion.notifyEntryStateOnDisplay = true
                                    self.monitoredBeaconRegions![biin.minor!] = interiorBeaconRegion
                                    self.locationManager!.startMonitoringForRegion(interiorBeaconRegion)
                                    self.locationManager!.requestAlwaysAuthorization()
                                    region_counter++
                                } else {
                                    
                                    let interiorBeaconRegion = CLBeaconRegion(proximityUUID: site.proximityUUID!, major: CLBeaconMajorValue(site.major!), minor: CLBeaconMinorValue(biin.minor!), identifier: biin.identifier!)
                                    interiorBeaconRegion.notifyEntryStateOnDisplay = true
                                    self.monitoredBeaconRegions![biin.minor!] = interiorBeaconRegion
                                    self.locationManager!.startMonitoringForRegion(interiorBeaconRegion)
                                    self.locationManager!.requestAlwaysAuthorization()
                                    region_counter++
                                }
                            }
                        }
                    }
                    
                    if interiorBiin != nil {
                        for biin in site.biins {
                            if region_counter < regions_available {
                                if biin.biinType == BNBiinType.PRODUCT {
                                    
                                    for child in interiorBiin!.children! {
                                        if child == biin.minor! {
                                            
                                            let productBeaconRegion = CLBeaconRegion(proximityUUID: site.proximityUUID!, major: CLBeaconMajorValue(site.major!), minor: CLBeaconMinorValue(biin.minor!), identifier: biin.identifier!)
                                            productBeaconRegion.notifyEntryStateOnDisplay = true
                                            self.monitoredBeaconRegions![biin.minor!] = productBeaconRegion
                                            self.locationManager!.startMonitoringForRegion(productBeaconRegion)
                                            self.locationManager!.requestAlwaysAuthorization()
                                            region_counter++
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    nowMonitoring = .SITE_INTERIOR_MONITORING
                
                }
            }
        }
    }

    func stop_SITE_INTERIOR_MONITORING(interiorBeaconRegion:CLBeaconRegion){
        start_SITE_EXTERIOR_MONITORING(currentExteriorRegion!)
    }
    */
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        
        
        if BNAppSharedManager.instance.IS_APP_UP {
            NSLog("BIIN - App is running and enter beacon region")
            return
        }
        
        if let beaconRegion = region as? CLBeaconRegion {
            

            self.locationManager!.requestStateForRegion(beaconRegion)
            currentBeaconRegion = beaconRegion
/*
            return
            
            if let major = beaconRegion.major {
            
                if let minor = beaconRegion.minor {
                    print("ENTER EXT region: \(beaconRegion.identifier), major: \(major), minor:\(minor)")
                    NSLog("ENTER EXT region: \(beaconRegion.identifier), major: \(major), minor:\(minor)")
                } else {
                    print("ENTER INT region: \(beaconRegion.identifier), \(major)")
                    NSLog("ENTER INT region: \(beaconRegion.identifier), \(major)")
                }
            } else {
                print("ENTER region: \(beaconRegion.identifier)")
                NSLog("ENTER region: \(beaconRegion.identifier)")
            }
            
            if currentBeaconRegion == nil {
                
                self.locationManager!.requestStateForRegion(beaconRegion)
                currentBeaconRegion = beaconRegion
                //BNAppSharedManager.instance.notificationManager.sendNotificationForBeaconRegionDetected(beaconRegion.identifier, major: beaconRegion.major!.integerValue )
            
            } else {
                
                
                print("ENTER region again: \(beaconRegion.identifier), \(beaconRegion.major!)")
                NSLog("ENTER region again: \(beaconRegion.identifier), \(beaconRegion.major!)")

                if currentBeaconRegion!.identifier == beaconRegion.identifier
                    && currentBeaconRegion!.major!.integerValue == beaconRegion.major!.integerValue {
                    
                    print("STILL ON SAME REGION: \(beaconRegion.identifier), \(beaconRegion.major!)")
                    NSLog("STILL ON SAME REGION: \(beaconRegion.identifier), \(beaconRegion.major!)")
                    
                } else {
                    
                    print("ENTER NEW region: \(beaconRegion.identifier), \(beaconRegion.major!)")
                    NSLog("ENTER NEW region: \(beaconRegion.identifier), \(beaconRegion.major!)")
    
                    currentBeaconRegion = beaconRegion
                    BNAppSharedManager.instance.notificationManager.sendNotificationForBeaconRegionDetected(beaconRegion.identifier, major: beaconRegion.major!.integerValue )
                }
            }
            
            */
            
            /*
            switch nowMonitoring {
            case .NONE:
                break
            case .SITES_MONITORING:
                
                if beaconRegion.minor != nil && BNAppSharedManager.instance.IS_APP_DOWN {
//                    NSLog("It seems is a interior beacon detected.")
                    //BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(beaconRegion.identifier)
                } else {
                
                    print("BIIN - .SITES_MONITORING - \(monitoredBeaconRegions!.count)")
                    BNAppSharedManager.instance.notificationManager.activateNotificationForSite(beaconRegion.identifier, major:beaconRegion.major!.integerValue)
                    
                    print("BIIN - .SITES_MONITORING B1")
                    if monitoredBeaconRegions != nil {
                        print("BIIN - .SITES_MONITORING B1.1")
                        if monitoredBeaconRegions!.count > 0 {
                            print("BIIN - .SITES_MONITORING B2")
                            if let _ = monitoredBeaconRegions![beaconRegion.major!.integerValue]{
                                
                                print("BIIN - .SITES_MONITORING B3")
                                
                                if currentExteriorRegion == nil {
                                    print("BIIN - .SITES_MONITORING B4")
                                    
                                    currentExteriorRegion = beaconRegion
                                    currentInteriorRegion = nil
                                    currentProductRegion = nil
//                                    start_SITE_EXTERIOR_MONITORING(beaconRegion)
                                    BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
                                    
                                    print("BIIN - .SITES_MONITORING B5")
                                }
                            }
                        }
                    }
                }
                break
                
            /*
            case .SITE_EXTERIOR_MONITORING:
//                NSLog("BIIN - .SITE_EXTERIOR_MONITORING")
                if currentExteriorRegion != nil {
                    if beaconRegion.minor != nil {
                        if beaconRegion.major!.integerValue == currentExteriorRegion!.major!.integerValue {
                            if currentInteriorRegion == nil {
                                if let interiorRegion = monitoredBeaconRegions![beaconRegion.minor!.integerValue]{
                                    currentInteriorRegion = interiorRegion
                                    start_SITE_INTERIOR_MONITORING(beaconRegion)
                                    BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(currentInteriorRegion!.identifier)
//                                    NSLog("2")
                                }
                            } else {
//                                NSLog("Enter other region with minor: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                            }
                        } else {
//                            NSLog("Enter other interior region: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                        }
                    } else if beaconRegion.major!.integerValue != currentExteriorRegion!.major!.integerValue {
                        if beaconRegion.minor != nil {
//                            NSLog("ENTER directly to new interior region!")
                            currentInteriorRegion = beaconRegion
                            currentExteriorRegion = monitoredBeaconRegions![beaconRegion.major!.integerValue]
                            start_SITE_INTERIOR_MONITORING(beaconRegion)
//                            NSLog("3")
                            
                        } else {
//                            NSLog("ENTER new exterior region!")
                            currentExteriorRegion = beaconRegion
                            currentInteriorRegion = nil
                            currentProductRegion = nil
                            start_SITE_EXTERIOR_MONITORING(beaconRegion)
                            BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
//                            NSLog("4")
                        }
                        
                    } else {
//                        NSLog("Enter other exterior region: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                        currentExteriorRegion = beaconRegion
                        currentInteriorRegion = nil
                        currentProductRegion = nil
                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
                        BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
//                        NSLog("5")
                    }
                }
                
                break
            case .SITE_INTERIOR_MONITORING:
                if currentInteriorRegion != nil {
                    if beaconRegion.minor != nil {
                        if beaconRegion.major!.integerValue == currentExteriorRegion!.major!.integerValue {
                            switch findBiinTypeByMinor(beaconRegion.minor!.integerValue) {
                            case .PRODUCT:
                                if let productRegion = monitoredBeaconRegions![beaconRegion.minor!.integerValue]{
                                    
                                    if currentProductRegion == nil {
                                        currentProductRegion = productRegion
//                                        NSLog("Show notification for product biin:\(currentProductRegion!.proximityUUID.UUIDString), major:\(currentProductRegion!.major!),  minor:\(currentProductRegion!.minor!)")
                                        BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(productRegion.identifier)
//                                        NSLog("6")
                                    } else {
                                        currentProductRegion = productRegion
//                                        NSLog("Show notification for other product biin:\(currentProductRegion!.proximityUUID.UUIDString), major:\(currentProductRegion!.major!),  minor:\(currentProductRegion!.minor!)")
                                        BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(productRegion.identifier)
//                                        NSLog("7")
                                    }
                                    
                                    BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN_REGION, to:productRegion.identifier)
                                }
                                break
                            case .INTERNO:
//                                NSLog("Enter a new internal region:\(currentProductRegion!.proximityUUID.UUIDString), major:\(currentProductRegion!.major!),  minor:\(currentProductRegion!.minor!)")
                                    currentInteriorRegion = beaconRegion
                                    start_SITE_INTERIOR_MONITORING(beaconRegion)
//                                    NSLog("8")
                                break
                            default:
                                break
                            }
                        }
                    } else {
//                        NSLog("Enter other exterior region: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                        currentExteriorRegion = beaconRegion
                        currentInteriorRegion = nil
                        currentProductRegion = nil
                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
                        BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
//                        NSLog("9")
                    }
                }
                break
*/
            default:
                break
            }
            */
            
        }

    }
    
    func findBiinTypeByMinor(minor:Int) ->BNBiinType {
        if currentExteriorRegion != nil {
            if let site = BNAppSharedManager.instance.dataManager.sites[currentExteriorRegion!.identifier] {
                for biin in site.biins {
                    if biin.minor! == minor {
                        return biin.biinType
                    }
                }
            }
        }
        return BNBiinType.NONE
    }

    func requestStateForMonitoredRegions(){
        for (_, value) in monitoredBeaconRegions! {
            locationManager!.requestStateForRegion(value)
        }
    }
    
    func isMonitoringRegion(region:CLRegion) -> Bool{
        
        var value = false
        
        for r in self.locationManager!.monitoredRegions {
            if r.identifier == region.identifier {
                value = true
            }
        }
        
        return value
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let beaconRegion = region as? CLBeaconRegion {
            locationManager!.requestStateForRegion(beaconRegion)
        }

    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
  
        
        //var stateString:String = ""
        
        switch state {
        case .Unknown:
            //stateString = "Unknown"
            break
        case .Inside:
            //stateString = "Inside"
            locationManager!.startRangingBeaconsInRegion((region as! CLBeaconRegion))
            break
        case .Outside:
            //stateString = "Outside"
            locationManager!.stopRangingBeaconsInRegion((region as! CLBeaconRegion))
            if currentNoticeMajor != 0 {
                if let site = BNAppSharedManager.instance.dataManager.findSiteByMajor(self.currentNoticeMajor) {
                    //print("Exit region: \(region.identifier), \(self.currentNoticeMajor), \(site.identifier!)")
                    BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.EXIT_BIIN_REGION, to:site.identifier!, by:site.identifier!)
                    self.currentNoticeMajor = 0
                }
            }
            break
        }
 
        //print("region: \(region.identifier) - state:\(stateString)")

//        if let beaconRegion = region as? CLBeaconRegion {
//            if beaconRegion.major != nil {
//                if beaconRegion.minor != nil {
//                }
//            } else {
//        
//            }
//        }
        
    }
    
    //BNDataManagerDelegate Methods
    func start_BEACON_RANGING() {
        
        if !BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED {
            return
        }
        
        NSLog("start_BEACON_RANGING")
        
        stop_REGION_MONITORING()
        nowMonitoring = BNRegionMonitoringType.RANGING
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()

        let proximityUUID:NSUUID = NSUUID(UUIDString:"AABBCCDD-A101-B202-C303-AABBCCDDEEFF")!
        let region:CLBeaconRegion = CLBeaconRegion(proximityUUID:proximityUUID, identifier:"BIIN_COMMERCIAL")
        self.rangedRegions[region] = NSArray()
        
        for (key, _): (AnyObject, AnyObject) in self.rangedRegions {
            self.locationManager!.startRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
        
        locationManager!.requestWhenInUseAuthorization()
    }
    
    //BNDataManagerDelegate Methods
    func stop_BEACON_RANGING() {
        
        NSLog("stop_BEACON_RANGING")
        
        //self.stopMonitoringBeaconRegions()
        for (key, _): (AnyObject, AnyObject) in self.rangedRegions {
            self.locationManager!.stopRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()
    }

    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {

    }
    
    //CLLocationManagerDelegate - Responding to Ranging Events
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
    

        //Sets detected beacon to proper region
        self.rangedRegions[region] = beacons

        
        //Clean local beacon
        self.myBeacons.removeAll(keepCapacity: false)
        
        //Get all beacon from regions
        for (_, value): (AnyObject, AnyObject) in self.rangedRegions {
            self.myBeacons += value as! Array<CLBeacon>
            print(" \(value)")
        }
        
        print("\(self.myBeacons.count)")
        
        self.myBeacons = self.myBeacons.sort{ $0.rssi > $1.rssi  }
        
        if !self.myBeacons.isEmpty {
            
            //value 0 = more beacons detected
            //value 1 = order changed
            //value 2 = proximity changed
            
            let value = didSomethingChangeOnBeaconsDetected(self.myBeacons, array2:self.myBeaconsPrevious)
            
            //Frist return value checks is there are more biins available
            
            if BNAppSharedManager.instance.IS_APP_UP  || !BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED {
                
                if value.0 || value.1 {
                    
                    self.counter += 1
                    
                    if self.counter == self.counterLimmit {
                        self.counter = 0
                        self.myBeaconsPrevious = self.myBeacons
                        isBiinsViewContainerEmpty = false
                        
                        if myBeacons.count > 0 {
                            devicesManager!.startDevicesDiscoveryWithInterval(10.0)
                            handleBiiniePositionOnFirstBiinDetected(myBeacons[0])
                        }
                    }
                    
                } else if value.2 {
                    
                }
                
            } else {
                if myBeacons.count > 0 {
                    let major = Int(myBeacons[0].major)
                    //print("Entered:\(major)")
                    
                    if currentNoticeMajor != major {
                        //print("Sending entered:\(major)")
                        currentNoticeMajor = major
                        BNAppSharedManager.instance.notificationManager.showNotice(major)
                    }
                }
            }
            
        } else {
            self.firstBeacon = nil
            self.firstBeaconUUID = nil
            self.counter = 0
            if !isBiinsViewContainerEmpty {
                if BNAppSharedManager.instance.IS_APP_UP  || !BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED {
                    cleanAndSentBiinsToDisplay()
                }else {
                    //print("Exited")

                }
            }
        }
        
    }
    
    func checkBiinRegionStatus(){
        self.locationManager!.requestStateForRegion(biinRegion!)
    }
    
    func regionFromBeacon(beacon: CLBeacon) -> CLBeaconRegion {
        let major = CLBeaconMajorValue(beacon.major.integerValue)
        let minor = CLBeaconMinorValue(beacon.minor.integerValue)
        let identifier = "\(beacon.proximityUUID.UUIDString).\(major).\(minor)" // Used for "is equal" check in Sets
        return CLBeaconRegion(proximityUUID: beacon.proximityUUID, major: major, minor: minor, identifier: identifier)
    }
    
    
    //The method checks is the tow Arrays are order the same way.
    func didSomethingChangeOnBeaconsDetected(array1:Array<CLBeacon>, array2:Array<CLBeacon>) -> ( Bool, Bool, Bool ){
        
        //value 0 = more beacons detected
        //value 1 = order changed
        //value 2 = proximity changed
        
        var value = (false, false, false)
        
        if !array1.isEmpty || !array2.isEmpty {
            if array1.count != array2.count {
                value.0 = true
            }
            
            if !value.0 {
                var i:Int = 0
                for _ in array1 {
//                for var i = 0; i < array1.count; i++ {
                    
                    if array1[i].minor.integerValue != array2[i].minor.integerValue {
                        value.1 = true
                    }
                    
                    if array1[i].proximity != array2[i].proximity {
                        value.2 = true
                    }
                    
                    i += 1
                }
            }
        }

        return value
    }
    
    func handleBiiniePositionOnFirstBiinDetected(beacon:CLBeacon){

        var changeSite = false
        
        if currentSite == nil {
            changeSite = true
        } else {
            if currentSite!.major != beacon.major.integerValue {
                changeSite = true
            }
        }
        
        if changeSite {
            for site in BNAppSharedManager.instance.dataManager.sites_ordered {

                if site.major == beacon.major.integerValue {
                    
//                    for biin in site.biins {
//                        //if biin.minor == beacon.minor.integerValue {
//
//                            switch biin.biinType {
//                            case .EXTERNO:
//                                site.isUserInside = false
//                                break
//                            case .INTERNO:
//                                site.isUserInside = true
//                                break
//                            case .PRODUCT:
//                                site.isUserInside = true
//                                break
//                            default:
//                                break
//                            }
                    
                            if !site.isUserInside {
                                //print("User is inside: \(site.title!)")
                                currentSite = site
                                self.delegateView!.showInSiteView!(currentSite)
                                BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN, to:"\(beacon.major.integerValue)", by:site.identifier!)
                                
                            } else {
                                //print("User is outside or entering: \(site.title!)")
                            }
                            
                        //}
                    //}
                    
                    return
                }
            }
        }
    }
    

    

    /*
    //TODO: Remove this method if not needed.
    //The method checks is first beacon on list has change.
    func didFirstBeaconChanged(uuid:String) -> Bool {
        var returnValue = false
        
        if self.firstBeacon == nil {
            self.firstBeaconUUID = uuid
            returnValue = true
        } else if self.firstBeaconUUID != uuid {
            self.counter++
            if self.counter == self.counterLimmit {
                self.firstBeaconUUID = uuid
                self.counter = 0
                returnValue = true
            }
        } else {
            self.counter = 0
        }
        
        return returnValue
    }
    */
    
    /*
    //This method sets the proximity on first beacon on list and return 
    //bool is proximity on first beacon has change.
    func didProximityChanged(proximity:Int) ->Bool {
        var returnValue = false
        var currentProximity = BNProximity.None
        
        if proximity <= -85 {
            currentProximity = BNProximity.Far
        } else if proximity <= -80 {
            currentProximity = BNProximity.Near
        } else if proximity <= -70 {
            currentProximity = BNProximity.Inmediate
        } else if proximity <= -60 {
            currentProximity = BNProximity.Over
        }
        
        if currentProximity != self.firstBeaconProximity {
            if self.counterProximity == self.counterProximityLimit {
                self.firstBeaconProximity = currentProximity
                self.counterProximity = 0
                returnValue = true
            } else {
                self.counterProximity++
            }
        }
        
        return returnValue
    }
    */
    
    //This method order the biin list according to beacons detected on field.
    func orderAndSentBiinsToDisplay(beacons:Array<CLBeacon>) {

        

        //Create an Array to temporary backup biins.
//        var biinBackup:Array<BNBiin> = Array<BNBiin>()
        //self.biins.removeAll(keepCapacity: false)
        //BNAppSharedManager.instance.dataManager.availableBiins.removeAll(keepCapacity: false)
        //Remove and backup biins from local list.

        if currentSite == nil {
            for beacon in beacons {
                if beacon.proximity != CLProximity.Unknown {
                    for (_, site) in BNAppSharedManager.instance.dataManager.sites {
                        if beacon.major.integerValue == site.major {
                            
                            
                            currentSite = site
                            self.delegateView!.showInSiteView!(currentSite!)
                            
                        }
                    }
                }
            }
        }
        /*
        //Put back backup biin on local list.
        if !biinBackup.isEmpty {
            for var i = 0; i < biinBackup.count; i++ {
                self.biins.insert(biinBackup[i], atIndex: i)
            }
        }
        
        //clear biinBackup
        biinBackup.removeAll(keepCapacity: false)
        */
        //self.delegateView?.manager!(self, showInSiteView: self.biins)

    }
    
    
    func cleanAndSentBiinsToDisplay() {
        
        isBiinsViewContainerEmpty = true
        self.biins.removeAll(keepCapacity: false)
//        BNAppSharedManager.instance.dataManager.availableBiins.removeAll(keepCapacity: false)
        currentSite = nil
        self.delegateView!.hideInSiteView!()
        self.myBeaconsPrevious.removeAll(keepCapacity: false)
        self.myBeacons.removeAll(keepCapacity: false)
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
        //TODO: send error when failing ranging on a region.
    }

    
    //CLLocationManagerDelegate - Responding to Visit Events
    func locationManager(manager: CLLocationManager, didVisit visit: CLVisit) {
        
    }
    
    //Methods to conform on BNPositionManager
    func manager(manager:BNDataManager!, startRegionsMonitoring regions:Array<BNRegion>) {
        
    }
    
    func startRegionsMonitoring(regions:Array<BNRegion>){
        
        //return
        
        for region in regions {
            
            if region.latitude == nil || region.longitude == nil {
                return
            }
            
            let radiuos:CLLocationDistance = CLLocationDistance(region.radious!)
            let lat:CLLocationDegrees? = CLLocationDegrees(region.latitude!)
            let long:CLLocationDegrees? = CLLocationDegrees(region.longitude!)
            let coord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
            let clRegion:CLCircularRegion = CLCircularRegion(center: coord, radius: radiuos, identifier: region.identifier!)
            self.locationManager!.startMonitoringForRegion(clRegion)
            self.locationManager!.requestStateForRegion(clRegion)
            
            //self.delegateView?.manager!(self, setPinOnMapWithLat: region.latitude!, long: region.longitude!, radious: region.radious!, title: region.identifier!, subtitle: region.identifier!)
        }

    }
    
    func manager(manager:BNDataManager!, stopRegionsMonitoring regions:Array<BNRegion>) {

        for region in regions {
            
            if region.latitude == nil || region.longitude == nil {
                return
            }
            
            let radiuos:CLLocationDistance = CLLocationDistance(region.radious!)
            let lat:CLLocationDegrees? = CLLocationDegrees(region.latitude!)
            let long:CLLocationDegrees? = CLLocationDegrees(region.longitude!)
            let coord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
            let clRegion:CLCircularRegion = CLCircularRegion(center: coord, radius: radiuos, identifier: region.identifier!)
            self.locationManager!.stopMonitoringForRegion(clRegion)
            self.locationManager!.requestStateForRegion(clRegion)
            
        }
    }

    //BNDataManagerDelegate Methods
    func manager(manager:BNDataManager, startSitesMonitoring value:Bool) {
        
        self.stopMonitoringBeaconRegions()
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()
        
        let proximityUUID:NSUUID = NSUUID(UUIDString:"AABBCCDD-A101-B202-C303-AABBCCDDEEFF")!
        let region:CLBeaconRegion = CLBeaconRegion(proximityUUID:proximityUUID, identifier:"BIIN_COMMERCIAL")
        self.rangedRegions[region] = NSArray()

        for (key, _): (AnyObject, AnyObject) in self.rangedRegions {
            self.locationManager!.startRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
        
        locationManager!.requestWhenInUseAuthorization()
    }
    
    func manager(manager:BNDataManager, stopSiteMonitoring site:BNSite) {
    
        /*
        self.stopMonitoringBeaconRegions()
        
        for biin in site.biins {
            for var i = 0; i < self.biins.count; i++ {
                if self.biins[i] == biin {
                    self.biins.removeAtIndex(i)
                    return
                }
            }
        }
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()
        
        for biin in self.biins {
            var major:CLBeaconMajorValue = UInt16(site.major!)
            var minor:CLBeaconMinorValue = UInt16(biin.minor!)
            var region:CLBeaconRegion = CLBeaconRegion(proximityUUID: site.proximityUUID!, major: major, minor: minor, identifier: biin.identifier!)
                
            self.rangedRegions[region] = NSArray()
        }
        
        self.startMonitoringBeaconRegions()
*/

    }
    
    
    //Old methods use to monitor biins. now the app monitors sites by uuid and idestifier, Remove this methods later startBiinMonitoring and stopBiinMonitoring
    func manager(manager:BNDataManager!, startBiinMonitoring biin:BNBiin) {
        
    }
    
    func manager(manager:BNDataManager!, stopBiinMonitoring biin:BNBiin) {
        
    }
    
    func startMonitoringBeaconRegions() {
        for (key, _): (AnyObject, AnyObject) in self.rangedRegions {
            self.locationManager!.startRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
    }
    
    func stopMonitoringBeaconRegions() {
        for (key, _): (AnyObject, AnyObject) in self.rangedRegions {
            self.locationManager!.stopRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
    }
    
    //Methods related to Beacons
    func centralManagerDidUpdateState(central: CBCentralManager) {

        BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED = false
        
        switch central.state {
            case .PoweredOn:
                BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED = true
                break
            case .PoweredOff: break
            case .Resetting: break
            case .Unauthorized: break
            case .Unknown: break
            case .Unsupported: break
        }
        
        
        if BNAppSharedManager.instance.IS_MAINVIEW_ON {
            if BNAppSharedManager.instance.IS_BLUETOOTH_ENABLED {
                start_BEACON_RANGING()
            } else {
                stop_BEACON_RANGING()
            }
        } else {
            BNAppSharedManager.instance.continueAppInitialization()
        }
    }
    
    func checkBluetoothServicesStatus()-> Bool{

        switch bluetoothManager!.state {
        case .PoweredOn:
            return true
        case .PoweredOff, .Unsupported, .Unknown, .Unauthorized:
            return false
        default:
            return false
        }
    }
    
    func checkHardwareStatus()-> Bool{
        
        
        switch bluetoothManager!.state {
        case .Unsupported:
            return false
        default:
            return true
        }
    }
}


func == (biin1:CLBeacon, biin2:CLBeacon) -> Bool {
    return biin1.proximityUUID.UUIDString == biin2.proximityUUID.UUIDString
}

func != (biin1:CLBeacon, biin2:CLBeacon) -> Bool {
    return biin1.proximityUUID.UUIDString != biin2.proximityUUID.UUIDString
}

func == (biin1:BNBiin, biin2:BNBiin) -> Bool {
    return biin1.identifier == biin2.identifier
}

 func != (biin1:BNBiin, biin2:BNBiin) -> Bool {
    return biin1.identifier != biin2.identifier
}

@objc protocol BNPositionManagerDelegate:NSObjectProtocol
{
    optional func manager(manager:BNPositionManager!, startEnterRegionProcessWithIdentifier identifier:String)
    optional func manager(manager:BNPositionManager!, startExitRegionProcessWithIdentifier identifier:String)
    optional func manager(manager:BNPositionManager!, markBiinAsDetectedWithUUID uuid:String)
    optional func manager(manager:BNPositionManager!, requestCategoriesDataOnBackground user:Biinie)
    
    //temporal methods
    optional func showInSiteView (site:BNSite?)
    optional func hideInSiteView()

}

enum BNProximity
{
    case Over
    case Inmediate
    case Near
    case Far
    case None
}

enum BNRegionMonitoringType {
    case NONE
    case SITES_MONITORING
    case SITE_EXTERIOR_MONITORING
    case SITE_INTERIOR_MONITORING
    case RANGING
}

extension Array {
     func hasBiin(child:BNBiin) -> Bool {
        for obj in self {
            if child == obj as! BNBiin {
                return true
            }
        }
        return false
    }
}