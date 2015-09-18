//  BNOrganization.swift
//  biin
//  Created by Esteban Padilla on 7/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNOrganization:NSObject {
    
    var identifier:String?

    //Details
    var title:String?
    var subTitle:String?
    
    var name:String?
    var brand:String?
    var organizationDescription:String?
    var extraInfo:String?
    
    var isLoyaltyEnabled:Bool = false
    var loyalty:BNLoyalty?

    var media:Array<BNMedia> = Array<BNMedia>()
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String){
        self.init()
        self.identifier = identifier
    }
    
    func addPoints(points:Int) {
        self.loyalty!.points += points
        BNAppSharedManager.instance.networkManager.sendBiiniePoints(BNAppSharedManager.instance.dataManager.bnUser!, organization: self, points:points)
    }
    
    deinit{
        
    }
}