//  BNDataManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNDataManager:NSObject, BNNetworkManagerDelegate, BNPositionManagerDelegate {

    //var viewController:BNMain_ViewController? //temporal
    
    var errorManager:BNErrorManager
    var delegatePM:BNDataManagerDelegate?
    var delegateNM:BNDataManagerDelegate?
    
    //User data
    var bnUser:BNUser?
    
    var regions = Dictionary<String, BNRegion>()
    var sites = Dictionary<String, BNSite>()
    var showcases = Dictionary<String, BNShowcase>()
    var elements = Dictionary<String, BNElement>()
    var elementsRequested = Dictionary<String, BNElement>()
    var elementsBiined = Dictionary<String, String>()
    
    //var showcasesIdentifiersToRequest:Dictionary<String, String> = Dictionary<String, String>()
    var sharedBiins = Dictionary<String, BNBiin>()
    
    //var categories = Dictionary<String, BNCategory>()
    //var sections:Array<BNSection> = Array<BNSection>()
    
    var currentRegionIdentifier:String?
    
    var timer:NSTimer?
    
    init(errorManager:BNErrorManager){
        
        self.errorManager = errorManager
        
        super.init()
        
        //loadCategories()

        
    }
    
    deinit {
        
    }
    
    func requestInitialData(){
        
        //Request regions
        BNAppSharedManager.instance.networkManager.requestRegions()
        
        //TODO: temporal data
        bnUser = BNUser(identifier:"@epadilla", name: "Esteban", lastName: "Padilla", email: "epadilla@somemail.com")
        bnUser!.jsonUrl = "http://s3-us-west-2.amazonaws.com/biintest/BiinFakeJsons/biinies/@epadilla.json"
        
        //1. Request user biined data
        delegateNM!.manager!(self, requestBiinieData: bnUser!)
        
        //delegateNM!.manager!(self, requestBiinedElementListForBNUser: bnUser!)
        delegateNM!.manager!(self, requestBoardsForBNUser:bnUser!)
        
        //2. Request user categories data.
        delegateNM!.manager!(self, requestCategoriesData:bnUser!)
    }
    
    /*
    ///Loads all user categories data into sections to display in main view.
    func loadUserSections(){
        
//        println("loadUserSections()")
        sections.removeAll(keepCapacity: false)
        
        for category in bnUser!.categories {
            var section = BNSection()
            section.identifier = category.identifier!
//            println("section: \(category.identifier!)")
            
            for site in category.sites {
                var siteData = sites[site.identifier!]
                
//                println("site: \(site.identifier!)")
                
                for biin in siteData!.biins {
                    if biin.bnBiinType == BNBiinType.Web {
                        println("section: \(category.identifier!) site: \(site.identifier!) biin identifier: \(biin.identifier!) type:\(biin.bnBiinType.hashValue) showcase:\(biin.showcase!.identifier!)")
                        var data = BNSectionDetails()
                        data.showcase = biin.showcase!.identifier!
                        data.biin = biin.identifier!
                        data.site = site.identifier!
                        section.data.append(data)
                        continue
                    }
                }
            }
            sections.append(section)
        }
        
        
//        for section in sections {
//            for data in section.data {
//                
//                self.elements[self.showcases[data.showcase]!.elements[0].identifier!]!.gallery.append(UIImageView(image:UIImage(named:"view3.jpg")))
//                
////                elements[""].gallery.append(UIImageView(image:UIImage(named:"view3.jpg")))
//                
////                showcases[data.showcase]!.elements[0].gallery.append(UIImageView(image:UIImage(named:"view3.jpg")))
//            }
//        }
    }
    
    */
    
    
    /**
    Loads all categories available on the categories array.
    */
    /*
    func loadCategories() {
        categories["My Biins"] = BNCategory(identifier: "My Biins")
        categories["Personal Care"] = BNCategory(identifier: "Personal Care")
        categories["Vacation"]      = BNCategory(identifier: "Vacation")
        categories["Shoes"]         = BNCategory(identifier: "Shoes")
        categories["Games"]         = BNCategory(identifier: "Games")
        categories["Outdoors"]      = BNCategory(identifier: "Outdoors")
        categories["Health"]        = BNCategory(identifier: "Health")
        categories["Food"]          = BNCategory(identifier: "Food")
        categories["Sports"]        = BNCategory(identifier: "Sports")
        categories["Education"]     = BNCategory(identifier: "Education")
        categories["Fashion"]       = BNCategory(identifier: "Fashion")
        categories["Music"]         = BNCategory(identifier: "Music")
        categories["Movies"]        = BNCategory(identifier: "Movies")
        categories["Technology"]    = BNCategory(identifier: "Technology")
        categories["Entertaiment"]  = BNCategory(identifier: "Entertaiment")
        categories["Travel"]        = BNCategory(identifier: "Travel")
    }
    */
    
    
    
    //BNNetworkManagerDelegate
    /**
    Start initial network requests.
    :param: Network manager that handled the regions request.
    :param: Network status.
    */
    func manager(manager: BNNetworkManager!, didReceivedConnectionStatus status: Bool) {
        if status {
            requestInitialData()
        }
    }
    

    ///Stores regions and request monitoring (Geofancing) on all regions.
    ///:param: Network manager that handled request.
    ///:param: Regions received from web service in json format already parse in an nice array.
    func manager(manager:BNNetworkManager!, didReceivedRegions regions:Array<BNRegion>) {
        
        for region in regions {
            //Check if regions exist.
            if self.regions[region.identifier!] == nil {
                //Regions does not exist, store it.
                self.regions[region.identifier!] = region
            }
        }
        
        if self.regions.count > 0 {
            self.delegatePM!.manager!(self, startRegionsMonitoring:Array(self.regions.values))
        }

        //FIXME: This few lines are only for testing when not entering a regions.
//        self.currentRegionIdentifier = "bnHome"
//        self.delegateNM!.manager!(self, requestRegionData:self.currentRegionIdentifier!)
//        println("Request region: \(self.currentRegionIdentifier!)")
        
    }
    

    ///Receives user categories data and start requests depending on data store.
    ///:param: Network manager that handled the request.
    ///:param: Categories received from web service in json format already parse in an nice array.
    func manager(manager: BNNetworkManager!, didReceivedUserCategories categories: Array<BNCategory>) {

        bnUser!.categories.removeAll(keepCapacity: false)
        bnUser!.categories = categories
        
        for category in bnUser!.categories {
            
            println("Category received: \(category.identifier!) sites:\(category.sitesDetails.count)")
            
            for siteDetails in category.sitesDetails {
                //Check if site exist.
                if self.sites[siteDetails.identifier!] == nil {
                    
                    var site = BNSite()
                    site.identifier = siteDetails.identifier!
                    site.jsonUrl = siteDetails.json!
                    sites[siteDetails.identifier!] = site
                    //Site does not exist, store it and request it's data.
                    delegateNM!.manager!(self, requestSiteData: site)
                }
            }
        }
    }
    
    
    ///Received site and start proccesing depending on data store.
    ///:param: Network manager that handled the request.
    ///:param: BNSite received from web service in json format already parse in an site object.
    func manager(manager: BNNetworkManager!, didReceivedSite site: BNSite) {
        
        sites[site.identifier!] = site
        //println("site:\(site.identifier!) biins: \(site.biins.count)")
        
        if sites[site.identifier!] == nil {
            println("ERROR: Site: \(site.identifier!) was requested but not added to sites list.")
        }
        
        for biin in sites[site.identifier!]!.biins {
            //Check if showcase exist.
            if showcases[biin.showcase!.identifier!] == nil {
                //Showcase does not exist, store it and request it's data.
                showcases[biin.showcase!.identifier!] = biin.showcase!
                //println("CRASH: \(biin.showcase!.identifier!)")
                delegateNM!.manager!(self, requestShowcaseData:showcases[biin.showcase!.identifier!]!)
            }
        }
    }
    
    ///Received site and start proccesing depending on data store.
    ///:param: Network manager that handled the request.
    ///:param: BNShowcase received from web service in json format already parse in an showcase object.
    func manager(manager:BNNetworkManager!, didReceivedShowcase showcase:BNShowcase) {

        ///println("Received showcase: \(showcase.identifier!)")
        showcases[showcase.identifier!] = showcase
        showcases[showcase.identifier!]!.isRequestPending = false
        
        requestElements(showcase.elements)
        
        /*
        for element in showcase.elements {

            //Check if element exist.
            if elements[element._id!] == nil {
                //Element does not exist, store it and request it's data.
                elements[element._id!] = element
                
                //Check is element is has been requested by it's identifier
                if elementsRequestedIdentifiers[element.identifier!] == nil {
                    //println("rRequest element: \(element._id!) and \(element.identifier!)")
                    elementsRequestedIdentifiers[element.identifier!] = element.identifier!
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                }
            }
        }
        */
    }
    
    ///Received biined element list and start proccesing depending on data store.
    ///:param: Network manager that handled the request.
    ///:param: BNElement list received from web service in json format already parse in an array object.
    func manager(manager: BNNetworkManager!, didReceivedBiinedElementList elementList: Array<BNElement>) {
        
        for element in elementList {
            if elementsBiined[element._id!] == nil {
                elementsBiined[element._id!] = element._id!
            }
        }
        
        requestElements(elementList)
        /*
        for element in elementList {
            
            //Check if element exist.
            if elements[element._id!] == nil {
                //Element does not exist, store it and request it's data.
                elements[element._id!] = element
                
                //Check is element is has been requested by it's identifier
                if elementsRequestedIdentifiers[element.identifier!] == nil {
                    println("Request biined element: \(element._id!) and \(element.identifier!)")
                    elementsRequestedIdentifiers[element.identifier!] = element.identifier!
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                }
            }
        }
        */
    }
    
    func requestElements(elementList:Array<BNElement>){
        for element in elementList {
            
            //Check if element exist.
            if elements[element._id!] == nil {
                //Element does not exist, store it and request it's data.
                var newElement = BNElement()
                newElement.identifier = element.identifier!
                newElement._id = element._id
                newElement.jsonUrl = element.jsonUrl!
                elements[newElement._id!] = newElement
                
                //Check is element is has been requested by it's identifier
                if elementsRequested[element.identifier!] == nil {
                    //println("Request element: \(element._id!) and \(element.identifier!)")
                    elementsRequested[element.identifier!] = element
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                } else {
                    //println("############# element is already in list \(element.identifier!) for \(element._id!)")
                    var value = elementsRequested[element.identifier!]!.isDownloadCompleted
                    
                    if value {
                        manageElementRelationShips(elementsRequested[element.identifier!]!)
                    }else {
                        //println("Request element Pending: \(element._id!) and \(element.identifier!)")
//                        elementsRequestedIdentifiers[element.identifier!] = element
//                        delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                    }
                }
            }
        }
    }
    
    
    ///Received element and start proccesing depending on data store.
    ///:param: Network manager that handled the request.
    ///:param: BNElement received from web service in json format already parse in an element object.
    func manager(manager: BNNetworkManager!, didReceivedElement element: BNElement) {
        //println("Received element: \(element.identifier!) id:\(element._id?) media \(element.media.count)")
        elementsRequested[element.identifier!] = element
        manageElementRelationShips(element)
        
        /*
        //Checks if element received is reference on element and clone its self.
        for (key, value) in elements {
            if value.identifier! == element.identifier! {
                element._id = key
                elements[key] = element.clone()
                println("Stored element: \(elements[key]?.identifier!) id:\(elements[key]?._id!) media \(elements[key]?.media.count)")
            }
        }
        */
    }
    
    func manageElementRelationShips(element:BNElement){
        
        //Checks if element received is reference on element and clone it self.
        for (key, value) in elements {
            if value.identifier! == element.identifier! {
                element._id = key
                elements[key] = element.clone()
                //println("Stored element: \(elements[key]?.identifier!) id:\(elements[key]?._id!) media \(elements[key]?.media.count)")
            }
        }
    }
    
    
    func manager(manager: BNNetworkManager!, didReceivedBoards boardsList: Array<BNBoard>) {
        println("Received boards: \(boardsList.count)")
        
        if boardsList.count > 0 {
            
            bnUser!.boards = Dictionary<String, BNBoard>()
            
            for board in boardsList {
                
                if bnUser!.boards![board.identifier!] == nil {
                    bnUser!.boards![board.identifier!] = board
                }
                
                for element in board.elements! {
                    if elementsBiined[element._id!] == nil {
                        elementsBiined[element._id!] = element._id!
                    }
                }
                
                requestElements(board.elements!)
            }
        }
    }
    
    ///Receives a notification for a element.
    func manager(manager:BNNetworkManager!, didReceivedElementNotification notification:String, element:BNElement) {
        println("Received element notification update: \(element.identifier)")
    }
    
    
    //TODO: Temporal
    func startRegionMonitorOnRegionVC() {
        
        self.delegatePM!.manager!(self, startRegionsMonitoring:Array(self.regions.values))
    }

    func manager(manager:BNNetworkManager!, didReveivedBiinsOnRegion biins:Array<BNBiin>, identifier:String) {
        
        //1. Check if biin are in region.
        //1.2 If biin is not in region request showcase data if needed/
        //2. If biin is already in region check for lastupdate
        //2.2 If update is needed request showcase data
        
        var requestShowcaseData = false

        /*
        for biin in biins {
            
            if self.regions[identifier]!.biins[biin.identifier!] == nil
            {
                self.regions[identifier]!.biins[biin.identifier!] = biin
                requestShowcaseData = true
                
            }else if self.regions[identifier]!.biins[biin.identifier!]!.lastUpdate!.isBefore(biin.lastUpdate!) {

                //Add showcase identifiers to send a request,
                println("Region: \(identifier) - update biin: \(biin.identifier) showcase: \(biin.showcaseIdentifier)")
                
                self.regions[identifier]!.biins[biin.identifier!]!.lastUpdate = biin.lastUpdate!
                
                if showcasesIdentifiersToRequest[ biin.showcaseIdentifier! ] == nil {
                    showcasesIdentifiersToRequest[ biin.showcaseIdentifier! ] = biin.showcaseIdentifier!
                }
                
            }else {
                requestShowcaseData = false
            }
            
            if requestShowcaseData {
                    
                //Process showcase - add and request showcase data
                if self.showcases[biin.showcaseIdentifier!] != nil {
                    
                    if !self.showcases[biin.showcaseIdentifier!]!.isRequestPending {
                        //self.delegatePM!.manager!(self, startBiinMonitoring: biin)
                    }
                    
                } else {
                    
                    //Biins are added to list since they a new
                    self.delegateNM!.manager!(self, requestShowcaseData: biin.showcaseIdentifier!)
                    var showcase = BNShowcase()
                    showcase.identifier = biin.showcaseIdentifier!
                    self.showcases[biin.showcaseIdentifier!] = showcase
                }
            }
        }
        
        for showcaseIdentifier in showcasesIdentifiersToRequest.keys {
            self.delegateNM!.manager!(self, requestShowcaseData:showcaseIdentifier)
        }
        
        self.showcasesIdentifiersToRequest.removeAll(keepCapacity: false)
        */
        
    }
    
    func manager(manager:BNNetworkManager!, didReveivedSharedBiins biins:Array<BNBiin>, identifier:String ) {
        
        var requestShowcaseData = false
        
        /*
        for biin in biins {
            
            if self.sharedBiins[biin.identifier!] == nil
            {
                self.sharedBiins[biin.identifier!] = biin
                requestShowcaseData = true
                
            }else if self.sharedBiins[biin.identifier!]!.lastUpdate!.isBefore(biin.lastUpdate!) {
                
                //Add showcase identifiers to send a request,
                println("Region: \(identifier) - update biin: \(biin.identifier) showcase: \(biin.showcaseIdentifier)")
                
                self.sharedBiins[biin.identifier!]!.lastUpdate = biin.lastUpdate!
                
                if showcasesIdentifiersToRequest[ biin.showcaseIdentifier! ] != nil {
                    showcasesIdentifiersToRequest[ biin.showcaseIdentifier! ] = biin.showcaseIdentifier!
                }
                
            }else {
                requestShowcaseData = false
            }
            
            if requestShowcaseData {
                
                //Process showcase - add and request showcase data
                if self.showcases[biin.showcaseIdentifier!] != nil {
                    
                    if !self.showcases[biin.showcaseIdentifier!]!.isRequestPending {
                        //self.delegatePM!.manager!(self, startBiinMonitoring: biin)
                    }
                    
                } else {
                    
                    //Biins are added to list since they a new
                    self.delegateNM!.manager!(self, requestShowcaseData: biin.showcaseIdentifier!)
                    var showcase = BNShowcase()
                    showcase.identifier = biin.showcaseIdentifier!
                    self.showcases[biin.showcaseIdentifier!] = showcase
                }
            }
        }
        
        for showcaseIdentifier in showcasesIdentifiersToRequest.keys {
            self.delegateNM!.manager!(self, requestShowcaseData:showcaseIdentifier)
        }
        
        self.showcasesIdentifiersToRequest.removeAll(keepCapacity: false)
        */
    }
    
    
//    func refreshTable(manager:BNNetworkManager!)
//    {
//        self.viewController?.refreshTable()
//    }

    

    
    func manager(manager:BNNetworkManager!, didReceivedBiinieData user:BNUser) {

        if self.bnUser != nil {

            self.bnUser = user
        }
        
        println("user friends: \(bnUser!.friends!.count)")
        
        //for friend in self.bnUser!.friends! {
        //    self.delegateNM!.manager!(self, requestImageData:friend.avatarUrl!, image: friend.avatarImage!)
        //}
    }
    
        func manager(manager:BNNetworkManager!, removeShowcaseRelationShips identifier:String) {
    
        /*
        for (key, value) in self.regions["bnHome"]!.biins {
            if value.showcaseIdentifier == identifier {
                if let removedBiin = self.regions["bnHome"]!.biins.removeValueForKey(key) {
//                    println("Biin removed.")
                }else {
//                    println("Biin does not exist.")
                }
            }
        }
        
        if let removedShowcase = self.showcases.removeValueForKey(identifier) {
//            println("Showcase remove")
        }else {
//            println("Showcase does not exist.")
        }
        */
    }
    
    
    //BNPositionManagerDelegate
    
    func manager(manager:BNPositionManager!, startEnterRegionProcessWithIdentifier identifier:String)
    {
        println("** Requesting data for region: \(identifier)")
        
        if self.delegateNM is BNNetworkManagerDelegate
        {
            
            println("Requesting data for region: \(identifier)")
            self.delegateNM!.manager!(self, requestRegionData: identifier)
            self.currentRegionIdentifier = identifier
//            self.viewController?.reloadTable(self.regions[identifier]?.biins, dataManager:self)
        }
    }
    
    func manager(manager:BNPositionManager!, startExitRegionProcessWithIdentifier identifier:String)
    {
        currentRegionIdentifier = nil
    }
    
    func manager(manager:BNPositionManager!, markBiinAsDetectedWithUUID uuid:String)
    {
        
    }
    
    //TODO:Remove later
    func createTemporalShowcases() {
        
        var iconSite = BNSite()
        iconSite.identifier = "iCon"
        iconSite.title =  "iCon"
        iconSite.subTitle = "Multiplaza del Este"
        iconSite.titleColor = UIColor.bnRed()
        iconSite.subTitleColor = UIColor.whiteColor()
        sites[iconSite.identifier!] = iconSite
        
        var iconShowcase = BNShowcase()
        iconShowcase.identifier = "icon.identifier"
//        iconShowcase.site = iconSite
        showcases[iconShowcase.identifier!] = iconShowcase
        
        var iphone = BNElement()
        iphone.position = 1
        iphone.title = "iPhone"
        iphone.subTitle = "None"
        iconShowcase.elements.append(iphone)
        
        showcases["icon.identifier"] = iconShowcase
        
    }
    
    
    
    //Store data methods
    func addElementBiined(_id:String) -> Int{
        if elementsBiined[_id] == nil {
            elementsBiined[_id] = _id
            elements[_id]!.userBiined = true
            elements[_id]!.biins++
            println("\(elements[_id]!.biins)")
            return elements[_id]!.biins
            //TODO: Post user just biined an element
        }
        return 0
    }
}

