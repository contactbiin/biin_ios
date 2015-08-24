//  BNNetworkManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import SystemConfiguration
import CoreLocation


class BNNetworkManager:NSObject, BNDataManagerDelegate, BNErrorManagerDelegate, BNPositionManagerDelegate {
    
    //URL requests with mocky
    //let connectibityUrl = "http://www.mocky.io/v2/546b66f21dc00bbc132cf175"
    //let regionsUrl = "http://www.mocky.io/v2/546b66d31dc00bbe132cf174"
    //let categoriesUrl = "http://www.mocky.io/v2/546b66a91dc00bb2132cf173"
    
    //URL from QA server (LUIS).
    //let connectibityUrl = "http://www.mocky.io/v2/546b66f21dc00bbc132cf175"
    //let regionsUrl = "https://biin-qa.herokuapp.com/mobile/regions"
    //let categoriesUrl = "http://biin-qa.herokuapp.com/mobile/categories"

    
    //URL requests
    //let connectibityUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getConnectibity.json"
    //let regionsUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getRegions.json"
    //let categoriesUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getCategories.json"
    let biinedElements = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons, /getBiinedElements.json"
    let boards = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getBoards.json"

    
    //URL requests
    let connectibityUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getConnectibity.json"
    
    //let regionsUrl = "https://www.biinapp.com/mobile/regions"
    ///let regionsUrl = "https://biin-qa.herokuapp.com/mobile/regions"
    
    
    //let categoriesUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getCategories.json"
    //let biinedElements = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getBiinedElements.json"
    //let boards = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getBoards.json"
    
    
//    let manager = AFHTTPRequestOperationManager()
    var errorManager:BNErrorManager?
    var delegateDM:BNNetworkManagerDelegate?
    var delegateVC:BNNetworkManagerDelegate?
    var requests = Dictionary<Int, BNRequest>()
    var requestAttempts = 0
    var requestAttemptsLimit = 3
    var requestTimer:NSTimer?
    var isRequestTimerAllow = false
    
    var epsNetwork:EPSNetworking?
    
    //var qa_URL = "https://qa-biinapp.herokuapp.com"
    //var production_URL = "https://www.biin.io"
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
 
    func checkConnectivity() {
        
        //self.delegateDM!.manager!(self, didReceivedConnectionStatus: Reachability.isConnectedToNetwork())
        //return
        
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
    
    
    /**
    Enable biinie to login.
    @param email:Biinie email.
    @param password:Biinie password.
    */
    func login(email:String, password:String){

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/auth/\(email)/\(password)", dataIdentifier: "", requestType:.Login)
        
        self.requests[request.identifier] = request
        var response:BNResponse?
        
        epsNetwork!.getJson(false, url:request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                
                self.handleFailedRequest(request, error: error)
                
                response = BNResponse(code:9, type: BNResponse_Type.RequestFailed)
                self.delegateVC!.manager!(self, didReceivedLoginValidation: response)
                
            } else {
                
                if let loginData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    var identifier = self.findString("identifier", dictionary: loginData)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        self.delegateDM!.manager!(self, didReceivedUserIdentifier: identifier)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedLoginValidation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
                
            }
        })
    }
    
    /**
    Enable biinie to register.
    @param user:Biinie data.
    */
    func register(user:Biinie) {
        
       var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.firstName!)/\(user.lastName!)/\(user.email!)/\(user.password!)/\(user.gender!)", dataIdentifier: "", requestType:.Register)
     
        self.requests[request.identifier] = request
        
        var response:BNResponse?
        
        epsNetwork!.getJson(false, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let registerData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    var identifier = self.findString("identifier", dictionary: registerData)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        self.delegateDM!.manager!(self, didReceivedUserIdentifier: identifier)
                        
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                        println("*** Register for user \(user.email!) SUCK!")
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedRegisterConfirmation: response)

                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
                
            }
        })
    }
    
    /**
    Send biinie categories.
    @param user:Biinie data.
    @param categories:List of categories seleted by biinie.
    */
    func sendBiinieCategories(user:Biinie, categories:Dictionary<String, String>) {

       var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/categories", dataIdentifier: "", requestType:.SendBiinieCategories)
 
        self.requests[request.identifier] = request
        
        var model = ["model":Array<Dictionary <String, String>>()] as Dictionary<String, Array<Dictionary <String, String>>>
        
        for (key, value) in categories {
            model["model"]?.append(["identifier":value])
        }
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
  
        var response:BNResponse?
        
        epsNetwork!.post(request.requestString, htttpBody:htttpBody, callback: {
            
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
                        println("*** Register categproes for user: \(user.email!) COOL!")
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                        println("*** Register categories for user: \(user.email!) SUCK!")
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedCategoriesSavedConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
                
            }
        })
    }
    
    /**
    Send biinie data.
    @param user:Biinie data.
    */
    func sendBiinie(user:Biinie) {
        
        println("sendBiinie(\(user.email))")
        
       var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)", dataIdentifier: "", requestType:.SendBiinie)

        self.requests[request.identifier] = request
        
        var model = Dictionary<String, Dictionary <String, String>>()
        var modelContent = Dictionary<String, String>()
        modelContent["firstName"] = user.firstName!
        modelContent["lastName"] = user.lastName!
        modelContent["email"] = user.email!
        modelContent["gender"] = user.gender!
        modelContent["birthDate"] = user.birthDate!.bnDateFormatt()
        model["model"] = modelContent
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)

        var response:BNResponse?
        
        epsNetwork!.post(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("ERROR on sendBiinie()")
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
    Send biinie actions.
    @param user:Biinie data.
    */
    func sendBiinieActions(user:Biinie) {

        if user.actions.count == 0 {
            return
        }

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/history", dataIdentifier: "", requestType:.SendBiinieCategories)

        self.requests[request.identifier] = request
        
        var model = ["model":["actions":Array<Dictionary<String, String>>()]] as Dictionary<String, Dictionary<String, Array<Dictionary <String, String>>>>

        for value in user.actions {
            var action = Dictionary <String, String>()
            action["whom"]  = user.identifier!
            action["at"]    = value.at!.bnDateFormatt()
            action["did"]   = "\(value.did!.hashValue)"
            action["to"]    = value.to!
            model["model"]!["actions"]?.append(action)
        }
        
        var httpError: NSError?
        var htttpBody:NSData? = NSJSONSerialization.dataWithJSONObject(model, options:nil, error: &httpError)
        
        var response:BNResponse?
        
        epsNetwork!.put(request.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on posting categoies")
                self.handleFailedRequest(request, error: error )
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        //response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        user.deleteAllActions()
                    } else {
                        //response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                    }
                    
                    BNAppSharedManager.instance.dataManager.bnUser!.actions.removeAll(keepCapacity: false)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
                
            }
        })
    }

    /**
    Send biinie earned points in organization.
    @param user:Biinie data.
    @param organization:Organization where biine win points.
    @param points:Amount of points earned by biinied
    */
    func sendBiiniePoints(user:Biinie, organization:BNOrganization, points:Int) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/organizations/\(organization.identifier!)/loyalty/points", dataIdentifier: "", requestType:.SendBiinieCategories)

        self.requests[request.identifier] = request
        
        var model = Dictionary<String, Dictionary <String, Int>>()
        
        var modelContent = Dictionary<String, Int>()
        modelContent["points"] = points
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
                    
                    self.delegateVC!.manager!(self, didReceivedCategoriesSavedConfirmation: response)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }

    
    
    
