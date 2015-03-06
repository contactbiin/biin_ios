//  SiteView_Bottom.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Bottom:BNView {
    
    var pointsLbl:UILabel?
    var informationBtn:BNUIButton_Information?
    
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
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSizeMake(3, 0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.25
        
        pointsLbl = UILabel(frame: CGRectMake(40, 8, (SharedUIManager.instance.screenWidth - 50), 14))
        pointsLbl!.textAlignment = NSTextAlignment.Right
        pointsLbl!.font = UIFont(name: "Lato-Light", size: 12)
        pointsLbl!.textColor = UIColor.appTextColor()
        self.addSubview(pointsLbl!)
        
        informationBtn = BNUIButton_Information(frame: CGRectMake(5, 2, 26, 26))
        informationBtn!.addTarget(father, action: "showInformationView:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(informationBtn!)

    }

    override func transitionIn() {
        println("trasition in on SiteView_Bottom")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on SiteView_Bottom")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: SiteView_Bottom")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: SiteView_Bottom")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance methods
    func updateForSite(site: BNSite?){
        //pointsLbl!.text = "Points: \(site!.loyalty!.points)"
    }
}
