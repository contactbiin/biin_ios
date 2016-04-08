//  SiteView_Location.swift
//  biin
//  Created by Esteban Padilla on 2/26/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit
import MessageUI
import UberRides

class SiteView_Location:BNView, MKMapViewDelegate, MFMailComposeViewControllerDelegate {

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
    
    var emailBtn:UIButton?
    var callBtn:UIButton?
    var npsBtn:UIButton?
    var commentBtn:BNUIButton_Contact?
//    var closeBtn:BNUIButton_Close?
    
    var siteLocation:CLLocationCoordinate2D?
//    var annotation:MKPointAnnotation?
    
    var yStop:CGFloat = 0

//    override init() {
//        super.init()
//    }
    var uber_button:RequestButton?
    weak var site:BNSite?
    
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

//        closeBtn = BNUIButton_Close(frame: CGRectMake((SharedUIManager.instance.screenWidth - 35), 5, 30, 30), iconColor: UIColor.blackColor())
//        closeBtn!.addTarget(father, action: Selector("hideInformationView:"), forControlEvents: UIControlEvents.TouchUpInside)
        //self.addSubview(closeBtn!)
        
        let siteAvatarSize = (SharedUIManager.instance.siteView_headerHeight)
        siteAvatar = BNUIImageView(frame: CGRectMake(5, 5, siteAvatarSize, siteAvatarSize), color:UIColor.whiteColor())
        //self.addSubview(siteAvatar!)
        
        let xpos:CGFloat = 10
        
        title = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.bnGrayDark()
        title!.textAlignment = NSTextAlignment.Left
        title!.text = "site title here"
        title!.numberOfLines = 0
        self.addSubview(title!)
    
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        streetAddress1!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
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
        map!.userInteractionEnabled = false

        map!.delegate = self
        self.addSubview(map!)
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
    
        ypos += 155
        
        emailBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 50))
        emailBtn!.setTitle(NSLocalizedString("EmailUs", comment: "EmailUs"), forState: UIControlState.Normal)
        emailBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        emailBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 16)
        //emailBtn!.backgroundColor = UIColor.bnVisitSiteColor()
        
        emailBtn!.layer.cornerRadius = 2
//        emailBtn!.layer.shadowColor = UIColor.blackColor().CGColor
//        emailBtn!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        emailBtn!.layer.shadowOpacity = 0.25
        
        emailBtn!.addTarget(self, action: #selector(self.sendMail(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(emailBtn!)
        
        ypos += 55
        callBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 50))
        callBtn!.setTitle(NSLocalizedString("CallUs", comment: "CallUs"), forState: UIControlState.Normal)
        callBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        callBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 16)
        //callBtn!.backgroundColor = UIColor.bnVisitSiteColor()

        callBtn!.layer.cornerRadius = 2
