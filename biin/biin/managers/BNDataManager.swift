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
    var bnUser:Biinie?
    var isUserLoaded = false
    
    //var regions = Dictionary<String, BNRegion>()
    var nearbySites = Array<String>()
    var favoritesSites = Array<String>()
    var favoritesElements = Array<String>()
    
    var sites = Dictionary<String, BNSite>()
    var sites_ordered = Array<BNSite>()
    var organizations = Dictionary<String, BNOrganization>()
    //var sites_OnBackground = Dictionary<String, BNSite>()
    var showcases = Dictionary<String, BNShowcase>()
    var elements_by_id = Dictionary<String, BNElement>() //list of virtual elements by _id (clones by _id)
    var elements_by_identifier = Dictionary<String, BNElement>()//List of element with data, not by _id
    var highlights = Array<BNHighlight>()//list of hightlight element
    //var availableBiins = Array<String>()//list of biins detected
    //var elementsBiined = Dictionary<String, String>()
    
    //var notifications = Array<BNNotification>()
    
    //var showcasesIdentifiersToRequest:Dictionary<String, String> = Dictionary<String, String>()
    //var sharedBiins = Dictionary<String, BNBiin>()
    
    var categories:Array<BNCategory>?/// = Dictionary<String, BNCategory>()
    //var sections:Array<BNSection> = Array<BNSection>()
    
    //var currentRegionIdentifier:String?
    
    //var timer:NSTimer?
    
    var commercialUUID:NSUUID?
    var privacyPolicy:String?
    var termOfService:String?
    
    init(errorManager:BNErrorManager){
        
        self.errorManager = errorManager
        
        super.init()
        
        loadCategories()
        
        loadBiinie()
    }
    
    func clean(){
        
        sites.removeAll()
        sites = Dictionary<String, BNSite>()

        sites_ordered.removeAll()
        sites_ordered = Array<BNSite>()
        
        organizations.removeAll()
        organizations = Dictionary<String, BNOrganization>()
        
        showcases.removeAll()
        showcases = Dictionary<String, BNShowcase>()
        
        elements_by_id.removeAll()
        elements_by_id = Dictionary<String, BNElement>() //list of virtual elements by _id (clones by _id)

        elements_by_identifier.removeAll()
        elements_by_identifier = Dictionary<String, BNElement>()//List of element with data, not by _id
        
        highlights.removeAll()
        highlights = Array<BNHighlight>()
    }
    
    func loadBiinie() {
        // Try loading a saved version first
        if let user = Biinie.loadSaved() {
            
            if user.firstName == "none" {
                isUserLoaded = false
            } else {
                bnUser = user
                isUserLoaded = true
                bnUser!.addAction(NSDate(), did:BiinieActionType.OPEN_APP, to:"biin_ios")
            }
        } else {
            isUserLoaded = false
            bnUser = Biinie(identifier:"", firstName: "none", lastName:"none", email: "none.com")
            bnUser!.isEmailVerified = false
            bnUser!.biinName = ""            
        }
    }
    
    deinit {
        
    }
    
    func requestBiinieInitialData(){
        
        //print("FLOW 4 - requestBiinieInitialData()")
        if isUserLoaded {
            
            delegateNM!.manager!(self, requestBiinieData: bnUser!)
            
            if bnUser!.email! == "ep@estebanpadilla.com"
                || bnUser!.email! == "demo@biin.io" {
                BNAppSharedManager.instance.IS_DEVELOPMENT_BUILD = true
            }
        }
    }
    
    func requestInitialData(){
        
        //print("FLOW 6 - requestInitialData()")
        delegateNM!.manager!(self, initialdata: bnUser!)
        
        //Changes request flow.
//        delegateNM!.manager!(self, requestCategoriesData: bnUser!)
//        delegateNM!.manager!(self, requestCollectionsForBNUser: bnUser!)
    }
    
    func requestDataOnWhenAppIsRunning(){
        BNAppSharedManager.instance.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
        //delegateNM!.manager!(self, requestCollectionsForBNUser: bnUser!)
    }
    

    
    /**
    Loads all categories available on the categories array.
    */
    func loadCategories() {
        categories = Array<BNCategory>()
        categories!.append(BNCategory(identifier: "category1", name: "Libros, Audio y peliculas"))
        categories!.append(BNCategory(identifier: "category2", name: "Entretenimiento"))
        categories!.append(BNCategory(identifier: "category3", name: "Belleza y Salud"))
        categories!.append(BNCategory(identifier: "category4", name: "Ropa y Zapatos Mujer"))
        categories!.append(BNCategory(identifier: "category5", name: "Ropa y Zapatos Niños"))
        categories!.append(BNCategory(identifier: "category6", name: "Ropa y Zapatos Hombre"))
        categories!.append(BNCategory(identifier: "category7", name: "Deportes y Outdoors"))
        categories!.append(BNCategory(identifier: "category8", name: "Hogar, Jardín y Ferretería"))
        categories!.append(BNCategory(identifier: "category9", name: "Tecnología"))
        categories!.append(BNCategory(identifier: "category10", name: "Juguetes y pasatiempos"))
        categories!.append(BNCategory(identifier: "category11", name: "Comida y Restaurantes"))
        categories!.append(BNCategory(identifier: "category12", name: "Automotriz e Indutrial"))
        categories!.append(BNCategory(identifier: "category13", name: "Joyería y Bisuteria"))
        categories!.append(BNCategory(identifier: "category14", name: "En el Super"))
        categories!.append(BNCategory(identifier: "category15", name: "Mascotas"))
        categories!.append(BNCategory(identifier: "category16", name: "Electrodomesticos"))
        categories!.append(BNCategory(identifier: "category17", name: "Muebles"))
        categories!.append(BNCategory(identifier: "category18", name: "Servicios"))
        /*
        categories!.append(BNCategory(identifier: "category16", name: "Ferias"))
        categories!.append(BNCategory(identifier: "category17", name: "Marcas"))
        categories!.append(BNCategory(identifier: "category18", name: "Actividades Masivas"))
        categories!.append(BNCategory(identifier: "category19", name: "GetAways"))
        categories!.append(BNCategory(identifier: "category20", name: "Educación"))
        categories!.append(BNCategory(identifier: "category21", name: "Museos y tours"))
        categories!.append(BNCategory(identifier: "category22", name: "Collecionables y Arte"))
        categories!.append(BNCategory(identifier: "category23", name: "Financiero"))
        categories!.append(BNCategory(identifier: "category24", name: "Instuticional"))
        categories!.append(BNCategory(identifier: "category25", name: "Salud"))
        */
    }
    
    func addElementToCategory(categoryIdentifier:String, element:BNElement){
        for category in self.bnUser!.categories {
            if category.identifier == categoryIdentifier {
                //category.elements[element.identifier!] = element
                continue
            }
        }
    }
    
    func addElementToCategoryByIndetifier(categoryIdentifier:String, elementIdentifier:String){
        for category in self.bnUser!.categories {
            if category.identifier == categoryIdentifier {
                //category.elements[elementIdentifier] = elements_by_id[elementIdentifier]
                continue
            }
        }
    }
    
    func startSitesMonitoring(){
        delegatePM!.manager!(self, startSitesMonitoring: true)
    }
    
    func startCommercialBiinMonitoring() {
        if commercialUUID != nil {
            delegatePM!.manager!(self, startCommercialBiinMonitoring:self.commercialUUID!)
        }
    }
    
    
    //BNNetworkManagerDelegate
    /**
    Start initial network requests.
    - parameter Network: manager that handled the regions request.
    - parameter Network: status.
    */
    func manager(manager: BNNetworkManager!, didReceivedConnectionStatus status: Bool) {
        
        //print("FLOW 3 - didReceivedConnectionStatus")
        if status && BNAppSharedManager.instance.IS_APP_UP {
            requestBiinieInitialData()
        } else if status && BNAppSharedManager.instance.IS_APP_DOWN {
            requestBiinieInitialData()
        }
    }
    
    func manager(manager: BNNetworkManager!, didReceivedUserIdentifier idetifier: String?) {

        bnUser!.identifier = idetifier
        bnUser!.save()
        isUserLoaded = true
    }
    
    func manager(manager: BNNetworkManager!, didReceivedEmailVerification value: Bool) {
        bnUser!.isEmailVerified = value
        bnUser!.save()
    }
    

    ///Stores regions and request monitoring (Geofancing) on all regions.
    ///- parameter Network: manager that handled request.
    ///- parameter Regions: received from web service in json format already parse in an nice array.
