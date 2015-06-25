//  SiteView_MiniLocation.swift
//  biin
//  Created by Esteban Padilla on 6/25/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit
import MessageUI

class SiteView_MiniLocation:BNView, MKMapViewDelegate, MFMailComposeViewControllerDelegate {
    
    var siteAvatarView:UIView?
    var siteAvatar:BNUIImageView?
    var title:UILabel?
    
    var streetAddress1:UILabel?
    var streetAddress2:UILabel?
    var phoneNumber:UILabel?
    var email:UILabel?
    
    var site_email:String?
    var site_phoneNumber:String?
    
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
    
    override init(frame: CGRect, father:BNView? ) {
        super.init(frame: frame, father:father )
    }

    
    convenience init(frame: CGRect, father:BNView?, site:BNSite?) {
        self.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        site_phoneNumber = ""
        site_email = ""
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        var headerWidth = screenWidth - 30
        var xpos:CGFloat = 3//(screenWidth - headerWidth) / 2
        var ypos:CGFloat = 2
        
        //var line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        //line.backgroundColor = UIColor.appButtonColor()
        //self.addSubview(line)
        
        siteAvatarView = UIView(frame: CGRectMake(xpos, ypos, 50, 50))
        siteAvatarView!.layer.cornerRadius = 25
        siteAvatarView!.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        siteAvatarView!.layer.borderWidth = 2
        siteAvatarView!.layer.masksToBounds = true
        self.addSubview(siteAvatarView!)
        
        siteAvatar = BNUIImageView(frame: CGRectMake(1, 1, 48, 48))
        //siteAvatar!.alpha = 0
        siteAvatar!.layer.cornerRadius = 25
        siteAvatar!.layer.masksToBounds = true
        siteAvatarView!.addSubview(siteAvatar!)
        
        if site!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site!.media[0].url!, image: siteAvatar)
        } else {
            siteAvatar!.image =  UIImage(named: "noImage.jpg")
            siteAvatar!.showAfterDownload()
        }
        
        xpos += 30
        
        title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width  - 30), 22))
        title!.font = UIFont(name: "Lato-Black", size: 20)
        title!.text = site!.title!
        title!.textColor = site!.titleColor!
        title!.numberOfLines = 0
        title!.sizeToFit()
        self.addSubview(title!)
        
        ypos += 23
        streetAddress1 = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
        streetAddress1!.font = UIFont(name: "Lato-Light", size: 12)
        streetAddress1!.text = site!.streetAddress1!
        streetAddress1!.textColor = UIColor.appTextColor()
        streetAddress1!.numberOfLines = 0
        self.addSubview(streetAddress1!)
        
//        ypos += 13
//        streetAddress2 = UILabel(frame: CGRectMake(xpos, ypos, (headerWidth - 95), 14))
//        streetAddress2!.font = UIFont(name: "Lato-Light", size: 12)
//        streetAddress2!.text = ""
//        streetAddress2!.textColor = UIColor.appTextColor()
//        self.addSubview(streetAddress2!)
//        
//        ypos += 13
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

        
        
        ypos += 180
        xpos = (screenWidth - 140) / 2
        
        xpos += 80
        
        xpos += 60
        //commentBtn = BNUIButton_Contact(frame: CGRectMake(xpos, ypos, 50, 50), text: "Call us", iconType: BNIconType.commentMedium)
        //self.addSubview(commentBtn!)
        
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
        title!.numberOfLines = 0
        title!.sizeToFit()
        ypos += title!.frame.height
        
        var headerWidth = SharedUIManager.instance.screenWidth - 30
        streetAddress1!.frame = CGRectMake(streetAddress1!.frame.origin.x, ypos, (headerWidth - 95), 12)
        streetAddress1!.text = "\(site!.streetAddress1!)"
        streetAddress1!.numberOfLines = 0
        streetAddress1!.sizeToFit()
        
        
//        ypos += streetAddress1!.frame.height
//        
//        streetAddress2!.text = "\(site!.country!), \(site!.state!), \(site!.zipCode!)"
//        streetAddress2!.frame.origin.y = ypos
//        
//        ypos += 13
        
        
//        if site!.phoneNumber! != "" {
//            site_phoneNumber = site!.phoneNumber!
//            var value = NSLocalizedString("Phone", comment: "Phone")
//            phoneNumber!.text = "\(value): \(site!.phoneNumber!)"
//            phoneNumber!.frame.origin.y = ypos
//            phoneNumber!.sizeToFit()
//            ypos += phoneNumber!.frame.height
//            
//            
//        }else {
//            
//        }
//        
//        if site!.email! != "" {
//            site_email = site!.email!
//            var value = NSLocalizedString("Email", comment: "Email")
//            email!.text = "\(value): \(site!.email!)"
//            email!.frame.origin.y = ypos
//            email!.sizeToFit()
//            ypos += email!.frame.height
//            
//            
//        } else {
//
//            
//        }
        
        //commentBtn!.icon!.color = site!.titleColor!
        //commentBtn!.showDisable()
        
        ypos += 10
        var total:CGFloat = (ypos - siteAvatarView!.frame.height) / 2
        siteAvatarView!.frame.origin.y = total
        
        

        
        ypos += 10
        //let span = MKCoordinateSpanMake(0.1, 0.1)
       // let region = MKCoordinateRegion(center: siteLocation!, span: span)
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