//        callBtn!.layer.shadowColor = UIColor.blackColor().CGColor
//        callBtn!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        callBtn!.layer.shadowOpacity = 0.25

        callBtn!.addTarget(self, action: #selector(self.call(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(callBtn!)
        
        
        
        ypos += 55
        npsBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 50))
        npsBtn!.setTitle(NSLocalizedString("npsBtn", comment: "npsBtn"), forState: UIControlState.Normal)
        npsBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        npsBtn!.titleLabel!.font = UIFont(name: "Lato-Light", size: 16)
        npsBtn!.layer.cornerRadius = 2
        npsBtn!.addTarget(self, action: #selector(self.nps(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(npsBtn!)

        uber_button = RequestButton()
        uber_button!.frame = CGRectMake(5, ypos, (self.frame.width - 10), 50)
        uber_button!.setTitle(NSLocalizedString("UBER", comment: "UBER"), forState: UIControlState.Normal)
        uber_button!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        uber_button!.titleLabel!.font = UIFont(name: "Lato-Light", size: 16)
        uber_button!.backgroundColor = UIColor.darkGrayColor()
        uber_button!.layer.cornerRadius = 2
//        uber_button!.layer.shadowColor = UIColor.blackColor().CGColor
//        uber_button!.layer.shadowOffset = CGSize(width: 0, height: 0)
//        uber_button!.layer.shadowOpacity = 0.25
        self.addSubview(uber_button!)
        uber_button!.setNeedsDisplay()
        
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
        title!.frame = CGRectMake(xpos, ypos, SharedUIManager.instance.screenWidth, (SharedUIManager.instance.siteView_titleSize + 3))
        
        
        streetAddress1!.text = ""
        streetAddress1!.frame = CGRectMake(xpos, ypos, (SharedUIManager.instance.screenWidth - 20), (SharedUIManager.instance.siteView_nutshellSize + 3))
        
        streetAddress2!.text = ""
        streetAddress2!.frame = CGRectMake(xpos, ypos, (SharedUIManager.instance.screenWidth - 20), (SharedUIManager.instance.siteView_nutshellSize + 3))
        
        ubication!.text = ""
        ubication!.frame = CGRectMake(xpos, ypos, (SharedUIManager.instance.screenWidth - 20), (SharedUIManager.instance.siteView_nutshellSize + 3))

        phoneLbl!.text = ""
        phoneLbl!.frame = CGRectMake(xpos, ypos, (SharedUIManager.instance.screenWidth - 20), (SharedUIManager.instance.siteView_nutshellSize + 3))

        emailLbl!.text = ""
        emailLbl!.frame = CGRectMake(xpos, ypos, (SharedUIManager.instance.screenWidth - 20), (SharedUIManager.instance.siteView_nutshellSize + 3))
        
        scheduleLbl!.text = ""
        scheduleLbl!.frame = CGRectMake(xpos, ypos, (SharedUIManager.instance.screenWidth - 20), (SharedUIManager.instance.siteView_nutshellSize + 3))
    
        
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
        
//        var hasPhone = false
//        var hasEmail = false
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ = self.site!.organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        var isWhitePrimary = false
        var textColor:UIColor?
        var bgColor:UIColor?
        
        
        if white >= 0.95 {
            print("Is white")
            isWhitePrimary = true
            textColor = site!.organization!.primaryColor!
            bgColor = site!.organization!.secondaryColor!
        } else {
            textColor = site!.organization!.secondaryColor!
            bgColor = site!.organization!.primaryColor
        }
        
        if site!.phoneNumber! != "" {
            site_phoneNumber = site!.phoneNumber!
            phoneLbl!.frame.origin.y = ypos
            phoneLbl!.text =  "\(NSLocalizedString("Phone", comment: "Phone")): \(site!.phoneNumber!)"
            phoneLbl!.sizeToFit()
            ypos += phoneLbl!.frame.height
//            hasPhone = true
            callBtn!.enabled = true
            callBtn!.alpha = 1
            callBtn!.setTitleColor(textColor!, forState: UIControlState.Normal)
            callBtn!.backgroundColor = bgColor!//site!.media[0].vibrantDarkColor
        }else {
            callBtn!.enabled = false
            callBtn!.alpha = 0
        }
 
 
        
        if site!.email! != "" && MFMailComposeViewController.canSendMail() {
            site_email = site!.email!
            emailLbl!.frame.origin.y = ypos
            emailLbl!.text = "\(NSLocalizedString("Email", comment: "Email")): \(site!.email!)"
            emailLbl!.sizeToFit()
            ypos += emailLbl!.frame.height
//            hasEmail = true
            
//            var value = NSLocalizedString("Email", comment: "Email")
//            email!.text = "\(value): \(site!.email!)"
//            email!.frame.origin.y = ypos
//            email!.sizeToFit()
//            ypos += email!.frame.height
            
            
            emailBtn!.enabled = true
            emailBtn!.alpha = 1
            emailBtn!.setTitleColor(textColor!, forState: UIControlState.Normal)
            emailBtn!.backgroundColor = bgColor!
        } else {
            emailBtn!.enabled = false
            emailBtn!.alpha = 0
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
        //commentBtn!.icon!.color = site!.titleColor!
        //commentBtn!.showDisable()
       
        //ypos += 25
        //var total:CGFloat = (ypos - siteAvatarView!.frame.height) / 2
        //siteAvatarView!.frame.origin.y = total
        
        //ypos += 10
//        map!.removeFromSuperview()
//        map = MKMapView(frame:CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, 160))
//        map!.delegate = self
//        self.addSubview(map!)

        map!.frame.origin.y = ypos
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(site!.latitude!), longitude: CLLocationDegrees(site!.longitude!))
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegion(center: siteLocation!, span: span)
        map!.setRegion(region, animated: false)

        
        let annotationsToRemove = map!.annotations
        map!.removeAnnotations( annotationsToRemove )
        
//        (map!.annotations[0] as! MKPointAnnotation).coordinate = siteLocation!
//        (map!.annotations[0] as! MKPointAnnotation).title = site!.title!
//        (map!.annotations[0] as! MKPointAnnotation).subtitle = site!.streetAddress1!
//        map!.selectAnnotation((map!.annotations[0] as! MKPointAnnotation), animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = siteLocation!
        annotation.title = site!.title!
        annotation.subtitle = site!.streetAddress1!
        map!.addAnnotation(annotation)
        
        updateButtons()
    }
    
    func updateButtons() {
        
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ = self.site!.organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        var isWhitePrimary = false
        var textColor:UIColor?
        var bgColor:UIColor?
        
        
        if white >= 0.95 {
            print("Is white")
            isWhitePrimary = true
            textColor = site!.organization!.primaryColor!
            bgColor = site!.organization!.secondaryColor!
        } else {
            textColor = site!.organization!.secondaryColor!
            bgColor = site!.organization!.primaryColor
        }
        
        var ypos:CGFloat = map!.frame.origin.y
        ypos += (map!.frame.height + 5)
        
        var hasPhone = false
        var hasEmail = false
        
        if site!.phoneNumber! != "" {

            hasPhone = true
        }
        
        if site!.email! != "" && MFMailComposeViewController.canSendMail() {

            hasEmail = true
        }
        
        if hasPhone {
            callBtn!.frame.origin.y = ypos
            ypos += callBtn!.frame.height
            ypos += 5
        }
        
        if hasEmail {
            emailBtn!.frame.origin.y = ypos
            ypos += emailBtn!.frame.height
            ypos += 5
        }
        
        let lat = Double(BNAppSharedManager.instance.positionManager.userCoordinates!.latitude)
        let long = Double(BNAppSharedManager.instance.positionManager.userCoordinates!.longitude)
        uber_button!.setProductID(site!.identifier!)
        uber_button!.setPickupLocation(latitude: lat, longitude:long, nickname:"\(BNAppSharedManager.instance.dataManager.bnUser!.firstName!) \(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)")
        uber_button!.setDropoffLocation(latitude: Double(site!.latitude!), longitude:Double(site!.longitude!), nickname: site!.title!)
        uber_button!.frame.origin.y = ypos
        ypos += uber_button!.frame.height
        
        if site!.organization!.hasNPS {
            ypos += 5
            if !BNAppSharedManager.instance.notificationManager.is_site_surveyed(site!.identifier) {
                npsBtn!.alpha = 1
                npsBtn!.enabled = true
                npsBtn!.frame.origin.y = ypos
                npsBtn!.backgroundColor = bgColor!//site!.organization!.primaryColor//site!.media[0].vibrantDarkColor
                npsBtn!.setTitleColor(textColor!, forState: UIControlState.Normal)
                ypos += npsBtn!.frame.height
                npsBtn!.setTitle(NSLocalizedString("npsBtn", comment: "npsBtn"), forState: UIControlState.Normal)
                npsBtn!.layer.borderColor = UIColor.clearColor().CGColor
                
            } else {
                npsBtn!.alpha = 1
                npsBtn!.enabled = false
                npsBtn!.frame.origin.y = ypos
                //                npsBtn!.backgroundColor = site!.media[0].vibrantDarkColor
                ypos += npsBtn!.frame.height
                npsBtn!.setTitle(NSLocalizedString("npsBtn_completed", comment: "npsBtn_completed"), forState: UIControlState.Normal)
                npsBtn!.backgroundColor = UIColor.whiteColor()
                npsBtn!.layer.borderColor = bgColor!.CGColor//site!.media[0].vibrantDarkColor?.CGColor
                npsBtn!.layer.borderWidth = 1
                npsBtn!.setTitleColor(bgColor, forState: UIControlState.Normal)
                
            }
        } else {
            npsBtn!.alpha = 0
            npsBtn!.enabled = false
        }
        
        ypos += 10

        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, (ypos + 10))
        

    }
    
    func call(sender:UIButton){
        
        if self.site_phoneNumber! != "" {
            let url:NSURL = NSURL(string:"tel://\(self.site_phoneNumber!)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func sendMail(sender: UIButton) {
        let picker = MFMailComposeViewController()
        let toRecipents = [site_email!]
        picker.setToRecipients(toRecipents)
        picker.mailComposeDelegate = self
        picker.setSubject(NSLocalizedString("EmailMsj", comment: "EmailMsj"))
        picker.setMessageBody("", isHTML: true)
        
        (father!.father! as? MainView)?.rootViewController!.presentViewController(picker, animated: true, completion: nil)
    }
    
    func nps(sender:UIButton){
        (father!.father! as? MainView)?.site_to_survey = self.site
//        (father!.father! as? MainView)?.setNextState(BNGoto.Survey)
        (father!.father! as? MainView)?.showSurveyViewOnRequest()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        (father!.father! as? MainView)?.rootViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func clean() {

        siteAvatar?.removeFromSuperview()
        title?.removeFromSuperview()
        
        streetAddress1?.removeFromSuperview()
        streetAddress2?.removeFromSuperview()
        ubication?.removeFromSuperview()
        
        map?.removeFromSuperview()
        
        emailBtn?.removeFromSuperview()
        callBtn?.removeFromSuperview()
        commentBtn?.clean()
        commentBtn?.removeFromSuperview()
//        closeBtn?.removeFromSuperview()
        
        siteLocation = nil
    }
    
    func show() {
        
    }
}

