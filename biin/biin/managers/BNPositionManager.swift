//  BNPositionManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import CoreLocation
import CoreBluetooth
import UIKit

class BNPositionManager:NSObject, CLLocationManagerDelegate, BNDataManagerDelegate, CBCentralManagerDelegate
{
    var locationManager:CLLocationManager?// = CLLocationManager()
    var bluetoothManager:CBCentralManager?
    
    var errorManager:BNErrorManager
    
    var delegateDM:BNPositionManagerDelegate?
    var delegateNM:BNPositionManagerDelegate?
    var delegateView:BNPositionManagerDelegate?
    
    //objective c implementation
    var firstBeacon:CLBeacon?
    var firstBeaconUUID:String?
    
    var counter = 0
    var counterLimmit = 20
    
    var firstBeaconProximity = BNProximity.None
    var counterProximity = 0
    var counterProximityLimit = 60
    
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
    var currentExteriorRegion:CLBeaconRegion?
    var currentInteriorRegion:CLBeaconRegion?
    var currentProductRegion:CLBeaconRegion?
    
    let MAX_NUMBER_OF_REGIONS = 20
    
    var isBiinsViewContainerEmpty = true
    
    var currentSite:BNSite?
    
    init(errorManager:BNErrorManager){
        
        self.errorManager = errorManager

        super.init()

        self.startLocationService()
    }
    
    func startLocationService()
    {
        monitoredBeaconRegions = Dictionary<Int, CLBeaconRegion>()
        
        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
        }
        
        self.locationManager!.delegate = self
        self.locationManager!.pausesLocationUpdatesAutomatically = true
        self.locationManager!.activityType = CLActivityType.OtherNavigation
        self.locationManager!.distanceFilter = kCLLocationAccuracyNearestTenMeters
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.requestAlwaysAuthorization()
        self.locationManager!.requestWhenInUseAuthorization()
        self.locationManager!.startUpdatingLocation()
        
