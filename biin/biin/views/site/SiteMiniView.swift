//  SiteMiniView.swift
//  biin
//  Created by Esteban Padilla on 1/17/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteMiniView: BNView {
    
    weak var site:BNSite?
    
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
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
        
        self.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.25).CGColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        
        self.site = site
        self.backgroundColor = site!.media[0].domainColor!
        var nameLbl = UILabel(frame: CGRectMake(5, 5, 100, 15))
        nameLbl.font = UIFont(name: "Lato-Regular", size:14)
        nameLbl.text = self.site!.identifier!
        self.addSubview(nameLbl)
    }
    
    override func transitionIn() {
        println("trasition in on CategoriesView_Header")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on CategoriesView_Header")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: CategoriesView_Header")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: CategoriesView_Header")
        }else{
            father!.updateUserControl(position)
        }
    }
}