//    func requestInitialData() {
    
//        self.delegateVC?.manager!(self, didReceivedInitialData:nil)
//        requestRegions()
//    }
    
    //FIXME: Method only for testing TSS
//    func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge)
//    {
//        println("willSendRequestForAuthenticationChallenge")
//    }
    
//    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void){
//        println("willSendRequestForAuthenticationChallenge")    
//    }
    
    
//    func testSSL(){
//        println("testSSL")
//        var request = BNRequest(requestString:regionsUrl, dataIdentifier: "", requestType:.Regions)
//        self.requests[request.identifier] = request
//        self.requestRegions(request)
//        
//    }
    
    
    
    func runRequest(){
        println("runRequest")
        
        for (key, value) in requests {
            
            switch value.requestType {
            case .Regions:
                self.requestRegions(value)
                break
            case .RegionData:
                self.requestRegionData(value)
                break
            case .UserCategories:
                self.requestUserCategoriesData(value)
                break
            case .SiteData:
                //self.requestSiteData(value)
                break
            case .ShowcaseData:
                self.requestShowcaseData(value, showcase:value.showcase!)
                break
            case .ElementData:
                self.requestElementData(value, element:value.element!)
                break
            default:
                break
            }
            
            //println("Request pending: \(requests.count)")
            return
        }
        
    }
    
    /**
    Checks is user email has been verified.
    @param identifier:Biinie identifier.
    */
    func manager(manager:BNDataManager!, checkIsEmailVerified identifier:String) {

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(identifier)/isactivate", dataIdentifier: "", requestType:.CheckIsEmailVerified)
        self.requests[request.identifier] = request
        
        epsNetwork!.getJson(false, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    self.delegateDM!.manager!(self, didReceivedEmailVerification: result)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }

    /**
    BNDataManagerDelegate - Methods to conform on BNNetworkManager.
    Creates a request for all regions and calls the requestRegions(request:BNRequest) method to handle the request.
    */
    func requestRegions() {
        println("requestRegions")

        var  request = BNRequest(requestString:"\(rootURL)/mobile/regions", dataIdentifier: "", requestType:.Regions)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestRegions(request)
        }
    }
    
    /**
    Handles the request for all regions.
    1. If the request is succesfull it parses all of them in a nice array.  
    2. Sends the array to the data manager for further processing (store and request monitoring).
    3. If the request fails it tells the error manager to process the failure.
    @param:The request to be process.
    */
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
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestRegionData identifier:String) of BNDataManagerDelegate.
    @param: identifier: Biinie identifier.
    */
    func manager(manager:BNDataManager!, requestRegionData identifier:String) {
        
        var request = BNRequest(requestString: "\(rootURL)/api/regions/\(identifier)/biins", dataIdentifier:identifier, requestType:.RegionData)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestRegionData(request)
        }
    }
    

    //FIXME: Docs not complete
    ///Handles the request for a region's data.
    ///
    ///1. If the request is succesfull it parses all of them in a nice array.
    ///2. Sends the array to the data manager for further processing (store and request monitoring).
    ///3. If the request fails it tells the error manager to process the failure.
    ///
    ///:param:The request to be process.
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
    
    
    func manager(manager: BNDataManager!, requestCategoriesDataByBiinieAndRegion user: Biinie, region: BNRegion) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(region.identifier!)/categories", dataIdentifier:"userCategories", requestType:.UserCategories)

        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestUserCategoriesData(request)
        }
    }

    func manager(manager: BNPositionManager!, requestCategoriesDataOnBackground user:Biinie) {
        
         var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)/categories", dataIdentifier:"userCategories", requestType:.UserCategories)

        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestUserCategoriesData(request)
        }
    }
    
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
    

    
    
    ///Conforms optional func manager(manager:BNDataManager!, requestUserCategoriesData user:BNUser) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestCategoriesData user:Biinie) {
        
        /*
        var request = BNRequest(requestString:categoriesUrl, dataIdentifier:"userCategories", requestType:.UserCategories)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestUserCategoriesData(request)
        }
        */
                
        //https://biin-qa.herokuapp.com/mobile/5eb36cc2-983d-4762-ac44-c6100bf3598a/10/10/categories

        if SimulatorUtility.isRunningSimulator {
           BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.9339660564594, -84.05398699629518)
            
        } else if BNAppSharedManager.instance.positionManager.userCoordinates == nil {
           BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(0.0, 0.0)
            //CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
        }
        
        
        
//        if BNAppSharedManager.instance.IS_PRODUCTION_DATABASE {
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)/categories", dataIdentifier:"userCategories", requestType:.UserCategories)
//        } else {
            //nota simulator
