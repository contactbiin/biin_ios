//  BNNetworkManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNNetworkManager:NSObject, BNDataManagerDelegate, BNErrorManagerDelegate {
    
    //URL requests with mocky
    //let connectibityUrl = "http://www.mocky.io/v2/546b66f21dc00bbc132cf175"
    //let regionsUrl = "http://www.mocky.io/v2/546b66d31dc00bbe132cf174"
    //let categoriesUrl = "http://www.mocky.io/v2/546b66a91dc00bb2132cf173"
    
    //URL from QA server (LUIS).
    //let connectibityUrl = "http://www.mocky.io/v2/546b66f21dc00bbc132cf175"
    //let regionsUrl = "https://biin-qa.herokuapp.com/mobile/regions"
    //let categoriesUrl = "http://biin-qa.herokuapp.com/mobile/categories"

    
    //URL requests
    let connectibityUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getConnectibity.json"
    let regionsUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getRegions.json"
    let categoriesUrl = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getCategories.json"
    let biinedElements = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getBiinedElements.json"
    let boards = "https://s3-us-west-2.amazonaws.com/biintest/BiinJsons/getBoards.json"
    
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
    
    init(errorManager:BNErrorManager) {
        //Initialize here any data or variables.
        super.init()
        self.errorManager = errorManager
        epsNetwork = EPSNetworking()
    }
    
    
    //Saving data
    func manager(manager: BNDataManager!, saveUserCategories user: BNUser) {
        
    }
    
    
    func checkConnectivity() {
        
        println("checkConnectivity()")
        var request = BNRequest(requestString:connectibityUrl, dataIdentifier: "", requestType:.ConnectivityCheck)
        self.requests[request.identifier] = request
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on regions data - Not connection available")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                println("Connection OK")
                self.delegateDM!.manager!(self, didReceivedConnectionStatus: true)
                self.removeRequestOnCompleted(request.identifier)
//                self.requests.removeValueForKey(request.identifier)
//                self.requestAttempts = 0
                
                //self.requestTimer = NSTimer(timeInterval: 1.0, target: self, selector: "runRequest", userInfo: nil, repeats: false)
                
                if self.isRequestTimerAllow {
                    self.requestTimer!.fire()
                }
            }
        }
    }
    
    func login(email:String, password:String){
        println("Trying login for (\(email))")
        
        var request = BNRequest(requestString:"https://www.biinapp.com/mobile/binnies/auth/\(email)/\(password)", dataIdentifier: "", requestType:.Login)
        self.requests[request.identifier] = request
        
        var response:BNResponse?
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on regions data")
                self.handleFailedRequest(request, error: error? )
                
                response = BNResponse(code:9, type: BNResponse_Type.RequestFailed)
                self.delegateVC!.manager!(self, didReceivedLoginValidation: response)
                println("*** Register for user \(email) SUCK - FAILED!")
                
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: dataData)
                    var result = self.findBool("result", dictionary: dataData)
                    var identifier = self.findString("identifier", dictionary: dataData)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        println("*** Login for user \(email) COOL!")
                        self.delegateDM!.manager!(self, didReceivedUserIdentifier: identifier)
                    } else {
                        response = BNResponse(code:status!, type: BNResponse_Type.Suck)
                        println("*** Login for user \(email) SUCK - NO USER!")
                    }
                    
                    self.delegateVC!.manager!(self, didReceivedLoginValidation: response)
                    //self.delegateDM!.manager!(self, didReceivedRegions: regions)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)
                
            }
        }

    }
    
    func register(user:BNUser) {
        
        println("login(\(user.email))")
        
        var request = BNRequest(requestString:"http://www.biinapp.com/mobile/binnies/\(user.firstName!)/\(user.lastName!)/\(user.email!)/\(user.password!)/\(user.gender!)", dataIdentifier: "", requestType:.Register)
        self.requests[request.identifier] = request
        
        var response:BNResponse?
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on regions data")
                self.handleFailedRequest(request, error: error? )
                
                response = BNResponse(code:10, type: BNResponse_Type.Suck)
                println("*** Register for user \(user.email!) SUCK - FAILED!")
                
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: dataData)
                    var result = self.findBool("result", dictionary: dataData)
                    var identifier = self.findString("identifier", dictionary: dataData)
                    
                    if result {
                        response = BNResponse(code:status!, type: BNResponse_Type.Cool)
                        println("*** Register for user \(user.email!) COOL!")
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
        }
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
                self.requestSiteData(value)
                break
            case .ShowcaseData:
                self.requestShowcaseData(value)
                break
            case .ElementData:
                self.requestElementData(value)
                break
            default:
                break
            }
            
            println("Request pending: \(requests.count)")
            return
        }
        
    }
    
    func manager(manager:BNDataManager!, checkIsEmailVerified identifier:String) {

        println("checkIsEmailVerified")
        
        var request = BNRequest(requestString:"https://www.biinapp.com/mobile/binnies/\(identifier)/isactivate", dataIdentifier: "", requestType:.CheckIsEmailVerified)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestRegions(request)
        }
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on regions data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var status = self.findInt("status", dictionary: dataData)
                    var result = self.findBool("result", dictionary: dataData)
                    
                    if result {
                        println("*** the email for \(identifier) IS verified!")
                    } else {
                        println("*** the email for \(identifier) IS NOT verified!")
                    }
                    
                    self.delegateDM!.manager!(self, didReceivedEmailVerification: result)
                    
                    if self.isRequestTimerAllow {
                        self.runRequest()
                    }
                }
                
                self.removeRequestOnCompleted(request.identifier)

            }
        }
    }

    
    
    //BNDataManagerDelegate - Methods to conform on BNNetworkManager
    ///Creates a request for all regions and calls the requestRegions(request:BNRequest) method to handle the request.
    func requestRegions() {
        println("requestRegions")
        var request = BNRequest(requestString:regionsUrl, dataIdentifier: "", requestType:.Regions)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestRegions(request)
        }
    }
    
    ///Handles the request for all regions.
    ///
    ///1. If the request is succesfull it parses all of them in a nice array.
    ///2. Sends the array to the data manager for further processing (store and request monitoring).
    ///3. If the request fails it tells the error manager to process the failure.
    ///
    ///:param:The request to be process.
    func requestRegions(request:BNRequest) {
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on regions data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var regions:Array<BNRegion> = Array()
                    var regionsData = self.findNSArray("regions", dictionary: dataData)

                    for var i = 0; i < regionsData?.count; i++
                    {
                        var dictionary = regionsData!.objectAtIndex(i) as NSDictionary
                        var region = BNRegion()
                        region.identifier   = self.findString("identifier", dictionary: dictionary)?
                        region.radious      = self.findInt("radious", dictionary: dictionary)?
                        region.latitude     = self.findFloat("latitude", dictionary:dictionary)?
                        region.longitude    = self.findFloat("longitude", dictionary:dictionary)?
                        regions.append(region)
                    }

                    self.delegateDM!.manager!(self, didReceivedRegions: regions)
                    
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
    
    
    ///Conforms optional func manager(manager:BNDataManager!, requestRegionData identifier:String) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestRegionData identifier:String) {
        var request = BNRequest(requestString: "http://biin.herokuapp.com/api/regions/\(identifier)/biins", dataIdentifier:identifier, requestType:.RegionData)
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
 
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on biinie data")
                self.handleFailedRequest(request, error: error? )
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
        }
    }
    

    ///Conforms optional func manager(manager:BNDataManager!, requestUserCategoriesData user:BNUser) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestCategoriesData user:BNUser) {
        var request = BNRequest(requestString:categoriesUrl, dataIdentifier:"userCategories", requestType:.UserCategories)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestUserCategoriesData(request)
        }
    }
    
    ///Handles the request for a user categories data and packs the information on an array of BNCategory.
    ///
    ///:param: The request to be process.
    func requestUserCategoriesData(request:BNRequest) {
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestUserCategoriesData()")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var categories = Array<BNCategory>()
                    var categoriesData = self.findNSArray("categories", dictionary: dataData)
                    
                    for var i = 0; i < categoriesData?.count; i++ {

                        var categoryData = categoriesData!.objectAtIndex(i) as NSDictionary
                        var category = BNCategory(identifier: self.findString("identifier", dictionary: categoryData)!)

                        category.name = self.findString("name", dictionary: categoryData)
                        
                        var sites = self.findNSArray("sites", dictionary: categoryData)

                        for var j = 0; j < sites?.count; j++ {
                            
                            var siteData = sites!.objectAtIndex(j) as NSDictionary

                            //TODO: Add site details to category here.
                            var siteDetails = BNCategorySiteDetails()
                            siteDetails.identifier = self.findString("identifier", dictionary: siteData)
                            siteDetails.json = self.findString("jsonUrl", dictionary: siteData)
                            category.sitesDetails.append(siteDetails)
                            
                            //var site = BNSite()
                            //site.identifier = self.findString("identifier", dictionary: siteData)
                            //site.jsonUrl = self.findString("jsonUrl", dictionary: siteData)
                            //category.sites.append(site)
                        }
                        
                        categories.append(category)
                    }

                    self.delegateDM!.manager!(self, didReceivedUserCategories:categories)
                    
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
    
    ///Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestSiteData site:BNSite) {
        var request = BNRequest(requestString:site.jsonUrl!, dataIdentifier:site.identifier!, requestType:.SiteData)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestSiteData(request)
        }
    }
    
    ///Handles the request for a site's data.
    ///
    ///:param: The request to be process.
    func requestSiteData(request:BNRequest) {
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                println("Error on requestSiteData()")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var site = BNSite()
                    site.jsonUrl = request.requestString
                    site.identifier = self.findString("identifier", dictionary: dataData)
                    site.proximityUUID = self.findNSUUID("proximityUUID", dictionary: dataData)
                    site.major = self.findInt("major", dictionary: dataData)
                    site.title = self.findString("title", dictionary: dataData)
                    site.subTitle = self.findString("subTitle", dictionary: dataData)
                    site.titleColor = self.findUIColor("titleColor", dictionary: dataData)
                    site.country = self.findString("country", dictionary: dataData)
                    site.state = self.findString("state", dictionary: dataData)
                    site.city = self.findString("city", dictionary: dataData)
                    site.zipCode = self.findString("zipCode", dictionary: dataData)
                    site.streetAddress1 = self.findString("streetAddress1", dictionary: dataData)
                    site.streetAddress2 = self.findString("streetAddress2", dictionary: dataData)
                    
                    site.biinedCount = self.findInt("biinedCount", dictionary: dataData)!
                    site.comments = self.findInt("comments", dictionary: dataData)!
                    site.userBiined = self.findBool("userBiined", dictionary: dataData)
                    site.userCommented = self.findBool("userCommented", dictionary: dataData)
                    site.userShared = self.findBool("userShared", dictionary: dataData)
                    
                    site.latitude = self.findFloat("latitude", dictionary:dataData)
                    site.longitude = self.findFloat("longitude", dictionary:dataData)
                    
                    var mediaArray = self.findNSArray("media", dictionary: dataData)
                    
                    for var i = 0; i < mediaArray?.count; i++ {
                        var mediaData = mediaArray!.objectAtIndex(i) as NSDictionary
                        var url = self.findString("url", dictionary:mediaData)
                        var type = self.findMediaType("mediaType", dictionary: mediaData)
                        var domainColor = self.findUIColor("domainColor", dictionary: mediaData)
                        var media = BNMedia(mediaType: type, url:url!, domainColor:domainColor!)
                        site.media.append(media)
                    }
                    
                    var biins = self.findNSArray("biins", dictionary: dataData)
                    
                    for var j = 0; j < biins?.count; j++ {
                        var biinData = biins!.objectAtIndex(j) as NSDictionary
                        var biin = BNBiin()
                        biin.identifier = self.findString("identifier", dictionary: biinData)
                        biin.minor = self.findInt("minor", dictionary: biinData)
                        biin.bnBiinType = self.findBNBiinType("biinType", dictionary: biinData)
                        biin.site = site
                        
                        var showcase = BNShowcase()
                        showcase.identifier = self.findString("showcaseIdentifier", dictionary: biinData)
                        showcase.lastUpdate = self.findNSDate("lastUpdate", dictionary:biinData)
                        showcase.jsonUrl = self.findString("jsonUrl", dictionary: biinData)
                        biin.showcase = showcase
                        site.biins.append(biin)
                    }

                    var loyaltyData = self.findNSDictionary("loyalty", dictionary: dataData)
                    var loyalty = BNLoyalty()
                    loyalty.isSubscribed = self.findBool("isSubscribed", dictionary: loyaltyData!)
                    
                    if loyalty.isSubscribed {
                        loyalty.points = self.findInt("points", dictionary:loyaltyData!)!
                        loyalty.subscriptionDate = self.findNSDate("subscriptionDate", dictionary:loyaltyData!)
                        loyalty.level = self.findInt("level", dictionary:loyaltyData!)!
                        //TODO: Add achievements and badges.
                    }

                    site.loyalty = loyalty
                    
                    self.delegateDM!.manager!(self, didReceivedSite: site)
                    
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
    
    ///Conforms optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase) {
        
        println("requestShowcaseData for:\(showcase.identifier!) ")
        
        var request = BNRequest(requestString:showcase.jsonUrl!, dataIdentifier:showcase.identifier!, requestType:.ShowcaseData)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestShowcaseData(request)
        }
    }
    
    ///Handles the request for a showcase's data.
    ///
    ///:param: The request to be process.
    func requestShowcaseData(request:BNRequest) {
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on showcase data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let showcaseData = data["data"] as? NSDictionary {
                    
                    var showcase = BNShowcase()
                    showcase.identifier = self.findString("identifier", dictionary: showcaseData)
                    showcase.lastUpdate = self.findNSDate("lastUpdate", dictionary: showcaseData)
                    showcase.theme = self.findBNShowcaseTheme("theme", dictionary: showcaseData)
                    showcase.showcaseType = self.findBNShowcaseType("showcaseType", dictionary: showcaseData)
                    showcase.title = self.findString("title", dictionary: showcaseData)
                    showcase.subTitle = self.findString("subTitle", dictionary: showcaseData)
                    showcase.titleColor = self.findUIColor("titleColor", dictionary: showcaseData)!
                    
                    var elements = self.findNSArray("elements", dictionary: showcaseData)

                    for var i = 0; i < elements?.count; i++ {

                        var elementData:NSDictionary = elements!.objectAtIndex(i) as NSDictionary
                        var element = BNElement()
                        element._id = self.findString("_id", dictionary: elementData)
                        element.identifier = self.findString("elementIdentifier", dictionary: elementData)
                        element.jsonUrl = self.findString("jsonUrl", dictionary: elementData)
                        showcase.elements.append(element)
                    }
                    
                    self.delegateDM!.manager!(self, didReceivedShowcase: showcase)
                    
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
    
    
    ///Conforms optional     optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) {
        //println("requestElementDataForBNUser for:\(element.identifier!) ")
        var request = BNRequest(requestString:element.jsonUrl!, dataIdentifier:element.identifier!, requestType:.ElementData)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestElementData(request)
        }
    }
    
    ///Handles the request for a element's data for a user.
    ///
    ///:param: The request to be process.
    func requestElementData(request:BNRequest) {
    
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on showcase data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let elementData = data["data"] as? NSDictionary {

                    var element = BNElement()
                    element.isDownloadCompleted = true
                    element.identifier = self.findString("identifier", dictionary: elementData)
                    //println("****** \(element.identifier!)")
                    element.elementType = self.findBNElementType("elementType", dictionary: elementData)
                    element.position = self.findInt("position", dictionary: elementData)
                    element.title = self.findString("title", dictionary: elementData)
                    element.subTitle = self.findString("subTitle", dictionary: elementData)
                    element.nutshellDescriptionTitle = self.findString("nutshellDescriptionTitle", dictionary: elementData)
                    element.nutshellDescription = self.findString("nutshellDescription", dictionary: elementData)
                    element.textColor = self.findUIColor("textColor", dictionary: elementData)!
                    //element.socialButtonsColor = self.findUIColor("socialButtonsColor", dictionary: elementData)!
                    element.hasListPrice = self.findBool("hasListPrice", dictionary: elementData)
                    
                    if element.hasListPrice {
                        element.listPrice = self.findString("listPrice", dictionary: elementData)
                    }
                    
                    element.hasDiscount = self.findBool("hasDiscount", dictionary: elementData)
                    
                    if element.hasDiscount {
                        element.discount = self.findString("discount", dictionary: elementData)
                        element.price = self.findString("price", dictionary: elementData)
                        element.savings = self.findString("savings", dictionary: elementData)
                    }
                    
                    element.hasTimming = self.findBool("hasTimming", dictionary: elementData)
        
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
                    
                    var details = self.findNSArray("details", dictionary: elementData)

                    for var i = 0; i < details?.count; i++ {
                        var detailData = details!.objectAtIndex(i) as NSDictionary

                        var detail = BNElementDetail()
                        detail.text = self.findString("text", dictionary: detailData)!
                        detail.elementDetailType = self.findBNElementDetailType("elementDetailType", dictionary: detailData)
                        
                        if (detail.elementDetailType! == BNElementDetailType.ListItem){
                            
                            var body = self.findNSArray("body", dictionary: detailData)
                            detail.body = Array<String>()
                            
                            for (var i = 0; i < body?.count; i++) {
                                var line = body!.objectAtIndex(i) as NSDictionary
                                detail.body!.append( self.findString("line", dictionary:line)! )
                            }
                            
                        }
                        
                        element.details.append(detail)
                    }
                    
                    var mediaArray = self.findNSArray("media", dictionary: elementData)
                    
                    for var j = 0; j < mediaArray?.count; j++ {
                        var mediaData = mediaArray!.objectAtIndex(j) as NSDictionary
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
                    element.biins = self.findInt("biins", dictionary: elementData)!
                    element.comments = self.findInt("comments", dictionary: elementData)!
                    element.userBiined = self.findBool("userBiined", dictionary: elementData)
                    element.userShared = self.findBool("userShared", dictionary: elementData)
                    element.userCommented = self.findBool("userCommented", dictionary: elementData)
                    element.userViewed = self.findBool("userViewed", dictionary: elementData)
                    
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
                    
                    self.delegateDM!.manager!(self, didReceivedElement: element)
                    
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
    
    ///Conforms optional func manager(manager: BNDataManager!, requestBiinedElementListForBNUser user: BNUser) of BNDataManagerDelegate.
    func manager(manager: BNDataManager!, requestBiinedElementListForBNUser user: BNUser) {
        
        var request = BNRequest(requestString:biinedElements, dataIdentifier:user.email!, requestType:.BiinedElements)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestBiinedElementListForBNUser(request)
        }
    }
    
    ///Handles the request for user biined element's data.
    ///
    ///:param: The request to be process.
    func requestBiinedElementListForBNUser(request:BNRequest) {
    
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on user elements biined data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var elementList = Array<BNElement>()
                    
                    var elements = self.findNSArray("elements", dictionary: dataData)
                    
                    for var i = 0; i < elements?.count; i++ {
                        
                        var elementData = elements!.objectAtIndex(i) as NSDictionary
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
        }
    }
    
    ///Conforms optional func manager(manager: BNDataManager!, requestBoardsForBNUser user: BNUser) of BNDataManagerDelegate.
    func manager(manager: BNDataManager!, requestBoardsForBNUser user: BNUser) {
        var request = BNRequest(requestString:boards, dataIdentifier:user.email!, requestType:.Boards)
        self.requests[request.identifier] = request
        
        if !isRequestTimerAllow {
            self.requestBoardsForBNUser(request)
        }
    }
    
    func requestBoardsForBNUser(request:BNRequest) {
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on user boards data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let dataData = data["data"] as? NSDictionary {
                    
                    var boardsList = Array<BNBoard>()
                    var boards = self.findNSArray("boards", dictionary: dataData)
//                    
                    for var i = 0; i < boards?.count; i++ {
                        
                        var boardData = boards!.objectAtIndex(i) as NSDictionary
                        var board = BNBoard()
                        board.identifier = self.findString("identifier", dictionary: boardData)
                        board.boardDescription = self.findString("boardDescription", dictionary: boardData)
                        board.name = self.findString("name", dictionary: boardData)
                        board.isMine = self.findBool("isMine", dictionary: boardData)
                    
                        if !board.isMine {
                            var owner = BNUser()
                            var ownerData = boardData["owner"] as NSDictionary
                            owner.identifier = self.findString("identifier", dictionary: ownerData)
                            owner.firstName = self.findString("firstName", dictionary: ownerData)
                            owner.lastName = self.findString("lastName", dictionary: ownerData)
                            owner.email = self.findString("email", dictionary: ownerData)
                            owner.imgUrl = self.findString("imgUrl", dictionary: ownerData)
                            board.owner = owner
                        }
                        
                        var elements = self.findNSArray("elements", dictionary: boardData)
                        
                        if elements?.count > 0 {

                            board.elements = Array<BNElement>()
                            
                            for ( var j = 0; j < elements?.count; j++ ) {
                                var elementData = elements!.objectAtIndex(j) as NSDictionary
                                var element = BNElement()
                                element.identifier = self.findString("identifier", dictionary: elementData)
                                element._id = self.findString("_id", dictionary: elementData)
                                element.jsonUrl = self.findString("jsonUrl", dictionary: elementData)
                                board.elements!.append(element)
                            }
                        }
                        
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
                        
                        boardsList.append(board)

                    }
                    
                    self.delegateDM!.manager!(self, didReceivedBoards: boardsList)
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    //TODO: Impelement later.
    ///Conforms optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) of BNDataManagerDelegate.
    func manager(manager:BNDataManager!, requestElementNotificationForBNUser element:BNElement, user:BNUser){
        println("requestElementNotificationForBNUser for:\(element.identifier!) ")
        var request = BNRequest(requestString:element.jsonUrl!, dataIdentifier:element.identifier!, requestType:.ShowcaseData)
        self.requests[request.identifier] = request
    
        self.requestElementNotificationForBNUser(request, element:element, user:user)
    }
    
    ///Handles the request for a element's notification for a user.
    ///
    ///:param: The request to be process.
    func requestElementNotificationForBNUser(request:BNRequest, element:BNElement, user:BNUser) {
        
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on showcase data")
                self.handleFailedRequest(request, error: error? )
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
        }
    }
    
    func manager(manager:BNDataManager!, requestImageData stringUrl:String, image:BNUIImageView) {
        
        var request = BNRequest(requestString: stringUrl, dataIdentifier:"", requestType:.ImageData)
        self.requests[request.identifier] = request
        
        epsNetwork!.getImage(stringUrl, image:image, callback:{(error: NSError?) -> Void in
            if (error? == nil) {
//                self.requestAttempts = 0
                self.delegateVC?.refreshTable!(self)
//                self.requests.removeValueForKey(request.identifier)
                self.removeRequestOnCompleted(request.identifier)
            } else {
                self.handleFailedRequest(request, error:error? )
            }
        })
    }
    
    func requestImageData(stringUrl:String, image:BNUIImageView!) {

        println("image url:\(stringUrl)")
        
        var request = BNRequest(requestString: stringUrl, dataIdentifier:"", requestType:.ImageData)
        self.requests[request.identifier] = request
        
        epsNetwork!.getImage(stringUrl, image:image, callback:{(error: NSError?) -> Void in
            
                if (error == nil)  {
//                    self.requestAttempts = 0
//                    self.delegateVC?.refreshTable!(self)
//                    self.requests.removeValueForKey(request.identifier)
                    self.removeRequestOnCompleted(request.identifier)
                } else {
                    self.handleFailedRequest(request, error:error? )
                    println("ERROR on image request")
                }
            })

//        
//        var request = BNRequest(requestString: stringUrl, dataIdentifier:"", requestType:.ImageData)
//        let placeholder = UIImage(named: "view640X2.jpg")
//        let url = NSURL(string:stringUrl)
//        var requestURL = NSURLRequest(URL: url)
//        var weakImage:UIImageView = image
//        
//        image.setImageWithURLRequest(requestURL, placeholderImage:placeholder, { (request, response:NSHTTPURLResponse!, image:UIImage!) in
//            
//            weakImage.image = image
//            self.requestAttempts = 0
//            self.delegateVC?.refreshTable!(self)
//            
//            }, failure:{( requestURL, response:NSHTTPURLResponse!, error:NSError!) in
//                
//                self.handleFailedRequest(request, error: error )
//                
//            })
    }
    
    func manager(manager:BNDataManager!, requestBiinieData biinie:BNUser) {
        var request = BNRequest(requestString:"https://www.biinapp.com/mobile/binnies/\(biinie.identifier!)", dataIdentifier:biinie.identifier!, requestType:.BiinieData)
        self.requests[request.identifier] = request
        self.requestBiinieData(request)
    }

    func requestBiinieData(request:BNRequest) {
     
        epsNetwork!.getJson(request.requestString) {
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            if (error != nil) {
                println("Error on biinie data")
                self.handleFailedRequest(request, error: error? )
            } else {
                
                if let biinieData = data["data"] as? NSDictionary {
                    //if let biinieData = dataData["biinie"] as? NSDictionary {
                        
                        var biinie = BNUser()
                        biinie.identifier = self.findString("identifier", dictionary:biinieData)
                        biinie.biinName = self.findString("biinName", dictionary: biinieData)
                        biinie.firstName = self.findString("firstName", dictionary: biinieData)
                        biinie.lastName = self.findString("lastName", dictionary: biinieData)
                        biinie.email = self.findString("email", dictionary: biinieData)
                        biinie.imgUrl = self.findString("imgUrl", dictionary: biinieData)
                        //biinie.biins = self.findInt("biins", dictionary: biinieData)
                        //biinie.following = self.findInt("following", dictionary: biinieData)
                        //biinie.followers = self.findInt("followers", dictionary: biinieData)
                    
                        var friends = self.findNSArray("friends", dictionary: biinieData)
                        /*
                        if friends?.count > 0 {
                            
                            biinie.friends = Array<BNUser>()
                            
                            for var i = 0; i < friends?.count; i++
                            {
                                var dictionary:NSDictionary = friends!.objectAtIndex(i) as NSDictionary
                                var friend = BNUser()
                                friend.identifier = self.findString("identifier", dictionary: dictionary)
                                friend.name = self.findString("name", dictionary: dictionary)
                                friend.lastName = self.findString("lastName", dictionary: dictionary)
                                friend.email = self.findString("email", dictionary: dictionary)
                                friend.avatarUrl = self.findString("avatarUrl", dictionary: dictionary)
                                biinie.friends!.append(friend)
                            }
                        }
                        */
                        self.delegateDM!.manager!(self, didReceivedBiinieData: biinie)
                   // }
                }
                
                self.removeRequestOnCompleted(request.identifier)
            }
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
            self.errorManager!.showAlert(error?)
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
                self.requestSiteData(request)
                break
            case .ShowcaseData:
                self.requestShowcaseData(request)
                break
            case .ElementData:
                self.requestElementData(request)
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
        
//        AFHTTPRequestOperationManager().POST(url, parameters: parameters,
//            success: {
//                
//                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
//                println("JSON: " + responseObject.description)
//                
//            }, failure: {
//                (operation: AFHTTPRequestOperation!, error: NSError!) in
//                println("ERROR: " + error.description)
//            }
//        )
    }
    
    func removeRequestOnCompleted(identifier:Int){
        requests.removeValueForKey(identifier)
        requestAttempts = 0
        
        if requests.count == 0 {
            println("NOT requests pending: \(self.requests.count)")
            self.delegateVC!.manager!(self, didReceivedAllInitialData: true)
        }
        
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
        var date:NSDate? = NSDate(dateString:(dictionary[name] as String))
        return date
    }
    
    func findBNBiinType(name:String, dictionary:NSDictionary) -> BNBiinType {
        var value:Int = self.findInt(name, dictionary: dictionary)!
        switch value {
        case 1:
            return BNBiinType.Web
        case 2:
            return BNBiinType.Beacon
        default:
            return BNBiinType.Beacon
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
    
    func findUIColor(name:String, dictionary:NSDictionary) ->UIColor? {
        return self.colorFromString(dictionary[name] as? String)
    }
    
    func colorFromString(color:String?)->UIColor? {
        
        if color == nil {
            return nil
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
    
    //TEMP - Request Shared Biins
//    func requestShareBiins(){
//        var request = BNRequest(requestString:"http://www.mocky.io/v2/53a98d46038b011117e36c1c", dataIdentifier:"sharedBiins", requestType:.SharedBiins)
//        self.requests[request.identifier] = request
        //self.requestRegionData(request)
//    }
    
}

@objc protocol BNNetworkManagerDelegate:NSObjectProtocol {
    
    optional func manager(manager:BNNetworkManager!, didReceivedLoginValidation response:BNResponse?)
    optional func manager(manager:BNNetworkManager!, didReceivedUserIdentifier idetifier:String?)
    optional func manager(manager:BNNetworkManager!, didReceivedEmailVerification value:Bool)
    optional func manager(manager:BNNetworkManager!, didReceivedRegisterConfirmation response:BNResponse?)

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
    
    
    ///Takes user biined element list and process data and request to download elements.
    ///
    ///:param: BNNetworkManager.
    ///:param: BNElement list biined by user.
    optional func manager(manager:BNNetworkManager!, didReceivedBiinedElementList elementList:Array<BNElement>)
    
    
    ///Takes user boards and process data and request to download elements.
    ///
    ///:param: BNNetworkManager.
    ///:param: User boards.
    optional func manager(manager:BNNetworkManager!, didReceivedBoards boardsList:Array<BNBoard>)
    
    
    
    
    
    
    

    

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

    optional func manager(manager:BNNetworkManager!, didReceivedBiinieData user:BNUser)
    optional func manager(manager:BNNetworkManager!, removeShowcaseRelationShips identifier:String)
    optional func manager(manager:BNNetworkManager!, didReveivedSharedBiins biins:Array<BNBiin>, identifier:String )
    optional func refreshTable(manager:BNNetworkManager!)
}

extension NSDate {
    convenience init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    func isBefore(date:NSDate) -> Bool {
        
        if self.compare(date) == NSComparisonResult.OrderedAscending {
            return true
        } else {
            return false
        }
    }
}
