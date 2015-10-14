//  SiteView_Information.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import MapKit


class SiteView_Information:BNView, MKMapViewDelegate {
    
    var backBtn:UIButton?
    
    var debugingMap:MKMapView?
    var console:UITextView?

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
        
        //BNAppSharedManager.instance.positionManager.delegateView = self
        
        self.backgroundColor = UIColor.appMainColor()
        
        debugingMap = MKMapView(frame:CGRectMake(0, (SharedUIManager.instance.screenHeight / 2), SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight / 2)))

        debugingMap!.delegate = self
        debugingMap!.showsUserLocation = true
        self.addSubview(debugingMap!)
        
        let siteLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
        
        let annotation = MKPointAnnotation()
//        annotation.setCoordinate(siteLocation)
        annotation.coordinate = siteLocation
        annotation.title = "Annotation title"
        annotation.subtitle = "Annotation subtitle"
        
        debugingMap!.addAnnotation(annotation)
        
        console = UITextView(frame:CGRectMake(0, 0, SharedUIManager.instance.screenWidth, (SharedUIManager.instance.screenHeight / 2)))
        self.console!.textColor = UIColor.blackColor()
        self.console!.font = UIFont(name: "Helvetica-Bold", size: 12.0)
        self.console!.text = "🐱"
        self.console!.backgroundColor = UIColor.clearColor()
        self.console!.editable = false
        self.console!.selectable = false
        self.addSubview(self.console!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 22, 50, 50))
        backBtn!.addTarget(father, action: "hideInformationView:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.backgroundColor = UIColor.redColor()
        self.addSubview(backBtn!)
        
        //Call his method again just for testing on view.
        BNAppSharedManager.instance.positionManager.startRegionsMonitoring(Array(BNAppSharedManager.instance.dataManager.regions.values))
        
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

    }
    
    //BNPositionManagerDelegate
    func startEnterRegionProcessWith(manager:BNPositionManager, identifier:String){}
    func startExitRegionProcessWith(manager:BNPositionManager, identifier:String){}
    func markBiinAsDetected(manager:BNPositionManager, uuid:String){}
    
    
    func manager(manager:BNPositionManager!,  setPinOnMapWithLat lat:Float, long:Float, radious:Int , title:String, subtitle:String)
    {
        let latitude = CLLocationDegrees(lat)
        let longitude = CLLocationDegrees(long)
        let circleRadious = CLLocationDistance(radious)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let point = MKPointAnnotation()
        point.coordinate = coordinate
        point.title = title
        point.subtitle = subtitle
        
        self.debugingMap!.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        self.debugingMap!.setRegion(viewRegion, animated:true)
        
        let circle = MKCircle(centerCoordinate: coordinate, radius:circleRadious)
        self.debugingMap!.addOverlay(circle)
    }
    
    func manager(manager:BNPositionManager!,  printText text:String)
    {
        var msj = self.console!.text + "\n"
        msj += text
        self.console!.text = msj
    }
    
    
    /*MKMapViewDelegate*/
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
        let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.location!.coordinate, 1000, 1000)
        self.debugingMap!.setRegion(viewRegion, animated: false)
    }
    /*
    func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayView!
    {
        var circleView:MKCircleView?
        
        if overlay is MKCircle
        {
            circleView = MKCircleView(overlay: overlay)

            circleView!.backgroundColor = UIColor.purpleColor()
            circleView!.tintColor = UIColor.bnRed()

            //circleView!.fillColor = UIColor.purpleColor().colorWithAlphaComponent(0.2)
            return circleView!
        }
        
        return circleView!
    }
    */
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    {

            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle

    }
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"xaxas")
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
    
    //Testing and learining
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }

}
