//  SiteView_Information.swift
//  biin
//  Created by Esteban Padilla on 2/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteView_Information:BNView {
    
    var backBtn:UIButton?
    
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
    //Instance methods
    func updateForSite(site: BNSite?){

    }
}
