//  SiteView_Location.swift
//  biin
//  Created by Esteban Padilla on 2/26/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit
import MessageUI

class SiteView_Location:BNView, MKMapViewDelegate, MFMailComposeViewControllerDelegate {

    //var siteAvatarView:UIView?
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
    
    var emailBtn:UIButton?
    var callBtn:UIButton?
    var commentBtn:BNUIButton_Contact?
    var closeBtn:BNUIButton_Close?
    
    var siteLocation:CLLocationCoordinate2D?
//    var annotation:MKPointAnnotation?
    
    var yStop:CGFloat = 0

//    override init() {
//        super.init()
//    }
    
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
        
        let screenWidth = SharedUIManager.instance.screenWidth
        //var screenHeight = SharedUIManager.instance.screenHeight
        
        let headerWidth = screenWidth - (SharedUIManager.instance.siteView_headerHeight + 10 + 45)
        var ypos:CGFloat = 10

        closeBtn = BNUIButton_Close(frame: CGRectMake((SharedUIManager.instance.screenWidth - 35), 5, 30, 30), iconColor: UIColor.blackColor())
        closeBtn!.addTarget(father, action: "hideInformationView:", forControlEvents: UIControlEvents.TouchUpInside)
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
        self.addSubview(title!)
    
        ypos += SharedUIManager.instance.siteView_titleSize + 2
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        streetAddress1!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        streetAddress1!.text = "Address"
        streetAddress1!.textColor = UIColor.appTextColor()
        streetAddress1!.numberOfLines = 0
        self.addSubview(streetAddress1!)

        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        streetAddress2 = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        streetAddress2!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        streetAddress2!.text = ""
        streetAddress2!.textColor = UIColor.appTextColor()
        streetAddress2!.numberOfLines = 0
        self.addSubview(streetAddress2!)
        
        ypos += SharedUIManager.instance.siteView_nutshellSize + 2
        ubication = UILabel(frame: CGRectMake(xpos, ypos, headerWidth, (SharedUIManager.instance.siteView_nutshellSize + 3)))
        ubication!.font = UIFont(name: "Lato-Light", size: SharedUIManager.instance.siteView_nutshellSize)
        ubication!.text = ""
        ubication!.textColor = UIColor.appTextColor()
        ubication!.numberOfLines = 0
        self.addSubview(ubication!)

        ypos += 10
        map = MKMapView(frame:CGRectMake(5, ypos, (screenWidth - 10), 150))
        map!.userInteractionEnabled = false

        map!.delegate = self
        self.addSubview(map!)
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
    
        ypos += 155
        
        emailBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 40))
        emailBtn!.setTitle("EMAIL", forState: UIControlState.Normal)
        emailBtn!.setTitleColor(UIColor.appTextColor(), forState: UIControlState.Normal)
        emailBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 12)
        emailBtn!.backgroundColor = UIColor.bnVisitSiteColor()
//        emailBtn!.layer.cornerRadius = 8
//        emailBtn!.layer.masksToBounds = true
//        emailBtn!.layer.borderColor = UIColor.biinColor().CGColor
//        emailBtn!.layer.borderWidth = 1
//        emailBtn!.backgroundColor = UIColor.clearColor()
        emailBtn!.addTarget(self, action: "sendMail:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(emailBtn!)
        
        ypos += 45
        callBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 40))
        callBtn!.setTitle("CALL", forState: UIControlState.Normal)
        callBtn!.setTitleColor(UIColor.appTextColor(), forState: UIControlState.Normal)
        callBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 12)
        callBtn!.backgroundColor = UIColor.bnVisitSiteColor()
