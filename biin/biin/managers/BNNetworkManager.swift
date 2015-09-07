//  BNNetworkManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import SystemConfiguration
import CoreLocation


class BNNetworkManager:NSObject, BNDataManagerDelegate, BNErrorManagerDelegate, BNPositionManagerDelegate {
    
    //URL requests
    let connectibityUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getConnectibity.json"

    var errorManager:BNErrorManager?
    var delegateDM:BNNetworkManagerDelegate?
    var delegateVC:BNNetworkManagerDelegate?
    var requests = Dictionary<Int, BNRequest>()
    var requestsQueue = Dictionary<Int, BNRequest>()
    var requestAttempts = 0
    var requestAttemptsLimit = 3
    var requestTimer:NSTimer?
    var isRequestTimerAllow = false
    
    var epsNetwork:EPSNetworking?
    var queueCounter = 0
    
    var rootURL = ""
    
    init(errorManager:BNErrorManager) {
        //Initialize here any data or variables.
        super.init()
        self.errorManager = errorManager
        epsNetwork = EPSNetworking()
    }
    
    func setRootURLForRequest(){
        if BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE {
            rootURL = "https://www.biin.io"
        } else if BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE {
            rootURL = "https://demo-biinapp.herokuapp.com"
        } else if BNAppSharedManager.instance.settings!.IS_QA_DATABASE {
            rootURL = "https://qa-biinapp.herokuapp.com"
        } else if BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE {
            rootURL = "https://dev-biinapp.herokuapp.com"
        }
    }
    
    //Saving data
    func manager(manager: BNDataManager!, saveUserCategories user: Biinie) {
        
    }
    
    func runQueue(){
        
        println("runQueue(): \(requestsQueue.count)")

        if requestsQueue.count == 0 {
            println("Queue is empty!")
            self.delegateVC!.manager!(self, didReceivedAllInitialData: true)

            if BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA {
                BNAppSharedManager.instance.mainViewController!.refresh()
                BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA = false
            }
            return
        }
        
        var value:CGFloat = ((CGFloat(requestsQueue.count) * 100.0 ) / 30.0)
        delegateVC!.manager!(self, updateProgressView:Float(value))
        
        var queueLimit = 10

        
        for (identifier, request) in requestsQueue {
            
            
            if !request.isRunning {
                println("Request Not Running: \(request.identifier)")
                
            } else {
                println("Request Running: \(request.identifier)")
            }
        }
        
        for (identifier, request) in requestsQueue {
            
            if queueCounter >= queueLimit {
                println("EXIT: \(queueCounter)")
                return
            }
            
            if !request.isRunning {
                
                request.run()
                
                queueCounter++
                println("Number of request running: \(queueCounter)")
    
            } else {
                println("Pending request id: \(request.identifier)")
                queueCounter++
            }
        }
    }
    
    func removeFromQueue(request:BNRequest){
        queueCounter--
        
        println("queueCounter: \(queueCounter)")
        requestsQueue.removeValueForKey(request.identifier)
        println("REMOVE: requests in queue:\(requestsQueue.count)")

        if queueCounter < 10 {
            runQueue()
        }
        
        
//        if requestsQueue.count == 0 {
//            
//            println("NOT requests pending: \(self.requestsQueue.count)")
//            self.delegateVC!.manager!(self, didReceivedAllInitialData: true)
//            
//            if BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA {
//                BNAppSharedManager.instance.mainViewController!.refresh()
//                BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA = false
//            }
//            
//        } else {
//            //self.delegateVC!.manager!(self, didReceivedAllInitialData: false)
//            println("Requests Pending:\(requestsQueue.count)")
//            
//            if requestsQueue.count == 1 {
//                println("")
//            }
//        }
//        
//        var value:CGFloat = ((CGFloat(requestsQueue.count) * 100.0 ) / 30.0)
//        delegateVC!.manager!(self, updateProgressView:Float(value))

    }
    
    func addToQueue(request:BNRequest){
        self.requestsQueue[request.identifier] = request
        runQueue()
        println("ADD: requests in queue:\(requestsQueue.count)")
    }
 
