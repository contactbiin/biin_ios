//  SiteView_Map.swift
//  biin
//  Created by Esteban Padilla on 5/19/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit
import MessageUI
//import UberRides

class SiteView_Map:BNView, MKMapViewDelegate {
    
    var title:UILabel?
    var map:MKMapView?
    var closeBtn:UIButton?
    var siteLocation:CLLocationCoordinate2D?
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
        let screenWidth = frame.width
        var ypos:CGFloat = 10
        
        closeBtn = BNUIButton_Close(frame: CGRectMake((SharedUIManager.instance.screenWidth - 35), 5, 30, 30), iconColor: UIColor.blackColor())
        closeBtn!.addTarget(father, action: #selector(self.closeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(closeBtn!)
        
        let xpos:CGFloat = 10
        
        title = UILabel(frame: CGRectMake(xpos, ypos, screenWidth, (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.bnGrayDark()
        title!.textAlignment = NSTextAlignment.Left
        title!.text = "site title here"
        title!.numberOfLines = 0
        self.addSubview(title!)
        
        ypos += 10
        map = MKMapView(frame:CGRectMake(5, ypos, (screenWidth - 10), 150))
        map!.userInteractionEnabled = false
        map!.delegate = self
        self.addSubview(map!)
        
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
        
        ypos += 55
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, ypos)
        
    }
    
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
        title!.text = "\(site!.title!) - \(site!.subTitle!)"
        title!.sizeToFit()
        
        ypos += title!.frame.height
        
        
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ = self.site!.organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        /*
        let textColor:UIColor?
        let bgColor:UIColor?
        
        
        if white >= 0.95 {
            //print("Is white")
            textColor = site!.organization!.primaryColor!
            bgColor = site!.organization!.secondaryColor!
        } else {
            textColor = site!.organization!.secondaryColor!
            bgColor = site!.organization!.primaryColor
        }
        */
        
        map!.frame.origin.y = ypos
        siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(site!.latitude!), longitude: CLLocationDegrees(site!.longitude!))
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegion(center: siteLocation!, span: span)
        map!.setRegion(region, animated: false)
        
        let annotationsToRemove = map!.annotations
        map!.removeAnnotations( annotationsToRemove )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = siteLocation!
        annotation.title = site!.title!
        annotation.subtitle = site!.streetAddress1!
        map!.addAnnotation(annotation)
    }
    
    func updateButtons() {
        
        /*
        var white:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        _ = self.site!.organization!.primaryColor!.getWhite(&white, alpha: &alpha)
        var textColor:UIColor?
        var bgColor:UIColor?
        
        
        if white >= 0.95 {
            textColor = site!.organization!.primaryColor!
            bgColor = site!.organization!.secondaryColor!
        } else {
            textColor = site!.organization!.secondaryColor!
            bgColor = site!.organization!.primaryColor
        }
        */
        var ypos:CGFloat = map!.frame.origin.y
        ypos += (map!.frame.height + 5)
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, (ypos + 5))
        
        
    }
    
    override func clean() {
        map?.removeFromSuperview()
        siteLocation = nil
    }
    
    func show() {
        
    }
    
    func closeBtnAction(sender:BNUIButton_Close) {
        
    }
}