//        callBtn!.layer.cornerRadius = 8
//        callBtn!.layer.masksToBounds = true
//        callBtn!.layer.borderColor = UIColor.biinColor().CGColor
//        callBtn!.layer.borderWidth = 1
//        callBtn!.backgroundColor = UIColor.clearColor()
        callBtn!.addTarget(self, action: "call:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(callBtn!)
        
        ypos += 45
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
        
        var ypos:CGFloat = title!.frame.origin.y
        
        //title!.textColor = site!.titleColor
        title!.text = "\(site!.title!) - \(site!.subTitle!)"
        //title!.numberOfLines = 1
        //title!.sizeToFit()
        ypos += title!.frame.height
        
        //var headerWidth = SharedUIManager.instance.screenWidth - 30
        //streetAddress1!.frame = CGRectMake(streetAddress1!.frame.origin.x, ypos, (headerWidth - 95), 12)
        streetAddress1!.frame.origin.y = ypos
        streetAddress1!.text = "\(site!.streetAddress1!)"
        //streetAddress1!.numberOfLines = 0
        //streetAddress1!.sizeToFit()
        ypos += streetAddress1!.frame.height
        
        streetAddress2!.frame.origin.y = ypos
        streetAddress2!.text = "\(site!.country!), \(site!.state!), \(site!.zipCode!)"
        //streetAddress2!.frame.origin.y = ypos
        ypos += streetAddress2!.frame.height + 10
        
//        ubication!.frame.origin.y = ypos
//        ubication!.text = site!.streetAddress1!
        //ubication!.frame = CGRectMake(ubication!.frame.origin.x, ypos, (headerWidth - 95), 12)
        //ubication!.numberOfLines = 2
        //ubication!.sizeToFit()
        //ubication!.frame.origin.y += ypos
        //ypos += ubication!.frame.height
        
        //ypos += ubication!.frame.height
        //callBtn!.setTitleColor(site!.media[0].vibrantColor!, forState: UIControlState.Normal)
        //callBtn!.backgroundColor = UIColor.bnVisitSiteColor() // site!.media[0].vibrantDarkColor
//        callBtn!.layer.borderColor = site!.media[0].vibrantColor!.CGColor
        //emailBtn!.setTitleColor(site!.media[0].vibrantColor!, forState: UIControlState.Normal)
//        emailBtn!.layer.borderColor = site!.media[0].vibrantColor!.CGColor
        //emailBtn!.backgroundColor = UIColor.bnVisitSiteColor()//site!.media[0].vibrantColor
        
        
        if site!.phoneNumber! != "" {
            site_phoneNumber = site!.phoneNumber!
            
//            var value = NSLocalizedString("Phone", comment: "Phone")
//            phoneNumber!.text = "\(value): \(site!.phoneNumber!)"
//            phoneNumber!.frame.origin.y = ypos
//            phoneNumber!.sizeToFit()
//            ypos += phoneNumber!.frame.height
            callBtn!.enabled = true

        }else {
            callBtn!.enabled = false
        }
 
        if site!.email! != "" {
            site_email = site!.email!
//            var value = NSLocalizedString("Email", comment: "Email")
//            email!.text = "\(value): \(site!.email!)"
//            email!.frame.origin.y = ypos
//            email!.sizeToFit()
//            ypos += email!.frame.height
            emailBtn!.enabled = true
        } else {
            emailBtn!.enabled = false
            
        }


        
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
        let span = MKCoordinateSpanMake(0.01, 0.01)
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
        
        //ypos += (map!.frame.height + 10)
        
        //emailBtn!.frame.origin.y = ypos
        //ypos += (50 + 10)
        //callBtn!.frame.origin.y = ypos
        
        //ypos += (50 + 10)
        
//        if site!.media.count > 0{
//            closeBtn!.icon!.color = site!.media[0].vibrantColor!
//            closeBtn!.layer.borderColor = site!.media[0].vibrantColor!.CGColor
//            closeBtn!.setNeedsDisplay()
//        } else {
//            closeBtn!.icon!.color = UIColor.blackColor()
//            closeBtn!.layer.borderColor = UIColor.blackColor().CGColor
//        }
        
//        if let organization = site!.organization {
//            if organization.media.count > 0 {
//                BNAppSharedManager.instance.networkManager.requestImageData(site!.organization!.media[0].url!, image: siteAvatar)
//                siteAvatar!.cover!.backgroundColor = site!.organization!.media[0].vibrantColor!
//            } else {
//                siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
//                siteAvatar!.showAfterDownload()
//            }
//        } else  {
//            siteAvatar!.image =  UIImage(contentsOfFile: "noImage.jpg")
//            siteAvatar!.showAfterDownload()
//        }
        
    }
    
    func call(sender:BNUIButton_Contact){
        
        if site_phoneNumber! != "" {
            let url:NSURL = NSURL(string:"tel://\(site_phoneNumber!)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func sendMail(sender: BNUIButton_Contact) {
        let picker = MFMailComposeViewController()
        let toRecipents = [site_email!]
        picker.setToRecipients(toRecipents)
        picker.mailComposeDelegate = self
        picker.setSubject(NSLocalizedString("EmailMsj", comment: "EmailMsj"))
        picker.setMessageBody("", isHTML: true)
        
        (father!.father! as? MainView)?.rootViewController!.presentViewController(picker, animated: true, completion: nil)
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
        closeBtn?.removeFromSuperview()
        
        siteLocation = nil
    }
    
    func show() {
        
    }
}