//            request = BNRequest(requestString:"\(qa_URL)/mobile/biinies/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)/categories", dataIdentifier:"userCategories", requestType:.UserCategories)
//        }
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestUserCategoriesData(request)
        }
    }
    
    /**
    Handles the request for a user categories data and packs the information on an array of BNCategory.
    @param: The request to be process.
    */
    func requestUserCategoriesData(request:BNRequest) {
        
        epsNetwork!.getJson(false, url: request.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestUserCategoriesData()")
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
                            var sites = self.findNSArray("sites", dictionary: categoryData)

                            for var j = 0; j < sites?.count; j++ {
                                
                                var siteData = sites!.objectAtIndex(j) as! NSDictionary

                                //TODO: Add site details to category here.
                                var siteDetails = BNCategorySiteDetails()
                                siteDetails.identifier = self.findString("identifier", dictionary: siteData)
                                siteDetails.json = self.findString("jsonUrl", dictionary: siteData)
                                siteDetails.biinieProximity = self.findFloat("biinieProximity", dictionary: siteData)
                                category.sitesDetails.append(siteDetails)
     
                            }
                        }
                        
                        categories.append(category)
                    }

                    self.delegateDM!.manager!(self, didReceivedUserCategories:categories)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestSiteData site:BNSite, user:Biinie) {
    
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/sites/\(site.identifier!)", dataIdentifier:"userCategories", requestType:.SiteData)
    
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestSiteData(request, psite:site)
        }
    }
    
    /**
    Handles the request for a site's data.
    :param: The request to be process.
    */
    func requestSiteData(request:BNRequest, psite:BNSite) {
        
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestSiteData()")
                println("\(error!.description)")
                self.handleFailedRequest(request, error: error )
            } else {

                var result = self.findBool("result", dictionary: data)

                if result {
                    if let siteData = data["data"] as? NSDictionary {
                        
                        var site = BNSite()
                        site.biinieProximity = psite.biinieProximity!
                        site.jsonUrl = request.requestString
                        site.identifier = self.findString("identifier", dictionary: siteData)
                        site.proximityUUID = self.findNSUUID("proximityUUID", dictionary: siteData)
                        site.major = self.findInt("major", dictionary: siteData)
                        site.title = self.findString("title", dictionary: siteData)
                        site.subTitle = self.findString("subTitle", dictionary: siteData)
                        site.titleColor = self.findUIColor("titleColor", dictionary: siteData)
                        site.country = self.findString("country", dictionary: siteData)
                        site.state = self.findString("state", dictionary: siteData)
                        site.city = self.findString("city", dictionary: siteData)
                        site.zipCode = self.findString("zipCode", dictionary: siteData)
                        site.streetAddress1 = self.findString("streetAddress1", dictionary: siteData)
                        site.ubication = self.findString("ubication", dictionary: siteData)
                        site.phoneNumber = self.findString("phoneNumber", dictionary: siteData)
                        site.email = self.findString("email", dictionary: siteData)
                        site.nutshell = self.findString("nutshell", dictionary: siteData)
                        
                        site.biinedCount = self.findInt("biinedCount", dictionary: siteData)!
                        //TODO: Pending "comments": "23", in web service
                        site.commentedCount = self.findInt("commentedCount", dictionary: siteData)!
                        site.userBiined = self.findBool("userBiined", dictionary: siteData)
                        site.userCommented = self.findBool("userCommented", dictionary: siteData)
                        site.userShared = self.findBool("userShared", dictionary: siteData)
                        
                        site.latitude = self.findFloat("latitude", dictionary:siteData)
                        site.longitude = self.findFloat("longitude", dictionary:siteData)

                        var neighbors = self.findNSArray("neighbors", dictionary: siteData)

                        if neighbors?.count > 0{
                            
                            site.neighbors = Array<String>()
                            
                            for var i = 0; i < neighbors?.count; i++ {
                                var neighborData = neighbors!.objectAtIndex(i) as! NSDictionary
                                var neighbor = self.findString("siteIdentifier", dictionary:neighborData)
                                site.neighbors!.append(neighbor!)
                            }
                        }
                        
                        var mediaArray = self.findNSArray("media", dictionary: siteData)
                        
                        for var i = 0; i < mediaArray?.count; i++ {
                            var mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            var url = self.findString("imgUrl", dictionary:mediaData)
                            var type = self.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = self.findUIColor("domainColor", dictionary: mediaData)
                            var media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                            site.media.append(media)
                        }
                        
                        var showcases = self.findNSArray("showcases", dictionary: siteData)
                        
                        if showcases?.count > 0 {
                            
                            site.showcases = Array<BNShowcase>()
                            
                            for var i = 0; i < showcases?.count; i++ {
                                var showcaseData = showcases!.objectAtIndex(i) as! NSDictionary
                                var identifier = self.findString("identifier", dictionary:showcaseData)
                                var showcase = BNShowcase()
                                showcase.identifier = identifier
                                showcase.siteIdentifier = site.identifier!
                                site.showcases!.append(showcase)
                            }
                        }
          
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
                                biin.organizationIdentifier = self.findString("organizationIdentifier", dictionary: biinData)
                                
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
                                            
                                            //TEMPORAL: USE TO GET NOTIFICATION WHILE APP IS DOWN
                                            object.major = biin.major!
                                            object.minor = biin.minor!
                                            
                                            biin.objects!.append(object)
                                        }
                                    }
                                }
                                
                                /*
                                var showcases = self.findNSArray("showcases", dictionary: biinData)
                                
                                if showcases?.count > 0 {
                                    
                                    biin.showcases = Array<BNShowcase>()
                                    
                                    for var k = 0; k < showcases?.count; k++ {
                                        if let showcaseData = showcases!.objectAtIndex(k) as? NSDictionary {
                                            
                                            var showcase = BNShowcase()
                                            showcase.identifier = self.findString("showcaseIdentifier", dictionary: showcaseData)
                                            showcase.endTime = self.findNSDate("endTime", dictionary: showcaseData)
                                            showcase.startTime = self.findNSDate("startTime", dictionary: showcaseData)
                                            showcase.isDefault = self.findBool("isDefault", dictionary: showcaseData)
                                            showcase.isUserNotified = self.findBool("isUserNotified", dictionary: showcaseData)
                                            biin.showcases!.append(showcase)
                                            
                                        }
                                    }
                                }
                                */
                                site.biins.append(biin)
                            }
                        }
                        
                        /*
                        var loyaltyData = self.findNSDictionary("loyalty", dictionary: dataData)
                        var loyalty = BNLoyalty()
                        loyalty.isSubscribed = self.findBool("isSubscribed", dictionary: loyaltyData!)
                        
                        loyalty.isSubscribed = true
                        if loyalty.isSubscribed {
                            loyalty.points = 100// self.findInt("points", dictionary:loyaltyData!)!
                            //loyalty.subscriptionDate = self.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                            loyalty.level = self.findInt("level", dictionary:loyaltyData!)!
                            //TODO: Add achievements and badges.
                        }
    
                        site.loyalty = loyalty
                        */
                        self.delegateDM!.manager!(self, didReceivedSite:site)
                        
                        if self.isRequestTimerAllow {
                            self.runRequest()
                        }
                    }
                    
                    self.removeRequestOnCompleted(request.identifier)
                    
                } else {
                    
                    //Remove site when is not downloaded from site list and user categories.
                    BNAppSharedManager.instance.dataManager.sites.removeValueForKey(psite.identifier!)
                    
                    for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
                        
                        if category.hasSites {
                            for var i = 0; i < category.sitesDetails.count; i++ {
                                if category.sitesDetails[i].identifier! == psite.identifier! {
                                    category.sitesDetails.removeAtIndex(i)
                                }
                            }
                        }
                    }
                    
                    self.removeRequestOnCompleted(request.identifier)

                }
            }
        })
    }
    
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    */
    func manager(manager: BNDataManager!, requestOrganizationData organization: BNOrganization, user: Biinie) {

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/organizations/\(organization.identifier!)", dataIdentifier:"userCategories", requestType:.OrganizationData)

        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestOrganizationData(request, organization:organization)
        }
    }
    
    /**
    Handles the request for a site's data.
    
    :param: The request to be process.
    */
    func requestOrganizationData(request:BNRequest, organization:BNOrganization) {
        
        println("\(request.requestString)")
        
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestOrganizationData()")
                println("\(error!.description)")
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {

                    var result = self.findBool("result", dictionary: data)

                    if result {
                        var organizationData = self.findNSDictionary("organization", dictionary: dataData)

                        
                        organization.name = self.findString("name", dictionary: organizationData!)
                        organization.brand = self.findString("brand", dictionary: organizationData!)
                        organization.extraInfo = self.findString("extraInfo", dictionary: organizationData!)
                        organization.organizationDescription = self.findString("description", dictionary: organizationData!)
                        
                        var mediaArray = self.findNSArray("media", dictionary: organizationData!)

                        for var i = 0; i < mediaArray?.count; i++ {
                            var mediaData = mediaArray!.objectAtIndex(i) as! NSDictionary
                            var url = self.findString("imgUrl", dictionary:mediaData)
                            var type = self.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = self.findUIColor("domainColor", dictionary: mediaData)
                            var media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                            organization.media.append(media)
                        }
       
                        var loyaltyData = self.findNSDictionary("loyalty", dictionary: dataData)
                        var loyalty = BNLoyalty()
                        loyalty.isSubscribed = self.findBool("isSubscribed", dictionary: loyaltyData!)

                        loyalty.isSubscribed = true
                        
                        if loyalty.isSubscribed {
                            loyalty.points = self.findInt("points", dictionary:loyaltyData!)!
                            loyalty.subscriptionDate = self.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                            loyalty.level = self.findInt("level", dictionary:loyaltyData!)!
                        }
                        
                        organization.loyalty = loyalty
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)

            }
        })
    }

    
    
    
    func manager(manager: BNDataManager!, requestHighlightsData user: Biinie) {
        var showcase:BNShowcase?
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/highlights", dataIdentifier:"userHightlights", requestType:.HighlightsData)
            showcase = BNShowcase()
            request.showcase = showcase!
        self.requests[request.identifier] = request
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
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase, user:Biinie) {

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/showcases/\(showcase.identifier!)/", dataIdentifier:"userCategories", requestType:.ShowcaseData)
        request.showcase = showcase
        self.requests[request.identifier] = request
        self.requestShowcaseData(request, showcase:showcase)
    }
    
    /**
    Handles the request for a showcase's data.
    
    :param: The request to be process.
    */
    func requestShowcaseData(request:BNRequest, showcase:BNShowcase) {
        
        epsNetwork!.getJson(true, url: request.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on showcase data")
                self.handleFailedRequest(request, error: error)
            } else {
            
                if let showcaseData = data["data"] as? NSDictionary {
                
                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        showcase.identifier = self.findString("identifier", dictionary: showcaseData)
                        showcase.lastUpdate = self.findNSDate("lastUpdate", dictionary: showcaseData)
                        showcase.theme = self.findBNShowcaseTheme("theme", dictionary: showcaseData)
                        showcase.showcaseType = self.findBNShowcaseType("showcaseType", dictionary: showcaseData)
                        showcase.title = self.findString("title", dictionary: showcaseData)
                        showcase.subTitle = self.findString("subTitle", dictionary: showcaseData)
                        showcase.titleColor = self.findUIColor("titleColor", dictionary: showcaseData)!
                        var elements = self.findNSArray("elements", dictionary: showcaseData)

                        for var i = 0; i < elements?.count; i++ {
                            
                            var elementData:NSDictionary = elements!.objectAtIndex(i) as! NSDictionary
                            var element = BNElement()
                            element._id = self.findString("_id", dictionary: elementData)
                            element.identifier = self.findString("elementIdentifier", dictionary: elementData)
                            element.jsonUrl = self.findString("jsonUrl", dictionary: elementData)
                            element.userViewed = self.findBool("hasBeenSeen", dictionary: elementData)
                            element.color = UIColor.elementColor()
                            element.siteIdentifier = showcase.siteIdentifier!
                            showcase.elements.append(element)
                        }
                        
                        self.delegateDM!.manager!(self, didReceivedShowcase: showcase)
                        
                        if self.isRequestTimerAllow {
                            self.runRequest()
                        }
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

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/elements/\(element.identifier!)", dataIdentifier:"userCategories", requestType:.ElementData)
        request.element = element
        self.requests[request.identifier] = request
        self.self.requestElementData(request, element:element)
    }
    
    /**
    Conforms optional     optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:Biinie) {
    
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/elements/\(element.identifier!)", dataIdentifier:"userCategories", requestType:.ElementData)
        request.element = element
        self.requests[request.identifier] = request
        self.self.requestElementData(request, element:element)
    }
    
    
    /**
    Handles the request for a element's data for a user.
    
    :param: The request to be process.
    */
    func requestElementData(request:BNRequest, element:BNElement) {

        var response:BNResponse?
        
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on element data")
                self.handleFailedRequest(request, error: error )
                
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
                println("*** element data SUCK - FAILED!")
                
            } else {
                
                if let elementData = data["data"] as? NSDictionary {

                    var status = self.findInt("status", dictionary: data)
                    var result = self.findBool("result", dictionary: data)
                    
                    if result {
                        element.isDownloadCompleted = true
                        element.identifier = self.findString("identifier", dictionary: elementData)
                        //println("Processing: \(element.identifier!)")
                        element.elementType = self.findBNElementType("elementType", dictionary: elementData)
                        element.position = self.findInt("position", dictionary: elementData)
                        element.title = self.findString("title", dictionary: elementData)
                        element.subTitle = self.findString("subTitle", dictionary: elementData)
                        element.nutshellDescriptionTitle = self.findString("nutshellDescriptionTitle", dictionary: elementData)
                        element.nutshellDescription = self.findString("nutshellDescription", dictionary: elementData)
                        element.titleColor = self.findUIColor("titleColor", dictionary: elementData)!
                        element.currency = self.findCurrency("currencyType", dictionary: elementData)
                        element.color = UIColor.elementColor()
                        //element.socialButtonsColor = self.findUIColor("socialButtonsColor", dictionary: elementData)!
                        
                        element.hasFromPrice = self.findBool("hasFromPrice", dictionary: elementData)
                        if element.hasFromPrice {
                            element.fromPrice = self.findString("fromPrice", dictionary: elementData)
                        }
                        
                        element.hasListPrice = self.findBool("hasListPrice", dictionary: elementData)
                        if element.hasListPrice {
                            element.listPrice = self.findString("listPrice", dictionary: elementData)
                        }
                        
                        element.hasDiscount = self.findBool("hasDiscount", dictionary: elementData)
                        if element.hasDiscount {
                            element.discount = self.findString("discount", dictionary: elementData)
                        }

                        element.hasPrice = self.findBool("hasPrice", dictionary: elementData)
                        if element.hasPrice {
                            element.price = self.findString("price", dictionary: elementData)
                        }

                        element.hasSaving = self.findBool("hasSaving", dictionary: elementData)
                        if element.hasSaving {
                            element.savings = self.findString("savings", dictionary: elementData)                        
                        }
                        
                        request.element!.hasTimming = self.findBool("hasTimming", dictionary: elementData)
                        if element.hasTimming {
                            element.initialDate = self.findNSDate("initialDate", dictionary: elementData)
                            element.expirationDate = self.findNSDate("expirationDate", dictionary: elementData)
                        }
                        
                        element.hasQuantity = self.findBool("hasQuantity", dictionary: elementData)
                        if element.hasQuantity {
                            element.quantity = self.findString("quantity", dictionary: elementData)
                            element.reservedQuantity = self.findString("reservedQuantity", dictionary: elementData)
                            element.claimedQuantity = self.findString("claimedQuantity", dictionary: elementData)
                            element.actualQuantity = self.findString("actualQuantity", dictionary: elementData)
                        }
                        
                        element.isHighlight = self.findBool("isHighlight", dictionary: elementData)
                        
                        var details = self.findNSArray("details", dictionary: elementData)

                        for var i = 0; i < details?.count; i++ {
                            var detailData = details!.objectAtIndex(i) as! NSDictionary

                            var detail = BNElementDetail()
                            detail.text = self.findString("text", dictionary: detailData)!
                            detail.elementDetailType = self.findBNElementDetailType("elementDetailType", dictionary: detailData)
                            
                            if (detail.elementDetailType! == BNElementDetailType.ListItem){
                                
                                var body = self.findNSArray("body", dictionary: detailData)
                                detail.body = Array<String>()
                                
                                for (var i = 0; i < body?.count; i++) {
                                    var line = body!.objectAtIndex(i) as! NSDictionary
                                    detail.body!.append( self.findString("line", dictionary:line)! )
                                }
                                
                            }
                            
                            if (detail.elementDetailType! == BNElementDetailType.PriceList){
                                
                                var body = self.findNSArray("body", dictionary: detailData)
                                detail.priceList = Array<BNElementDetail_PriceLlist>()
                                
                                //detail.body = Array<String>()
                                
                                for (var i = 0; i < body?.count; i++) {
                                    var line = body!.objectAtIndex(i) as! NSDictionary
                                    var priceListItem = BNElementDetail_PriceLlist()
                                    priceListItem.currency = self.findCurrency("currencyType", dictionary: line)
                                    priceListItem.description = self.findString("description", dictionary: line)
                                    priceListItem.price = self.findString("line", dictionary: line)
                                    detail.priceList!.append(priceListItem)

//                                    detail.priceList!.append( self.findString("line", dictionary:line)! )
                                }
                                
                            }
                            
                            
                            element.details.append(detail)
                        }
                        
                        var mediaArray = self.findNSArray("media", dictionary: elementData)
                        
                        for var j = 0; j < mediaArray?.count; j++ {
                            var mediaData = mediaArray!.objectAtIndex(j) as! NSDictionary
                            var url = self.findString("url", dictionary: mediaData)!
                            var type = self.findMediaType("mediaType", dictionary: mediaData)
                            var domainColor = self.findUIColor("domainColor", dictionary:mediaData)
                            var media = BNMedia(mediaType:type, url:url, domainColor:domainColor!)
                            element.media.append(media)
                            
    //                        var image = UIImageView(image:UIImage(named:"view3.jpg"))
    //                        element.gallery.append(image)
    //                        
    //                        BNAppSharedManager.instance.networkManager.requestImageData(url, image:image)
                        }
                        /*
                        element.activateNotification = self.findBool("activateNotification", dictionary: elementData)

                        if (element.activateNotification){
                            
                            element.notifications = Array<BNNotification>()
                            
                            var notificationArray = self.findNSArray("notifications", dictionary: elementData)
                            
                            for (var k = 0; k < notificationArray?.count; k++){
                                var notificationData = notificationArray!.objectAtIndex(k) as NSDictionary
                                
                                var isActive = self.findBool("isActive", dictionary: notificationData)
                                var type = self.findNotificationType("notificationType", dictionary: notificationData)
                                var text = self.findString("text", dictionary: notificationData)
                                
                                var notification = BNNotification(isActive: isActive, notificationType:type, text:text!)
                                element.notifications!.append(notification)
                            }
                        }
    //                    element.showNotification = self.findBool("showNotification", dictionary: elementData)
    //                    element.hasNotification = self.findBool("hasNotification", dictionary: elementData)
                        */
                        element.biinedCount = self.findInt("biinedCount", dictionary: elementData)!
                        element.commentedCount = self.findInt("commentedCount", dictionary: elementData)!
                        element.userBiined = self.findBool("userBiined", dictionary: elementData)
                        element.userShared = self.findBool("userShared", dictionary: elementData)
                        element.userCommented = self.findBool("userCommented", dictionary: elementData)
                        request.element!.userViewed = self.findBool("userViewed", dictionary: elementData)
                        
                        var hasSticker = self.findBool("hasSticker", dictionary: elementData)
                        
                        if (hasSticker) {
                            if let stickerData = elementData["sticker"] as? NSDictionary {
                                element.hasSticker = hasSticker
                                var stickerColor = self.findUIColor("color", dictionary: stickerData)
                                var stickerType = self.findBNStickerType("type", dictionary: stickerData)
                                var sticker = BNSticker(type:stickerType, color:stickerColor!)
                                element.sticker = sticker
                            }
                        }
                        

                        println("Element url: \(request.requestString)")
                        
                        if element.isHighlight {
                           self.delegateDM!.manager!(self, didReceivedHightlight:element)
                        } else {
                            self.delegateDM!.manager!(self, didReceivedElement:element)
                        }
                        

                        
                        if self.isRequestTimerAllow {
                            self.runRequest()
                        }
                        
                        
                    }
                }
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    ///Conforms optional func manager(manager: BNDataManager!, requestBiinedElementListForBNUser user: BNUser) of BNDataManagerDelegate.
    func manager(manager: BNDataManager!, requestBiinedElementListForBNUser user: Biinie) {
        
        var request = BNRequest(requestString:biinedElements, dataIdentifier:user.email!, requestType:.BiinedElements)
//        self.requests[request.identifier] = request
//        
//        if !isRequestTimerAllow {
//            self.requestBiinedElementListForBNUser(request)
//        }
    }
    
    ///Handles the request for user biined element's data.
    ///
    ///:param: The request to be process.
    func requestBiinedElementListForBNUser(request:BNRequest) {
    
        epsNetwork!.getJson(true, url: request.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on user elements biined data")
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var elementList = Array<BNElement>()
                    
                    var elements = self.findNSArray("elements", dictionary: dataData)
                    
                    for var i = 0; i < elements?.count; i++ {
                        
                        var elementData = elements!.objectAtIndex(i) as! NSDictionary
                        var element = BNElement()
                        element._id = self.findString("_id", dictionary: elementData)
                        element.identifier = self.findString("elementIdentifier", dictionary: elementData)
                        element.jsonUrl = self.findString("jsonUrl", dictionary: elementData)
                        elementList.append(element)
                    }
                    
                    self.delegateDM!.manager!(self, didReceivedBiinedElementList: elementList)
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    ///Conforms optional func manager(manager: BNDataManager!, requestBoardsForBNUser user: BNUser) of BNDataManagerDelegate.
    func manager(manager: BNDataManager!, requestCollectionsForBNUser user: Biinie) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/collections", dataIdentifier: "", requestType:.Collections)
        self.requests[request.identifier] = request
        self.requestCollectionsForBNUser(request)
        
    }
    
    func requestCollectionsForBNUser(request:BNRequest) {
        
        println("requestCollectionsForBNUser() url: \(request.requestString)")
        
        epsNetwork!.getJson(true, url: request.requestString, callback: {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var result = self.findBool("result", dictionary: data)

                    if result {
                        
                        var collectionList = Array<BNCollection>()
                        var collections = self.findNSArray("biinieCollections", dictionary: dataData)

                        println("number of collections: \(collections?.count)")
                        
                        for var i = 0; i < collections?.count; i++ {
                            
                            var collectionData = collections!.objectAtIndex(i) as! NSDictionary
                            var collection = BNCollection()
                            collection.identifier = self.findString("identifier", dictionary: collectionData)
                            collection.title = NSLocalizedString("CollectionTitle", comment: "CollectionTitle")
                            collection.subTitle = NSLocalizedString("CollectionSubTitle", comment: "CollectionSubTitle")
                            
                            //board.isMine = self.findBool("isMine", dictionary: boardData)
                        
    //                        if !board.isMine {
    //                            var owner = BNUser()
    //                            var ownerData = boardData["owner"] as NSDictionary
    //                            owner.identifier = self.findString("identifier", dictionary: ownerData)
    //                            owner.firstName = self.findString("firstName", dictionary: ownerData)
    //                            owner.lastName = self.findString("lastName", dictionary: ownerData)
    //                            owner.email = self.findString("email", dictionary: ownerData)
    //                            owner.imgUrl = self.findString("imgUrl", dictionary: ownerData)
    //                            board.owner = owner
    //                        }
                            
                            var elements = self.findNSArray("elements", dictionary: collectionData)
                            collection.items = Array<String>()
                            
                            if elements?.count > 0 {

                                collection.elements = Dictionary<String, BNElement>()
                                
                                for ( var j = 0; j < elements?.count; j++ ) {
                                    var elementData = elements!.objectAtIndex(j) as! NSDictionary
                                    var element = BNElement()
                                    element.identifier = self.findString("identifier", dictionary: elementData)
                                    element._id = self.findString("_id", dictionary: elementData)
                                    collection.elements[element.identifier!] = element
                                    collection.items.append(element.identifier!)
                                }
                            }
                            
                            var sites = self.findNSArray("sites", dictionary: collectionData)
                            
                            if sites?.count > 0 {
                                
                                collection.sites = Dictionary<String, BNSite>()
                                
                                for ( var i = 0; i < sites?.count; i++ ) {
                                    var siteData = sites!.objectAtIndex(i) as! NSDictionary
                                    var site = BNSite()
                                    site.identifier = self.findString("identifier", dictionary: siteData)
                                    collection.sites[site.identifier!] = site
                                    collection.items.append(site.identifier!)
                                }
                            }
                            
                            
                            /*
                            var biinies = self.findNSArray("biinies", dictionary: boardData)
                            
                            if biinies?.count > 0 {
                                board.biinies = Array<BNUser>()
                                
                                for var k = 0; k < biinies!.count; k++ {
                                    var biinieData = biinies!.objectAtIndex(k) as NSDictionary
                                    var biinie = BNUser()
                                    biinie.identifier = self.findString("identifier", dictionary: biinieData)
                                    //biinie.biinName = self.findString("biinName", dictionary: biinieData)
                                    biinie.firstName = self.findString("firstName", dictionary: biinieData)
                                    biinie.lastName = self.findString("lastName", dictionary: biinieData)
                                    biinie.email = self.findString("email", dictionary: biinieData)
                                    biinie.imgUrl = self.findString("imgUrl", dictionary: biinieData)
                                    //biinie.biins = self.findInt("biins", dictionary: biinieData)
                                    //biinie.following = self.findInt("following", dictionary: biinieData)
                                    //biinie.followers = self.findInt("followers", dictionary: biinieData)
                                    //board.biinies!.append(biinie)
                                }
                            }
                            */
                            
                            collectionList.append(collection)

                        }
                        
                        self.delegateDM!.manager!(self, didReceivedCollections: collectionList)
                    }
                
                } else {
                    println("NOT COLLECTION FOR \(request.requestString)")
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
    }
    
    
    func sendBiinedElement(user: Biinie, element: BNElement, collectionIdentifier:String) {
        
        println("saveBiinedElement(\(user.email)) element: \(element.identifier!)")

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)", dataIdentifier: "", requestType:.SendBiinedElement)
        self.requests[request.identifier] = request
        
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
        self.requests[request.identifier] = request
        
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

        self.requests[request.identifier] = request
        
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
        self.requests[request.identifier] = request
        
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
        self.requests[request.identifier] = request
        
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
        self.requests[request.identifier] = request
        
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
    
    
    func sendNotifiedObject(user: Biinie, biin: BNBiin, object:BNBiinObject) {
        
        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/biin/\(biin.identifier!)/object/\(object.identifier!)/notified", dataIdentifier: "", requestType:.SendNotifiedObject)
        self.requests[request.identifier] = request
        
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
        self.requests[request.identifier] = request
    
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
        self.requests[request.identifier] = request
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
            self.requests[request.identifier] = request
            
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
    
    func manager(manager:BNDataManager!, requestBiinieData biinie:Biinie) {

        var request = BNRequest(requestString:"\(rootURL)/mobile/biinies/\(biinie.identifier!)", dataIdentifier:biinie.identifier!, requestType:.BiinieData)
        self.requests[request.identifier] = request
        self.requestBiinieData(request, biinie:biinie)
    }

    func requestBiinieData(request:BNRequest, biinie:Biinie) {
     
        epsNetwork!.getJson(false, url: request.requestString, callback:{
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on biinie data")
                self.handleFailedRequest(request, error: error )
            } else {
                
                if let biinieData = data["data"] as? NSDictionary {

                    biinie.identifier = self.findString("identifier", dictionary:biinieData)
                    biinie.biinName = self.findString("biinName", dictionary: biinieData)
                    biinie.firstName = self.findString("firstName", dictionary: biinieData)
                    biinie.lastName = self.findString("lastName", dictionary: biinieData)
                    biinie.email = self.findString("email", dictionary: biinieData)
                    biinie.imgUrl = self.findString("imgUrl", dictionary: biinieData)
                    biinie.gender = self.findString("gender", dictionary: biinieData)
                    biinie.isEmailVerified = self.findBool("isEmailVerified", dictionary: biinieData)
                    biinie.birthDate = self.findNSDate("birthDate", dictionary: biinieData)
                
                    var friends = self.findNSArray("friends", dictionary: biinieData)
                    var categories = Array<BNCategory>()
                    var categoriesData = self.findNSArray("categories", dictionary: biinieData)
                    
                    for var i = 0; i < categoriesData?.count; i++ {
                        
                        var categoryData = categoriesData!.objectAtIndex(i) as! NSDictionary
                        var category = BNCategory(identifier: self.findString("identifier", dictionary: categoryData)!)
                        
                        category.name = self.findString("name", dictionary: categoryData)
                        
                        categories.append(category)
                    }

                    biinie.categories = categories
                    self.delegateDM!.manager!(self, didReceivedBiinieData: biinie)
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        })
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
                self.requestRegions(request)
                break
            case .RegionData:
                self.requestRegionData(request)
                break
            case .UserCategories:
                self.requestUserCategoriesData(request)
                break
            case .SiteData:
                //self.requestSiteData(request)
                break
            case .ShowcaseData:
                self.requestShowcaseData(request, showcase:request.showcase!)
                break
            case .ElementData:
                self.requestElementData(request, element:request.element!)
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
            
            println("NOT requests pending: \(self.requests.count)")
            self.delegateVC!.manager!(self, didReceivedAllInitialData: true)
            
            if BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA {
                BNAppSharedManager.instance.mainViewController!.refresh()
                BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA = false
            }
            
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
    func findBool(name:String, dictionary:NSDictionary) -> Bool {
        var value = self.findInt(name, dictionary: dictionary)

        if value == 1 {
            return true
        } else {
            return false
        }
    }
    
    func findInt(name:String, dictionary:NSDictionary) ->Int? {
        return (dictionary[name] as? String)?.toInt()
    }

    func findFloat(name:String, dictionary:NSDictionary) ->Float? {
        return NSString(string:(dictionary[name] as? String)!).floatValue
    }
    
    func findString(name:String, dictionary:NSDictionary) ->String? {
        return dictionary[name] as? String
    }
    
    func findNSDictionary(name:String, dictionary:NSDictionary) ->NSDictionary? {
        return dictionary[name] as? NSDictionary
    }
    
    func findNSArray(name:String, dictionary:NSDictionary) ->NSArray? {
        return dictionary[name] as? NSArray
    }
    
    func findNSUUID(name:String, dictionary:NSDictionary) ->NSUUID? {
        var uuid:NSUUID?
        uuid = NSUUID(UUIDString:(dictionary[name] as? String)!)
        return uuid
    }
    
    func findNSDate(name:String, dictionary:NSDictionary) ->NSDate? {
        var date:NSDate? = NSDate(dateString:(dictionary[name] as? String)!)
        return date
    }
    
    func findBNBiinType(name:String, dictionary:NSDictionary) -> BNBiinType {
        var value:Int = self.findInt(name, dictionary: dictionary)!
        switch value {
        case 0:
            return BNBiinType.NONE
        case 1:
            return BNBiinType.EXTERNO
        case 2:
            return BNBiinType.INTERNO
        case 3:
            return BNBiinType.PRODUCT
        default:
            return BNBiinType.NONE
        }
    }
    
    func findBNElementType(name:String, dictionary:NSDictionary) -> BNElementType {
        var value = self.findInt(name, dictionary: dictionary)

        if value == 1 {
            return BNElementType.Simple
        } else if value == 2 {
            return BNElementType.Informative
        } else if value == 3 {
            return BNElementType.Benefit
        } else {
            return BNElementType.Simple
        }
    }
    
    func findBNElementDetailType(name:String, dictionary:NSDictionary) -> BNElementDetailType {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNElementDetailType.Title
        } else if value == 2 {
            return BNElementDetailType.Paragraph
        } else if value == 3 {
            return BNElementDetailType.Quote
        } else if value == 4 {
            return BNElementDetailType.ListItem
        } else if value == 5 {
            return BNElementDetailType.Link
        } else if value == 6 {
            return BNElementDetailType.PriceList
        } else {
            return BNElementDetailType.Title
        }
    }
    
    func findBNShowcaseTheme(name:String, dictionary:NSDictionary) -> BNShowcaseTheme {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNShowcaseTheme.Dark
        } else if value == 2 {
            return BNShowcaseTheme.Light
        } else {
            return BNShowcaseTheme.Light
        }
    }
    
    func findBNShowcaseType(name:String, dictionary:NSDictionary) -> BNShowcaseType {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNShowcaseType.SimpleProduct
        } else if value == 2 {
            return BNShowcaseType.MultipleProduct
        } else {
            return BNShowcaseType.SimpleProduct
        }
    }
    
    
    func findBNStickerType(name:String, dictionary:NSDictionary) -> BNStickerType {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNStickerType.CIRCLE_FREE
        } else if value == 2 {
            return BNStickerType.CIRCLE_SALE
        } else if value == 3 {
            return BNStickerType.CIRCLE_BEST_OFFER
        } else if value == 4 {
            return BNStickerType.CIRCLE_FREE_GIFT
        } else {
            return BNStickerType.NONE
        }
    }
    
    func findNotificationType(name:String, dictionary:NSDictionary) -> BNNotificationType {
        var value = self.findInt(name, dictionary: dictionary)
        if value == 1 {
            return BNNotificationType.STIMULUS
        } else if value == 2 {
            return BNNotificationType.ENGAGE
        } else if value == 3{
            return BNNotificationType.CONVERT
        } else {
            return BNNotificationType.STIMULUS
        }
    }
    
    func findMediaType(name:String, dictionary:NSDictionary) -> BNMediaType {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNMediaType.Image
        } else if value == 2 {
            return BNMediaType.Video
        } else {
            return BNMediaType.Image
        }
    }
    
    func findBiinObjectType(name:String, dictionary:NSDictionary) -> BNBiinObjectType {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNBiinObjectType.ELEMENT
        } else if value == 2 {
            return BNBiinObjectType.SHOWCASE
        } else {
            return BNBiinObjectType.NONE
        }
    }
    
    func findUIColor(name:String, dictionary:NSDictionary) ->UIColor? {
        return self.colorFromString(dictionary[name] as? String)
    }
    
    func findCurrency(name:String, dictionary:NSDictionary) -> String {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return "$"
        } else if value == 2 {
            return "¢"
        } else if value ==  3 {
            return "€"
        } else {
           return "$"
        }
    }
    
    
    func colorFromString(color:String?)->UIColor? {
        
        if color == nil || color == "" {
            return UIColor.appTextColor()
        }
        
        var r = ""
        var g = ""
        var b = ""
        
        var isNumber = false
        var counter = 0
        
        for c in color! {
            isNumber = false
            switch (c) {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if counter == 0 {
                    r.append(c)
                } else if counter == 1 {
                    g.append(c)
                } else if counter == 2 {
                    b.append(c)
                }
                continue
            case ",":
                counter++
                continue
            default:
                break
            }
        }
        
        return UIColor(red: (CGFloat(r.toInt()!) / 255), green: (CGFloat(g.toInt()!) / 255), blue:(CGFloat(b.toInt()!) / 255), alpha: 1.0)
    }
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