        if self.bluetoothManager == nil {
            self.bluetoothManager = CBCentralManager(delegate: self, queue: nil, options: nil)
            self.bluetoothManager!.delegate = self
        }
    }
    
    func getCurrentLocation(){
        
        if self.locationManager == nil {
            startLocationService()
        }
        
        locationFixAchieved = false
        locationManager!.startUpdatingLocation()
    }
    
    
    //CLLocationManagerDelegate - Responding to Authorization Changes
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        print("didChangeAuthorizationStatus()")
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            print("didChangeAuthorizationStatus() autorized")
            break
        case .Denied, .Restricted, .NotDetermined:
            print("didChangeAuthorizationStatus() denied")
            break
        }
        
        if BNAppSharedManager.instance.isWaitingForLocationServicesPermision {
            BNAppSharedManager.instance.continueAppInitialization()
        }
    }
    
    func checkLocationServicesStatus()-> Bool{
        print("checkLocationServicesStatus()")
        
        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            print("checkLocationServicesStatus() autorized")
            return true
        case .Denied, .Restricted, .NotDetermined:
            print("checkLocationServicesStatus() denied")
            return false
        }
    }
    
   
    
    //CLLocationManagerDelegate - Responding to Location Events
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.delegateView?.manager?(self, printText:"LocationManager update should not be working")
//        var location:CLLocation = locations[0] as CLLocation
//        println("updade location latitude: \(location.coordinate.latitude)")
//        println("updade location longitude: \(location.coordinate.latitude)")

        NSLog("BIIN - 1")
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as? CLLocation
            userCoordinates = locationObj!.coordinate
            NSLog("LAT:  \(userCoordinates!.latitude)")
            NSLog("LONG: \(userCoordinates!.longitude)")
            NSLog("BIIN - 2")
            locationManager!.stopUpdatingLocation()
            NSLog("BIIN - 3")
            self.locationManager!.startMonitoringSignificantLocationChanges()
            NSLog("BIIN - 4")
        }
        
        if BNAppSharedManager.instance.IS_APP_READY_FOR_NEW_DATA_REQUEST {
            NSLog("BIIN - Request user categories on background when user moved!")
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

            BNAppSharedManager.instance.dataManager.requestDataForNewPosition()
        }
        
        NSLog("BIIN - END")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //let text = "Error: " + error.description
        //self.delegateView?.manager?(self, printText: text)
    }
    
    
    //CLLocationManagerDelegate - Responding to Region Events
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        //let text = "Monitoring: " + region.identifier
        //self.delegateView?.manager?(self, printText: text)
    }
    
    
    func manager(manager: BNDataManager, startCommercialBiinMonitoring proximityUUID: NSUUID) {
        
        print("startCommercialBiinMonitoring():")
        /*
        var region:CLBeaconRegion = CLBeaconRegion(proximityUUID:proximityUUID, identifier:BIIN_COMMERCIAL)
        region.notifyEntryStateOnDisplay = true //If you want to get a guaranteed extra monitoring update in the background whenever the users wakes up their phone, set the notifyEntryStateOnDisplay option on your region as so:
        var site:BNSite = BNSite()
        site.identifier = region.identifier!
        self.monitoredRegions[region.identifier!] = region
        self.locationManager!.startMonitoringForRegion(region)
        self.locationManager!.requestWhenInUseAuthorization()
        self.locationManager!.requestStateForRegion(region)
        
        
        //TESTING BEACON MONITORING
        //STAGE 1 - IN_GEO_REGION_MONITORING
        var site_counter = 0
        var max_number_of_regions = 19
        for (identifier, site) in BNAppSharedManager.instance.dataManager.sites {
            if site_counter < max_number_of_regions {
                site.is_IN_GEO_REGION_MONITORING = true
                var site_region = CLBeaconRegion(proximityUUID:site.proximityUUID!, major:CLBeaconMajorValue(site.major!), identifier:site.identifier!)
                self.locationManager!.startMonitoringForRegion(site_region)
                self.locationManager!.requestAlwaysAuthorization()
                self.monitoredRegions[site_region.identifier!] = site_region
            }
            site_counter++
        }
        */
        start_BEACON_RANGING()
        //start_SITES_MONITORING()
        
    }
    
    func stop_REGION_MONITORING(){
        nowMonitoring = .NONE
        stop_SITES_MONITORING()
        currentExteriorRegion = nil
        currentInteriorRegion = nil
        currentProductRegion = nil

    }
    
    func start_SITES_MONITORING(){
        
        NSLog("BIIN - start_SITES_MONITORING 1")
        
        if BNAppSharedManager.instance.IS_APP_UP {
            return
        }

        NSLog("BIIN - start_SITES_MONITORING 2")
        print("start_SITES_MONITORING()")
        
        stop_BEACON_RANGING()
        
        //Stop Monitoring all
        if nowMonitoring == .SITES_MONITORING {
            stop_SITES_MONITORING()
        }
        
        //STAGE 1-5 / SITES_MONITORING
        var site_counter = 0
        for (_, site) in BNAppSharedManager.instance.dataManager.sites {
            if site.showInView {
                if let _ = self.monitoredBeaconRegions![site.major!] {
                    print("This site major already monitored: \(site.major!)")
                } else {
                    if site_counter < MAX_NUMBER_OF_REGIONS {
                        print("Monitoring site: \(site.title!) major: \(site.major!) identifier: \(site.identifier!)")
                        nowMonitoring = .SITES_MONITORING
                        let exteriorBeaconRegion = CLBeaconRegion(proximityUUID:site.proximityUUID!, major:CLBeaconMajorValue(site.major!), identifier:site.identifier!)
                        exteriorBeaconRegion.notifyEntryStateOnDisplay = true
                        self.monitoredBeaconRegions![site.major!] = exteriorBeaconRegion
                        self.locationManager!.startMonitoringForRegion(exteriorBeaconRegion)
                        self.locationManager!.requestAlwaysAuthorization()
                        self.locationManager!.requestStateForRegion(exteriorBeaconRegion)
                    }
                    site_counter++
                }
            }
        }
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
        
        NSLog("loking for site \(beaconRegion.identifier)")
        
        if let site = BNAppSharedManager.instance.dataManager.sites[beaconRegion.identifier] {
            if site.showInView {
            NSLog("Add neighbors ext regions")
                if let neighbors = site.neighbors {
                    for neighbor in neighbors {
                        if let neighborSite = BNAppSharedManager.instance.dataManager.sites[neighbor] {
                            
                            NSLog("Monitoring neighborBeaconRegion major: \(neighborSite.major!)")
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
                NSLog("Monitoring site exterior region: \(site.major!) major")
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
                            NSLog("Monitoring site interior region: \(biin.minor!) minor, biin identifier:\(biin.identifier!)")
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
                                
                                print("Monitoring neighborBeaconRegion major: \(neighborSite.major!)")
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
                    print("Monitoring site exterior region: \(site.major!) major")
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
                                    print("Monitoring site interior region: \(biin.minor!) minor")
                                    let interiorBeaconRegion = CLBeaconRegion(proximityUUID: site.proximityUUID!, major: CLBeaconMajorValue(site.major!), minor: CLBeaconMinorValue(biin.minor!), identifier: biin.identifier!)
                                    interiorBeaconRegion.notifyEntryStateOnDisplay = true
                                    self.monitoredBeaconRegions![biin.minor!] = interiorBeaconRegion
                                    self.locationManager!.startMonitoringForRegion(interiorBeaconRegion)
                                    self.locationManager!.requestAlwaysAuthorization()
                                    region_counter++
                                } else {
                                    print("Monitoring site interior region: \(biin.minor!) minor")
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
                                            print("Monitoring site product region: \(child) minor")
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
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        NSLog("BIIN - didEnterRegion() 1")
        
        if BNAppSharedManager.instance.IS_APP_UP{
            NSLog("BIIN - didEnterRegion() 2")
            return
        }
        
        NSLog("BIIN - didEnterRegion() 3")
        
        if let beaconRegion = region as? CLBeaconRegion {
            
            NSLog("ENTER region: \(beaconRegion.identifier), \(beaconRegion.major), \(beaconRegion.minor)")
            
            switch nowMonitoring {
            case .NONE:
                break
            case .SITES_MONITORING:
                
                if beaconRegion.minor != nil && BNAppSharedManager.instance.IS_APP_DOWN {
                    NSLog("It seems is a interior beacon detected.")
                    //BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(beaconRegion.identifier)
                } else {
                
                    NSLog("BIIN - .SITES_MONITORING - \(monitoredBeaconRegions!.count)")
                    BNAppSharedManager.instance.notificationManager.activateNotificationForSite(beaconRegion.identifier, major:beaconRegion.major!.integerValue)
                    
                    NSLog("BIIN - .SITES_MONITORING B1")
                    if monitoredBeaconRegions != nil {
                        NSLog("BIIN - .SITES_MONITORING B1.1")
                        if monitoredBeaconRegions!.count > 0 {
                            NSLog("BIIN - .SITES_MONITORING B2")
                            if let _ = monitoredBeaconRegions![beaconRegion.major!.integerValue]{
                                NSLog("BIIN - .SITES_MONITORING B3")
                                if currentExteriorRegion == nil {
                                    NSLog("BIIN - .SITES_MONITORING B4")
                                    currentExteriorRegion = beaconRegion
                                    currentInteriorRegion = nil
                                    currentProductRegion = nil
                                    start_SITE_EXTERIOR_MONITORING(beaconRegion)
                                    BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
                                    NSLog("BIIN - .SITES_MONITORING B5")
                                }
                            }
                        }
                    }
                }
                break
            case .SITE_EXTERIOR_MONITORING:
                NSLog("BIIN - .SITE_EXTERIOR_MONITORING")
                if currentExteriorRegion != nil {
                    if beaconRegion.minor != nil {
                        if beaconRegion.major!.integerValue == currentExteriorRegion!.major!.integerValue {
                            if currentInteriorRegion == nil {
                                if let interiorRegion = monitoredBeaconRegions![beaconRegion.minor!.integerValue]{
                                    currentInteriorRegion = interiorRegion
                                    start_SITE_INTERIOR_MONITORING(beaconRegion)
                                    BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(currentInteriorRegion!.identifier)
                                    NSLog("2")
                                }
                            } else {
                                NSLog("Enter other region with minor: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                            }
                        } else {
                            NSLog("Enter other interior region: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                        }
                    } else if beaconRegion.major!.integerValue != currentExteriorRegion!.major!.integerValue {
                        if beaconRegion.minor != nil {
                            NSLog("ENTER directly to new interior region!")
                            currentInteriorRegion = beaconRegion
                            currentExteriorRegion = monitoredBeaconRegions![beaconRegion.major!.integerValue]
                            start_SITE_INTERIOR_MONITORING(beaconRegion)
                            NSLog("3")
                            
                        } else {
                            NSLog("ENTER new exterior region!")
                            currentExteriorRegion = beaconRegion
                            currentInteriorRegion = nil
                            currentProductRegion = nil
                            start_SITE_EXTERIOR_MONITORING(beaconRegion)
                            BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
                            NSLog("4")
                        }
                        
                    } else {
                        NSLog("Enter other exterior region: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                        currentExteriorRegion = beaconRegion
                        currentInteriorRegion = nil
                        currentProductRegion = nil
                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
                        BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
                        NSLog("5")
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
                                        NSLog("Show notification for product biin:\(currentProductRegion!.proximityUUID.UUIDString), major:\(currentProductRegion!.major!),  minor:\(currentProductRegion!.minor!)")
                                        BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(productRegion.identifier)
                                        NSLog("6")
                                    } else {
                                        currentProductRegion = productRegion
                                        NSLog("Show notification for other product biin:\(currentProductRegion!.proximityUUID.UUIDString), major:\(currentProductRegion!.major!),  minor:\(currentProductRegion!.minor!)")
                                        BNAppSharedManager.instance.notificationManager.activateNotificationForBiin(productRegion.identifier)
                                        NSLog("7")
                                    }
                                    
                                    BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_BIIN_REGION, to:productRegion.identifier)
                                }
                                break
                            case .INTERNO:
                                NSLog("Enter a new internal region:\(currentProductRegion!.proximityUUID.UUIDString), major:\(currentProductRegion!.major!),  minor:\(currentProductRegion!.minor!)")
                                    currentInteriorRegion = beaconRegion
                                    start_SITE_INTERIOR_MONITORING(beaconRegion)
                                    NSLog("8")
                                break
                            default:
                                break
                            }
                        }
                    } else {
                        NSLog("Enter other exterior region: \(beaconRegion.minor) on current exterior:\(currentExteriorRegion!.major!)")
                        currentExteriorRegion = beaconRegion
                        currentInteriorRegion = nil
                        currentProductRegion = nil
                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
                        BNAppSharedManager.instance.notificationManager.activateNotificationForSite(currentExteriorRegion!.identifier, major:beaconRegion.major!.integerValue)
                        NSLog("9")
                    }
                }
                break
            default:
                break
            }
        }
        
        /*
        if let beaconRegion = region as? CLBeaconRegion {
            println("Enter region: \(beaconRegion.identifier!), \(beaconRegion.major), \(beaconRegion.minor)")
            
            //IN_SITE_REGION_MONITORING
            //Stop monitor ext beacons regions.
            //Start monitor site beacon regions.
            
            for (identifier, monitoredRegion) in monitoredRegions {
                
                if identifier == BIIN_COMMERCIAL {
                    println("Delete all regions and keep monitoring BIIN_COMMERCIAL")
                } else {
                    if let site = BNAppSharedManager.instance.dataManager.sites[identifier] {
                        site.is_IN_GEO_REGION_MONITORING = false
                        self.locationManager!.stopMonitoringForRegion(monitoredRegion)
                        //monitoredRegions.removeValueForKey(identifier)
                        self.locationManager!.requestStateForRegion(monitoredRegion)
                    }
                }
            }
            
            for (identifier, site) in BNAppSharedManager.instance.dataManager.sites {
                if site.proximityUUID!.UUIDString == beaconRegion.proximityUUID.UUIDString {

                    site.is_IN_GEO_REGION_MONITORING = false
                    site.is_IN_SITE_REGION_MONITORING = true
                    
                    site.neighborA?.is_IN_GEO_REGION_MONITORING = false
                    site.neighborB?.is_IN_GEO_REGION_MONITORING = false
                    site.neighborC?.is_IN_GEO_REGION_MONITORING = false
                    site.neighborD?.is_IN_GEO_REGION_MONITORING = false
                    
                    site.neighborA?.is_IN_SITE_REGION_MONITORING = true
                    site.neighborB?.is_IN_SITE_REGION_MONITORING = true
                    site.neighborC?.is_IN_SITE_REGION_MONITORING = true
                    site.neighborD?.is_IN_SITE_REGION_MONITORING = true
                } else {
                    
                }
            }
        }
        */
        
        /*
        return
        if !isIN_BIIN_COMMERCIAL {
            
            var text = ""
            self.myBeacons = Array<CLBeacon>()
            self.rangedRegions = NSMutableDictionary()
            var myBeaconsPrevious = Array<CLBeacon>()
            
            if let beaconRegion = region as? CLBeaconRegion {
                
                text = "Enter region: \(beaconRegion.identifier!), \(beaconRegion.major), \(beaconRegion.minor)"
                self.rangedRegions[beaconRegion] = NSArray()
                
                if !true {
                
                    if !true {
                        
                        println("Start monitoring sites")
                        /*
                        var regionSiteA:CLBeaconRegion = CLBeaconRegion(proximityUUID:beaconRegion.proximityUUID!, major:3, identifier: "BIIN_COMMERCIAL_SITE_A")
                        regionSiteA.notifyEntryStateOnDisplay = true
                        self.locationManager!.startMonitoringForRegion(regionSiteA)
                        self.locationManager!.requestStateForRegion(regionSiteA)
                        
                        var regionSiteB:CLBeaconRegion = CLBeaconRegion(proximityUUID:beaconRegion.proximityUUID!, major:4, identifier: "BIIN_COMMERCIAL_SITE_B")
                        regionSiteB.notifyEntryStateOnDisplay = true
                        self.locationManager!.startMonitoringForRegion(regionSiteB)
                        self.locationManager!.requestStateForRegion(regionSiteB)
                        
                        var regionSiteC:CLBeaconRegion = CLBeaconRegion(proximityUUID:beaconRegion.proximityUUID!, major:5, identifier: "BIIN_COMMERCIAL_SITE_C")
                        regionSiteB.notifyEntryStateOnDisplay = true
                        self.locationManager!.startMonitoringForRegion(regionSiteC)
                        self.locationManager!.requestStateForRegion(regionSiteC)
                        */
                    }
                }
                
                
                self.locationManager!.startRangingBeaconsInRegion( beaconRegion )
                self.isIN_BIIN_COMMERCIAL = true
                
                BNAppSharedManager.instance.networkManager.checkConnectivity()
                
                
                
            }
            
            
            println("\(text)")
            self.delegateView?.manager?(self, printText: text)
            self.delegateDM!.manager!(self, startEnterRegionProcessWithIdentifier: region.identifier)
            
            if BNAppSharedManager.instance.runningInBackground() {
                
                var localNotification:UILocalNotification = UILocalNotification()
                localNotification.alertAction = "editList"
                localNotification.alertBody = text
                localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                localNotification.category = "shoppingListReminderCategory"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
            }
        }
        */
        
        NSLog("BIIN - .SITES_MONITORING END")

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
            
            print("EXIT region: \(beaconRegion.identifier), \(beaconRegion.major), \(beaconRegion.minor)")
            
            BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.EXIT_BIIN_REGION, to:beaconRegion.identifier)
            
            switch nowMonitoring {
            case .NONE:
                break
            case .SITES_MONITORING:
//                if let exteriorRegion = monitoredBeaconRegions[beaconRegion.major!.integerValue]{
//                    if currentExteriorRegion == nil {
//                        currentExteriorRegion = beaconRegion
//                        currentInteriorRegion = nil
//                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
//                    }
//                }
                break
            case .SITE_EXTERIOR_MONITORING:
                    /*
                    if beaconRegion.major.integerValue == currentExteriorRegion!.major.integerValue {
                        if let interiorRegion = monitoredBeaconRegions[beaconRegion.minor!.integerValue]{
                            if currentExteriorRegion != nil && currentInteriorRegion == nil {
                                currentInteriorRegion = interiorRegion
                                start_SITE_INTERIOR_MONITORING(beaconRegion)
                            }
                        }
                    }
                    */
                break
            case .SITE_INTERIOR_MONITORING:
//                if beaconRegion.minor != nil {
//                    if beaconRegion.major.integerValue == currentExteriorRegion!.major.integerValue {
//                        if let interiorRegion = monitoredBeaconRegions[beaconRegion.minor!.integerValue]{
//                            if currentExteriorRegion != nil && currentInteriorRegion != nil {
//                                currentInteriorRegion = nil
//                                currentProductRegion = nil
//                                stop_SITE_INTERIOR_MONITORING(beaconRegion)
//                            }
//                        }
//                    }
//                }
                
                
                break
            default:
                break
            }
        }

        
        /*
        return
        
        var text = "Exit region: " + region.identifier
        println("\(text)")
        return
        
         if isIN_BIIN_COMMERCIAL {
            
            var text = "Exit region: " + region.identifier
            println("\(text)")
            
            
            self.delegateView?.manager?(self, printText: text)
            self.delegateDM!.manager!(self, startExitRegionProcessWithIdentifier: region.identifier)
            
            if BNAppSharedManager.instance.runningInBackground() {
                var localNotification:UILocalNotification = UILocalNotification()
                localNotification.alertAction = "Exit Regions"
                localNotification.alertBody = text
                localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            }
            
            if let beaconRegion = region as? CLBeaconRegion {
                text = "Enter region: \(beaconRegion.identifier!), \(beaconRegion.major), \(beaconRegion.minor)"
                self.locationManager!.stopRangingBeaconsInRegion(beaconRegion)
                self.isIN_BIIN_COMMERCIAL = false
                //self.rangedRegions[beaconRegion] = nil
                
                self.biins.removeAll(keepCapacity: false)
                BNAppSharedManager.instance.dataManager.availableBiins.removeAll(keepCapacity: false)
                self.delegateView?.manager!(self, updateMainViewController: self.biins)
                
            }
        }
        */
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {

        print("Region:")
  
        var stateString:String = ""
        
        switch state {
        case .Unknown:
            stateString = "Unknown"
            break
        case .Inside:
            stateString = "Inside"
//            if let beaconRegion = region as? CLBeaconRegion {
//                if currentExteriorRegion == nil {
//                    
//                    if beaconRegion.minor != nil {
//                        println("Already in region with minor:\(beaconRegion.minor!), major:\(beaconRegion.major!), identifier: \(region!.identifier)")
//                        currentExteriorRegion = beaconRegion
//                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
//                    } else {
//                        currentExteriorRegion = beaconRegion
//                        start_SITE_EXTERIOR_MONITORING(beaconRegion)
//                    }
//                
//                /*
//                self.myBeacons = Array<CLBeacon>()
//                self.rangedRegions = NSMutableDictionary()
//                var myBeaconsPrevious = Array<CLBeacon>()
//                
//                if let beaconRegion = region as? CLBeaconRegion {
//                    println("IN region: \(beaconRegion.identifier!), \(beaconRegion.major), \(beaconRegion.minor)")
//                    self.rangedRegions[beaconRegion] = NSArray()
//                    self.locationManager!.startRangingBeaconsInRegion( beaconRegion )
//                    self.isIN_BIIN_COMMERCIAL = true
//                }
//                */
//                }
//            }
            break
        case .Outside:
            stateString = "Outside"
            break
//        default:
//            break
        }
        
        
        print("Region:\(region.identifier), major:nil, minor:nil, state\(stateString)")

        if let beaconRegion = region as? CLBeaconRegion {
            if beaconRegion.major != nil {
                if beaconRegion.minor != nil {
                    print("Region:\(region.identifier), major:\(beaconRegion.major!), minor:\(beaconRegion.minor!), state\(stateString)")
                }
            } else {
                print("Region:\(region.identifier), major:nil, minor:nil, state\(stateString)")
            }
        }

    }
    
    //BNDataManagerDelegate Methods
    func start_BEACON_RANGING() {
        
        print("start_BEACON_RANGING()")
        
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
        
        print("stop_BEACON_RANGING()")
        
        //self.stopMonitoringBeaconRegions()
        for (key, _): (AnyObject, AnyObject) in self.rangedRegions {
            self.locationManager!.stopRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()

        
    }

    
    
    
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
//        let text = "Error: " + error.description
//        self.delegateView?.manager?(self, printText: text)
    }
    
    //CLLocationManagerDelegate - Responding to Ranging Events
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        //Sets detected beacon to proper region
        self.rangedRegions[region] = beacons
        

        /*
        println("region identifier: \(region!.identifier!)")
        println("region uuid:\(region!.proximityUUID.UUIDString)")
        println("regions detected: \(self.rangedRegions.count)")
        
        
        println("------------------------------------------------------")
        println("------------------------------------------------------")
        
        
        for (key, value) in self.rangedRegions {
            
            println("region identifier: \((key as CLBeaconRegion).identifier!)")
            println("region uuid:\((key as CLBeaconRegion).proximityUUID.UUIDString)")
            
            var beacons = value as Array<CLBeacon>
            for beacon in beacons {
                println("uuid: \(beacon.proximityUUID.UUIDString)")
                println("major: \(beacon.major)")
                println("minor: \(beacon.minor)")
                println("rssi: \(beacon.rssi)")
            }

        }
        
        println("------------------------------------------------------")
        println("------------------------------------------------------")
        */
        
        //Clean local beacon
        self.myBeacons.removeAll(keepCapacity: false)
        
        //Get all beacon from regions
        for (_, value): (AnyObject, AnyObject) in self.rangedRegions {
            self.myBeacons += value as! Array<CLBeacon>
            
        }
        
        self.myBeacons = self.myBeacons.sort{ $0.rssi > $1.rssi  }
        
        if !self.myBeacons.isEmpty {
            
            //value 0 = more beacons detected
            //value 1 = order changed
            //value 2 = proximity changed
            
            let value = didSomethingChangeOnBeaconsDetected(self.myBeacons, array2:self.myBeaconsPrevious)
            
            //Frist return value checks is there are more biins available
            if value.0 || value.1 {
                
                self.counter++
                
                if self.counter == self.counterLimmit {
                    self.counter = 0
                    self.myBeaconsPrevious = self.myBeacons
                    
                    //TESTING ->
                    print("")
                    print("Beacon order  -------")
                    for b:CLBeacon in self.myBeacons {
                        print("***")
                        
                        print("proximity: \(b.proximity.rawValue)")
    
                        switch b.proximity {
                        case .Unknown:
                            print("proximity: Unknown")
                        case .Immediate:
                            print("proximity: Immediate")
                            
                        case .Near:
                            print("proximity: Near")
                        case .Far:
                            print("proximity: Far")
//                            default:
//                            break
                        }
                        print("rssi: \(b.rssi)")
                        print("major: \(b.major)")
                        print("minor: \(b.minor)")
                    }
                    print("")
                    //TESTING <-
                    
                    //if value.0 || value.1 {
                    //if isBiinsViewContainerEmpty {
                        isBiinsViewContainerEmpty = false
                        //self.orderAndSentBiinsToDisplay(self.myBeacons)
                    //}
                    //}
                    
                    if myBeacons.count > 0 {
                        handleBiiniePositionOnFirstBiinDetected(myBeacons[0])
                    }
                    
                    //TEMP: update table view
//                    if self.delegateView is BNPositionManagerDelegate {
                    
//                        self.delegateView?.manager!(self, updateMainViewController: self.biins)
//                    }
                } else if value.2 {
                    /*
                    println("Something change on proximity")
                    
                    println("")
                    println("Proximity change and reorder  -------")
                    for b:CLBeacon in self.myBeacons {
                        println("***")
                        
                        println("proximity: \(b.proximity.rawValue)")
                        
                        switch b.proximity {
                        case .Unknown:
                            println("proximity: Unknown")
                        case .Immediate:
                            println("proximity: Immediate")
                        case .Near:
                            println("proximity: Near")
                        case .Far:
                            println("proximity: Far")
                        default:
                            break
                        }
                        
                        println("rssi: \(b.rssi)")
                        println("major: \(b.major)")
                        println("minor: \(b.minor)")
                    }
                    println("")
                    */
                }
            }
            
            //Check how close is first beacon to device.
            //if didProximityChanged(self.myBeacons[0].rssi) {
                //TODO: implement proximity changes on first beacon.
                
            //}
            
        } else {
            self.firstBeacon = nil
            self.firstBeaconUUID = nil
            self.counterProximity = 0
            self.counter = 0
            if !isBiinsViewContainerEmpty {
                cleanAndSentBiinsToDisplay()
            }
        }
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
                for var i = 0; i < array1.count; i++ {
                    
                    if array1[i].minor.integerValue != array2[i].minor.integerValue {
                        value.1 = true
                    }
                    
                    if array1[i].proximity != array2[i].proximity {
                        value.2 = true
                    }
                }
            }
        }

        return value
    }
    
    func handleBiiniePositionOnFirstBiinDetected(beacon:CLBeacon){
        
        print("handleBiinPositionChange()")
        print("uuid: \(beacon.proximityUUID.UUIDString)")
        print("major: \(beacon.major)")
        print("minor: \(beacon.minor)")
        
        
        var changeSite = false
        
        if currentSite == nil {
            changeSite = true
        } else {
            if currentSite!.major != beacon.major.integerValue {
                changeSite = true
            }
        }
        
        if changeSite {
            for (_, site) in BNAppSharedManager.instance.dataManager.sites {
                if site.major == beacon.major.integerValue {
                    
                    print("Entering a new site premises.....\(site.title!)")
                    currentSite = site
                    self.delegateView!.showInSiteView!(currentSite)

                    for biin in site.biins {
                        if biin.minor == beacon.minor.integerValue {
                            
                            print("Biin information")
                            print("biin name: \(biin.name!)")
                            //println("biin message: \(biin.state?.message!)")
                            
                            /*
                            var localNotification:UILocalNotification = UILocalNotification()
                            localNotification.alertAction = "Biin"
                            localNotification.alertBody = biin.name!
                            localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                            */
                            
                            switch biin.biinType {
                            case .EXTERNO:
                                print("User is outside \(site.title!)")
                                site.isUserInside = false
                                break
                            case .INTERNO:
                                print("User is inside \(site.title!)")
                                site.isUserInside = true
                                break
                            case .PRODUCT:
                                print("User is inside and near a product \(site.title!)")
                                site.isUserInside = true
                                break
                            default:
                                break
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
        /*
        //1. get organization by uuid
        for (_, site) in BNAppSharedManager.instance.dataManager.sites {
            
            site.isUserInside = false
            
            //if site.proximityUUID!.UUIDString == beacon.proximityUUID.UUIDString {
                
                if site.major == beacon.major.integerValue {
                    
//                    if currentSite != nil {
//                        if site.proximityUUID!.UUIDString == currentSiteUUID!.UUIDString {
//                            print("*** Still on the same site premises.....")
//                        } else {
//                            print("*** Change site premises.....")
//                            currentSiteUUID = site.proximityUUID
//                            
//                            currentSite = site
//                            self.delegateView!.hideInSiteView!()
//                            self.delegateView!.showInSiteView!(currentSite!)
//                        }
//                    } else {
//                        print("Entering a new site premises.....")
//                        currentSiteUUID = site.proximityUUID
//                        currentSite = site
//                        self.delegateView!.showInSiteView!(currentSite!)
//                    }
//                    
                    for biin in site.biins {
                        if biin.minor == beacon.minor.integerValue {
                            
                            print("Biin information")
                            print("biin name: \(biin.name!)")
                            //println("biin message: \(biin.state?.message!)")
                            
                            /*
                            var localNotification:UILocalNotification = UILocalNotification()
                            localNotification.alertAction = "Biin"
                            localNotification.alertBody = biin.name!
                            localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                            */
                            
                            switch biin.biinType {
                            case .EXTERNO:
                                print("User is outside \(site.title!)")
                                site.isUserInside = false
                                break
                            case .INTERNO:
                                print("User is inside \(site.title!)")
                                site.isUserInside = true
                                break
                            case .PRODUCT:
                                print("User is inside and near a product \(site.title!)")
                                site.isUserInside = true
                                break
                            default:
                                break
                            }
                        }
                    }
                }
            //}
        }
        //2, get site by major
        
        //3. get biin by minor
        */
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

        print("orderAndSentBiinsToDisplay: \(beacons.count)")

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
                            
                            print("ADDING BIIN TO DISPLAY \(site.major), \(site.title!)")
                            currentSite = site
                            self.delegateView!.showInSiteView!(currentSite!)
                            
                            /*
                            var minorAdded = 0
                            for biin in site.biins {
                                if beacon.minor.integerValue == biin.minor && minorAdded != biin.minor {
                                    minorAdded = biin.minor!
                                    print("ADDING BIIN TO DISPLAY \(site.major) \(biin.minor)")
                                    BNAppSharedManager.instance.dataManager.availableBiins.append(biin.currectObject()._id!)
                                    self.biins.append(biin)
                                }
                            }
*/
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
        print("cleanAndSentBiinsToDisplay")
        isBiinsViewContainerEmpty = true
        self.biins.removeAll(keepCapacity: false)
        BNAppSharedManager.instance.dataManager.availableBiins.removeAll(keepCapacity: false)
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
        
        /*
        for region in regions {
            
            println("Monitoring region 1: \(region.identifier!)")
            
            if region.latitude == nil || region.longitude == nil {
                return
            }
            
            var radiuos:CLLocationDistance = CLLocationDistance(region.radious!)
            var lat:CLLocationDegrees? = CLLocationDegrees(region.latitude!)
            var long:CLLocationDegrees? = CLLocationDegrees(region.longitude!)
            var coord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
            var clRegion:CLCircularRegion = CLCircularRegion(center: coord, radius: radiuos, identifier: region.identifier!)
            self.locationManager!.startMonitoringForRegion(clRegion)
            self.locationManager!.requestStateForRegion(clRegion)
            
            self.delegateView?.manager!(self, setPinOnMapWithLat: region.latitude!, long: region.longitude!, radious: region.radious!, title: region.identifier!, subtitle: region.identifier!)
        }
        */
    }
    
    func startRegionsMonitoring(regions:Array<BNRegion>){
        
        //return
        
        for region in regions {
            
            print("Monitoring region 2: \(region.identifier!)")
            
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
        
        print("startSiteMonitoring():")
        
        self.stopMonitoringBeaconRegions()
        
//        for biin in site.biins {
//            if !self.biins.hasBiin(biin) {
//                self.biins.append(biin)
//            }
//        }
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()
        
        /*
        for (key, value) in BNAppSharedManager.instance.dataManager.sites {

            println("////////////////////////////////////////////////////")
            println("Site title: \(value.title!)")
            
            for biin in value.biins {
                
                println("ADDING BEACON")
                println("uuid: \(value.proximityUUID!.UUIDString)")
                println("major: \(value.major!)")
                println("minor: \(biin.minor!)")
                println("---------------------------------------")
                
                if !self.biins.hasBiin(biin) {
                    self.biins.append(biin)
                }
                
                var major:CLBeaconMajorValue = UInt16(value.major!)
                var minor:CLBeaconMajorValue = UInt16(biin.minor!)
                
                var region:CLBeaconRegion = CLBeaconRegion(proximityUUID: value.proximityUUID!, identifier: value.title!)
                self.rangedRegions[region] = NSArray()
            }
        }
        */
        
        
        print("RANGING BIIN COMMERCIAL REGION")
        print("uuid:")
        print("---------------------------------------")
        
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
        /*
        println("Start biin monitoring: \(biin.identifier) with uuid \(biin.proximityUUID!.UUIDString)")
    
        if !self.biins.hasBiin(biin) {
            self.stopMonitoringBeaconRegions()
            
            self.biins.append(biin)
            self.myBeacons = Array<CLBeacon>()
            self.rangedRegions = NSMutableDictionary()
            
            for obj in self.biins {
                var major:CLBeaconMajorValue = UInt16(obj.major!)
                var minor:CLBeaconMajorValue = UInt16(obj.minor!)
                var region:CLBeaconRegion = CLBeaconRegion(proximityUUID: obj.proximityUUID!, major:major, minor:minor, identifier: obj.identifier!)
                self.rangedRegions[region] = NSArray()
            }
            
            self.startMonitoringBeaconRegions()
        }
        */
    }
    
    func manager(manager:BNDataManager!, stopBiinMonitoring biin:BNBiin) {
        /*
        self.stopMonitoringBeaconRegions()
        
        for var i = 0; i < self.biins.count; i++ {
            if self.biins[i] == biin {
                self.biins.removeAtIndex(i)
                return
            }
        }
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()
        
        for obj in self.biins {
            var major:CLBeaconMajorValue = UInt16(obj.major!)
            var minor:CLBeaconMinorValue = UInt16(obj.minor!)
            var region:CLBeaconRegion = CLBeaconRegion(proximityUUID: obj.proximityUUID!, major: major, minor: minor, identifier: obj.identifier!)
            self.rangedRegions[region] = NSArray()
        }
        
        self.startMonitoringBeaconRegions()
        */
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
        print("centralManagerDidUpdateState()")

        switch central.state {
            
        case .PoweredOn:
            print(".PoweredOn")
            
        case .PoweredOff:
            print(".PoweredOff")
            
        case .Resetting:
            print(".Resetting")
            
        case .Unauthorized:
            print(".Unauthorized")
            
        case .Unknown:
            print(".Unknown")
            
        case .Unsupported:
            print(".Unsupported")
        }
        
        BNAppSharedManager.instance.continueAppInitialization()
    }
    
    func checkBluetoothServicesStatus()-> Bool{

        print("checkBluetoothServicesStatus()")
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
        
        print("checkHardwareStatus()")
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
    //optional func manager(manager:BNPositionManager!, setPinOnMapWithLat lat:Float, long:Float, radious:Int , title:String, subtitle:String)
    //optional func manager(manager:BNPositionManager!,  printText text:String)
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