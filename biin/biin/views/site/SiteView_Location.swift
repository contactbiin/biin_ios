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
    var phoneNumber:UILabel?
    var email:UILabel?
    
    var map:MKMapView?
    
    var site_email:String?
    var site_phoneNumber:String?
    
    var emailBtn:BNUIButton_Contact?
    var callBtn:BNUIButton_Contact?
    var commentBtn:BNUIButton_Contact?
    
    var siteLocation:CLLocationCoordinate2D?
    var annotation:MKPointAnnotation?

    override init() {
        super.init()
    }
    
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
        siteAvatarView!.layer.borderColor = UIColor.appBackground().CGColor
        siteAvatarView!.layer.borderWidth = 6
        siteAvatarView!.layer.masksToBounds = true
        self.addSubview(siteAvatarView!)
        
        siteAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
        //siteAvatar!.alpha = 0
        siteAvatar!.layer.cornerRadius = 30
        siteAvatar!.layer.masksToBounds = true
        siteAvatarView!.addSubview(siteAvatar!)
        
        //BNAppSharedManager.instance.networkManager.requestImageData(BNAppSharedManager.instance.dataManager.bnUser!.imgUrl!, image: siteAvatar)

        xpos += 100
        ypos += 5
        
        title = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 20))
        title!.font = UIFont(name: "Lato-Regular", size: 22)
        title!.text = ""
        title!.textColor = UIColor.biinColor()
        self.addSubview(title!)
        
        ypos += 22
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 12))
        streetAddress1!.font = UIFont(name: "Lato-Light", size: 10)
        streetAddress1!.text = "Address"
        streetAddress1!.textColor = UIColor.appTextColor()
        streetAddress1!.numberOfLines = 0
        self.addSubview(streetAddress1!)

        ypos += 13
        streetAddress2 = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 12))
        streetAddress2!.font = UIFont(name: "Lato-Light", size: 10)
        streetAddress2!.text = ""
        streetAddress2!.textColor = UIColor.appTextColor()
        self.addSubview(streetAddress2!)
        
        ypos += 13
        phoneNumber = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 12))
        phoneNumber!.font = UIFont(name: "Lato-Light", size: 10)
        phoneNumber!.text = ""
        phoneNumber!.textColor = UIColor.appTextColor()
        self.addSubview(phoneNumber!)
        
        ypos += 13
        email = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 12))
        email!.font = UIFont(name: "Lato-Light", size: 10)
        email!.text = ""
        email!.textColor = UIColor.appTextColor()
        self.addSubview(email!)
        
        ypos += 35
        map = MKMapView(frame:CGRectMake(10, ypos, (screenWidth - 20), 160))
        map!.userInteractionEnabled = false
        map!.layer.cornerRadius = 3
        map!.layer.borderColor = UIColor.appBackground().CGColor
        map!.layer.borderWidth = 1
        map!.delegate = self
        self.addSubview(map!)
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
    
        annotation = MKPointAnnotation()
        annotation!.setCoordinate(siteLocation!)
        annotation!.title = "Annotation title"
        annotation!.subtitle = "Annotation subtitle"
        
        map!.addAnnotation(annotation!)
        
        ypos += 180
        xpos = (screenWidth - 170) / 2
        emailBtn = BNUIButton_Contact(frame: CGRectMake(xpos, ypos, 50, 50), text: "Email us", iconType: BNIconType.emailMedium)
        emailBtn!.addTarget(self, action: "sendMail:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(emailBtn!)
        
        xpos += 60
        callBtn = BNUIButton_Contact(frame: CGRectMake(xpos, ypos, 50, 50), text: "Call us", iconType: BNIconType.phoneMedium)
        callBtn!.addTarget(self, action: "call:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(callBtn!)
        
        xpos += 60
        commentBtn = BNUIButton_Contact(frame: CGRectMake(xpos, ypos, 50, 50), text: "Call us", iconType: BNIconType.commentMedium)
        self.addSubview(commentBtn!)
        
        var line = UIView(frame: CGRectMake(5, (frame.height - 5), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        self.addSubview(line)
        
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
        
        title!.textColor = site!.titleColor
        title!.text = site!.title!

        var headerWidth = SharedUIManager.instance.screenWidth - 30
        streetAddress1!.frame = CGRectMake(streetAddress1!.frame.origin.x, streetAddress1!.frame.origin.y, (headerWidth - 95), 12)
        streetAddress1!.text = "\(site!.streetAddress1!)"
        streetAddress1!.numberOfLines = 0
        streetAddress1!.sizeToFit()
        
        var ypos:CGFloat = streetAddress1!.frame.origin.y
        ypos += streetAddress1!.frame.height
        
        streetAddress2!.text = "\(site!.country!), \(site!.state!), \(site!.zipCode!)"
        streetAddress2!.frame.origin.y = ypos
        
        ypos += 13
        
        
        if site!.phoneNumber! != "" {
            site_phoneNumber = site!.phoneNumber!
            phoneNumber!.text = "Phone: \(site!.phoneNumber!)"
            phoneNumber!.frame.origin.y = ypos
            ypos += 13
            
            callBtn!.icon!.color = site!.titleColor!
            callBtn!.showEnable()
            
        }else {
            callBtn!.showDisable()
        }
 
        if site!.email! != "" {
            site_email = site!.email!
            email!.text = "email: \(site!.email!)"
            email!.frame.origin.y = ypos
            
            emailBtn!.icon!.color = site!.titleColor!
            emailBtn!.showEnable()
            
        } else {
            emailBtn!.showDisable()
            
        }

        commentBtn!.icon!.color = site!.titleColor!
        commentBtn!.showDisable()
       
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(site!.latitude!), longitude: CLLocationDegrees(site!.longitude!))
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: siteLocation!, span: span)
        map!.setRegion(region, animated: false)
        
        
        annotation!.setCoordinate(siteLocation!)
        
        BNAppSharedManager.instance.networkManager.requestImageData(site!.media[0].url!, image: siteAvatar)
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
        picker.setSubject("Hello there!")
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

