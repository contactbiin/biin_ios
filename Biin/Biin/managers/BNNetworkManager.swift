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
    var versionUrl = ""
    
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
    
    var requestManager:BNRequestManager?
    
    init(errorManager:BNErrorManager) {
        //Initialize here any data or variables.
        super.init()
        self.errorManager = errorManager
        epsNetwork = EPSNetworking()
        requestManager = BNRequestManager(networkManager: self, errorManager: errorManager)
    }
    
    func setRootURLForRequest(){
        
        var value = ""
        if BNAppSharedManager.instance.settings!.IS_PRODUCTION_DATABASE {
            value = "prod"
        } else if BNAppSharedManager.instance.settings!.IS_DEMO_DATABASE {
            value = "demo"
        } else if BNAppSharedManager.instance.settings!.IS_QA_DATABASE {
            value = "qa"
        } else if BNAppSharedManager.instance.settings!.IS_DEVELOPMENT_DATABASE {
            value = "dev"
        }
        
        self.versionUrl = "https://www.biin.io/checkversion/\(BNAppSharedManager.instance.version)/ios/\(value)"
        //print(versionUrl)
    }
    
    //New request manager calls
    func internet_Failed() {
        self.errorManager!.showInternetError()
    }
    
    func initialData_Completed() {
        self.delegateVC!.didReceivedAllInitialData!()
    }
    
    func initialData_Failed(){ }
    
    func versionCheck_Completed() {
        self.delegateVC!.didReceivedVersionStatus!()
    }
    
    func versionCheck_Failed() {
        self.errorManager!.showVersionError()
    }
    
    func biinie_Completed(biinie:Biinie?) {
        self.delegateDM!.didReceivedBiinieData!(biinie)
    }
    
    func biinie_Failed() { }
    
    func biinie_NotRegistered() {
        self.delegateDM!.biinieNotRegistered!()
        self.errorManager!.showNotBiinieError()
    }
    
    func sendBiinieActions_Completed(){
        BNAppSharedManager.instance.dataManager.biinie!.actions.removeAll(keepCapacity: false)
        BNAppSharedManager.instance.dataManager.biinie!.save()
    }
    
    func sendBiinieActions_Failed() { }
    
    func sendBiinieToken_Completed() { }
    
    func sendBiinieToken_Failed() {
        BNAppSharedManager.instance.dataManager!.biinie!.token! = ""
        BNAppSharedManager.instance.dataManager!.biinie!.save()
    }
    
    func sendBiinieOnEnterSite_Completed() {
        
    }
    
    func sendBiinieOnExitSite_Completed() {
        
    }
    
    func login_Completed() {
        self.delegateVC!.didReceivedLoginValidation!(true)
    }
    
    func login_Failed() {
        self.delegateVC!.didReceivedLoginValidation!(false)
    }
    
    func login_Facebook_Completed() {
        self.delegateVC!.didReceivedFacebookLoginValidation!(true)
    }
    
    func login_Facebook_Failed() {
        self.delegateVC!.didReceivedFacebookLoginValidation!(false)
    }
    
    func register_Completed() {
        self.delegateVC!.didReceivedRegisterConfirmation!(true)
    }
    
    func register_Failed() {
        self.delegateVC!.didReceivedRegisterConfirmation!(true)
    }
    
    func sendBiinie_Update_Completed() {
        self.delegateVC!.didReceivedUpdateConfirmation!(true)
    }
    
    func sendBiinie_Failed() {
        self.delegateVC!.didReceivedUpdateConfirmation!(false)
    }
    
    func sendBiinieOnEnterSite_Failed() {
        
    }
    
    func sendBiinieOnExitSite_Failed() {
        
    }
    
    func addToQueue(request:BNRequest){
        self.requestManager!.processRequest(request)
    }
    
    func checkVersion() {
        let request = BNRequest_VersionCheck(requestString:versionUrl, errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    func addTo_OLD_QUEUE(request:BNRequest) {
        self.requests[request.identifier] = request
    }
    
    func sendClaimedGift_Completed(){
        
    }
    
    func sendClaimedGift_Failed(){
        
    }
    
    func sendRefusedGift_Completed() {
        
    }
    
    
    func sendRefusedGift_Failed() {
        
    }
    
    /**
    Enable biinie to login.
    @param email:Biinie email.
    @param password:Biinie password.
    */
    func login(email:String, password:String){
//        
//        let address = "\(rootURL)/mobile/biinies/auth/\(email)/\(password)"
//        let escapedAddress = address.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        let urlpath = NSString(format: "\(escapedAddress!)")
        
        let url : NSString = "\(rootURL)/mobile/biinies/auth/\(email)/\(password)"
//        let urlStr : NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        let stringURL : NSURL = NSURL(string: "\(urlStr)")!
        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        let request = BNRequest_Login(requestString:"\(urlStr)" , errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    
    /**
     Enable biinie to login.
     @param email:Biinie email.
     @param password:Biinie password.
     */
    func login_Facebook(email:String){
        let url : NSString = "\(rootURL)/mobile/biinies/auth/thirdparty/facebook/\(email)"
        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        let request = BNRequest_Login_Facebook(requestString:"\(urlStr)" , errorManager: self.errorManager!, networkManager: self)
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
        
        let url : NSString = "\(rootURL)/mobile/biinies/\(SharedUIManager.instance.fixEmptySpace(user.firstName!))/\(user.lastName!)/\(user.email!)/\(user.password!)/\(user.gender!)/\(date!)"

        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        let request = BNRequest_Register(requestString: "\(urlStr)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
     Enable biinie to register using Facebook.
     @param user:Biinie data.
     */
    func register_with_Facebook(user:Biinie) {
        
        var date:String?
        
        if user.birthDate != nil {
            date = user.birthDate?.bnDateFormattForActions()
        }else {
            date = "none"
        }
        
        if user.password == "" {
            user.password = "none"
        }
        
        let url : NSString = "\(rootURL)/mobile/biinies/facebook/\(SharedUIManager.instance.fixEmptySpace(user.firstName!))/\(user.lastName!)/\(user.email!)/\(user.password!)/\(user.gender!)/\(date!)/\(user.facebook_id!)"
    
        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        let request = BNRequest_Register_with_Facebook(requestString: "\(urlStr)", errorManager: self.errorManager!, networkManager: self)
        addToQueue(request)
    }
    
    /**
    Request all biinie data
    @param biinie:Biinie object.
    */
    func requestBiinieData(manager:BNDataManager?, biinie: Biinie?) {
        let request = BNRequest_Biinie(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)", errorManager: self.errorManager!, networkManager: self, biinie: biinie)
        addToQueue(request)
    }
    
    /**
    Send biinie data.
    @param user:Biinie data.
    */
    func sendBiinie(biinie:Biinie?) {
        let request = BNRequest_SendBiinie(requestString:"\(rootURL)/mobile/biinies/\(biinie!.identifier!)", errorManager:self.errorManager, networkManager:self, biinie:biinie)
        addToQueue(request)
    }
    
    func sendBiinieToken(biinie:Biinie?) {
        //PUT /mobile/biinies/<identifierbiinie>/registerfornotifications
        let request = BNRequest_SendBiinieToken(requestString:"\(rootURL)/mobile/biinies/\(biinie!.identifier!)/registerfornotifications", errorManager: self.errorManager!, networkManager: self, biinie: biinie)
        addToQueue(request)
    }
    
    func sendBiinieOnEnterSite(biinie:Biinie?, siteIdentifier:String?, time:NSDate?) {
        let request = BNRequest_SendBiinieOnEnterSite(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/onentersite/\(siteIdentifier!)", errorManager: self.errorManager, networkManager: self, biinie: biinie, time: time)
        addToQueue(request)
    }
    
    func sendBiinieOnExitSite(biinie:Biinie?, siteIdentifier:String?, time:NSDate?) {
        let request = BNRequest_SendBiinieOnExitSite(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/onexitsite/\(siteIdentifier!)", errorManager: self.errorManager, networkManager: self, biinie: biinie, time: time)
        addToQueue(request)
    }
    
    /**
    Send biinie actions.
    @param user:Biinie data.
    */
    func sendBiinieActions(biinie:Biinie?) {
        if biinie!.actions.count > 0 {
            let request = BNRequest_SendBiinieActions(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/history", errorManager: self.errorManager, networkManager: self, biinie: biinie)
            addToQueue(request)
        }
    }
    
    //LOYALTY
    func sendLoyaltyCardEnrolled(biinie:Biinie?, loyalty:BNLoyalty?){
        //get /mobile/biinies/:identifier/cards/enroll/:cardidentifier
        let request = BNRequest_SendLoyaltyCardEnrolled(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/cards/enroll/\(loyalty!.loyaltyCard!.identifier!)", errorManager: self.errorManager, networkManager: self, biinie: biinie, loyalty: loyalty)
        addToQueue(request)
    }
    
    func sendLoyaltyCardAddStar(biinie:Biinie?, loyalty:BNLoyalty?){
        //get /mobile/biinies/:identifier/cards/setStar/:cardidentifier
        let request = BNRequest_SendLoyaltyCardAddStar(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/cards/setStar/\(loyalty!.loyaltyCard!.identifier!)/\(BNAppSharedManager.instance.dataManager.qrCode!)", errorManager: self.errorManager, networkManager: self, biinie: biinie, loyalty: loyalty)
        addToQueue(request)
    }
    
    func sendLoyaltyCardCompleted(biinie:Biinie?, loyalty:BNLoyalty?){
        //get /mobile/biinies/:identifier/cards/setCompleted/:cardidentifier
        let request = BNRequest_SendLoyaltyCardCompleted(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/cards/setCompleted/\(loyalty!.loyaltyCard!.identifier!)", errorManager: self.errorManager, networkManager: self, biinie: biinie, loyalty: loyalty)
        addToQueue(request)
    }
    
    func manager(manager: BNDataManager!, initialdata biinie: Biinie?) {
        
        if BNAppSharedManager.instance.positionManager.userCoordinates == nil {
            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.73854872449546, -83.99879993264159)
        }
        
        let s1 = "\(rootURL)/mobile/initialData/\(biinie!.identifier!)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)/\(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)"
        
        let request = BNRequest_InitialData(requestString:s1, errorManager: self.errorManager!, networkManager: self)
        
        addToQueue(request)
    }
    
    func sendLikedElement(biinie:Biinie?, element:BNElement?) {

        var like = "unlike"
        if element!.userLiked {
            like = "like"
        }
        
        let request = BNRequest_SendLikedElement(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/\(like)", errorManager: self.errorManager, networkManager: self, element: element)
        
        addToQueue(request)
    }
    
    func sendSharedElement(biinie: Biinie?, element: BNElement?) {
        let request = BNRequest_SendSharedElement(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/share", errorManager: self.errorManager!, networkManager: self, element: element)
        addToQueue(request)
    }
    
    func sendLikedSite(biinie: Biinie?, site: BNSite?) {

        var like = "unlike"
        if site!.userLiked {
            like = "like"
        }
        
        let request = BNRequest_SendLikedSite(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/\(like)", errorManager: self.errorManager!, networkManager: self, site:site)

        addToQueue(request)
    }
    
    func sendSharedSite(biinie:Biinie?, site:BNSite? ) {
        let request = BNRequest_SendSharedSite(requestString: "\(rootURL)/mobile/biinies/\(biinie!.identifier!)/share", errorManager: self.errorManager!, networkManager: self, site: site)
        addToQueue(request)
    }

    func requestElementsForShowcase(showcase: BNShowcase?, view: BNView?) {
        
        let url = "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.biinie!.identifier!)/requestElementsForShowcase/\(showcase!.site!.identifier!)/\(showcase!.identifier!)/\(showcase!.batch)"
        
        let request = BNRequest_ElementsForShowcase(requestString: url, errorManager: self.errorManager!, networkManager: self, showcase: showcase, biinie:BNAppSharedManager.instance.dataManager.biinie , view: view)
        addToQueue(request)
    }
    
    func requestElementsForCategory(category:BNCategory?, view:BNView?){
        let url = "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.biinie!.identifier!)/requestElementsForCategory/\(category!.identifier!)/0"
        let request = BNRequest_ElementsForCategory(requestString: url, errorManager: self.errorManager!, networkManager: self, category:category, view:view)
        addToQueue(request)
    }
    
    func requestSites(view: BNView?) {
        let url = "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.biinie!.identifier!)/requestSites/0"
        let request = BNRequest_Sites(requestString: url, errorManager: self.errorManager!, networkManager: self, view: view)
        addToQueue(request)
    }
    
    func sendSurvey(biinie: Biinie?, site: BNSite?, rating:Int, comment:String) {
        let request = BNRequest_SendSurvey(requestString: "\(rootURL)/mobile/rating/site", errorManager: self.errorManager!, networkManager: self, site: site, rating: rating, comment: comment, biinie: biinie)
        
        addToQueue(request)
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
        if !self.requestManager!.isQueued(stringUrl) {
            let request = BNRequest_Image(requestString: stringUrl, errorManager: self.errorManager!, networkManager: self, image:image)
            addToQueue(request)
        } else {
            
            epsNetwork!.getImageInCache(stringUrl, image: image)
            
        }
    }
    
    func sendClaimedGift(gift:BNGift?) {
        let request = BNRequest_SendClaimedGift(requestString: "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.biinie!.identifier!)/gifts/claim", errorManager: self.errorManager!, networkManager: self, gift: gift)
        addToQueue(request)
    }
    
    func sendRefusedGift(gift:BNGift?){
        
//        var refusedGift:BNGift?
//        refusedGift = BNGift()
//        refusedGift!.identifier = gift!.identifier
//        
        let request = BNRequest_SendRefusedGift(requestString: "\(rootURL)/mobile/biinies/\(BNAppSharedManager.instance.dataManager.biinie!.identifier!)/gifts/refuse", errorManager: self.errorManager!, networkManager: self, gift: gift)
        addToQueue(request)
    }
    
    func resume(){
        self.errorManager!.isAlertOn = false
        self.requestManager!.resume()
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
    

    optional func didReceivedVersionStatus()
    optional func didReceivedAllInitialData()
    optional func didReceivedBiinieData(user:Biinie?)
    optional func biinieNotRegistered()
    optional func didReceivedLoginValidation(isValidated:Bool)
    optional func didReceivedFacebookLoginValidation(isValidated:Bool)
    optional func didReceivedRegisterConfirmation(isRegistered:Bool)
    optional func didReceivedUpdateConfirmation(updated:Bool)
    
    
    optional func manager(manager:BNNetworkManager!, didReceivedUserIdentifier idetifier:String?)
    
    optional func manager(manager:BNNetworkManager!, didReceivedEmailVerification value:Bool)
    
    optional func manager(manager:BNNetworkManager!, didReceivedCategoriesSavedConfirmation response:BNResponse?)
    
    
    optional func manager(manager:BNNetworkManager!, didReceivedInitialData biins:Array<BNBiin>?)
    
    optional func manager(manager:BNNetworkManager!, didReceivedRegions regions:Array<BNRegion>)

    ///Takes connection status and start initial requests
    ///
    ///- parameter BNNetworkManager.:
    ///- parameter Status: of the network check.
    optional func manager(manager:BNNetworkManager!, didReceivedConnectionStatus status:Bool)
//    optional func manager(manager:BNNetworkManager!, didReceivedVersionStatus)
    
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

    optional func manager(manager:BNNetworkManager!, didReveivedBiinsOnRegion biins:Array<BNBiin>, identifier:String)
    
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
    
    convenience init(dateStringMMddyyyy:String) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = formatter.dateFromString(dateStringMMddyyyy)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    convenience init(dateString_yyyyMMddZ:String) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = formatter.dateFromString(dateString_yyyyMMddZ)
        
        if dateString_yyyyMMddZ != "" {
            self.init(timeInterval:0, sinceDate:d!)
        } else {
            self.init()
        }
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
    
    func bnDateFormattForNotification() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss ZZZ"
        return formatter.stringFromDate(self)
    }
    
    func bnDisplayDateFormatt()->String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.stringFromDate(self)
    }
    
    func bnDisplayDateFormatt_by_Day()->String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
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
    
    func alredyPassedADay() {
        
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