@objc protocol BNDataManagerDelegate:NSObjectProtocol {
    
    //Methods to conform on BNNetworkManager
    
    ///Request a region's data.
    ///
    ///:param: BNDataManager that store all data.
    ///:param: Region's identifier requesting the data.
    optional func manager(manager:BNDataManager!, requestRegionData identifier:String)
    
    
    ///Request user categories.
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNUser requesting the data.
    optional func manager(manager:BNDataManager!, requestCategoriesData user:BNUser)
    
    
    ///Request a site's data
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNSite requesting the data.
    optional func manager(manager:BNDataManager!, requestSiteData site:BNSite)
    
    ///Request showcase's data
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNShowcase requesting the data.
    optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase)
    
    ///Request element's data for BNUser (app user)
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNElement requesting the data.
    ///:param: BNUser requesting the element's data.
    optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser)
    
    ///Request user biined element's.
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNUser requesting the element's data.
    optional func manager(manager:BNDataManager!, requestBiinedElementListForBNUser user:BNUser)
    
    
    ///Request user boards.
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNUser requesting the element's data.
    optional func manager(manager:BNDataManager!, requestBoardsForBNUser user:BNUser)
    
    
    ///Request user (biinie) data
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNUser requesting the element's data.
    optional func manager(manager:BNDataManager!, requestBiinieData biinie:BNUser)
    
    
    
    
    
    
    
    
    
    //NOT SURE IS NEEDED FROM HERE DOWN
    
    
    
    
    ///Request element's notification for a BNUser (app user)
    ///
    ///:param: BNDataManager that store all data.
    ///:param: BNElement requesting the data.
    ///:param: BNUser requesting the element's data.
    optional func manager(manager:BNDataManager!, requestElementNotificationForBNUser element:BNElement, user:BNUser)
    


    
    
    
    
    
    optional func manager(manager:BNDataManager!, requestImageData stringUrl:String, image:UIImageView!)
    
    
    
    optional func manager(manager:BNDataManager!, requestBiinieAvatar stringUrl:String, image:UIImageView)
    
    
    
    
    
    //Methods to conform on BNPositionManager
    optional func manager(manager:BNDataManager!, startRegionsMonitoring regions:Array<BNRegion>)
    optional func manager(manager:BNDataManager!, stopRegionsMonitoring regions:Array<BNRegion>)
    
    
    ///Request BNPositionManager to starts a site monitoring.
    ///
    ///:param: BNDataManager
    ///:param: Site to be monitor bu BNPositionManager.
    ///:returns: none
    optional func manager(manager:BNDataManager, startSiteMonitoring site:BNSite)
    
    ///Request position manager to stop a site monitoring.
    ///
    ///:param: Data manager that stores the sites.
    ///:param: Site to be monitor.
    ///:returns: none
    optional func manager(manager:BNDataManager, stopSiteMonitoring site:BNSite)
    
    //TODO: Remove this two methods later
    optional func manager(manager:BNDataManager!, startBiinMonitoring biin:BNBiin)
    optional func manager(manager:BNDataManager!, stopBiinMonitoring biin:BNBiin)
}

