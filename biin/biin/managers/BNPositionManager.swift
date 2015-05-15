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
    var delegateView:BNPositionManagerDelegate?
    
    //objective c implementation
    var firstBeacon:CLBeacon?
    var firstBeaconUUID:String?
    
    var counter = 0
    var counterLimmit = 30
    
    var firstBeaconProximity = BNProximity.None
    var counterProximity = 0
    var counterProximityLimit = 60
    
    var myBeacons = Array<CLBeacon>()
    var myBeaconsPrevious = Array<CLBeacon>()
    
    var biins = Array<BNBiin>()
    var rangedRegions:NSMutableDictionary = NSMutableDictionary();
    
    var currentSiteUUID:NSUUID?
    var locationFixAchieved = false
    var userCoordinates:CLLocationCoordinate2D?
    
    init(errorManager:BNErrorManager){
        
        self.errorManager = errorManager

        super.init()

        self.startLocationService()
    }
    
    func startLocationService()
    {
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
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        println("didChangeAuthorizationStatus()")
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            println("didChangeAuthorizationStatus() autorized")
            break
        case .Denied, .Restricted, .NotDetermined:
            println("didChangeAuthorizationStatus() denied")
            break
        }
        
        if BNAppSharedManager.instance.isWaitingForLocationServicesPermision {
            BNAppSharedManager.instance.continueAppInitialization()
        }
    }
    
    func checkLocationServicesStatus()-> Bool{
        println("checkLocationServicesStatus()")
        
        var status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            println("checkLocationServicesStatus() autorized")
            return true
        case .Denied, .Restricted, .NotDetermined:
            println("checkLocationServicesStatus() denied")
            return false
        }
    }
    
   
    
    //CLLocationManagerDelegate - Responding to Location Events
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
//        self.delegateView?.manager?(self, printText:"LocationManager update should not be working")
//        var location:CLLocation = locations[0] as CLLocation
//        println("updade location latitude: \(location.coordinate.latitude)")
//        println("updade location longitude: \(location.coordinate.latitude)")
        
            if (locationFixAchieved == false) {
                locationFixAchieved = true
                var locationArray = locations as NSArray
                var locationObj = locationArray.lastObject as? CLLocation
                userCoordinates = locationObj!.coordinate
                println("LAT:  \(userCoordinates!.latitude)")
                println("LONG: \(userCoordinates!.longitude)")
                locationManager!.stopUpdatingLocation()
            }
        

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError) {
        var text = "Error: " + error.description
        self.delegateView?.manager?(self, printText: text)
    }
    
    
    //CLLocationManagerDelegate - Responding to Region Events
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        var text = "Monitoring: " + region.identifier
        self.delegateView?.manager?(self, printText: text)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion) {
        var text = "Enter region: " + region.identifier
        println("\(text)")
        self.delegateView?.manager?(self, printText: text)
        self.delegateDM!.manager!(self, startEnterRegionProcessWithIdentifier: region.identifier)
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Enter Regions"
        localNotification.alertBody = text
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion) {
        var text = "Exit region: " + region.identifier
        println("\(text)")
        self.delegateView?.manager?(self, printText: text)
        self.delegateDM!.manager!(self, startExitRegionProcessWithIdentifier: region.identifier)
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Exit Regions"
        localNotification.alertBody = text
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        
        switch state {
        case .Inside:
            println("Region state: \(state.hashValue) for region: \(region!.identifier)")
//            self.delegateDM!.manager!(self, startEnterRegionProcessWithIdentifier:region!.identifier)
            break
        case .Outside:
            
            break
        case .Unknown:
            
            break
        default:
            
            break
        }
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        var text = "Error: " + error.description
        self.delegateView?.manager?(self, printText: text)
    }
    
    //CLLocationManagerDelegate - Responding to Ranging Events
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject], inRegion region: CLBeaconRegion!)
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
        for (key:AnyObject, value:AnyObject) in self.rangedRegions {
            self.myBeacons += value as! Array<CLBeacon>
            
        }
        
        self.myBeacons = sorted(self.myBeacons){ $0.rssi > $1.rssi }
        
        if !self.myBeacons.isEmpty {
            
            
            if !checkArraysEquality(self.myBeacons, array2:self.myBeaconsPrevious) {
                
                self.counter++
                
                if self.counter == self.counterLimmit {
                    self.counter = 0
                    self.myBeaconsPrevious = self.myBeacons
                    
                    /*
                    println("")
                    println("Beacon order  -------")
                    for b:CLBeacon in self.myBeacons {
                        println("***")
                        println("uuid: \(b.proximityUUID.UUIDString)")
                        println("major: \(b.major)")
                        println("minor: \(b.minor)")
                    }
                    println("")
                    */
                    
                    self.orderBiins(self.myBeacons)
                    
                    if myBeacons.count > 0 {
                        handleBiinPositionChange(myBeacons[0])
                    }
                    
                    //TEMP: update table view
//                    if self.delegateView is BNPositionManagerDelegate {
                        self.delegateView?.manager!(self, updateMainViewController: self.biins)
//                    }
                }
            }
            
            //Check how close is first beacon to device.
            if didProximityChanged(self.myBeacons[0].rssi) {
                //TODO: implement proximity changes on first beacon.
                
            }
            
        } else {
            self.firstBeacon = nil
            self.firstBeaconUUID = nil
            self.counterProximity = 0
            self.counter = 0
        }
    }
    
    func handleBiinPositionChange(beacon:CLBeacon){
        
        println("handleBiinPositionChange()")
        println("uuid: \(beacon.proximityUUID.UUIDString)")
        println("major: \(beacon.major)")
        println("minor: \(beacon.minor)")
        
        
        //1. get organization by uuid
        for (identifier, site) in BNAppSharedManager.instance.dataManager.sites {
            
            site.isUserInside = false
            
            if site.proximityUUID!.UUIDString == beacon.proximityUUID.UUIDString {
                
                if site.major == beacon.major.integerValue {
                    
                    if currentSiteUUID != nil {
                        if site.proximityUUID!.UUIDString == currentSiteUUID!.UUIDString {
                            println("*** Still on the same site premises.....")
                        } else {
                            println("*** Change site premises.....")
                            currentSiteUUID = site.proximityUUID
                        }
                    } else {
                        println("Entering a new site premises.....")
                        currentSiteUUID = site.proximityUUID
                    }
                    
                    for biin in site.biins {
                        if biin.minor == beacon.minor.integerValue {
                            
                            println("Biin information")
                            println("site: \(site.title!)")
                            println("uuid: \(beacon.proximityUUID.UUIDString)")
                            println("site id: \(site.major!)")
                            println("biin id:\(biin.minor!)")
                            println("biin type: \(biin.biinType.hashValue)")
                            //println("biin message: \(biin.state?.message!)")
                            
                            switch biin.biinType {
                            case .EXTERNO:
                                println("User is outside \(site.title!)")
                                site.isUserInside = true
                                break
                            case .INTERNO:
                                println("User is inside \(site.title!)")
                                site.isUserInside = true
                                break
                            case .PRODUCT:
                                println("User is inside and near a product \(site.title!)")
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
        //2, get site by major
        
        //3. get biin by minor
        
    }
    
    //The method checks is the tow Arrays are order the same way.
    func checkArraysEquality(array1:Array<CLBeacon>, array2:Array<CLBeacon>) -> Bool{
        if array1.isEmpty || array2.isEmpty || array1.count != array2.count {
            return false
        } else {
            for var i = 0; i < array1.count; i++ {
                if array1[i].proximityUUID.UUIDString != array2[i].proximityUUID.UUIDString {
                    return false
                } else if array1[i].minor.integerValue != array2[i].minor.integerValue {
                    return false
                }
            }
        }
        return true
    }

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
    
    //This method order the biin list according to beacons detected on field.
    func orderBiins(beacons:Array<CLBeacon>) {

        //Create an Array to temporary backup biins.
        var biinBackup:Array<BNBiin> = Array<BNBiin>()

        //Remove and backup biins from local list.
        for beacon in beacons {
            for var i = 0; i < self.biins.count; i++ {
//                if beacon.proximityUUID.UUIDString == self.biins[i].proximityUUID!.UUIDString {
//                    biinBackup.append(self.biins[i])
//                    self.biins.removeAtIndex(i)
//                }
            }
        }
        
        //Put back backup biin on local list.
        if !biinBackup.isEmpty {
            for var i = 0; i < biinBackup.count; i++ {
                self.biins.insert(biinBackup[i], atIndex: i)
            }
        }
        
        //clear biinBackup
        biinBackup.removeAll(keepCapacity: false)
    }
    
    func locationManager(manager: CLLocationManager!, rangingBeaconsDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        //TODO: send error when failing ranging on a region.
    }

    
    //CLLocationManagerDelegate - Responding to Visit Events
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        
    }
    
    //Methods to conform on BNPositionManager
    func manager(manager:BNDataManager!, startRegionsMonitoring regions:Array<BNRegion>) {
        
        
        
        
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
    }
    
    func startRegionsMonitoring(regions:Array<BNRegion>){
        
        return
        
        for region in regions {
            
            println("Monitoring region 2: \(region.identifier!)")
            
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

    }
    
    func manager(manager:BNDataManager!, stopRegionsMonitoring regions:Array<BNRegion>) {

        for region in regions {
            
            if region.latitude == nil || region.longitude == nil {
                return
            }
            
            var radiuos:CLLocationDistance = CLLocationDistance(region.radious!)
            var lat:CLLocationDegrees? = CLLocationDegrees(region.latitude!)
            var long:CLLocationDegrees? = CLLocationDegrees(region.longitude!)
            var coord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
            var clRegion:CLCircularRegion = CLCircularRegion(center: coord, radius: radiuos, identifier: region.identifier!)
            self.locationManager!.stopMonitoringForRegion(clRegion)
            self.locationManager!.requestStateForRegion(clRegion)
            
        }
    }
    
    

    //BNDataManagerDelegate Methods
    func manager(manager:BNDataManager, startSitesMonitoring value:Bool) {
        
        println("startSiteMonitoring():")
        
        self.stopMonitoringBeaconRegions()
        
//        for biin in site.biins {
//            if !self.biins.hasBiin(biin) {
//                self.biins.append(biin)
//            }
//        }
        
        self.myBeacons = Array<CLBeacon>()
        self.rangedRegions = NSMutableDictionary()
        
        
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
        
        for (key:AnyObject, value:AnyObject) in self.rangedRegions {
            self.locationManager!.startRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
        
        locationManager!.requestWhenInUseAuthorization()
    }
    
    func manager(manager:BNDataManager, stopSiteMonitoring site:BNSite) {
    
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
        for (key:AnyObject, value:AnyObject) in self.rangedRegions {
            self.locationManager!.startRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
    }
    
    func stopMonitoringBeaconRegions() {
        for (key:AnyObject, value:AnyObject) in self.rangedRegions {
            self.locationManager!.stopRangingBeaconsInRegion(key as! CLBeaconRegion)
        }
    }
    
    //Methods related to Beacons
    
    
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println("centralManagerDidUpdateState()")

        switch central.state {
            
        case .PoweredOn:
            println(".PoweredOn")
            
        case .PoweredOff:
            println(".PoweredOff")
            
        case .Resetting:
            println(".Resetting")
            
        case .Unauthorized:
            println(".Unauthorized")
            
        case .Unknown:
            println(".Unknown")
            
        case .Unsupported:
            println(".Unsupported")
        }
        
        BNAppSharedManager.instance.continueAppInitialization()
    }
    
    func checkBluetoothServicesStatus()-> Bool{

        println("checkBluetoothServicesStatus()")
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
        
        println("checkHardwareStatus()")
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
    
    //temporal methods
    optional func manager(manager:BNPositionManager!, updateMainViewController biins:Array<BNBiin>)
    optional func manager(manager:BNPositionManager!,  setPinOnMapWithLat lat:Float, long:Float, radious:Int , title:String, subtitle:String)
    optional func manager(manager:BNPositionManager!,  printText text:String)
}

enum BNProximity
{
    case Over
    case Inmediate
    case Near
    case Far
    case None
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