    func checkConnectivity() {
        
        println("checkConnectivity()")
        
        var request = BNRequest_ConnectivityCheck(requestString: connectibityUrl, dataIdentifier: "", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
        
        //self.delegateDM!.manager!(self, didReceivedConnectionStatus: Reachability.isConnectedToNetwork())
        //return
        /*
        var request = BNRequest(requestString:connectibityUrl, dataIdentifier: "", requestType:.ConnectivityCheck)
        self.requests[request.identifier] = request
        
        
        
        epsNetwork!.getJson(false, url: request.requestString, callback:{
                (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
                
                if (error != nil) {
                    //println("Error on regions data - Not connection available")
                    self.errorManager!.showInternetError()
                    self.handleFailedRequest(request, error: error )
                    self.requests.removeAll(keepCapacity: false)
                } else {
                    
                    self.delegateDM!.manager!(self, didReceivedConnectionStatus: true)
                    self.removeRequestOnCompleted(request.identifier)
                    //                self.requests.removeValueForKey(request.identifier)
                    //                self.requestAttempts = 0
                    
                    //self.requestTimer = NSTimer(timeInterval: 1.0, target: self, selector: "runRequest", userInfo: nil, repeats: false)
                    
                    if self.isRequestTimerAllow {
                        self.requestTimer!.fire()
                    }
                }
            })
        
        */
/*
        epsNetwork!.getJson(false, url:request.requestString ) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                //println("Error on regions data - Not connection available")
                self.errorManager!.showInternetError()
                self.handleFailedRequest(request, error: error )
                self.requests.removeAll(keepCapacity: false)
            } else {

                self.delegateDM!.manager!(self, didReceivedConnectionStatus: true)
                self.removeRequestOnCompleted(request.identifier)

                if self.isRequestTimerAllow {
                    self.requestTimer!.fire()
                }
            }
        }
*/
    }
    
    func addTo_OLD_QUEUE(request:BNRequest) {
        println("----    \(request.requestString)")
        self.requests[request.identifier] = request
    }
    
    
    /**
    Enable biinie to login.
    @param email:Biinie email.
    @param password:Biinie password.
    */
    func login(email:String, password:String){
        var request = BNRequest_Login(requestString: "\(rootURL)/mobile/biinies/auth/\(email)/\(password)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Enable biinie to register.
    @param user:Biinie data.
    */
    func register(user:Biinie) {
        var request = BNRequest_Register(requestString: "\(rootURL)/mobile/biinies/\(user.firstName!)/\(user.lastName!)/\(user.email!)/\(user.password!)/\(user.gender!)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Request all biinie data
    @param biinie:Biinie object.
    */
    func manager(manager:BNDataManager!, requestBiinieData biinie:Biinie) {
        var request = BNRequest_Biinie(requestString: "\(rootURL)/mobile/biinies/\(biinie.identifier!)", errorManager: self.errorManager!, networkManager: self, user: biinie)
        addToQueue(request)
    }
    
    /**
    Send biinie data.
    @param user:Biinie data.
    */
    func sendBiinie(user:Biinie) {
        var request = BNRequest_SendBiinie(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)", errorManager:self.errorManager!, networkManager:self, user:user)
        addToQueue(request)
    }
    
    /**
    Send biinie actions.
    @param user:Biinie data.
    */
    func sendBiinieActions(user:Biinie) {
        if user.actions.count > 0 {
            var request = BNRequest_SendBiinieActions(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/history", errorManager: self.errorManager!, networkManager: self, user: user)
            addToQueue(request)
        }
    }
    
    /**
    Send biinie categories.
    @param user:Biinie data.
    @param categories:List of categories seleted by biinie.
    */
    func sendBiinieCategories(user:Biinie, categories:Dictionary<String, String>) {
        var request = BNRequest_SendBiinieCategories(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/categories", errorManager: self.errorManager!, networkManager: self, categories: categories)
        addToQueue(request)
    }

    /**
    Send biinie earned points in organization.
    @param user:Biinie data.
    @param organization:Organization where biine win points.
    @param points:Amount of points earned by biinied
    */
    func sendBiiniePoints(user:Biinie, organization:BNOrganization, points:Int) {
        var request = BNRequest_SendBiiniePoints(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/organizations/\(organization.identifier!)/loyalty/points", errorManager: self.errorManager!, networkManager: self, user: user, organization: organization, points: points)
        addToQueue(request)
    }
    
    /**
    Checks is user email has been verified.
    @param identifier:Biinie identifier.
    */
    func manager(manager:BNDataManager!, checkIsEmailVerified identifier:String) {
        var request = BNRequest_CheckEmail_IsVerified(requestString: "\(rootURL)/mobile/biinies/\(identifier)/isactivate", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Request categories
    @param biinie:Biinie object.
    */
    func manager(manager:BNDataManager!, requestCategoriesData user:Biinie) {
        
        if SimulatorUtility.isRunningSimulator {
            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.9339660564594, -84.05398699629518)
            
        } else if BNAppSharedManager.instance.positionManager.userCoordinates == nil {
            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
        }
        
        var request = BNRequest_Categories(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)/categories", errorManager: self.errorManager!, networkManager:self)
        addToQueue(request)
    }
    
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase, user:Biinie) {
        
        var request = BNRequest_Showcase(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/showcases/\(showcase.identifier!)/", errorManager: self.errorManager!, networkManager: self, showcase: showcase, user: user)
        addToQueue(request)
    }
    
    /**
    Conforms optional     optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:Biinie) {
        var request = BNRequest_Element(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/elements/\(element.identifier!)", dataIdentifier: "", errorManager: self.errorManager!, networkManager: self, element: element)
        addToQueue(request)
    }
    
    ///Conforms optional func manager(manager: BNDataManager!, requestBoardsForBNUser user: BNUser) of BNDataManagerDelegate.
    func manager(manager: BNDataManager!, requestCollectionsForBNUser user: Biinie) {
        var request = BNRequest_Collections(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collections", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestSiteData site:BNSite, user:Biinie) {
        var request = BNRequest_Site(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/sites/\(site.identifier!)", dataIdentifier: "", errorManager: self.errorManager!, networkManager: self, site: site)
        self.addToQueue(request)
    }
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    */
    func manager(manager: BNDataManager!, requestOrganizationData organization: BNOrganization, user: Biinie) {
        
        var request = BNRequest_Organization(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/organizations/\(organization.identifier!)", dataIdentifier: "", errorManager: self.errorManager!, networkManager: self, organization: organization)
        addToQueue(request)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func runRequest(){
        println("runRequest")
        
        for (key, value) in requests {
            
            switch value.requestType {
            case .Regions:
                //self.requestRegions(value)
                break
            case .RegionData:
                //self.requestRegionData(value)
                break
            case .UserCategories:
                //self.requestUserCategoriesData(value)
                break
            case .SiteData:
                //self.requestSiteData(value)
                break
            case .ShowcaseData:
                //                self.requestShowcaseData(value, showcase:value.showcase!)
                break
            case .ElementData:
                //                self.requestElementData(value, element:value.element!)
                break
            default:
                break
            }
            
            //println("Request pending: \(requests.count)")
            return
        }
        
    }

    /**
    BNDataManagerDelegate - Methods to conform on BNNetworkManager.
    Creates a request for all regions and calls the requestRegions(request:BNRequest) method to handle the request.
    */
    /*
    func requestRegions() {
        println("requestRegions")

        var  request = BNRequest(requestString:"\(rootURL)/mobile/regions", dataIdentifier: "", requestType:.Regions)
        addTo_OLD_QUEUE(request)
        if !isRequestTimerAllow {
            self.requestRegions(request)
        }
    }
    */
    /**
    Handles the request for all regions.
    1. If the request is succesfull it parses all of them in a nice array.  
    2. Sends the array to the data manager for further processing (store and request monitoring).
    3. If the request fails it tells the error manager to process the failure.
    @param:The request to be process.
    */
    /*
    func requestRegions(request:BNRequest) {
        
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on regions data")
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var regions:Array<BNRegion> = Array()
                    var regionsData = self.findNSArray("regions", dictionary: dataData)

                    for var i = 0; i < regionsData?.count; i++
                    {
                        var dictionary = regionsData!.objectAtIndex(i) as! NSDictionary
                        var region = BNRegion()
                        region.identifier   = self.findString("identifier", dictionary: dictionary)
                        region.radious      = self.findInt("radious", dictionary: dictionary)
                        region.latitude     = self.findFloat("latitude", dictionary:dictionary)
                        region.longitude    = self.findFloat("longitude", dictionary:dictionary)
                        regions.append(region)
                    }

                    self.delegateDM!.manager!(self, didReceivedRegions: regions)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    */
    /**
    Conforms optional func manager(manager:BNDataManager!, requestRegionData identifier:String) of BNDataManagerDelegate.
    @param: identifier: Biinie identifier.
    */
    /*
    func manager(manager:BNDataManager!, requestRegionData identifier:String) {
        
        var request = BNRequest(requestString: "\(rootURL)/api/regions/\(identifier)/biins", dataIdentifier:identifier, requestType:.RegionData)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        if !isRequestTimerAllow {
            self.requestRegionData(request)
        }
    }
    */

    //FIXME: Docs not complete
    ///Handles the request for a region's data.
    ///
    ///1. If the request is succesfull it parses all of them in a nice array.
    ///2. Sends the array to the data manager for further processing (store and request monitoring).
    ///3. If the request fails it tells the error manager to process the failure.
    ///
    ///:param:The request to be process.
    /*
    func requestRegionData(request:BNRequest) {
 
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on biinie data")
                self.handleFailedRequest(request, error: error )
            } else {
                
                var biins:Array<BNBiin> = Array()
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    /*
                    var biinsData = self.findNSArray("biins", dictionary: dataData)
                        
                    for var i = 0; i < biinsData!.count; i++ {
                        var dictionary = biinsData!.objectAtIndex(i) as NSDictionary
                        var biin = BNBiin()
                        ?
                        biin.identifier     = self.findString("identifier", dictionary: dictionary)?
                        biin.major          = self.findInt("major", dictionary: dictionary)?
                        biin.minor          = self.findInt("minor", dictionary: dictionary)?
                        biin.proximityUUID  = self.findNSUUID("proximityUUID", dictionary: dictionary)?
                        biin.lastUpdate     = self.findNSDate("lastUpdate", dictionary: dictionary)?
                        biin.showcaseIdentifier = self.findString("showcaseIdentifier", dictionary: dictionary)?
                        biins.append(biin)
                    }
                    
                    switch request.requestType {
                    case .RegionData:
                        self.delegateDM!.manager!(self, didReveivedBiinsOnRegion:biins, identifier:request.dataIdentifier)
                    case .SharedBiins:
                        self.delegateDM!.manager!(self, didReveivedSharedBiins: biins, identifier: "")
                    default:
                        break
                    }
                    
                    self.requests.removeValueForKey(request.identifier)
                    self.requestAttempts = 0
                    */

                }
            }
        })
    }
    */

    /*
    func manager(manager: BNDataManager!, requestCategoriesDataByBiinieAndRegion user: Biinie, region: BNRegion) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(region.identifier!)/categories", dataIdentifier:"userCategories", requestType:.UserCategories)
        addTo_OLD_QUEUE(request)
        
        if !isRequestTimerAllow {
            //self.requestUserCategoriesData(request)
        }
    }
*/
    /*
    func manager(manager: BNPositionManager!, requestCategoriesDataOnBackground user:Biinie) {
        
         var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)/categories", dataIdentifier:"userCategories", requestType:.UserCategories)

//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        if !isRequestTimerAllow {
            //self.requestUserCategoriesData(request)
        }
    }
*/
    
    /*
    ///Handles the request for a user categories data and packs the information on an array of BNCategory.
    ///
    ///:param: The request to be process.
    func requestUserCategoriesDataOnBackground(request:BNRequest) {
        
        
        println("\(request.requestString)")
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestUserCategoriesDataOnBackground()")
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var categories = Array<BNCategory>()
                    var categoriesData = self.findNSArray("categories", dictionary: dataData)
                    
                    for var i = 0; i < categoriesData?.count; i++ {
                        
                        var categoryData = categoriesData!.objectAtIndex(i) as! NSDictionary
                        var category = BNCategory(identifier: self.findString("identifier", dictionary: categoryData)!)
                        
                        category.name = self.findString("name", dictionary: categoryData)
                        category.hasSites = self.findBool("hasSites", dictionary: categoryData)
                        
                        //category.hasSites = true
                        if category.hasSites {
                            
                            category.backgroundSites = Dictionary<String, BNSite>()
                            
                            var sites = self.findNSArray("sites", dictionary: categoryData)
                            
                            for var j = 0; j < sites?.count; j++ {
                                
                                var siteData = sites!.objectAtIndex(j) as! NSDictionary
                                var site = BNSite()
                                site.identifier = self.findString("identifier", dictionary: siteData)
                                
                                var biins = self.findNSArray("biins", dictionary: siteData)
                                
                                for var j = 0; j < biins?.count; j++ {
                                    if let biinData = biins!.objectAtIndex(j) as? NSDictionary {
                                        var biin = BNBiin()
                                        biin.identifier = self.findString("identifier", dictionary: biinData)
                                        biin.accountIdentifier = self.findString("accountIdentifier", dictionary: biinData)
                                        biin.siteIdentifier = self.findString("siteIdentifier", dictionary: biinData)
                                        biin.organizationIdentifier = self.findString("organizationIdentifier", dictionary: biinData)
                                        biin.major = self.findInt("major", dictionary: biinData)
                                        biin.minor = self.findInt("minor", dictionary: biinData)
                                        biin.proximityUUID = self.findNSUUID("proximityUUID", dictionary: biinData)
                                        biin.venue = self.findString("venue", dictionary: biinData)
                                        biin.name = self.findString("name", dictionary: biinData)
                                        biin.biinType = self.findBNBiinType("biinType", dictionary: biinData)
                                        
                                        //REMOVE ->
                                        biin.site = site
                                        //biin.lastUpdate = self.findNSDate("lastUpdate", dictionary: biinData)
                                        //REMOVE <-
                                        
                                        
                                        var children = self.findNSArray("children", dictionary: biinData)
                                        
                                        if children?.count > 0 {
                                            
                                            biin.children = Array<Int>()
                                            
                                            for var i = 0; i < children?.count; i++ {
                                                var child = (children!.objectAtIndex(i) as? String)?.toInt()
                                                biin.children!.append(child!)
                                            }
                                        }
                                        
                                        var objects = self.findNSArray("objects", dictionary: biinData)
                                        
                                        if objects!.count > 0 {
                                            biin.objects = Array<BNBiinObject>()
                                            for var k = 0; k < objects!.count; k++ {
                                                if let objectData = objects!.objectAtIndex(k) as? NSDictionary {
                                                    var object = BNBiinObject()
                                                    object._id = self.findString("_id", dictionary: objectData)
                                                    object.identifier = self.findString("identifier", dictionary: objectData)
                                                    object.isDefault = self.findBool("isDefault", dictionary: objectData)
                                                    object.onMonday = self.findBool("onMonday", dictionary: objectData)
                                                    object.onTuesday = self.findBool("onTuesday", dictionary: objectData)
                                                    object.onWednesday = self.findBool("onWednesday", dictionary: objectData)
                                                    object.onThursday = self.findBool("onThursday", dictionary: objectData)
                                                    object.onFriday = self.findBool("onFriday", dictionary: objectData)
                                                    object.onSaturday = self.findBool("onSaturday", dictionary: objectData)
                                                    object.onSunday = self.findBool("onSunday", dictionary: objectData)
                                                    object.startTime = self.findFloat("startTime", dictionary: objectData)!
                                                    object.endTime = self.findFloat("endTime", dictionary: objectData)!
                                                    object.hasTimeOptions = self.findBool("hasTimeOptions", dictionary: objectData)
                                                    object.hasNotification = self.findBool("hasNotification", dictionary: objectData)
                                                    object.notification = self.findString("notification", dictionary: objectData)
                                                    object.isUserNotified = self.findBool("isUserNotified", dictionary: objectData)
                                                    object.isBiined = self.findBool("isBiined", dictionary: objectData)
                                                    object.objectType = self.findBiinObjectType("objectType", dictionary: objectData)
                                                    biin.objects!.append(object)
                                                }
                                            }
                                        }

                                        site.biins.append(biin)
                                    }
                                }    
                                
                                category.backgroundSites![site.identifier!] = site
                            }
                        }
                        
                        categories.append(category)
                    }
                    
                    self.delegateDM!.manager!(self, didReceivedUserCategoriesOnBackground:categories)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
                //                self.requests.removeValueForKey(request.identifier)
                //                self.requestAttempts = 0
                
            }
        }
    }
    */
    

    
    



    
    func manager(manager: BNDataManager!, requestHighlightsData user: Biinie) {
        var showcase:BNShowcase?
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/highlights", dataIdentifier:"userHightlights", requestType:.HighlightsData)
            showcase = BNShowcase()
            request.showcase = showcase!
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        self.requestHighlightsData(request, showcase:request.showcase!)
    }
    
    /**
    Handles the request for a showcase's data.

    :param: The request to be process.
    */
    func requestHighlightsData(request:BNRequest, showcase:BNShowcase) {
        
        
        println("\(request.requestString)")
        
        epsNetwork!.getJson(true, url: request.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on hightlights data")
                println("\(error!.description)")
                self.handleFailedRequest(request, error: error)
            } else {
                
                if let showcaseData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if status != nil {
                        
                        println("*** Request hightlights data BAD! \(status!) request: \(request.requestString)")
                        
                    } else {
                        
                        var elements = self.findNSArray("elements", dictionary: showcaseData)
                        
                        for var i = 0; i < elements?.count; i++ {
                            
                            var elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                            var element = BNElement()
                            element.isHighlight = true
                            element._id = self.findString("_id", dictionary: elementData)
                            element.identifier = self.findString("elementIdentifier", dictionary: elementData)
                            element.jsonUrl = self.findString("jsonUrl", dictionary: elementData)
                            element.siteIdentifier = self.findString("siteIdentifier", dictionary: elementData)
                            showcase.elements.append(element)
                            element.color = UIColor.elementColor()
                        }
                        
                        self.delegateDM!.manager!(self, didReceivedHihglightList: showcase)
                        
                        if self.isRequestTimerAllow {
                            self.runRequest()
                        }
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    

    

    
    
    func sendBiinedElement(user: Biinie, element: BNElement, collectionIdentifier:String) {
        
        println("saveBiinedElement(\(user.email)) element: \(element.identifier!)")

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)", dataIdentifier: "", requestType:.SendBiinedElement)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        var model = Dictionary<String, Dictionary <String, String>>()

        var modelContent = Dictionary<String, String>()
        modelContent["identifier"] = element.identifier!
        modelContent["_id"] = element._id!
        modelContent["type"] = "element" //"site"
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.put(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("ERROR on sendBiinedElement()")
                self.handleFailedRequest(request, error: error )
                
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
                println("*** sendBiinedElement() for user \(user.email!) SUCK - FAILED!")
                println("*** data \(data)")
                
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)

                    println("*** data \(data)")
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        println("*** sendBiinedElement() for user \(user.email!) COOL!")
                        //self.delegateDM!.manager!(self, didReceivedUserIdentifier: identifier)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                        println("*** sendBiinedElement() for user \(user.email!) SUCK!")
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedUpdateConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    func sendUnBiinedElement(user: Biinie, elementIdentifier:String, collectionIdentifier:String) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)/element/\(elementIdentifier)", dataIdentifier: "", requestType:.SendBiinedElement)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        println("\(request.requestString)")
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["type"] = "element"
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.delete(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }

    
    func sendBiinedSite(user: Biinie, site: BNSite, collectionIdentifier:String) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)", dataIdentifier: "", requestType:.SendBiinedSite)

//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["identifier"] = site.identifier!
        modelContent["type"] = "site"
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.put(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedUpdateConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    
    func sendUnBiinedSite(user: Biinie, siteIdentifier:String, collectionIdentifier:String) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)/site/\(siteIdentifier)", dataIdentifier: "", requestType:.SendBiinedElement)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["type"] = "site"
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.delete(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    

    /**
    Registration of Share Service:
    Method: PUT
    Route: 'mobile/biinies/[Biinie Identifier]/share’
    Model: {"model":{"identifier”:”’[Object Identifier]","type":”element/site"}}
    Example: {"model":{"identifier":"1234","type":"element”}}
    */
    func sendSharedElement(user: Biinie, element: BNElement) {

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/share", dataIdentifier: "", requestType:.SendBiinedElement)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["identifier"] = element.identifier!
        modelContent["type"] = "element"
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.put(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)

                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedUpdateConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    func sendSharedSite(user:Biinie, site:BNSite ) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/share", dataIdentifier: "", requestType:.SendBiinedSite)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        var model = Dictionary<String, Dictionary <String, String>>()
        
        var modelContent = Dictionary<String, String>()
        modelContent["identifier"] = site.identifier!
        modelContent["type"] = "site"
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.put(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
                
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)

                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedUpdateConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    /**
    Handles the request for a element's data.
    
    :param: The request to be process.
    */
    func manager(manager: BNDataManager!, requestHightlightDataForBNUser element: BNElement, user: Biinie) {
        /*
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/elements/\(element.identifier!)", dataIdentifier:"userCategories", requestType:.ElementData)
        request.element = element
        //        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        
        self.self.requestElementData(request, element:element)
        */
    }
    
    func sendNotifiedObject(user: Biinie, biin: BNBiin, object:BNBiinObject) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/biin/\(biin.identifier!)/object/\(object.identifier!)/notified", dataIdentifier: "", requestType:.SendNotifiedObject)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        var model = Dictionary<String, Dictionary <String, String>>()
        var modelContent = Dictionary<String, String>()
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.put(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedUpdateConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }

    
    
    //TODO: Impelement later.
    ///Conforms optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestElementNotificationForBNUser element:BNElement, user:Biinie){
        println("requestElementNotificationForBNUser for:\(element.identifier!) ")
        var request = BNRequest(requestString:element.jsonUrl!, dataIdentifier:element.identifier!, requestType:.ShowcaseData)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
        self.requestElementNotificationForBNUser(request, element:element, user:user)
    }
    
    ///Handles the request for a element's notification for a user.
    ///
    ///:param: The request to be process.
    func requestElementNotificationForBNUser(request:BNRequest, element:BNElement, user:Biinie) {
        
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on showcase data")
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let showcaseData = data["data"] as? NSDictionary {
                    
//                    var showcase = BNShowcase()
//                    showcase.identifier = self.findString("identifier", dictionary: showcaseData)
//                    showcase.lastUpdate = self.findNSDate("lastUpdate", dictionary: showcaseData)
//                    showcase.theme = self.findBNShowcaseTheme("theme", dictionary: showcaseData)
//                    
//                    var elements = self.findNSArray("elements", dictionary: showcaseData)
//                    
//                    for var i = 0; i < elements?.count; i++ {
//                        
//                        var elementData:NSDictionary = elements!.objectAtIndex(i) as NSDictionary
//                        var element = BNElement()
//                        element.identifier = self.findString("elementIdentifier", dictionary: elementData)
//                        element.jsonUrl = self.findString("jsonUrl", dictionary: elementData)
//                    }
//                    
//                    self.delegateDM!.manager!(self, didReceivedShowcase: showcase)
                }
                self.removeRequestOnCompleted(request.identifier)
//                self.requests.removeValueForKey(request.identifier)
//                self.requestAttempts = 0
            }
        })
    }
    

    func manager(manager: BNDataManager!, requestImageData stringUrl: String, image: UIImageView!) {
        var request = BNRequest(requestString: stringUrl, dataIdentifier:"", requestType:.ImageData)
//        self.requests[request.identifier] = request
        addTo_OLD_QUEUE(request)
    }
    
    func removeImageRequest(stringUrl:String){
        for (identifier, request) in self.requests {
            if stringUrl == request.requestString {
                self.removeRequestOnCompleted(request.identifier)
                break
            }
        }
    }
    

    func requestImageData(stringUrl:String, image:BNUIImageView!) {
        
        var isRequestInQueue = false
        
        for (identifier, request) in self.requests {
            if stringUrl == request.requestString {
                isRequestInQueue = true
                break
            }
        }
        
        if !isRequestInQueue {
            
            var request = BNRequest(requestString: stringUrl, dataIdentifier:"", requestType:.ImageData)
//            self.requests[request.identifier] = request
            addTo_OLD_QUEUE(request)
            epsNetwork!.getImage(stringUrl, image:image, callback:{(error: NSError?) -> Void in
                
                    if (error == nil)  {
                        self.removeRequestOnCompleted(request.identifier)
                    } else {
                        self.handleFailedRequest(request, error:error )
                    }
                })
        } else {
            epsNetwork!.getImageInCache(stringUrl, image: image)
        }
    }
    

  
    func handleFailedRequest(request:BNRequest, error:NSError? ) {
        
        switch error!.code {
            case 3840:
                self.delegateDM!.manager!(self, removeShowcaseRelationShips: request.dataIdentifier)
//                self.requests.removeValueForKey(request.identifier)
                self.removeRequestOnCompleted(request.identifier)
                self.removeShowcase(request.dataIdentifier)
                self.errorManager!.showAlert(error)
//                self.requestAttempts = 0
                return
            case 1005:
            break
            default:
            break
        }
        
        if self.requestAttempts == self.requestAttemptsLimit {
            self.errorManager!.showAlert(error)
            self.requestAttempts = 0
        } else {
            
            println("Trying request again: " + request.requestString)
            
            switch request.requestType {
            case .Regions:
                //self.requestRegions(request)
                break
            case .RegionData:
                //self.requestRegionData(request)
                break
            case .UserCategories:
                //self.requestUserCategoriesData(request)
                break
            case .SiteData:
                //self.requestSiteData(request)
                break
            case .ShowcaseData:
//                self.requestShowcaseData(request, showcase:request.showcase!)
                break
            case .ElementData:
                if request.requestAttemps <= 4 {
                    request.requestAttemps++
                    //self.requestElementData(request, element:request.element!)
                } else {
                    
                }
                break
            default:
                break
            }
        }
        
        self.requestAttempts++
    }
    
    //Request to remove a showcase when it data is corrupt or is not longer in server.
    func removeShowcase( identifier:String ) {
        println("Request to remove showcase from server: \(identifier)")
    }

    //BNErrorManagerDelegate
    func manager(manager:BNErrorManager!, saveError error:BNError) {
        var url = "http://biin.herokuapp.com/api/errors/add/"
        var parameters = ["code": error.code, "title":error.title, "description":error.errorDescription, "proximityUUID":error.proximityUUID, "region":error.region]
    }
    
    func removeRequestOnCompleted(identifier:Int){
        
        requests.removeValueForKey(identifier)
        requestAttempts = 0
        
        if requests.count == 0 {
            
            //println("NOT requests pending: \(self.requests.count)")
            //self.delegateVC!.manager!(self, didReceivedAllInitialData: true)
            
            //if BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA {
            //    BNAppSharedManager.instance.mainViewController!.refresh()
            //    BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA = false
            //}
            
        } else {
            //self.delegateVC!.manager!(self, didReceivedAllInitialData: false)
            println("Requests Pending:\(requests.count)")
            
            if requests.count == 1 {
                println("")
            }
        }
        
        var value:CGFloat = ((CGFloat(requests.count) * 100.0 ) / 30.0)
        delegateVC!.manager!(self, updateProgressView:Float(value))

    }
    
    //Parse Methods
//    func findBool(name:String, dictionary:NSDictionary) -> Bool {
//        var value = self.findInt(name, dictionary: dictionary)
//
//        if value == 1 {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    func findInt(name:String, dictionary:NSDictionary) ->Int? {
//        return (dictionary[name] as? String)?.toInt()
//    }
//
//    func findFloat(name:String, dictionary:NSDictionary) ->Float? {
//        return NSString(string:(dictionary[name] as? String)!).floatValue
//    }
//    
//    func findString(name:String, dictionary:NSDictionary) ->String? {
//        return dictionary[name] as? String
//    }
    
//    func findNSDictionary(name:String, dictionary:NSDictionary) ->NSDictionary? {
//        return dictionary[name] as? NSDictionary
//    }
//    
//    func findNSArray(name:String, dictionary:NSDictionary) ->NSArray? {
//        return dictionary[name] as? NSArray
//    }
//    
//    func findNSUUID(name:String, dictionary:NSDictionary) ->NSUUID? {
//        var uuid:NSUUID?
//        uuid = NSUUID(UUIDString:(dictionary[name] as? String)!)
//        return uuid
//    }
//    
//    func findNSDate(name:String, dictionary:NSDictionary) ->NSDate? {
//        var date:NSDate? = NSDate(dateString:(dictionary[name] as? String)!)
//        return date
//    }
//    
//    func findBNBiinType(name:String, dictionary:NSDictionary) -> BNBiinType {
//        var value:Int = self.findInt(name, dictionary: dictionary)!
//        switch value {
//        case 0:
//            return BNBiinType.NONE
//        case 1:
//            return BNBiinType.EXTERNO
//        case 2:
//            return BNBiinType.INTERNO
//        case 3:
//            return BNBiinType.PRODUCT
//        default:
//            return BNBiinType.NONE
//        }
//    }
//    
//    func findBNElementType(name:String, dictionary:NSDictionary) -> BNElementType {
//        var value = self.findInt(name, dictionary: dictionary)
//
//        if value == 1 {
//            return BNElementType.Simple
//        } else if value == 2 {
//            return BNElementType.Informative
//        } else if value == 3 {
//            return BNElementType.Benefit
//        } else {
//            return BNElementType.Simple
//        }
//    }
//    
//    func findBNElementDetailType(name:String, dictionary:NSDictionary) -> BNElementDetailType {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return BNElementDetailType.Title
//        } else if value == 2 {
//            return BNElementDetailType.Paragraph
//        } else if value == 3 {
//            return BNElementDetailType.Quote
//        } else if value == 4 {
//            return BNElementDetailType.ListItem
//        } else if value == 5 {
//            return BNElementDetailType.Link
//        } else if value == 6 {
//            return BNElementDetailType.PriceList
//        } else {
//            return BNElementDetailType.Title
//        }
//    }
//    
//    func findBNShowcaseTheme(name:String, dictionary:NSDictionary) -> BNShowcaseTheme {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return BNShowcaseTheme.Dark
//        } else if value == 2 {
//            return BNShowcaseTheme.Light
//        } else {
//            return BNShowcaseTheme.Light
//        }
//    }
//    
//    func findBNShowcaseType(name:String, dictionary:NSDictionary) -> BNShowcaseType {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return BNShowcaseType.SimpleProduct
//        } else if value == 2 {
//            return BNShowcaseType.MultipleProduct
//        } else {
//            return BNShowcaseType.SimpleProduct
//        }
//    }
//    
//    
//    func findBNStickerType(name:String, dictionary:NSDictionary) -> BNStickerType {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return BNStickerType.CIRCLE_FREE
//        } else if value == 2 {
//            return BNStickerType.CIRCLE_SALE
//        } else if value == 3 {
//            return BNStickerType.CIRCLE_BEST_OFFER
//        } else if value == 4 {
//            return BNStickerType.CIRCLE_FREE_GIFT
//        } else {
//            return BNStickerType.NONE
//        }
//    }
//    
//    func findNotificationType(name:String, dictionary:NSDictionary) -> BNNotificationType {
//        var value = self.findInt(name, dictionary: dictionary)
//        if value == 1 {
//            return BNNotificationType.STIMULUS
//        } else if value == 2 {
//            return BNNotificationType.ENGAGE
//        } else if value == 3{
//            return BNNotificationType.CONVERT
//        } else {
//            return BNNotificationType.STIMULUS
//        }
//    }
//    
//    func findMediaType(name:String, dictionary:NSDictionary) -> BNMediaType {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return BNMediaType.Image
//        } else if value == 2 {
//            return BNMediaType.Video
//        } else {
//            return BNMediaType.Image
//        }
//    }
//    
//    func findBiinObjectType(name:String, dictionary:NSDictionary) -> BNBiinObjectType {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return BNBiinObjectType.ELEMENT
//        } else if value == 2 {
//            return BNBiinObjectType.SHOWCASE
//        } else {
//            return BNBiinObjectType.NONE
//        }
//    }
//    
//    func findUIColor(name:String, dictionary:NSDictionary) ->UIColor? {
//        return self.colorFromString(dictionary[name] as? String)
//    }
//    
//    func findCurrency(name:String, dictionary:NSDictionary) -> String {
//        var value = self.findInt(name, dictionary: dictionary)
//        
//        if value == 1 {
//            return "$"
//        } else if value == 2 {
//            return "¢"
//        } else if value ==  3 {
//            return "€"
//        } else {
//           return "$"
//        }
//    }
//    
//    
//    func colorFromString(color:String?)->UIColor? {
//        
//        if color == nil || color == "" {
//            return UIColor.appTextColor()
//        }
//        
//        var r = ""
//        var g = ""
//        var b = ""
//        
//        var isNumber = false
//        var counter = 0
//        
//        for c in color! {
//            isNumber = false
//            switch (c) {
//            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
//                if counter == 0 {
//                    r.append(c)
//                } else if counter == 1 {
//                    g.append(c)
//                } else if counter == 2 {
//                    b.append(c)
//                }
//                continue
//            case ",":
//                counter++
//                continue
//            default:
//                break
//            }
//        }
//        
//        return UIColor(red: (CGFloat(r.toInt()!) / 255), green: (CGFloat(g.toInt()!) / 255), blue:(CGFloat(b.toInt()!) / 255), alpha: 1.0)
//    }
}

@objc protocol BNNetworkManagerDelegate:NSObjectProtocol {
    
    optional func manager(manager:BNNetworkManager!, didReceivedLoginValidation response:BNResponse?)
    optional func manager(manager:BNNetworkManager!, didReceivedUserIdentifier idetifier:String?)
    optional func manager(manager:BNNetworkManager!, didReceivedEmailVerification value:Bool)
    optional func manager(manager:BNNetworkManager!, didReceivedRegisterConfirmation response:BNResponse?)
    optional func manager(manager:BNNetworkManager!, didReceivedUpdateConfirmation response:BNResponse?)
    optional func manager(manager:BNNetworkManager!, didReceivedCategoriesSavedConfirmation response:BNResponse?)
    
    optional func manager(manager:BNNetworkManager!, didReceivedInitialData biins:Array<BNBiin>?)
    
    optional func manager(manager:BNNetworkManager!, didReceivedRegions regions:Array<BNRegion>)

    ///Takes connection status and start initial requests
    ///
    ///:param: BNNetworkManager.
    ///:param: Status of the network check.
    optional func manager(manager:BNNetworkManager!, didReceivedConnectionStatus status:Bool)
    
    ///Takes categories data requested and procces that data.
    ///
    ///:param: BNNetworkManager.
    ///:param: An array of categories.
    optional func manager(manager:BNNetworkManager!, didReceivedUserCategories categories:Array<BNCategory>)

    optional func manager(manager:BNNetworkManager!, didReceivedUserCategoriesOnBackground categories:Array<BNCategory>)

    
    ///Takes site data requested and proccess that data.
    ///
    ///:param: BNNetworkManager.
    ///:param: BNSite requested.
    optional func manager(manager:BNNetworkManager!, didReceivedSite site:BNSite)
    
    ///Takes showcase data requested and proccess that data.
    ///
    ///:param: BNNetworkManager.
    ///:param: BNShowcase requested.
    optional func manager(manager:BNNetworkManager!, didReceivedShowcase showcase:BNShowcase)
    
    ///Takes element data requested and proccess that data.
    ///
    ///:param: BNNetworkManager.
    ///:param: BNElement requested.
    optional func manager(manager:BNNetworkManager!, didReceivedElement element:BNElement)
    
    
    
    optional func manager(manager:BNNetworkManager!, didReceivedHihglightList showcase:BNShowcase)

    
    
    ///Takes element data requested and proccess that data.
    ///
    ///:param: BNNetworkManager.
    ///:param: BNElement requested.
    optional func manager(manager:BNNetworkManager!, didReceivedHightlight element:BNElement)
    
    
    ///Takes user biined element list and process data and request to download elements.
    ///
    ///:param: BNNetworkManager.
    ///:param: BNElement list biined by user.
    optional func manager(manager:BNNetworkManager!, didReceivedBiinedElementList elementList:Array<BNElement>)
    
    
    ///Takes user boards and process data and request to download elements.
    ///
    ///:param: BNNetworkManager.
    ///:param: User boards.
    optional func manager(manager:BNNetworkManager!, didReceivedCollections collectionList:Array<BNCollection>)
    
    
    
    
    
    optional func manager(manager:BNNetworkManager!, updateProgressView value:Float)

    

    

    ///Takes a notification string data requested for a element and proccess that data.
    ///
    ///:param: BNNetworkManager.
    ///:param: String notification requested.
    ///:param: BNEelement requesting the data.
    optional func manager(manager:BNNetworkManager!, didReceivedElementNotification notification:String, element:BNElement)
    
    
    ///Notifies main menu view that all initial data is downloaded and is safe to enter the app.
    ///
    ///:param: BNNetworkManager.
    ///:param: Just a flag.
    optional func manager(manager:BNNetworkManager!, didReceivedAllInitialData value:Bool)
    
    
    optional func manager(manager:BNNetworkManager!, didReveivedBiinsOnRegion biins:Array<BNBiin>, identifier:String)

    optional func manager(manager:BNNetworkManager!, didReceivedBiinieData user:Biinie)
    optional func manager(manager:BNNetworkManager!, removeShowcaseRelationShips identifier:String)
    optional func manager(manager:BNNetworkManager!, didReveivedSharedBiins biins:Array<BNBiin>, identifier:String )
    optional func refreshTable(manager:BNNetworkManager!)
}

extension NSDate {
    convenience init(dateString:String) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = formatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    func bnDateFormatt()->String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter.stringFromDate(self)
    }
    
    func bnDateFormattForActions()->String{
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter.stringFromDate(self)
    }
    
    func bnDisplayDateFormatt()->String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.stringFromDate(self)
    }
    
    func bnShortDateFormat()->String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(self)
    }
    
    func isBefore(date:NSDate) -> Bool {
        
        if self.compare(date) == NSComparisonResult.OrderedAscending {
            return true
        } else {
            return false
        }
    }

    func daysBetweenFromAndTo(toDate:NSDate) -> Int {
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate:toDate, toDate:NSDate(), options: nil)
        return (components.day + 1)
    }
    
    
}
