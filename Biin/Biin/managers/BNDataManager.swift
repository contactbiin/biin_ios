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
    var biinie:Biinie?
    var isUserLoaded = false
    
    //var regions = Dictionary<String, BNRegion>()
    var nearbySites = Array<String>()
    var favoritesSites = Array<String>()
    var favoritesElements = Array<BNElementRelationShip>()
    
    var sites = Dictionary<String, BNSite>()
    var sites_ordered = Array<BNSite>()
    var organizations = Dictionary<String, BNOrganization>()
    //var sites_OnBackground = Dictionary<String, BNSite>()
    var showcases = Dictionary<String, BNShowcase>()
//    var elements_by_id = Dictionary<String, BNElement>() //list of virtual elements by _id (clones by _id)
    var elements = Dictionary<String, BNElement>()//List of element with data, not by _id
    var highlights = Array<BNElementRelationShip>()//list of hightlight element
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
        
        favoritesSites.removeAll()
        favoritesSites = Array<String>()
        
        favoritesElements.removeAll()
        favoritesElements = Array<BNElementRelationShip>()
        
        sites.removeAll()
        sites = Dictionary<String, BNSite>()

        sites_ordered.removeAll()
        sites_ordered = Array<BNSite>()
        
        organizations.removeAll()
        organizations = Dictionary<String, BNOrganization>()
        
        showcases.removeAll()
        showcases = Dictionary<String, BNShowcase>()
        