//    func manager(manager:BNNetworkManager!, didReceivedRegions regions:Array<BNRegion>) {
        //delegateNM!.manager!(self, requestCategoriesData: bnUser!)
//    }

    ///Receives user categories data and start requests depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter Categories: received from web service in json format already parse in an nice array.
    func manager(manager: BNNetworkManager!, didReceivedUserCategories categories: Array<BNCategory>) {
        
        bnUser!.categories.removeAll(keepCapacity: false)
        bnUser!.categories = Array<BNCategory>()
        
        for (_, site) in sites {
            site.showInView = false
        }

        for category in categories {
            

            category.name = findCategoryNameByIdentifier(category.identifier!)
            
            
            for siteDetails in category.sitesDetails {
                //Check if site exist.
                if self.sites[siteDetails.identifier!] == nil {
                    
                    let site = BNSite()
                    site.identifier = siteDetails.identifier!
                    site.biinieProximity = siteDetails.biinieProximity!
                    //site.jsonUrl = siteDetails.json!
                    sites[siteDetails.identifier!] = site
                    //Site does not exist, store it and request it's data.
                    delegateNM!.manager!(self, requestSiteData: site, user:bnUser!)
                } else {
                    self.sites[siteDetails.identifier!]?.showInView = true
                }
            }
            
            bnUser!.addCategory(category)
        }
    }
    
    func findCategoryNameByIdentifier(identifier:String) -> String {
        
        var name = ""
        
        for category in self.categories! {
            if category.identifier! == identifier {
                name = category.name!
                category.isUserCategory = true
                return name
            }
        }
        return name
    }
    
    
    //NOT IN USE
    ///Received site and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNSite: received from web service in json format already parse in an site object.
    func manager(manager: BNNetworkManager!, didReceivedSite site: BNSite) {
        
        //var isExternalBiinAdded = false
        
        sites[site.identifier!] = site
        
        if sites[site.identifier!] == nil {
            
        }
        
        if commercialUUID == nil {
            commercialUUID = site.proximityUUID
        }
        
        /*
        if site.showcases != nil {
            for showcase in site.showcases! {
                
                if showcases[showcase.identifier!] == nil {
                    //Showcase does not exist, store it and request it's data.
                    showcases[showcase.identifier!] = showcase
                    delegateNM!.manager!(self, requestShowcaseData:showcases[showcase.identifier!]!, user:bnUser!)
                }
            }
        }
        */
        
        if site.organization == nil {
            if organizations[site.organizationIdentifier!] == nil {
                //1. Add organization
                //2. set site organizarion
                organizations[site.organizationIdentifier!] = BNOrganization(identifier: site.organizationIdentifier!)
                delegateNM!.manager!(self, requestOrganizationData:organizations[site.organizationIdentifier!]!, user: self.bnUser!)
                site.organization = organizations[site.organizationIdentifier!]
                
                //HACK, add site's media to organization until it can be download.
                //                    if site.media.count > 0 {
                //                        organizations[biin.organizationIdentifier!]?.media = site.media
                //                        organizations[biin.organizationIdentifier!]?.title = site.title!
                //                        organizations[biin.organizationIdentifier!]?.subTitle = site.subTitle!
                //                    }
                
            } else  {
                //2. set site organization
                site.organization = organizations[site.organizationIdentifier!]
            }
        }
        
        for biin in sites[site.identifier!]!.biins {
            
            
            if biin.objects != nil && biin.objects!.count > 0 {
                
                //Set biin state.
                biin.setBiinState()
                
                for object in biin.objects! {
                    
                    switch object.objectType {
                    case .ELEMENT:
                        if object.hasNotification {
//                            switch biin.biinType {
//                            case .EXTERNO:
                                //if !isExternalBiinAdded {
                                    //isExternalBiinAdded = true
                                
                                    let notificaitonText = "\(site.title!) - \(object.notification!)"
                                    BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText:notificaitonText, notificationType: BNLocalNotificationType.EXTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
                                //}
//                                break
//                            case .INTERNO:
                                //let notificaitonText = "\(site.title!) - \(object.notification!)"
                                //BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText: notificaitonText, notificationType: BNLocalNotificationType.INTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
//                                break
//                            case .PRODUCT:
                                //let notificaitonText = "\(site.title!) - \(object.notification!)"
                                //BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText: notificaitonText, notificationType: BNLocalNotificationType.PRODUCT, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier:object.identifier!)
//                                break
//                            default:
//                                break
//                            }
                        }
                        
                        let element = BNElement()
                        element.identifier = object.identifier!
                        element._id = object._id!
                        let showcase = BNShowcase()
                        showcase.site = biin.site
                        element.showcase = showcase
                        //element.siteIdentifier = site.identifier
                        requestElement(element)
                        
                        break
                    case .SHOWCASE:
                        if showcases[object.identifier!] == nil {
                            //Showcase does not exist, store it and request it's data.
                            let showcase = BNShowcase()
                            showcase.identifier = object.identifier!
                            showcase.isDefault = object.isDefault
                            showcases[object.identifier!] = showcase
                            
                            delegateNM!.manager!(self, requestShowcaseData:showcases[showcase.identifier!]!, user:bnUser!)
                        }
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func manager(manager: BNNetworkManager!, didReceivedHihglightList showcase: BNShowcase) {
        //requestElements(showcase.elements)
    }
    
    
    ///Received site and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNShowcase: received from web service in json format already parse in an showcase object.
    func manager(manager:BNNetworkManager!, didReceivedShowcase showcase:BNShowcase) {
        /*
        showcases[showcase.identifier!] = showcase
        showcases[showcase.identifier!]!.isRequestPending = false
        
        requestElements(showcase.elements)
        */
    }
    
    /*
    func checkAllShowcasesCompleted(){
        
        for (_, showcase) in showcases {
            showcase.isShowcaseGameCompleted = true
            for element in showcase.elements {
                if !BNAppSharedManager.instance.dataManager.elements_by_id[element._id!]!.userViewed {
                    showcase.isShowcaseGameCompleted = false
                    break
                }
            }
        }
    }
    */
    
    ///Received biined element list and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNElement: list received from web service in json format already parse in an array object.
    func manager(manager: BNNetworkManager!, didReceivedBiinedElementList elementList: Array<BNElement>) {
        
    }
    
    func requestElements(elementList:Array<BNElement>){
        
        for element in elementList {
            
            //Check if element exist.
            if elements_by_id[element._id!] == nil {
        
                elements_by_id[element._id!] = element
                
                //Check is element is has been requested by it's identifier
                if elements_by_identifier[element.identifier!] == nil {
                    elements_by_identifier[element.identifier!] = element
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                } else {

                    let value = elements_by_identifier[element.identifier!]!.isDownloadCompleted
                    
                    if value {
                        manageElementRelationShips(elements_by_identifier[element.identifier!]!)
                    }else {

                    }
                }
            }
        }
    }
    
    func requestElement(element:BNElement){
        //Check if element exist.
        if elements_by_id[element._id!] == nil {

            elements_by_id[element._id!] = element
            
            //Check is element is has been requested by it's identifier
            if elements_by_identifier[element.identifier!] == nil {

                elements_by_identifier[element.identifier!] = element
                delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
            } else {

                let value = elements_by_identifier[element.identifier!]!.isDownloadCompleted
                
                if value {
                    manageElementRelationShips(elements_by_identifier[element.identifier!]!)
                }else {
                }
            }
        }
    }
    
    
    ///Received element and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNElement: received from web service in json format already parse in an element object.
    func manager(manager: BNNetworkManager!, didReceivedElement element: BNElement) {

        elements_by_identifier[element.identifier!] = element
        manageElementRelationShips(element)
    }
    
    func manager(manager: BNNetworkManager!, didReceivedHightlight element: BNElement) {
        
    }
    
    func addHighlights(){
        /*
        self.highlights = Array<BNElement>()
        
        var categoryCounter = 1
        
        var element1:BNElement?
        var element2:BNElement?
        var element1Added = false
        var element2Added = false
        
        for category in self.bnUser!.categories {
            
            if categoryCounter <= 6 {
                if category.elements.count > 0 {
                    
                    var elements = Array<BNElement>()
                    
//                    for (_, element) in category.elements {
//                        if element.isHighlight {
//                            elements.append(element)
//                        }
//                    }
                    
                    if elements.count > 0 {
                        elements = elements.sort{$0.showcase!.site!.biinieProximity < $1.showcase!.site!.biinieProximity}
                        
                        highlights.append(elements[0])
                        categoryCounter += 1
                        
                        if elements.count > 1 {
                            
                            if !element1Added {
                                element1Added = true
                                element1 = elements[1]

                            } else if !element2Added {
                                element2Added = true
                                element2 = elements[1]
                                
                            }
                        }
                    }
                }
            } else {
                continue
            }
        }
        
        self.highlights = self.highlights.sort{$0.showcase!.site!.biinieProximity < $1.showcase!.site!.biinieProximity}
        
        if element1 != nil {
            self.highlights.append(element1!)
        }

        if element2 != nil {
            self.highlights.append(element2!)
        }
        */
    }
    
    func isSiteAdded(identifier:String) -> Bool {
//        for siteView in sites! {
//            if siteView.site!.identifier == identifier {
//                return true
//            }
//        }
        return false
    }
    
    func manageElementRelationShips(element:BNElement){
        
        //Checks if element received is reference on element and clone it self.
        for (key, value) in elements_by_id {
            if value.identifier! == element.identifier! {
                element._id = key
                elements_by_id[key] = element.clone()

                if bnUser!.elementsViewed[element._id!] != nil {
                    elements_by_id[key]?.userViewed = true
                }
            }
        }
    }
    
    
    ///Receives a notification for a element.
    func manager(manager:BNNetworkManager!, didReceivedElementNotification notification:String, element:BNElement) {
        
    }
    
    
    //TODO: Temporal
    //func startRegionMonitorOnRegionVC() {
        
        //self.delegatePM!.manager!(self, startRegionsMonitoring:Array(self.regions.values))
    //}

    func manager(manager:BNNetworkManager!, didReveivedBiinsOnRegion biins:Array<BNBiin>, identifier:String) {
        

    }
    
    func manager(manager:BNNetworkManager!, didReveivedSharedBiins biins:Array<BNBiin>, identifier:String ) {

    }
    

    func biinieNotFoundOnDB(user: Biinie) {
        bnUser!.clear()
        BNAppSharedManager.instance.settings!.clear()
    }
    

    
    func manager(manager:BNNetworkManager!, didReceivedBiinieData user:Biinie, isBiinieOnBD:Bool) {
        
        
        //print("FLOW 5 - didReceivedBiinieData")
        if isBiinieOnBD {
            if self.bnUser != nil {
                self.bnUser = user
                self.bnUser!.save()
            }
            
            requestInitialData()
            
        } else {
            bnUser!.clear()
            //BNAppSharedManager.instance.settings!.clear()
            errorManager.showNotBiinieError()
        }
        /*x
        //Add a temporal BNCollection
        bnUser!.collections = Dictionary<String, BNCollection>()
        var collection = BNCollection()
        collection.identifier = "temporalCollection01"
        collection.name = "Biined element and sites."
        collection.collectionDescription = "This is a list of all your biined element and sites."
        bnUser!.collections![collection.identifier!] = collection
        */
        
       // delegateNM!.manager!(self, requestCollectionsForBNUser: bnUser!)
    }
    
    func manager(manager: BNNetworkManager!, didReceivedCollections collectionList: Array<BNCollection>) {
        

        
        if collectionList.count > 0 {
            
            bnUser!.collections = Dictionary<String, BNCollection>()
            
            for collection in collectionList {
            
                
                let new_collection = BNCollection()
                new_collection.identifier = collection.identifier
                new_collection.title = collection.title
                new_collection.subTitle = collection.subTitle
                bnUser!.temporalCollectionIdentifier = collection.identifier
                
                for (_id, element) in collection.elements {
                    if let store_element = elements_by_id[_id] {
                        new_collection.elements[_id] = store_element
                        new_collection.elements[_id]?.isRemovedFromShowcase = element.isRemovedFromShowcase
                    } else {
                        //print("element not store:\(_id)")
                        if let element_by_identifier = elements_by_identifier[element.identifier!] {
                            
                            elements_by_id[_id] = element_by_identifier.clone()
                            elements_by_id[_id]!._id = _id
                            
                            if let showcase = showcases[element.showcase!._id!] {
                                elements_by_id[_id]!.showcase = showcase
                            }
                            
                            new_collection.elements[_id] = elements_by_id[_id]
                            new_collection.elements[_id]?.isRemovedFromShowcase = element.isRemovedFromShowcase
                        }
                        
                    }
                }
                
                bnUser!.collections![collection.identifier!] = new_collection
                BNAppSharedManager.instance.mainViewController!.enableCollectionBtnOnMenu()

//                if bnUser!.collections![collection.identifier!] == nil {
//                    bnUser!.collections![collection.identifier!] = collection
//                    bnUser!.temporalCollectionIdentifier = collection.identifier!
//                }
//                
//                
                
                //for (key, element) in collection.elements {
                //    if elementsBiined[element._id!] == nil {
                //        elementsBiined[element._id!] = element._id!
                //    }
                //}
            
                //TODO: Remove this call temporary
                //requestElements(collection.elements.values.array)
            }
            
        }
    }
    
    func manager(manager:BNNetworkManager!, removeShowcaseRelationShips identifier:String) {
    

    }
    
    
    //BNPositionManagerDelegate
//    func manager(manager:BNPositionManager!, startEnterRegionProcessWithIdentifier identifier:String)
//    {
//
//        if self.delegateNM is BNNetworkManagerDelegate
//        {
//            self.delegateNM!.manager!(self, requestRegionData: identifier)
//            self.currentRegionIdentifier = identifier
//
//        }
//    }
    
//    func manager(manager:BNPositionManager!, startExitRegionProcessWithIdentifier identifier:String)
//    {
//        currentRegionIdentifier = nil
//    }
    
    func manager(manager:BNPositionManager!, markBiinAsDetectedWithUUID uuid:String)
    {
        
    }
    
    //Store data methods
    func addElementBiined(_id:String) -> Int{
        //if elementsBiined[_id] == nil {
            //elementsBiined[_id] = _id
            elements_by_id[_id]!.userCollected = true
            elements_by_id[_id]!.collectCount += 1
            return elements_by_id[_id]!.collectCount
            //TODO: Post user just biined an element
        //}
        //return 0
    }
    
    func receivedOrganization(organization: BNOrganization) {
        organizations[organization.identifier!] = organization
    }
    
    func isSiteStored(identifier:String) -> Bool{

        for site in sites_ordered {
            if site.identifier! == identifier {
                return true
            }
        }
        
        return false
    }
    
    func receivedSite(site: BNSite) {
        
        //var isExternalBiinAdded = false
        
        
        if !isSiteStored(site.identifier!) {
            
            sites_ordered.append(site)
            site.organization = organizations[site.organizationIdentifier!]
            
            organizations[site.organizationIdentifier!]?.sites.append(site.identifier!)

            sites[site.identifier!] = site
            
            if sites[site.identifier!] == nil {
                
            }
            
            if commercialUUID == nil {
                commercialUUID = site.proximityUUID
            }
     
            
            for biin in sites[site.identifier!]!.biins {
                
                if biin.objects != nil && biin.objects!.count > 0 {
                    
                    //Set biin state.
                    biin.setBiinState()
                    
                    for object in biin.objects! {
                        
                        switch object.objectType {
                        case .ELEMENT:
                            if object.hasNotification {
                                switch biin.biinType {
                                case .EXTERNO:
//                                    if !isExternalBiinAdded {
//                                        isExternalBiinAdded = true
                                        let notificaitonText = "\(site.title!) - \(object.notification!)"
                                        BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText:notificaitonText, notificationType: BNLocalNotificationType.EXTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
//                                    }
                                    break
                                case .INTERNO:
                                    //let notificaitonText = "\(site.title!) - \(object.notification!)"
                                    //BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText:notificaitonText, notificationType: BNLocalNotificationType.INTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
                                    break
                                case .PRODUCT:
                                    //let notificaitonText = "\(site.title!) - \(object.notification!)"
                                    //BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText:notificaitonText, notificationType: BNLocalNotificationType.PRODUCT, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier:object.identifier!)
                                    break
                                default:
                                    break
                                }
                            }
                            
//                            let element = BNElement()
//                            element.identifier = object.identifier!
//                            element._id = object._id!//Use as a element _id
//                            let showcase = BNShowcase()
//                            showcase.site = biin.site
//                            element.showcase = showcase
//                            requestElement(element)
                            
                            //Check if element exist.
                            if elements_by_id[object._id!] == nil {
                                
                                //Checks if element received is already on elements_by_identifier list.
                                if let element = elements_by_identifier[object.identifier!] {
                                    //Checks if element received is reference on element and clone it self.
                                    
                                    
                                    //                for (element_identifier, element_by_identifier) in elements_by_identifier {
                                    if object.identifier! == element.identifier! {
                                        
                                        elements_by_id[object._id!] = element.clone()
                                        elements_by_id[object._id!]!._id = object._id
                                        let showcase = BNShowcase()
                                        showcase.site = biin.site
                                        elements_by_id[object._id!]!.showcase = showcase
                                    }
                                    //                }
                                }
                            }
                            
                            break
                        /*
                        case .SHOWCASE:
                            if showcases[object.identifier!] == nil {
                                //Showcase does not exist, store it and request it's data.
                                let showcase = BNShowcase()
                                showcase.identifier = object.identifier!
                                showcase.isDefault = object.isDefault
                                showcases[object.identifier!] = showcase
                                
                                delegateNM!.manager!(self, requestShowcaseData:showcases[showcase.identifier!]!, user:bnUser!)
                            }
                            break
                        */
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
    
    func receivedShowcase(showcase: BNShowcase) {
        
        showcase.isRequestPending = false
        if showcases[showcase.identifier!] == nil {
            showcases[showcase.identifier!] = showcase
            
        }
        
        /*
        showcase.isRequestPending = false
        if showcases[showcase._id!] == nil {
            showcases[showcase._id!] = showcase
            
        }
        
        for element in showcase.elements {
            
            //Check if element exist.
            if elements_by_id[element._id!] == nil {
                
                //Checks if element received is already on elements_by_identifier list.
                if elements_by_identifier[element.identifier!] != nil {
                    //Checks if element received is reference on element and clone it self.
                    for (identifier, element_by_identifier) in elements_by_identifier {
                        if identifier == element.identifier! {
                            
                            elements_by_id[element._id!] = element_by_identifier.clone()
                            elements_by_id[element._id!]!._id = element._id
                            elements_by_id[element._id!]!.showcase = element.showcase
                        }
                    }
                } else {
                    elements_by_identifier[element.identifier!] = element
                    elements_by_id[element._id!] = element.clone()
                    elements_by_id[element._id!]!._id = element._id
                    elements_by_id[element._id!]!.showcase = element.showcase
                }
            }
        }
        
        
        var i:Int = 0
        for _ in showcase.elements {
            
            if elements_by_id[showcase.elements[i]._id!] != nil {
                showcase.elements[i] = elements_by_id[ showcase.elements[i]._id! ]!
            }
            
            i += 1
        }
 
         */
    }

    func receivedElement(element: BNElement) {
        //Check is element is has been requested by it's identifier
        if elements_by_identifier[element.identifier!] == nil {
            elements_by_identifier[element.identifier!] = element
        }
    }

    
    func receivedElementOnCategory(_id: String, identifier:String, showcase_id:String) {

        //Check if element exist.
        if elements_by_id[_id] == nil {
            
            //Checks if element received is already on elements_by_identifier list.
            if let element = elements_by_identifier[identifier] {
                //Checks if element received is reference on element and clone it self.
                
                
//                for (element_identifier, element_by_identifier) in elements_by_identifier {
                    if identifier == element.identifier! {
                        
                        elements_by_id[_id] = element.clone()
                        elements_by_id[_id]!._id = _id
                        elements_by_id[_id]!.showcase = showcases[showcase_id]
                    }
//                }
            }
        }
    }
    
    func receivedHightlight(highlights:Array<BNHighlight >) {


        self.highlights = highlights


    }
    
    func receivedCategories(categories:Array<BNCategory>) {
        
        bnUser!.categories.removeAll(keepCapacity: false)
        bnUser!.categories = Array<BNCategory>()
        
//        for (_, site) in sites {
//            site.showInView = false
//        }
        
        for category in categories {
            
            
            category.name = findCategoryNameByIdentifier(category.identifier!)
            
            
//            for siteDetails in category.sitesDetails {
//                //Check if site exist.
//                if self.sites[siteDetails.identifier!] == nil {
//                    
//                    let site = BNSite()
//                    site.identifier = siteDetails.identifier!
//                    site.biinieProximity = siteDetails.biinieProximity!
//                    //site.jsonUrl = siteDetails.json!
//                    sites[siteDetails.identifier!] = site
//                    //Site does not exist, store it and request it's data.
//                    delegateNM!.manager!(self, requestSiteData: site, user:bnUser!)
//                } else {
//                    self.sites[siteDetails.identifier!]?.showInView = true
//                }
//            }
            
            bnUser!.addCategory(category)
        }
    }
    
    
    func applyCollectedElement(element:BNElement?) {
        
        if self.bnUser!.collections![self.bnUser!.temporalCollectionIdentifier!]?.elements[element!._id!] == nil {
        
            self.bnUser!.collections![self.bnUser!.temporalCollectionIdentifier!]?.elements[element!._id!] = self.elements_by_id[element!._id!]

            element!.collectCount += 1
            elements_by_identifier[element!.identifier!]?.collectCount = element!.collectCount
            elements_by_identifier[element!.identifier!]?.userCollected = element!.userCollected
            
            for (identifier, clone) in elements_by_id {
                if element!.identifier! == identifier {
                    clone.collectCount = element!.collectCount
                    clone.userCollected = element!.userCollected
                }
            }
        }
    }
    
    
    func applyUnCollectedElement(element:BNElement?) {

        self.bnUser!.collections![self.bnUser!.temporalCollectionIdentifier!]!.elements.removeValueForKey(element!._id!)
        
        elements_by_identifier[element!.identifier!]?.userCollected = element!.userCollected
        
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userCollected = element!.userCollected
            }
        }
    
    }


    func applyLikeElement(element:BNElement?) {
        
        elements_by_identifier[element!.identifier!]?.userLiked = element!.userLiked
        
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userLiked = element!.userLiked
            }
        }
    }
    
    func applyShareElement(element:BNElement?) {
        
        elements_by_identifier[element!.identifier!]?.userShared = element!.userShared
        
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userShared = element!.userShared
            }
        }
    }
    
    func applyViewedElement(element:BNElement?) {

        element!.userViewed = true
        
        //TODO: this action should have the _id and identifier sent
        BNAppSharedManager.instance.dataManager.bnUser!.addAction(NSDate(), did:BiinieActionType.ENTER_ELEMENT_VIEW, to:element!.identifier!)
        
        elements_by_identifier[element!.identifier!]?.userViewed = element!.userViewed
        
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userViewed = element!.userViewed
            }
        }
    }
    
    func requestElementsForShowcase(showcase: BNShowcase?, view: BNView?) {
        delegateNM!.requestElementsForShowcase!(showcase, view: view)
    }
    
    func requestElementsForCategory(category:BNCategory, view:BNView?){
        delegateNM!.requestElementsForCategory!(category, view: view)
    }
    
    func requestSites(view:BNView?) {
        delegateNM!.requestSites!(view)
    }
    
    func addFavoriteSite(identifier:String) {
        var isAdded = false
        for i in (0..<favoritesSites.count) {
            if favoritesSites[i] == identifier {
                isAdded = true
            }
        }
        
        if !isAdded {
            favoritesSites.insert(identifier, atIndex: 0)
//            favoritesSites.append(identifier)
        }
    }
    
    func removeFavoriteSite(identifier:String) {
        for i in (0..<favoritesSites.count) {
            if favoritesSites[i] == identifier {
                favoritesSites.removeAtIndex(i)
                break
            }
        }
    }
}

@objc protocol BNDataManagerDelegate:NSObjectProtocol {
    
    
    
    //Request on demand
    optional func requestElementsForShowcase(showcase:BNShowcase?, view:BNView?)
    optional func requestElementsForCategory(category:BNCategory?, view:BNView?)
    optional func requestSites(view:BNView?)

    
    
    
    ///Request initialdata to display on app
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the data.
    optional func manager(manager:BNDataManager!, initialdata user:Biinie)
    
    //Saving user data
    optional func manager(manager:BNDataManager!, saveUserCategories user:Biinie)
    
    
    //Methods to conform on BNNetworkManager
    
    ///Checks is biinies email is verified.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter Biinie's: identifier.
    optional func manager(manager:BNDataManager!, checkIsEmailVerified identifier:String)
    
    ///Request a region's data.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter Region's: identifier requesting the data.
    optional func manager(manager:BNDataManager!, requestRegionData identifier:String)
    
    
    ///Request user categories.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the data.
    optional func manager(manager:BNDataManager!, requestCategoriesData user:Biinie)
    
    
    ///Request user categories.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the data.
    optional func manager(manager:BNDataManager!, requestCategoriesDataByBiinieAndRegion user:Biinie, region:BNRegion)
    
    ///Request a site's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNSite: requesting the data.
    optional func manager(manager:BNDataManager!, requestSiteData site:BNSite, user:Biinie)
    
    
    ///Request a organization's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNOrganization: requesting the data.
    optional func manager(manager:BNDataManager!, requestOrganizationData organization:BNOrganization, user:Biinie)
    
    
    
    ///Request showcase's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNShowcase: requesting the data.
    optional func manager(manager:BNDataManager!, requestHighlightsData user:Biinie)
    
    ///Request showcase's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNShowcase: requesting the data.
    optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase, user:Biinie)
    
    ///Request element's data for BNUser (app user)
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNElement: requesting the data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:Biinie)
    
    ///Request user biined element's.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestBiinedElementListForBNUser user:Biinie)
    
    
    ///Request user boards.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestCollectionsForBNUser user:Biinie)

    //optional func manager(manager:BNDataManager!, sendBiinedElement user:BNUser, element:BNElement, collection:BNCollection)
    
    //optional func manager(manager:BNDataManager!, deleteBiinedElement user:BNUser, element:BNElement, collection:BNCollection)
    
    ///Request user (biinie) data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestBiinieData biinie:Biinie)
    
    
    
    optional func manager(manager:BNDataManager!, startSiteBiinsBackgroundMonitoring value:Bool)

    
    
    
    
    
    
    
    //NOT SURE IS NEEDED FROM HERE DOWN
    
    
    
    
    ///Request element's notification for a BNUser (app user)
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNElement: requesting the data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestElementNotificationForBNUser element:BNElement, user:Biinie)
    
    optional func manager(manager:BNDataManager!, requestImageData stringUrl:String, image:UIImageView!)
    
    optional func manager(manager:BNDataManager!, requestBiinieAvatar stringUrl:String, image:UIImageView)
    
    //Methods to conform on BNPositionManager
    optional func manager(manager:BNDataManager!, startRegionsMonitoring regions:Array<BNRegion>)
    optional func manager(manager:BNDataManager!, stopRegionsMonitoring regions:Array<BNRegion>)
    
    
    ///Request BNPositionManager to starts a site monitoring.
    ///
    ///- parameter BNDataManager:
    ///- parameter Site: to be monitor bu BNPositionManager.
    ///- returns: none
    optional func manager(manager:BNDataManager, startSitesMonitoring value:Bool)
    
    optional func manager(manager:BNDataManager, startCommercialBiinMonitoring proximityUUID:NSUUID)
    ///Request position manager to stop a site monitoring.
    ///
    ///- parameter Data: manager that stores the sites.
    ///- parameter Site: to be monitor.
    ///- returns: none
    optional func manager(manager:BNDataManager, stopSitesMonitoring value:Bool)
    
    //TODO: Remove this two methods later
    optional func manager(manager:BNDataManager!, startBiinMonitoring biin:BNBiin)
    optional func manager(manager:BNDataManager!, stopBiinMonitoring biin:BNBiin)
}

