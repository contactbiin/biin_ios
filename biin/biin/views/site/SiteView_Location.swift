//  SiteView_Location.swift
//  biin
//  Created by Esteban Padilla on 2/26/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit
import MessageUI

class SiteView_Location:BNView, MKMapViewDelegate, MFMailComposeViewControllerDelegate {

    var siteAvatarView:UIView?
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    
    var streetAddress1:UILabel?
    var streetAddress2:UILabel?
    var ubication:UILabel?
    //var phoneNumber:UILabel?
    //var email:UILabel?
    
    var map:MKMapView?
    
    var site_email:String?
    var site_phoneNumber:String?
    
    var emailBtn:BNUIButton_Contact?
    var callBtn:BNUIButton_Contact?
    var commentBtn:BNUIButton_Contact?
    
    var siteLocation:CLLocationCoordinate2D?
    var annotation:MKPointAnnotation?
    
    var yStop:CGFloat = 0

//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        site_phoneNumber = ""
        site_email = ""
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var headerWidth = screenWidth - 30
        var xpos:CGFloat = (screenWidth - headerWidth) / 2
        var ypos:CGFloat = 10
    
        //var line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        //line.backgroundColor = UIColor.appButtonColor()
        //self.addSubview(line)
    
        siteAvatarView = UIView(frame: CGRectMake(xpos, ypos, 92, 92))
        siteAvatarView!.layer.cornerRadius = 35
        siteAvatarView!.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        siteAvatarView!.layer.borderWidth = 4
        siteAvatarView!.layer.masksToBounds = true
        self.addSubview(siteAvatarView!)
        
        siteAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
        //siteAvatar!.alpha = 0
        siteAvatar!.layer.cornerRadius = 35
        siteAvatar!.layer.masksToBounds = true
        siteAvatarView!.addSubview(siteAvatar!)
        
        //BNAppSharedManager.instance.networkManager.requestImageData(BNAppSharedManager.instance.dataManager.bnUser!.imgUrl!, image: siteAvatar)

        xpos += 100
        
        title = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 22))
        title!.font = UIFont(name: "Lato-Black", size: 20)
        title!.text = ""
        title!.textColor = UIColor.biinColor()
        title!.numberOfLines = 0
        title!.sizeToFit()
        self.addSubview(title!)
        
        ypos += 23
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
        streetAddress1!.font = UIFont(name: "Lato-Light", size: 12)
        streetAddress1!.text = "Address"
        streetAddress1!.textColor = UIColor.appTextColor()
        streetAddress1!.numberOfLines = 0
        self.addSubview(streetAddress1!)

        ypos += 13
        streetAddress2 = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
        streetAddress2!.font = UIFont(name: "Lato-Light", size: 12)
        streetAddress2!.text = ""
        streetAddress2!.textColor = UIColor.appTextColor()
        self.addSubview(streetAddress2!)
        
        ypos += 13
        
        ubication = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
        ubication!.font = UIFont(name: "Lato-Light", size: 12)
        ubication!.text = ""
        ubication!.textColor = UIColor.appTextColor()
        self.addSubview(ubication!)

//        ypos += 13
//        
//        phoneNumber = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
//        phoneNumber!.font = UIFont(name: "Lato-Light", size: 12)
//        phoneNumber!.text = ""
//        phoneNumber!.textColor = UIColor.appTextColor()
//        self.addSubview(phoneNumber!)
//        
//        ypos += 13
//        email = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
//        email!.font = UIFont(name: "Lato-Light", size: 12)
//        email!.text = ""
//        email!.textColor = UIColor.appTextColor()
//        self.addSubview(email!)
        
        ypos += 35
        yStop = ypos //To use in shareview.
        map = MKMapView(frame:CGRectMake(0, ypos, screenWidth, 160))
        ///map!.userInteractionEnabled = false
