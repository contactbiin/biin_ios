//  SiteView_Location.swift
//  biin
//  Created by Esteban Padilla on 2/26/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit
import UberRides

class SiteView_Location:BNView, MKMapViewDelegate {

    //var siteAvatarView:UIView?
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    
    var streetAddress1:UILabel?
    var streetAddress2:UILabel?
    var ubication:UILabel?
    var phoneLbl:UILabel?
    var emailLbl:UILabel?
    var scheduleLbl:UILabel?
    //var phoneNumber:UILabel?
    //var email:UILabel?
    
    var map:MKMapView?
    
    var site_email:String?
    var site_phoneNumber:String?
    
    var commentBtn:BNUIButton_Contact?
    var closeBtn:UIButton?
    
    var siteLocation:CLLocationCoordinate2D?
    
    var yStop:CGFloat = 0

    var uber_button:RideRequestButton?
    var waze_button:UIButton?
    weak var site:BNSite?
    
    var isInSiteView = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        site_phoneNumber = ""
        site_email = ""
        
        let screenWidth = frame.width//SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        
        //let headerWidth = screenWidth - (SharedUIManager.instance.siteView_headerHeight + 10 + 45)
        var ypos:CGFloat = 10
        
        let siteAvatarSize = (SharedUIManager.instance.siteView_headerHeight)
        siteAvatar = BNUIImageView(frame: CGRectMake(5, 5, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        //self.addSubview(siteAvatar!)
        
        let xpos:CGFloat = 10
        
        title = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.bnGrayDark()
        title!.textAlignment = NSTextAlignment.Left
        title!.text = "site title here"
        title!.numberOfLines = 0
        self.addSubview(title!)
    
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        streetAddress1!.font = UIFont(name: "Lato-Regular", size: SharedUIManager.instance.siteView_nutshellSize)
        streetAddress1!.text = "Address"
        streetAddress1!.textColor = UIColor.bnGrayDark()
        streetAddress1!.numberOfLines = 0
        self.addSubview(streetAddress1!)

        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        streetAddress2 = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        streetAddress2!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        streetAddress2!.text = ""
        streetAddress2!.textColor = UIColor.bnGrayDark()
        streetAddress2!.numberOfLines = 0
        self.addSubview(streetAddress2!)
        
        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        ubication = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        ubication!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        ubication!.text = ""
        ubication!.textColor = UIColor.bnGrayDark()
        ubication!.numberOfLines = 0
        self.addSubview(ubication!)

        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        phoneLbl = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        phoneLbl!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        phoneLbl!.text = ""
        phoneLbl!.textColor = UIColor.bnGrayDark()
        phoneLbl!.numberOfLines = 0
        self.addSubview(phoneLbl!)
        
        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        emailLbl = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        emailLbl!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        emailLbl!.text = ""
        emailLbl!.textColor = UIColor.bnGrayDark()
        emailLbl!.numberOfLines = 0
        self.addSubview(emailLbl!)
        
        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        scheduleLbl = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        scheduleLbl!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        scheduleLbl!.text = ""
        scheduleLbl!.textColor = UIColor.bnGrayDark()
        scheduleLbl!.numberOfLines = 0
        self.addSubview(scheduleLbl!)
        
        ypos += 10
        map = MKMapView(frame:CGRectMake(5, ypos, (screenWidth - 10), 150))
//        map!.userInteractionEnabled = false
        map!.delegate = self
        self.addSubview(map!)
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
        ypos += 155
        
        closeBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 50))
        closeBtn!.addTarget(self, action: #selector(self.closeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        closeBtn!.setTitle(NSLocalizedString("Close", comment: "Close"), forState: UIControlState.Normal)
        closeBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        closeBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 16)
        closeBtn!.layer.cornerRadius = 2
        self.addSubview(closeBtn!)
    
//        ypos += 55
//        uber_button = RequestButton()
//        uber_button!.frame = CGRectMake(5, ypos, (self.frame.width - 10), 50)
//        uber_button!.setTitle(NSLocalizedString("UBER", comment: "UBER"), forState: UIControlState.Normal)
//        uber_button!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        uber_button!.titleLabel!.font = UIFont(name: "Lato-Black", size: 16)
//        uber_button!.backgroundColor = UIColor.bnUber()
//        uber_button!.layer.cornerRadius = 2
//        self.addSubview(uber_button!)
//        uber_button!.setNeedsDisplay()
        
        
        ypos += 55        
        uber_button = RideRequestButton()
        uber_button!.frame = CGRectMake(5, ypos, (self.frame.width - 10), 50)
        self.addSubview(uber_button!)
        
        
        ypos += 55
        waze_button = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 50))
        waze_button!.backgroundColor = UIColor.bnWaze()
        waze_button!.setTitle(NSLocalizedString("Waze", comment: "Waze"), forState: UIControlState.Normal)
        waze_button!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        waze_button!.titleLabel!.font = UIFont(name: "Lato-Black", size: 16)
        waze_button!.layer.cornerRadius = 2
        waze_button!.addTarget(self, action: #selector(self.wazeAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(waze_button!)
        
        ypos += 55
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, ypos)
        
    }
    /*
    convenience init(frame:CGRect, father:BNView?){
    self.init(frame: frame, father:father )
    self.backgroundColor = UIColor.appMainColor()
    
    var ypos:CGFloat = 3
    buttonsView = SocialButtonsView(frame: CGRectMake(0, ypos, frame.width, 15), father: self, site: site)
    self.addSubview(buttonsView!)
    
    ypos += 16
    
    var title = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_titleSize + 2)))
    title.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_titleSize)
    title.textColor = UIColor.biinColor()
    title.text = site!.title
    self.addSubview(title)
    
    ypos += SharedUIManager.instance.miniView_titleSize + 2
    
    var subTitle = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), (SharedUIManager.instance.miniView_subTittleSize + 2)))
    subTitle.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.miniView_subTittleSize)
    subTitle.textColor = UIColor.appTextColor()
    subTitle.text = "Site title here"
    self.addSubview(subTitle)
    }
    */
    override func transitionIn() {

    }
    
    override func transitionOut( state:BNState? ) {

    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {

        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {

        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance methods
    //Instance methods
    func updateForSite(site: BNSite?){
        
        self.site = site
        
        var ypos:CGFloat = title!.frame.origin.y
        let xpos:CGFloat = 10

        title!.text = ""
        title!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_titleSize + 3))
        
        
        streetAddress1!.text = ""
        streetAddress1!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_nutshellSize + 3))
        
        streetAddress2!.text = ""
        streetAddress2!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_nutshellSize + 3))
        
        ubication!.text = ""
        ubication!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_nutshellSize + 3))

        phoneLbl!.text = ""
        phoneLbl!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_nutshellSize + 3))

        emailLbl!.text = ""
        emailLbl!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_nutshellSize + 3))
        
        scheduleLbl!.text = ""
        scheduleLbl!.frame = CGRectMake(xpos, ypos, self.frame.width, (SharedUIManager.instance.siteView_nutshellSize + 3))
    
        
        //title!.textColor = site!.titleColor
        title!.text = "\(site!.title!) - \(site!.subTitle!)"
        //title!.numberOfLines = 1
        title!.sizeToFit()
        ypos += title!.frame.height
        
        //var headerWidth = SharedUIManager.instance.screenWidth - 30
        //streetAddress1!.frame = CGRectMake(streetAddress1!.frame.origin.x, ypos, (headerWidth - 95), 12)
        if site!.streetAddress1! != "" {
            streetAddress1!.frame.origin.y = ypos
            streetAddress1!.text = "\(site!.streetAddress1!)"
            streetAddress1!.sizeToFit()
            ypos += streetAddress1!.frame.height
        }
        
        if site!.streetAddress2! != "" {
            streetAddress2!.frame.origin.y = ypos
            streetAddress2!.text = "\(site!.streetAddress2!)"
            streetAddress2!.sizeToFit()
            ypos += streetAddress2!.frame.height
        }
        
        ubication!.frame.origin.y = ypos
        ubication!.text = "\(site!.country!), \(site!.state!), \(site!.zipCode!)"
        ubication!.sizeToFit()
        ypos += ubication!.frame.height

        if site!.phoneNumber! != "" {
            site_phoneNumber = site!.phoneNumber!
            phoneLbl!.frame.origin.y = ypos
            phoneLbl!.text =  "\(NSLocalizedString("Phone", comment: "Phone")): \(site!.phoneNumber!)"
            phoneLbl!.sizeToFit()
            ypos += phoneLbl!.frame.height
        }
 
        if site!.email! != "" {
            site_email = site!.email!
            emailLbl!.frame.origin.y = ypos
            emailLbl!.text = "\(NSLocalizedString("Email", comment: "Email")): \(site!.email!)"
            emailLbl!.sizeToFit()
            ypos += emailLbl!.frame.height
        }
        
        if site!.siteSchedule != "" && site!.siteSchedule != nil {
            scheduleLbl!.text = "\(NSLocalizedString("Schedule", comment: "Schedule")): \(site!.siteSchedule!)"
            scheduleLbl!.frame.origin.y = ypos
            scheduleLbl!.sizeToFit()
            ypos += scheduleLbl!.frame.height
        } else {
            //print("Site schedule not set:\(site!.identifier!)")
        }
        
        ypos += 15
        yStop = ypos

        map!.frame.origin.y = ypos
    
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(site!.latitude!), longitude: CLLocationDegrees(site!.longitude!))
        
        /*
        let sourcePlacemark = MKPlacemark(coordinate: BNAppSharedManager.instance.positionManager.userCoordinates!, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: siteLocation!, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Me"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = site!.title!
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.map!.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.map!.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map!.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
        */
        
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: siteLocation!, span: span)
        map!.setRegion(region, animated: false)

        let annotationsToRemove = map!.annotations
        map!.removeAnnotations( annotationsToRemove )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = siteLocation!
        annotation.title = site!.title!
        annotation.subtitle = site!.streetAddress1!
        map!.addAnnotation(annotation)
        
        if isInSiteView {
            updateButtons()
        }
    }
    
    func updateButtons() {
        
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ = self.site!.organization!.primaryColor!.getWhite(&white, alpha: &alpha)
//        var textColor:UIColor?
        var bgColor:UIColor?
        
        
        if white >= 0.95 {
//            textColor = site!.organization!.primaryColor!
            bgColor = site!.organization!.secondaryColor!
        } else {
//            textColor = site!.organization!.secondaryColor!
            bgColor = site!.organization!.primaryColor
        }
        
        var ypos:CGFloat = map!.frame.origin.y
        ypos += (map!.frame.height + 5)
        
//        var hasPhone = false
        
        waze_button!.frame.origin.y = ypos
        ypos += waze_button!.frame.height
        ypos += 5
        
        
        let lat = Double(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)
        let long = Double(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)
//        uber_button!.setProductID(site!.identifier!)
//        uber_button!.setPickupLocation(latitude: lat, longitude:long, nickname:"\(BNAppSharedManager.instance.dataManager.bnUser!.firstName!) \(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)")
//        uber_button!.setDropoffLocation(latitude: Double(site!.latitude!), longitude:Double(site!.longitude!), nickname: site!.title!)
//        uber_button!.frame.origin.y = ypos
//        ypos += uber_button!.frame.height
//        ypos += 5
        
        
        let ridesClient = RidesClient()
        let pickupLocation = CLLocation(latitude: lat, longitude:long)
        let dropoffLocation = CLLocation(latitude:  Double(site!.latitude!), longitude: Double(site!.longitude!))
        //var builder = RideParametersBuilder().setDropoffLocation(dropoffLocation)
        var builder = RideParametersBuilder().setPickupLocation(pickupLocation).setDropoffLocation(dropoffLocation)
        
        ridesClient.fetchUserProfile { (profile, response) in
            print("\(profile)")
        }
        
        ridesClient.fetchCheapestProduct(pickupLocation: pickupLocation, completion: {
            product, response in
            if let productID = product?.productID {
                builder = builder.setProductID(productID)
                self.uber_button!.rideParameters = builder.build()
                self.uber_button!.loadRideInformation()
            }
        })
            
        uber_button!.layer.cornerRadius = 2
        uber_button!.frame.origin.y = ypos
        ypos += uber_button!.frame.height
        ypos += 5
        
        closeBtn!.frame.origin.y = ypos
        closeBtn!.backgroundColor = bgColor
        ypos += closeBtn!.frame.height
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, (ypos + 5))
        
    }
    
    func wazeAction(sender:UIButton){
        
//        if self.site_phoneNumber! != "" {
//            let url:NSURL = NSURL(string:"tel://\(self.site_phoneNumber!)")!
//            UIApplication.sharedApplication().openURL(url)
//        }
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string:"waze://")!) {
            // Waze is installed. Launch Waze and start navigation
            let urlStr = "waze://?ll=\(site!.latitude!),\(site!.longitude!)&navigate=yes"//"waze://?ll=\(),\()&navigate=yes"
            UIApplication.sharedApplication().openURL(NSURL(string: urlStr)!)
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];

        } else  {
            UIApplication.sharedApplication().openURL(NSURL(string:"http://itunes.apple.com/us/app/id323229106")!)
        }
    }
    
    override func clean() {

        siteAvatar?.removeFromSuperview()
        title?.removeFromSuperview()
        
        streetAddress1?.removeFromSuperview()
        streetAddress2?.removeFromSuperview()
        ubication?.removeFromSuperview()
        
        map?.removeFromSuperview()
        
        commentBtn?.clean()
        commentBtn?.removeFromSuperview()
        
        siteLocation = nil
    }
    
    func show() {
        
    }
    
    func closeBtnAction(sender:UIButton){
        (self.father as? SiteView)?.locationBtnAction(sender)
    }
}

