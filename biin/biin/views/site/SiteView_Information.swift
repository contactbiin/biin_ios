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
        backBtn = UIButton(frame: CGRectMake(20, 20, 40, 40))
        backBtn!.addTarget(father, action: "hideInformationView:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn!.backgroundColor = UIColor.redColor()
        self.addSubview(backBtn!)
        
        debugingMap = MKMapView(frame:frame)
        debugingMap!.userInteractionEnabled = false
        debugingMap!.layer.cornerRadius = 3
        debugingMap!.layer.borderColor = UIColor.appBackground().CGColor
        debugingMap!.layer.borderWidth = 1
        debugingMap!.delegate = self
        self.addSubview(debugingMap!)
    }
    
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

    }
}