//        elements_by_id.removeAll()
//        elements_by_id = Dictionary<String, BNElement>() //list of virtual elements by _id (clones by _id)

        elements.removeAll()
        elements = Dictionary<String, BNElement>()//List of element with data, not by _id
        
        highlights.removeAll()
        highlights = Array<BNElementRelationShip>()
    }
    
    func loadBiinie() {
        // Try loading a saved version first
        if let user = Biinie.loadSaved() {
            
            if user.firstName == "none" {
                isUserLoaded = false
            } else {
                biinie = user
                isUserLoaded = true
                biinie!.addAction(NSDate(), did:BiinieActionType.OPEN_APP, to:"biin_ios", by:"")
            }
        } else {
            isUserLoaded = false
            biinie = Biinie(identifier:"", firstName: "none", lastName:"none", email: "none.com")
            biinie!.isEmailVerified = false
            biinie!.biinName = ""
        }
    }
    
    deinit {
        
    }
    
    func requestBiinieInitialData(){
        
        //print("FLOW 4 - requestBiinieInitialData()")
        if isUserLoaded {
            
            delegateNM!.requestBiinieData!(self, biinie: biinie!)
            
            if biinie!.email! == "ep@estebanpadilla.com"
                || biinie!.email! == "demo@biin.io" {
                BNAppSharedManager.instance.IS_DEVELOPMENT_BUILD = true
            }
        }
    }
    
    func requestInitialData(){
        
        //print("FLOW 6 - requestInitialData()")
        delegateNM!.manager!(self, initialdata: biinie!)
        
        //Changes request flow.
//        delegateNM!.manager!(self, requestCategoriesData: bnUser!)
//        delegateNM!.manager!(self, requestCollectionsForBNUser: bnUser!)
    }
    
    func requestDataOnWhenAppIsRunning(){
        //BNAppSharedManager.instance.networkManager.sendBiinieActions(BNAppSharedManager.instance.dataManager.bnUser!)
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
        for category in self.biinie!.categories {
            if category.identifier == categoryIdentifier {
                //category.elements[element.identifier!] = element
                continue
            }
        }
    }
    
    func addElementToCategoryByIndetifier(categoryIdentifier:String, elementIdentifier:String){
        for category in self.biinie!.categories {
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
    
//    func manager(manager: BNNetworkManager!, didReceivedVersionStatus needsUpdate: Bool) {
//        
//        print("didReceivedVersionStatus")
//        if !needsUpdate {
//            requestBiinieInitialData()
//        } else {
//            print("didReceivedVersionStatus - show version window")
//        }
//    }
    
    func manager(manager: BNNetworkManager!, didReceivedUserIdentifier idetifier: String?) {

        biinie!.identifier = idetifier
        biinie!.save()
        isUserLoaded = true
    }
    
    func manager(manager: BNNetworkManager!, didReceivedEmailVerification value: Bool) {
        biinie!.isEmailVerified = value
        biinie!.save()
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
        
        biinie!.categories.removeAll(keepCapacity: false)
        biinie!.categories = Array<BNCategory>()
        
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
                    delegateNM!.manager!(self, requestSiteData: site, user:biinie)
                } else {
                    self.sites[siteDetails.identifier!]?.showInView = true
                }
            }
            
            biinie!.addCategory(category)
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

        if site.organization == nil {
            if organizations[site.organizationIdentifier!] == nil {
                //1. Add organization
                //2. set site organizarion
                organizations[site.organizationIdentifier!] = BNOrganization(identifier: site.organizationIdentifier!)
                delegateNM!.manager!(self, requestOrganizationData:organizations[site.organizationIdentifier!]!, user: self.biinie)
                site.organization = organizations[site.organizationIdentifier!]
            } else  {
                //2. set site organization
                site.organization = organizations[site.organizationIdentifier!]
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
        
        /*
        for element in elementList {
            
            //Check if element exist.
            if elements_by_id[element._id!] == nil {
        
                elements_by_id[element._id!] = element
                
                //Check is element is has been requested by it's identifier
                if elements[element.identifier!] == nil {
                    elements[element.identifier!] = element
                    delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
                } else {

                    let value = elements[element.identifier!]!.isDownloadCompleted
                    
                    if value {
                        manageElementRelationShips(elements[element.identifier!]!)
                    }else {

                    }
                }
            }
        }
         */
    }
    
    func requestElement(element:BNElement){
        
        /*
        //Check if element exist.
        if elements_by_id[element._id!] == nil {

            elements_by_id[element._id!] = element
            
            //Check is element is has been requested by it's identifier
            if elements[element.identifier!] == nil {

                elements[element.identifier!] = element
                delegateNM!.manager!(self, requestElementDataForBNUser:element, user:bnUser!)
            } else {

                let value = elements[element.identifier!]!.isDownloadCompleted
                
                if value {
                    manageElementRelationShips(elements[element.identifier!]!)
                }else {
                }
            }
        }
         */
    }
    
    
    ///Received element and start proccesing depending on data store.
    ///- parameter Network: manager that handled the request.
    ///- parameter BNElement: received from web service in json format already parse in an element object.
    func manager(manager: BNNetworkManager!, didReceivedElement element: BNElement) {

        elements[element.identifier!] = element
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
        
        /*
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
         */
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
        biinie!.clear()
        BNAppSharedManager.instance.settings!.clear()
    }
    
//    func isGiftStored(identifier:String) ->Bool{
//        for gift in biinie!.gifts_store {
//            if gift == identifier {
//                return true
//            }
//        }
//        return false
//    }

    func didReceivedBiinieData(user: Biinie?) {
        
        if self.biinie != nil {
            
            //TODO: Temporal hack to show notifications.
            //biinie!.gifts_store.removeAll()
            
//            for gift in user!.gifts {
//                if !isGiftStored(gift.identifier!) {
//                    //user!.newGiftCounter += 1
//                    user!.gifts_store.append(gift.identifier!)
//                }
//            }
            
            user!.notifications = self.biinie!.notifications
            user!.token = self.biinie!.token
            user!.needsTokenUpdate = self.biinie!.needsTokenUpdate
            self.biinie = user
            self.biinie!.save()
        }
        
        requestInitialData()
        
        if self.biinie!.needsTokenUpdate {
            //print("SEND TOKEN TO CMS")
            BNAppSharedManager.instance.networkManager!.sendBiinieToken(self.biinie)
        }
    }
    
    func biinieNotRegistered() {
        biinie!.clear()
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
        
        /*
        //if elementsBiined[_id] == nil {
            //elementsBiined[_id] = _id
            elements_by_id[_id]!.userCollected = true
            elements_by_id[_id]!.collectCount += 1
            return elements_by_id[_id]!.collectCount
            //TODO: Post user just biined an element
        //}
         */
        return 0
    }
    
    func receivedOrganization(organization: BNOrganization) {
        organizations[organization.identifier!] = organization
        
        //TODO: TEMPORAL, crear algunas loyaltyes
        
        
        let loyalty = BNLoyalty()
        loyalty.identifier = organization.identifier!
        loyalty.organizationIdentifier = organization.identifier!
        loyalty.loyaltyCard = BNLoyaltyCard()
        loyalty.loyaltyCard!.title = "Tarjeta de cliente frecuente"
        loyalty.loyaltyCard!.goal = "Obten un regalo gratis al completar 10 estrellitas"
        loyalty.loyaltyCard!.rule = "Por la compra de 3750 o más recibe una estrella."
        loyalty.loyaltyCard!.elementIdentifier = "8bf8a6cc-8542-4d89-b2b8-848d7cb4dloca02e"
        loyalty.loyaltyCard!.conditions = "Al hacer tap en OK aceptas las condiciones de uso de la tarjeta de clientes frecuente de Tukasa."
        loyalty.loyaltyCard!.startDate = NSDate()
        loyalty.loyaltyCard!.endDate = NSDate()
        loyalty.loyaltyCard!.isCompleted = false
        loyalty.loyaltyCard!.isUnavailable = false
        loyalty.loyaltyCard!.isBiinieEnrolled = false
        
        var i = 0
        while i < 10 {
            i += 1
            var slot = BNLoyaltyCard_Slot()
//            if i < 5 {
//                slot.isFilled = true
//            } else {
                slot.isFilled  = false
//            }
            loyalty.loyaltyCard!.slots.append(slot)
        }
        
        biinie!.loyalties[organization.identifier!] = loyalty
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

            site.surveyCompleted = BNAppSharedManager.instance.notificationManager.is_site_surveyed(site.identifier!)
            
            sites[site.identifier!] = site
            
//            if sites[site.identifier!] == nil {
//                
//            }
            
            if commercialUUID == nil {
                commercialUUID = site.proximityUUID
            }
            
            for notice in BNAppSharedManager.instance.notificationManager.localNotices {
                if notice.major == site.major! {
                    notice.siteIdentifier = site.identifier!
                }
            }
            
            BNAppSharedManager.instance.notificationManager.save()
     
          /*
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

                                        let notificaitonText = "\(site.title!) - \(object.notification!)"
                                        BNAppSharedManager.instance.notificationManager.addLocalNotification(object, notificationText:notificaitonText, notificationType: BNLocalNotificationType.EXTERNAL, siteIdentifier: site.identifier!, biinIdentifier: biin.identifier!, elementIdentifier: object.identifier!)

                                    break
                                case .INTERNO:
                                    break
                                case .PRODUCT:
                                    break
                                default:
                                    break
                                }
                            }
                            

                            break
                        default:
                            break
                        }
                    }
                }
            }
        */
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
        if elements[element.identifier!] == nil {
            elements[element.identifier!] = element
        }
    }

    
    func receivedElementOnCategory(_id: String, identifier:String, showcase_id:String) {
        /*
        //Check if element exist.
        if elements_by_id[_id] == nil {
            
            //Checks if element received is already on elements_by_identifier list.
            if let element = elements[identifier] {
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
 */
    }
    
    func receivedHightlight(highlights:Array<BNElementRelationShip>) {

        self.highlights = highlights
    }
    
    func receivedCategories(categories:Array<BNCategory>) {
        
        biinie!.categories.removeAll(keepCapacity: false)
        biinie!.categories = Array<BNCategory>()
        
        for category in categories {
            category.name = findCategoryNameByIdentifier(category.identifier!)
            biinie!.addCategory(category)
        }
    }
    
    
    func applyCollectedElement(element:BNElement?) {
        
        /*
        if self.bnUser!.collections![self.bnUser!.temporalCollectionIdentifier!]?.elements[element!._id!] == nil {
        
            self.bnUser!.collections![self.bnUser!.temporalCollectionIdentifier!]?.elements[element!._id!] = self.elements_by_id[element!._id!]

            element!.collectCount += 1
            elements[element!.identifier!]?.collectCount = element!.collectCount
            elements[element!.identifier!]?.userCollected = element!.userCollected
            
            for (identifier, clone) in elements_by_id {
                if element!.identifier! == identifier {
                    clone.collectCount = element!.collectCount
                    clone.userCollected = element!.userCollected
                }
            }
        }
         */
    }
    
    
    func applyUnCollectedElement(element:BNElement?) {

//        self.bnUser!.collections![self.bnUser!.temporalCollectionIdentifier!]!.elements.removeValueForKey(element!._id!)
        
        removeFavoriteElement(element!.identifier!)
        
        elements[element!.identifier!]?.userCollected = element!.userCollected
        
        /*
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userCollected = element!.userCollected
            }
        }
         */
    
    }


    func applyLikeElement(element:BNElement?) {
        
        removeFavoriteElement(element!.identifier!)
        elements[element!.identifier!]?.userLiked = element!.userLiked
        
        if element!.userLiked {
            addFavoriteElement(element!.identifier!, showcaseIdentifier: element!.showcase!.identifier!, siteIdentifier: element!.showcase!.site!.identifier!)
        } else {
            removeFavoriteElement(element!.identifier!)
        }
        /*
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userLiked = element!.userLiked
            }
        }
         */
    }
    
    func applyShareElement(element:BNElement?) {
        
        elements[element!.identifier!]?.userShared = element!.userShared
        
//        for (identifier, clone) in elements_by_id {
//            if element!.identifier! == identifier {
//                clone.userShared = element!.userShared
//            }
//        }
    }
    
    func applyViewedElement(element:BNElement?) {

        element!.userViewed = true
        
        //TODO: this action should have the _id and identifier sent
        BNAppSharedManager.instance.dataManager.biinie!.addAction(NSDate(), did:BiinieActionType.ENTER_ELEMENT_VIEW, to:element!.identifier!, by:element!.showcase!.site!.identifier!)
        
        elements[element!.identifier!]?.userViewed = element!.userViewed
        /*
        for (identifier, clone) in elements_by_id {
            if element!.identifier! == identifier {
                clone.userViewed = element!.userViewed
            }
        }
         */
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
    
    func addFavoriteElement(identifier:String, showcaseIdentifier:String, siteIdentifier:String) {
        var isAdded = false
        for i in (0..<favoritesElements.count) {
            if favoritesElements[i].identifier == identifier {
                isAdded = true
            }
        }
        
        if !isAdded {
            favoritesElements.insert(BNElementRelationShip(identifier: identifier, showcase: showcaseIdentifier, site: siteIdentifier), atIndex: 0)
        }
    }
    
    func removeFavoriteElement(identifier:String) {
        for i in (0..<favoritesElements.count) {
            if favoritesElements[i].identifier == identifier {
                favoritesElements.removeAtIndex(i)
                break
            }
        }
    }
    
    func findSiteByMajor(major:Int) -> BNSite? {
        
        for ( _, site) in self.sites {
            if site.major! == major {
                return site
            }
        }
        
        return nil
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
    optional func manager(manager:BNDataManager!, initialdata user:Biinie?)
    
    
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
    optional func manager(manager:BNDataManager!, requestCategoriesData user:Biinie?)
    
    
    ///Request user categories.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the data.
    optional func manager(manager:BNDataManager!, requestCategoriesDataByBiinieAndRegion user:Biinie?, region:BNRegion)
    
    ///Request a site's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNSite: requesting the data.
    optional func manager(manager:BNDataManager!, requestSiteData site:BNSite?, user:Biinie?)
    
    
    ///Request a organization's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNOrganization: requesting the data.
    optional func manager(manager:BNDataManager!, requestOrganizationData organization:BNOrganization?, user:Biinie?)
    
    
    
    ///Request showcase's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNShowcase: requesting the data.
    optional func manager(manager:BNDataManager!, requestHighlightsData user:Biinie?)
    
    ///Request showcase's data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNShowcase: requesting the data.
    optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase?, user:Biinie?)
    
    ///Request element's data for BNUser (app user)
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNElement: requesting the data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement?, user:Biinie?)
    
    ///Request user biined element's.
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the element's data.
    optional func manager(manager:BNDataManager!, requestBiinedElementListForBNUser user:Biinie?)
    
    ///Request user (biinie) data
    ///
    ///- parameter BNDataManager: that store all data.
    ///- parameter BNUser: requesting the element's data.
    optional func requestBiinieData(manager:BNDataManager?, biinie:Biinie?)
    
    
    
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