//        map!.layer.cornerRadius = 3
//        map!.layer.borderColor = UIColor.appButtonBorderColor().CGColor
//        map!.layer.borderWidth = 1
        map!.delegate = self
        self.addSubview(map!)
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
    
        annotation = MKPointAnnotation()
        //annotation!.setCoordinate(siteLocation!)
        annotation!.coordinate = siteLocation!
        annotation!.title = "Annotation title"
        annotation!.subtitle = "Annotation subtitle"
        
        map!.addAnnotation(annotation!)
        
        ypos += 180
        xpos = (screenWidth - 140) / 2
        emailBtn = BNUIButton_Contact(frame: CGRectMake(0, ypos, screenWidth, 50), text:NSLocalizedString("EmailUs", comment: "EmailUs"), iconType: BNIconType.emailMedium)
        emailBtn!.addTarget(self, action: "sendMail:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(emailBtn!)
        
        xpos += 80
        callBtn = BNUIButton_Contact(frame: CGRectMake(0, ypos, screenWidth, 50), text:NSLocalizedString("CallUs", comment: "CallUs"), iconType: BNIconType.phoneMedium)
        callBtn!.addTarget(self, action: "call:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(callBtn!)
        
        xpos += 60
        //commentBtn = BNUIButton_Contact(frame: CGRectMake(xpos, ypos, 50, 50), text: "Call us", iconType: BNIconType.commentMedium)
        //self.addSubview(commentBtn!)
        
        var line = UIView(frame: CGRectMake(5, (frame.height - 5), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        self.addSubview(line)
        
        //ypos += 5
        //self.frame = CGRectMake(0, 0, frame.width, ypos)
        
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
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
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

        
        var ypos:CGFloat = title!.frame.origin.y
        
        title!.textColor = site!.titleColor
        title!.text = site!.title!
        title!.numberOfLines = 1
        title!.sizeToFit()
        ypos += title!.frame.height
        
        var headerWidth = SharedUIManager.instance.screenWidth - 30
        streetAddress1!.frame = CGRectMake(streetAddress1!.frame.origin.x, ypos, (headerWidth - 95), 12)
        streetAddress1!.text = "\(site!.streetAddress1!)"
        streetAddress1!.numberOfLines = 0
        streetAddress1!.sizeToFit()
        

        ypos += streetAddress1!.frame.height
        streetAddress2!.text = "\(site!.country!), \(site!.state!), \(site!.zipCode!)"
        streetAddress2!.frame.origin.y = ypos
        
        
        ypos += streetAddress2!.frame.height
        ubication!.text = site!.ubication!
        ubication!.frame = CGRectMake(ubication!.frame.origin.x, ypos, (headerWidth - 95), 12)
        ubication!.numberOfLines = 2
        ubication!.sizeToFit()
        ubication!.frame.origin.y = ypos
        
        ypos += ubication!.frame.height
        
        if site!.phoneNumber! != "" {
            site_phoneNumber = site!.phoneNumber!
//            var value = NSLocalizedString("Phone", comment: "Phone")
//            phoneNumber!.text = "\(value): \(site!.phoneNumber!)"
//            phoneNumber!.frame.origin.y = ypos
//            phoneNumber!.sizeToFit()
//            ypos += phoneNumber!.frame.height
            callBtn!.showEnable()
        }else {
            callBtn!.showDisable()
        }
 
        if site!.email! != "" {
            site_email = site!.email!
//            var value = NSLocalizedString("Email", comment: "Email")
//            email!.text = "\(value): \(site!.email!)"
//            email!.frame.origin.y = ypos
//            email!.sizeToFit()
//            ypos += email!.frame.height
            emailBtn!.showEnable()
        } else {
            emailBtn!.showDisable()
            
        }

        //commentBtn!.icon!.color = site!.titleColor!
        //commentBtn!.showDisable()
       
        ypos += 10
        var total:CGFloat = (ypos - siteAvatarView!.frame.height) / 2
        siteAvatarView!.frame.origin.y = total
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(site!.latitude!), longitude: CLLocationDegrees(site!.longitude!))

        ypos += 10
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: siteLocation!, span: span)
        map!.setRegion(region, animated: false)
        map!.frame.origin.y = ypos
        
        annotation!.coordinate = siteLocation!
        annotation!.title = site!.title!
        annotation!.subtitle = site!.streetAddress1!
        
        ypos += (map!.frame.height + 10)
        
        emailBtn!.frame.origin.y = ypos
        ypos += (50 + 10)
        callBtn!.frame.origin.y = ypos
        
        ypos += (50 + 10)
        
        if site!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site!.media[0].url!, image: siteAvatar)
        } else {
            siteAvatar!.image =  UIImage(named: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        

    }
    
    func call(sender:BNUIButton_Contact){
        
        if site_phoneNumber! != "" {
            var url:NSURL = NSURL(string:"tel://\(site_phoneNumber!)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func sendMail(sender: BNUIButton_Contact) {
        var picker = MFMailComposeViewController()
        var toRecipents = [site_email!]
        picker.setToRecipients(toRecipents)
        picker.mailComposeDelegate = self
        picker.setSubject(NSLocalizedString("EmailMsj", comment: "EmailMsj"))
        picker.setMessageBody("", isHTML: true)
        
        (father!.father! as? MainView)?.rootViewController!.presentViewController(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        (father!.father! as? MainView)?.rootViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MKMapViewDelegate
    /*
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        var dequeedAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier("sitePin")
        println("\(dequeedAnnotation.reuseIdentifier!)")
        
        
        if dequeedAnnotation != nil {
            dequeedAnnotation.annotation = annotation
            return dequeedAnnotation
        }else {
            dequeedAnnotation = MKAnnotationView(annotation:annotation, reuseIdentifier: "sitePin")
            dequeedAnnotation.canShowCallout = false
            dequeedAnnotation.image = UIImage(named: "mapIcon.png")
        }
       return dequeedAnnotation
    }
    */
}

