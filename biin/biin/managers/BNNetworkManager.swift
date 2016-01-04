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
    let connectibityUrl = "http://google.com/"

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
    var queueLimit = 10
    
    var totalNumberOfRequest = 0
    var requestProcessed = 0
    
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
            rootURL = "https://demo-biin-backend.herokuapp.com"
        } else if BNAppSharedManager.instance.settings!.IS_QA_DATABASE {
            rootURL = "https://qa-biin-backend.herokuapp.com"
        } else if BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE {
            rootURL = "https://dev-biin-backend.herokuapp.com"//"https://dev-biinapp.herokuapp.com"
        }
    }
    
    //Saving data
    func manager(manager: BNDataManager!, saveUserCategories user: Biinie) {
        
    }
    

    
    func runQueue(){
        
        var totalRequestRunnin = 0

        if requestsQueue.count == 0 {
            
//            let delayInSeconds = 0.5;
//            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
//            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            

                self.delegateVC!.manager!(self, didReceivedAllInitialData: true)

                // -- FINISHED SOMETHING AWESOME, WOO! --
            
                if BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA {
                    BNAppSharedManager.instance.mainViewController!.refresh()
                    BNAppSharedManager.instance.IS_APP_REQUESTING_NEW_DATA = false
                }
//            }
        }
        
        for (_, request) in requestsQueue {
            if !request.isRunning {
                
            } else {
                totalRequestRunnin++
            }
        }
        
        for (_, request) in requestsQueue {
            
            if queueCounter >= queueLimit {
    
                return
            }
            
            if !request.isRunning {
                
                request.run()
                
                queueCounter++
    
            } else {

            }
        }
    }
    
    func removeFromQueue(request:BNRequest){
        queueCounter--
        requestProcessed++
        
        request.clean()
        requestsQueue.removeValueForKey(request.identifier)

        if queueCounter < 10 {
            runQueue()
        }
        
        let value:CGFloat = (CGFloat(requestProcessed) / CGFloat(totalNumberOfRequest))
        delegateVC!.manager!(self, updateProgressView:Float(value))
    }
    
    func addToQueue(request:BNRequest){
        self.requestsQueue[request.identifier] = request
        runQueue()
        totalNumberOfRequest++
    }
    
    func isQueued(stringUrl:String) -> Bool {
        
        for (_, request) in self.requestsQueue {
            if stringUrl == request.requestString {
                return true
            }
        }
        return false
    }
 
    func checkConnectivity() {
        
        let request = BNRequest_ConnectivityCheck(requestString: connectibityUrl, dataIdentifier: "", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
        
    }
    
    func addTo_OLD_QUEUE(request:BNRequest) {
        self.requests[request.identifier] = request
    }
    
    
    /**
    Enable biinie to login.
    @param email:Biinie email.
    @param password:Biinie password.
    */
    func login(email:String, password:String){
        let request = BNRequest_Login(requestString: "\(rootURL)/mobile/biinies/auth/\(email)/\(password)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Enable biinie to register.
    @param user:Biinie data.
    */
    func register(user:Biinie) {
        
        var date:String?
        
        if user.birthDate != nil {
            date = user.birthDate?.bnDateFormattForActions()
        }else {
            date = "none"
        }
        
        let request = BNRequest_Register(requestString: "\(rootURL)/mobile/biinies/\(SharedUIManager.instance.fixEmptySpace(user.firstName!))/\(user.lastName!)/\(user.email!)/\(user.password!)/\(user.gender!)/\(date!)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Request all biinie data
    @param biinie:Biinie object.
    */
    func manager(manager:BNDataManager!, requestBiinieData biinie:Biinie) {
        let request = BNRequest_Biinie(requestString: "\(rootURL)/mobile/biinies/\(biinie.identifier!)", errorManager: self.errorManager!, networkManager: self, user: biinie)
        addToQueue(request)
    }
    
    /**
    Send biinie data.
    @param user:Biinie data.
    */
    func sendBiinie(user:Biinie) {
        let request = BNRequest_SendBiinie(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)", errorManager:self.errorManager!, networkManager:self, user:user)
        addToQueue(request)
    }
    
    /**
    Send biinie actions.
    @param user:Biinie data.
    */
    func sendBiinieActions(user:Biinie) {
        if user.actions.count > 0 {
            let request = BNRequest_SendBiinieActions(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/history", errorManager: self.errorManager!, networkManager: self, user: user)
            addToQueue(request)
        }
    }
    
    /**
    Send biinie categories.
    @param user:Biinie data.
    @param categories:List of categories seleted by biinie.
    */
    func sendBiinieCategories(user:Biinie, categories:Dictionary<String, String>) {
        let request = BNRequest_SendBiinieCategories(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/categories", errorManager: self.errorManager!, networkManager: self, categories: categories)
        addToQueue(request)
    }

    /**
    Send biinie earned points in organization.
    @param user:Biinie data.
    @param organization:Organization where biine win points.
    @param points:Amount of points earned by biinied
    */
    func sendBiiniePoints(user:Biinie, organization:BNOrganization, points:Int) {
        let request = BNRequest_SendBiiniePoints(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/organizations/\(organization.identifier!)/loyalty/points", errorManager: self.errorManager!, networkManager: self, user: user, organization: organization, points: points)
        addToQueue(request)
    }
    
    /**
    Checks is user email has been verified.
    @param identifier:Biinie identifier.
    */
    func manager(manager:BNDataManager!, checkIsEmailVerified identifier:String) {
        let request = BNRequest_CheckEmail_IsVerified(requestString: "\(rootURL)/mobile/biinies/\(identifier)/isactivate", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    
    func manager(manager: BNDataManager!, initialdata user: Biinie) {
        
//        
//        if SimulatorUtility.isRunningSimulator {
//            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.9339660564594, -84.05398699629518)
//        } else
        if BNAppSharedManager.instance.positionManager.userCoordinates == nil {
            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.73854872449546, -83.99879993264159)
        }
        
        let s1 = "\(rootURL)/mobile/initialData/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)"
        //let s1 = "https://dev-biin-backend.herokuapp.com/mobile/initialData"
        
        let request = BNRequest_InitialData(requestString:s1, errorManager: self.errorManager!, networkManager: self)
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
        
        let request = BNRequest_Categories(requestString:"\(rootURL)/mobile/biinies/\(user.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)/categories", errorManager: self.errorManager!, networkManager:self)
        addToQueue(request)
    }
    
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestShowcaseData showcase:BNShowcase, user:Biinie) {
        
        let request = BNRequest_Showcase(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/showcases/\(showcase.identifier!)/", errorManager: self.errorManager!, networkManager: self, showcase: showcase, user: user)
        addToQueue(request)
    }
    
    /**
    Conforms optional     optional func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:BNUser) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestElementDataForBNUser element:BNElement, user:Biinie) {
        let request = BNRequest_Element(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/elements/\(element.identifier!)", dataIdentifier: "", errorManager: self.errorManager!, networkManager: self, element: element)
        addToQueue(request)
    }
    
    ///Conforms optional func manager(manager: BNDataManager!, requestBoardsForBNUser user: BNUser) of BNDataManagerDelegate.
    func manager(manager: BNDataManager!, requestCollectionsForBNUser user: Biinie) {
        ///mobile/biinies/ca8bca2e-db80-40e8-a017-7badd86d0ab8/requestCollection
        let request = BNRequest_CollectionsForBiinie(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/requestCollection", errorManager: self.errorManager!, networkManager: self)
        
//        let request = BNRequest_Collections(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/requestCollection", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    */
    func manager(manager:BNDataManager!, requestSiteData site:BNSite, user:Biinie) {
        let request = BNRequest_Site(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/sites/\(site.identifier!)", dataIdentifier: "", errorManager: self.errorManager!, networkManager: self, site: site)
        self.addToQueue(request)
    }
    
    /**
    Conforms optional func manager(manager:BNDataManager!, requestSiteData site:BNSite) of BNDataManagerDelegate.
    */
    func manager(manager: BNDataManager!, requestOrganizationData organization: BNOrganization, user: Biinie) {
        
        let request = BNRequest_Organization(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/organizations/\(organization.identifier!)", dataIdentifier: "", errorManager: self.errorManager!, networkManager: self, organization: organization)
        addToQueue(request)
        
    }
    
    /**
    Social Element Methods
    */
    /*
    func sendBiinedElement(user: Biinie, element: BNElement, collectionIdentifier:String) {
        let request = BNRequest_SendBiinedElement(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)", errorManager: self.errorManager!, networkManager: self, element:element)
        addToQueue(request)
    }
    
    func sendUnBiinedElement(user: Biinie, element:BNElement, collectionIdentifier:String) {
        let request = BNRequest_SendUnBiinedElement(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)/element/\(element.identifier!)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    */
    
    func sendCollectedElement(user: Biinie, element: BNElement?, collectionIdentifier:String) {
        
        let request = BNRequest_SendCollectedElement(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collect/\(collectionIdentifier)", errorManager: self.errorManager!, networkManager: self, element:element)
        addToQueue(request)
    }
    
    func sendUnCollectedElement(user: Biinie, element:BNElement?, collectionIdentifier:String) {
        let request = BNRequest_SendUnCollectedElement(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collect/\(collectionIdentifier)/element/\(element!.identifier!)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    func sendLikedElement(user:Biinie, element:BNElement?) {

        var like = "unlike"
        if element!.userLiked {
            like = "like"
        }
        
        let request = BNRequest_SendLikedElement(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/\(like)", errorManager: self.errorManager!, networkManager: self, element: element)
        
        addToQueue(request)
    }
    
    func sendSharedElement(user: Biinie, element: BNElement?) {
        let request = BNRequest_SendSharedElement(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/share", errorManager: self.errorManager!, networkManager: self, element: element)
        addToQueue(request)
    }
    
    
    /**
    Social Site Methods
    */
    /*
    func sendBiinedSite(user: Biinie, site: BNSite, collectionIdentifier:String) {
        let request = BNRequest_SendBiinedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)", errorManager: self.errorManager!, networkManager: self, site: site)
        addToQueue(request)
    }
    
    func sendUnBiinedSite(user: Biinie, site:BNSite, collectionIdentifier:String) {
        let request = BNRequest_SendUnBiinedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collections/\(collectionIdentifier)/site/\(site.identifier!)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    */
    
    func sendCollectedSite(user: Biinie, site: BNSite, collectionIdentifier:String ) {
        let request = BNRequest_SendCollectedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collect/\(collectionIdentifier)", errorManager: self.errorManager!, networkManager: self, site: site)
        addToQueue(request)
    }
    
    func sendUnCollectedSite(user: Biinie, site:BNSite, collectionIdentifier:String ) {
        let request = BNRequest_SendUnCollectedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/collect/\(collectionIdentifier)/site/\(site.identifier!)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    func sendLikedSite(user: Biinie, site: BNSite?) {

        var like = "unlike"
        if site!.userLiked {
            like = "like"
        }
        
        let request = BNRequest_SendLikedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/\(like)", errorManager: self.errorManager!, networkManager: self, site:site)

        addToQueue(request)
    }
    
    func sendFollowedSite(user:Biinie, site:BNSite?) {
        
        var follow = "unfollow"
        if site!.userFollowed {
            follow = "follow"
        }

        let request = BNRequest_SendFollowedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/\(follow)", errorManager: self.errorManager!, networkManager: self, site: site)

        addToQueue(request)
    }
    
    func sendSharedSite(user:Biinie, site:BNSite? ) {
        let request = BNRequest_SendSharedSite(requestString: "\(rootURL)/mobile/biinies/\(user.identifier!)/share", errorManager: self.errorManager!, networkManager: self, site: site)
        addToQueue(request)
    }

    
    
    func requestElementsForShowcase(showcase: BNShowcase?, view: BNView?) {
        
        let url = "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.bnUser!.identifier!)/requestElementsForShowcase/\(showcase!.site!.identifier!)/\(showcase!.identifier!)/\(showcase!.batch)"
        
        //let url = "https://dev-biin-backend.herokuapp.com/mobile/nextElementsInShowcaseTemp"
        let request = BNRequest_ElementsForShowcase(requestString: url, errorManager: self.errorManager!, networkManager: self, showcase: showcase, user:BNAppSharedManager.instance.dataManager.bnUser , view: view)
        addToQueue(request)
    }
    
    func requestElementsForCategory(category:BNCategory?, view:BNView?){
        let url = "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.bnUser!.identifier!)/requestElementsForCategory/\(category!.identifier!)/0"
        let request = BNRequest_ElementsForCategory(requestString: url, errorManager: self.errorManager!, networkManager: self, category:category, view:view)
        addToQueue(request)
    }
    
    func requestSites(view: BNView?) {
        let url = "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.bnUser!.identifier!)/requestSites/0"
        let request = BNRequest_Sites(requestString: url, errorManager: self.errorManager!, networkManager: self, view: view)
        addToQueue(request)
    }
    
    
    func runRequest(){
        
        for (_, value) in requests {
            
            switch value.requestType {

            default:
                break
            }
            
            return
        }
        
    }


    
    
    
    
    
    

    
    
    
    
    func removeImageRequest(stringUrl:String){
        for (_, request) in self.requests {
            if stringUrl == request.requestString {
                self.removeRequestOnCompleted(request.identifier)
                break
            }
        }
    }
    

    func requestImageData(stringUrl:String, image:BNUIImageView!) {
        
        if !isQueued(stringUrl) {
            
            let request = BNRequest_Image(requestString: stringUrl, errorManager: self.errorManager!, networkManager: self, image:image)
            addToQueue(request)
        } else {
            epsNetwork!.getImageInCache(stringUrl, image: image)
        }
    }
    
    func handleFailedRequest(request:BNRequest, error:NSError? ) {
        
        print("Request error: \(error!.code) request: \(request.requestString)")
        
        
        if error?.code == -1001 && request.requestType == .InitialData{
            request.requestAttemps = 0
            request.isRunning = false
            self.errorManager!.showServerError()

        }
        
        switch request.requestType {
        case .None:
            break
        case .Login:
            let response:BNResponse = BNResponse(code:9, type: BNResponse_Type.RequestFailed)
            self.delegateVC!.manager!(self, didReceivedLoginValidation: response)
            break
        case .Register:
            let response:BNResponse = BNResponse(code:10, type: BNResponse_Type.Suck)
            self.delegateVC!.manager!(self, didReceivedLoginValidation: response)
            break
        case .Biinie, .SendBiinie, .SendBiiniePoints, .SendBiinieActions, .SendBiinieCategories, .SendCollectedElement, .SendUnCollectedElement, .SendLikedElement, .SendSharedElement, .SendCollectedSite, .SendUnCollectedSite, .SendFollowedSite, .SendLikedSite, .SendSharedSite, .CheckEmail_IsVerified, .Site, .Showcase, .Element, .Categories, .Organization, .Collections, .ElementsForShowcase:
            
            if request.requestAttemps >= 3 {
                request.requestAttemps = 0
                request.isRunning = false
                self.errorManager!.showInternetError()
            } else {
                request.isRunning = false
                request.run()
            }
            
            break
        case .Image:
            
            request.isRunning = false
            request.run()
            
            break
        case .ConnectivityCheck:
            if request.requestAttemps >= 3 {
                request.requestAttemps = 0
                request.isRunning = false
                self.errorManager!.showInternetError()
            } else {
                request.isRunning = false
                request.run()
            }
            break
        case .ServerError:
            if request.requestAttemps >= 3 {
                request.requestAttemps = 0
                request.isRunning = false
                self.errorManager!.showServerError()
            } else {
                request.isRunning = false
                request.run()
            }
            break
        default:
            break
        }
    }
    
    func resume(){
        for (_, request) in requestsQueue {
            if !request.isRunning {
                request.run()
            }
        }
    }
    
    //Request to remove a showcase when it data is corrupt or is not longer in server.
    func removeShowcase( identifier:String ) {
    }

    //BNErrorManagerDelegate
    func manager(manager:BNErrorManager!, saveError error:BNError) {
        //var url = "http://biin.herokuapp.com/api/errors/add/"
        //var parameters = ["code": error.code, "title":error.title, "description":error.errorDescription, "proximityUUID":error.proximityUUID, "region":error.region]
    }
    
    func removeRequestOnCompleted(identifier:Int){
        
        requests.removeValueForKey(identifier)
        requestAttempts = 0
        
        if requests.count == 0 {
            
        } else {
            
            if requests.count == 1 {

            }
        }
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
    ///- parameter BNNetworkManager.:
    ///- parameter Status: of the network check.
    optional func manager(manager:BNNetworkManager!, didReceivedConnectionStatus status:Bool)
    
    ///Takes categories data requested and procces that data.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter An: array of categories.
    optional func manager(manager:BNNetworkManager!, didReceivedUserCategories categories:Array<BNCategory>)

    optional func manager(manager:BNNetworkManager!, didReceivedUserCategoriesOnBackground categories:Array<BNCategory>)

    
//    optional func receivedSite(site:BNSite)
//    optional func receivedOrganization(organization:BNOrganization)
//    optional func receivedShowcase(showcase:BNShowcase)
//    optional func receivedElement(element:BNElement)
//    optional func receivedHightlight(element:BNElement)
    
    
    ///Takes site data requested and proccess that data.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter BNSite: requested.
    optional func manager(manager:BNNetworkManager!, didReceivedSite site:BNSite)
    
    ///Takes showcase data requested and proccess that data.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter BNShowcase: requested.
    optional func manager(manager:BNNetworkManager!, didReceivedShowcase showcase:BNShowcase)
    
    ///Takes element data requested and proccess that data.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter BNElement: requested.
    optional func manager(manager:BNNetworkManager!, didReceivedElement element:BNElement)
    
    
    
    optional func manager(manager:BNNetworkManager!, didReceivedHihglightList showcase:BNShowcase)

    
    
    ///Takes element data requested and proccess that data.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter BNElement: requested.
    //optional func manager(manager:BNNetworkManager!, didReceivedHightlight element:BNElement)
    
    
    ///Takes user biined element list and process data and request to download elements.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter BNElement: list biined by user.
    optional func manager(manager:BNNetworkManager!, didReceivedBiinedElementList elementList:Array<BNElement>)
    
    
    ///Takes user boards and process data and request to download elements.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter User: boards.
    optional func manager(manager:BNNetworkManager!, didReceivedCollections collectionList:Array<BNCollection>)
    
    
    
    
    
    optional func manager(manager:BNNetworkManager!, updateProgressView value:Float)

    

    

    ///Takes a notification string data requested for a element and proccess that data.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter String: notification requested.
    ///- parameter BNEelement: requesting the data.
    optional func manager(manager:BNNetworkManager!, didReceivedElementNotification notification:String, element:BNElement)
    
    
    ///Notifies main menu view that all initial data is downloaded and is safe to enter the app.
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter Just: a flag.
    optional func manager(manager:BNNetworkManager!, didReceivedAllInitialData value:Bool)
    
    
    optional func manager(manager:BNNetworkManager!, didReveivedBiinsOnRegion biins:Array<BNBiin>, identifier:String)
    
    optional func manager(manager:BNNetworkManager!, didReceivedBiinieData user:Biinie, isBiinieOnBD:Bool)
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
    
    func bnDateFormattForActions() -> String {
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
        let unit:NSCalendarUnit = .Day
        let components = cal.components(unit, fromDate:toDate, toDate:NSDate(), options: [])
        return (components.day + 1)
    }
}

extension String {
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString  
        
        return nsSt.stringByAppendingPathExtension(ext)  
    }  
}
