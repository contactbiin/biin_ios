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
    
    var regions = Dictionary<String, BNRegion>()
    var sites = Dictionary<String, BNSite>()
    var organizations = Dictionary<String, BNOrganization>()
    var sites_OnBackground = Dictionary<String, BNSite>()
    var showcases = Dictionary<String, BNShowcase>()
    var elements = Dictionary<String, BNElement>()
    var highlights = Dictionary<String, String>()//list of hightlight element
    var availableBiins = Array<String>()//list of biins detected
    var elementsRequested = Dictionary<String, BNElement>()
    //var elementsBiined = Dictionary<String, String>()
    
    //var notifications = Array<BNNotification>()
    
    //var showcasesIdentifiersToRequest:Dictionary<String, String> = Dictionary<String, String>()
    var sharedBiins = Dictionary<String, BNBiin>()
    
    var categories:Array<BNCategory>?/// = Dictionary<String, BNCategory>()
    //var sections:Array<BNSection> = Array<BNSection>()
    
    var currentRegionIdentifier:String?
    
    var timer:NSTimer?
    
    var commercialUUID:NSUUID?
    
    init(errorManager:BNErrorManager){
        
        self.errorManager = errorManager
        
        super.init()
        
        loadCategories()
        
        // Try loading a saved version first
        if let user = Biinie.loadSaved() {
            print("Loading bnUser:")
            bnUser = user
            isUserLoaded = true
            //bnUser!.clear()
        } else {
            // Create a new Course List
            print("Not user available")
            isUserLoaded = false
            bnUser = Biinie(identifier:"", firstName: "guess", lastName:"guess", email: "guess@biinapp.com")
            bnUser!.isEmailVerified = false
            bnUser!.biinName = ""
        }
        
        //NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "startAppTimer:", userInfo: nil, repeats: false)
    }
    
    deinit {
        
    }
    
    func requestBiinieInitialData(){
        NSLog("BIIN - requestBiinieInitialData()")
        delegateNM!.manager!(self, requestBiinieData: bnUser!)
    }
    
    func requestInitialData(){
        NSLog("BIIN - requestInitialData()")
        delegateNM!.manager!(self, requestCategoriesData: bnUser!)
        delegateNM!.manager!(self, requestCollectionsForBNUser: bnUser!)
    }
    
    func requestDataForNewPosition(){
        print("requestDataForNewPosition()")
        delegateNM!.manager!(self, requestCategoriesData: bnUser!)
        BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA = true
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
                category.elements[element.identifier!] = element
                continue
            }
        }
    }

//    func removeNotification(identifier:Int){
//        for var i = 0; i < notifications.count; i++ {
//            if notifications[i].identifier == identifier {
//                notifications.removeAtIndex(i)
//                return
//            }
//        }
//    }
    
    func startSitesMonitoring(){
        delegatePM!.manager!(self, startSitesMonitoring: true)
    }
    
    func startCommercialBiinMonitoring() {
        delegatePM!.manager!(self, startCommercialBiinMonitoring:self.commercialUUID!)
    }
    
    
    //BNNetworkManagerDelegate
    /**
    Start initial network requests.
    - parameter Network: manager that handled the regions request.
    - parameter Network: status.
    */
    func manager(manager: BNNetworkManager!, didReceivedConnectionStatus status: Bool) {
        if status && BNAppSharedManager.instance.IS_APP_UP {
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
    func manager(manager:BNNetworkManager!, didReceivedRegions regions:Array<BNRegion>) {
        
        
        /*
        for region in regions {
            //Check if regions exist.
            if self.regions[region.identifier!] == nil {
                //Regions does not exist, store it.
                self.regions[region.identifier!] = region
            }
        }
        */
//        delegateNM!.manager!(self, requestCategoriesDataByBiinieAndRegion: bnUser!, region:self.regions["bnHome"]!)
        delegateNM!.manager!(self, requestCategoriesData: bnUser!)
        
        /*
        if self.regions.count > 0 {
            //TESTING
            self.delegatePM!.manager!(self, startRegionsMonitoring:Array(self.regions.values))
        }
        */
        
        //FIXME: This few lines are only for testing when not entering a regions.
//        self.currentRegionIdentifier = "bnHome"
//        self.delegateNM!.manager!(self, requestRegionData:self.currentRegionIdentifier!)
//        println("Request region: \(self.currentRegionIdentifier!)")
        
    }
    /*
    func manager(manager: BNNetworkManager!, didReceivedUserCategoriesOnBackground categories: Array<BNCategory>) {
        
        println("didReceivedUserCategoriesOnBackground(): \(categories.count)")
        
        var isExternalBiinAdded = false
        var start_background_monitor = false
        
        sites_OnBackground = Dictionary<String, BNSite>()
        
        for category in categories {
            
            println("*****   Category received: \(category.identifier!) sites:\(category.sitesDetails.count)")
            
            category.name = findCategoryNameByIdentifier(category.identifier!)
            
            if category.backgroundSites != nil {

                for (identifier, site) in category.backgroundSites! {
                    
                    sites_OnBackground[site.identifier!] = site
                    
                    for biin in site.biins {
                        
                        start_background_monitor = true
                        
                        if commercialUUID == nil {
                            commercialUUID = biin.proximityUUID
                        }
                        
                        if biin.objects != nil && biin.objects!.count > 0 {
                            
                            biin.setBiinState()
                            
                            for object in biin.objects! {
                                
                                println("Object: \(object._id!)")
                                
                                switch object.objectType {
                                case .ELEMENT:
                                    if object.hasNotification {
                                        switch biin.biinType {
                                        case .EXTERNO:
                                            if !isExternalBiinAdded {
                                                isExternalBiinAdded = true
                                                BNAppSharedManager.instance.notificationManager.addLocalNotification(object._id!, notificationText: object.notification!, notificationType: BNLocalNotificationType.EXTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
                                            }
                                            break
                                        case .INTERNO:
                                            BNAppSharedManager.instance.notificationManager.addLocalNotification(object._id!, notificationText: object.notification!, notificationType: BNLocalNotificationType.INTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
                                            break
                                        case .PRODUCT:
                                            BNAppSharedManager.instance.notificationManager.addLocalNotification(object._id!, notificationText: object.notification!, notificationType: BNLocalNotificationType.PRODUCT, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier:object.identifier!)
                                            break
                                        default:
                                            break
                                        }
                                    }
                                    
                                    //var element = BNElement()
                                    //element.identifier = object.identifier!
                                    //element._id = object._id!
                                    //element.siteIdentifier = site.identifier
                                    //requestElement(element)
                                    
                                    break
                                case .SHOWCASE:
                                    if showcases[object.identifier!] == nil {
                                        //Showcase does not exist, store it and request it's data.
                                        //var showcase = BNShowcase()
                                        //showcase.identifier = object.identifier!
                                        //showcase.isDefault = object.isDefault
                                        //showcases[object.identifier!] = showcase
                                        
                                        //delegateNM!.manager!(self, requestShowcaseData:showcases[showcase.identifier!]!)
                                    }
                                    break
                                default:
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
        
        //self.sites = sorted(self.sites){ $0.rssi > $1.rssi  }
        
        if start_background_monitor {
            delegatePM!.manager!(self, startSiteBiinsBackgroundMonitoring: false)
        }
    }
    */

    ///Receives user categories data and start requests depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter Categories: received from web service in json format already parse in an nice array.
    func manager(manager: BNNetworkManager!, didReceivedUserCategories categories: Array<BNCategory>) {


        print("didReceivedUserCategories(): \(categories.count)")
        bnUser!.categories.removeAll(keepCapacity: false)
        bnUser!.categories = Array<BNCategory>()
        
        
        for (_, site) in sites {
            site.showInView = false
        }

        
        for category in categories {
            
            //println("*****   Category received: \(category.identifier!) sites:\(category.sitesDetails.count)")

            category.name = findCategoryNameByIdentifier(category.identifier!)
            
            //BNAppSharedManager.instance.biinieCategoriesBckup[category.name!] = category
            
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
//            bnUser!.categories.append(category)
            
        }
        
        //println("categories backup \(BNAppSharedManager.instance.biinieCategoriesBckup.count)")
        //println("user categories(): \(bnUser!.categories.count)")
        
//        var sitesArray:Array<BNSite> = Array<BNSite>()
//        
//        for (key, value) in sites {
//            sitesArray.append(value)
//        }
//        
//        sitesArray = sorted(sitesArray){ $0.biinieProximity < $1.biinieProximity  }
//
//        sites.removeAll(keepCapacity: false)
//        
//        for orderedSite in sitesArray {
//            sites[orderedSite.identifier!] = orderedSite
//        }
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
    
    
    ///Received site and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNSite: received from web service in json format already parse in an site object.
    func manager(manager: BNNetworkManager!, didReceivedSite site: BNSite) {
        
        
        var isExternalBiinAdded = false
        //site.biinieProximity = sites[site.identifier!]?.biinieProximity!
        
        sites[site.identifier!] = site
        //BNAppSharedManager.instance.notificationManager.addLocalNotification(site.identifier!, text: "Bienvenido a \(site.title!)", notificationType:BNLocalNotificationType.EXTERNAL, itemIdentifier:site.identifier!)
        //println("site:\(site.identifier!) biins: \(site.biins.count)")
        
        if sites[site.identifier!] == nil {
            print("ERROR: Site: \(site.identifier!) was requested but not added to sites list.")
        }
        
        if commercialUUID == nil {
            commercialUUID = site.proximityUUID
        }
        
        if site.showcases != nil {
            for showcase in site.showcases! {
                
                if showcases[showcase.identifier!] == nil {
                    //Showcase does not exist, store it and request it's data.
                    showcases[showcase.identifier!] = showcase
                    //println("CRASH: \(biin.showcase!.identifier!)")
                    delegateNM!.manager!(self, requestShowcaseData:showcases[showcase.identifier!]!, user:bnUser!)
                }
            }
        }
        
        
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
            
            

            
            //REMOVE ->
            /*
            for showcase in biin.showcases! {
            
                if showcases[showcase.identifier!] == nil {
                    //Showcase does not exist, store it and request it's data.
                    showcases[showcase.identifier!] = showcase
                    //println("CRASH: \(biin.showcase!.identifier!)")
                    delegateNM!.manager!(self, requestShowcaseData:showcases[showcase.identifier!]!)
                }
            }
            */
            //REMOVE <-
            
            
            if biin.objects != nil && biin.objects!.count > 0 {
                
                //Set biin state.
                biin.setBiinState()
                //println("Add notification for biin: \(biin.identifier!)")
                //HACK for biinType
                //biin.updateBiinType()
                
                for object in biin.objects! {
                    
                    //println("Object: \(object._id!)")
                    
                    switch object.objectType {
                    case .ELEMENT:
                        if object.hasNotification {
                            switch biin.biinType {
                            case .EXTERNO:
                                if !isExternalBiinAdded {
                                    isExternalBiinAdded = true
                                    BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText: object.notification!, notificationType: BNLocalNotificationType.EXTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
                                }
                                break
                            case .INTERNO:
                                BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText: object.notification!, notificationType: BNLocalNotificationType.INTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)
                                break
                            case .PRODUCT:
                                BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText: object.notification!, notificationType: BNLocalNotificationType.PRODUCT, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier:object.identifier!)
                                break
                            default:
                                break
                            }
                        }
                        
                        let element = BNElement()
                        element.identifier = object.identifier!
                        element._id = object._id!
                        element.siteIdentifier = site.identifier
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
        requestElements(showcase.elements)
    }
    
    
    ///Received site and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNShowcase: received from web service in json format already parse in an showcase object.
    func manager(manager:BNNetworkManager!, didReceivedShowcase showcase:BNShowcase) {

        //println("Received showcase: \(showcase.identifier!)")
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
    
    func checkAllShowcasesCompleted(){
        for (_, showcase) in showcases {
            showcase.isShowcaseGameCompleted = true
            for element in showcase.elements {
                if !BNAppSharedManager.instance.dataManager.elements[element._id!]!.userViewed {
                    showcase.isShowcaseGameCompleted = false
                    break
                }
            }
        }
    }
    ///Received biined element list and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNElement: list received from web service in json format already parse in an array object.
    func manager(manager: BNNetworkManager!, didReceivedBiinedElementList elementList: Array<BNElement>) {
        
        //for element in elementList {
        //    if elementsBiined[element._id!] == nil {
        //        elementsBiined[element._id!] = element._id!
         //   }
        //}
        
        
        //TODO: Remove this call temparary
        //requestElements(elementList)
        
        
        
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
                let newElement = BNElement()
                newElement.identifier = element.identifier!
                newElement._id = element._id
                newElement.userViewed = element.userViewed
                newElement.siteIdentifier = element.siteIdentifier
                //newElement.jsonUrl = element.jsonUrl!
                elements[newElement._id!] = newElement
                
                //Check is element is has been requested by it's identifier
                if elementsRequested[element.identifier!] == nil {
                    //println("Request element: \(element._id!) and \(element.identifier!)")
                    elementsRequested[element.identifier!] = element
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                } else {
                    //println("############# element is already in list \(element.identifier!) for \(element._id!)")
                    let value = elementsRequested[element.identifier!]!.isDownloadCompleted
                    
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
    
    
    func requestElement(element:BNElement){
        //for element in elementList {
        
        
            //println("request element: \(element.identifier!)")
        
        
            //Check if element exist.
            if elements[element._id!] == nil {
                //Element does not exist, store it and request it's data.
                let newElement = BNElement()
                newElement.identifier = element.identifier!
                newElement._id = element._id
                newElement.siteIdentifier = element.siteIdentifier
                newElement.userViewed = element.userViewed
                //newElement.jsonUrl = element.jsonUrl!
                elements[newElement._id!] = newElement
                
                //Check is element is has been requested by it's identifier
                if elementsRequested[element.identifier!] == nil {
                    //println("Request element: \(element._id!) and \(element.identifier!)")
                    elementsRequested[element.identifier!] = element
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                } else {
                    //println("############# element is already in list \(element.identifier!) for \(element._id!)")
                    let value = elementsRequested[element.identifier!]!.isDownloadCompleted
                    
                    if value {
                        manageElementRelationShips(elementsRequested[element.identifier!]!)
                    }else {
                        //println("Request element Pending: \(element._id!) and \(element.identifier!)")
                        //                        elementsRequestedIdentifiers[element.identifier!] = element
                        //                        delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                    }
                }
            }
        //}
    }
    
    
    ///Received element and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNElement: received from web service in json format already parse in an element object.
    func manager(manager: BNNetworkManager!, didReceivedElement element: BNElement) {
        //println("Received element: \(element.identifier!) id:\(element._id!) media \(element.media.count)")
        elementsRequested[element.identifier!] = element
        manageElementRelationShips(element)
        
        if highlights.count < 6 {
            if element.isHighlight {
                highlights[element._id!] = element._id!
            }
        }
        
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
    
    func manager(manager: BNNetworkManager!, didReceivedHightlight element: BNElement) {
//        elementsRequested[element.identifier!] = element
//        highlights[element._id!] = element._id!
//        manageElementRelationShips(element)
    }
    
    func addHighlights(){
        

        
        var sitesArray:Array<BNSite> = Array<BNSite>()
        
        //let dataManager = BNAppSharedManager.instance.dataManager
        //let user = dataManager.bnUser!
        //var categories = user.categories
        
        for category in self.bnUser!.categories {
            if category.hasSites {
                for var i = 0; i < category.sitesDetails.count; i++ {
                    
                    let siteIdentifier = category.sitesDetails[i].identifier!
                    
                    if let site = self.sites[ siteIdentifier ] {
                        if site.showInView {
                            sitesArray.append(site)
                            print("Adding site.....")
                        }
                    }
                }
            }
        }
        
        sitesArray = sitesArray.sort{ $0.biinieProximity < $1.biinieProximity  }
        /*
        for site in sitesArray {
            if site.showInView {
                if !isSiteAdded(site.identifier!) {
                    //println("***** ADDING SITE:\(site.identifier!) title: \(site.title!)")
                    
                    if columnCounter < columns {
                        columnCounter++
                        xpos = xpos + siteSpacer
                        
                    } else {
                        ypos = ypos + siteViewHeight + siteSpacer
                        xpos = siteSpacer
                        columnCounter = 1
                    }
                    
                    let miniSiteView = SiteMiniView(frame: CGRectMake(xpos, ypos, siteViewWidth, siteViewHeight), father: self, site:site)
                    miniSiteView.isPositionedInFather = true
                    miniSiteView.isReadyToRemoveFromFather = false
                    miniSiteView.delegate = father?.father! as! MainView
                    
                    sites!.append(miniSiteView)
                    scroll!.addSubview(miniSiteView)
                    
                    xpos = xpos + siteViewWidth
                    
                } else {
                    for siteView in sites! {
                        if siteView.site!.identifier == site.identifier! && !siteView.isPositionedInFather {
                            
                            //println("***** POSITIONING SITE:\(site.identifier!) title: \(site.title!)")
                            if columnCounter < columns {
                                columnCounter++
                                xpos = xpos + siteSpacer
                                
                            } else {
                                ypos = ypos + siteViewHeight + siteSpacer
                                xpos = siteSpacer
                                columnCounter = 1
                            }
                            siteView.isPositionedInFather = true
                            siteView.isReadyToRemoveFromFather = false
                            siteView.frame = CGRectMake(xpos, ypos, siteViewWidth, siteViewHeight)
                            xpos = xpos + siteViewWidth
                            
                            break
                        }
                    }
                }
            }
        }
        /*
        else {
        //                        for var i = 0; i < sites!.count; i++ {
        //                            if sites![i].site!.identifier == siteIdentifier {
        //                                println("***** REMOVE SITE:\(siteIdentifier) title: \(sites![i].site!.title!)")
        //                                sites![i].removeFromSuperview()
        //                                sites!.removeAtIndex(i)
        //                                break
        //                            }
        //                        }
        }
        }
        }
        }
        */
        ypos = ypos + siteViewHeight + siteSpacer
        scroll!.contentSize = CGSizeMake(SharedUIManager.instance.screenWidth, ypos)
        
        //SharedUIManager.instance.miniView_height = siteViewHeight
        //SharedUIManager.instance.miniView_width = siteViewWidth
        //SharedUIManager.instance.miniView_columns = columns
        
        
        //var sitesCount = sites!.count
        for var i = 0; i < sites!.count; i++ {
            if sites![i].isReadyToRemoveFromFather {
                //println("***** REMOVE SITE:title: \(sites![i].site!.title!)")
                sites![i].removeFromSuperview()
                sites!.removeAtIndex(i)
                i = 0
                
            }
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
        for (key, value) in elements {
            if value.identifier! == element.identifier! {
                element._id = key
                elements[key] = element.clone()
                //println("Stored element: \(elements[key]?.identifier!) id:\(elements[key]?._id!) media \(elements[key]?.media.count)")
                
                if bnUser!.elementsViewed[element._id!] != nil {
                    elements[key]?.userViewed = true
                }
            }
        }
    }
    
    
    ///Receives a notification for a element.
    func manager(manager:BNNetworkManager!, didReceivedElementNotification notification:String, element:BNElement) {
        //println("Received element notification update: \(element.identifier)")
    }
    
    
    //TODO: Temporal
    //func startRegionMonitorOnRegionVC() {
        
        //self.delegatePM!.manager!(self, startRegionsMonitoring:Array(self.regions.values))
    //}

    func manager(manager:BNNetworkManager!, didReveivedBiinsOnRegion biins:Array<BNBiin>, identifier:String) {
        
        //1. Check if biin are in region.
        //1.2 If biin is not in region request showcase data if needed/
        //2. If biin is already in region check for lastupdate
        //2.2 If update is needed request showcase data
        
        //var requestShowcaseData = false

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
        
        
        
        //var requestShowcaseData = false
        
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

    

    
    func manager(manager:BNNetworkManager!, didReceivedBiinieData user:Biinie) {
        
        if self.bnUser != nil {
            self.bnUser = user
            self.bnUser!.save()
        }
        
        requestInitialData()
        
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
        
        //println("Received collections: \(collectionList.count)")
        
        if collectionList.count > 0 {
            
            bnUser!.collections = Dictionary<String, BNCollection>()
            
            for collection in collectionList {
                
                if bnUser!.collections![collection.identifier!] == nil {
                    bnUser!.collections![collection.identifier!] = collection
                    bnUser!.temporalCollectionIdentifier = collection.identifier!
                }
                
                print("\(bnUser!.collections![collection.identifier!]?.elements.count)")
                
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
        //println("** Requesting data for region: \(identifier)")
        if self.delegateNM is BNNetworkManagerDelegate
        {
            
            print("Requesting data for region: \(identifier)")
            self.delegateNM!.manager!(self, requestRegionData: identifier)
            self.currentRegionIdentifier = identifier
            //self.viewController?.reloadTable(self.regions[identifier]?.biins, dataManager:self)
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
        
        let iconSite = BNSite()
        iconSite.identifier = "iCon"
        iconSite.title =  "iCon"
        iconSite.subTitle = "Multiplaza del Este"
        iconSite.titleColor = UIColor.bnRed()
        sites[iconSite.identifier!] = iconSite
        
        let iconShowcase = BNShowcase()
        iconShowcase.identifier = "icon.identifier"
//        iconShowcase.site = iconSite
        showcases[iconShowcase.identifier!] = iconShowcase
        
        let iphone = BNElement()
        iphone.position = 1
        iphone.title = "iPhone"
        iphone.subTitle = "None"
        iconShowcase.elements.append(iphone)
        
        showcases["icon.identifier"] = iconShowcase
        
    }
    
    
    
    //Store data methods
    func addElementBiined(_id:String) -> Int{
        //if elementsBiined[_id] == nil {
            //elementsBiined[_id] = _id
            elements[_id]!.userCollected = true
            elements[_id]!.collectCount++
            return elements[_id]!.collectCount
            //TODO: Post user just biined an element
        //}
        //return 0
    }
}

@objc protocol BNDataManagerDelegate:NSObjectProtocol {
    
    
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

