//  BNOrganization.swift
//  biin
//  Created by Esteban Padilla on 7/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNOrganization:NSObject {
    
    var identifier:String?

    //Details
    var title:String?
    var subTitle:String?
    
    //var name:String?
    var brand:String?
    var organizationDescription:String?
    var extraInfo:String?
    
    var isLoyaltyEnabled:Bool = false
    var loyalty:BNLoyalty?

    var primaryColor:UIColor?
    var secondaryColor:UIColor?
    
    var media:Array<BNMedia> = Array<BNMedia>()
    
    var hasNPS = false
    
    var sites:Array<String> = Array<String>()
    
    var isUserInSite = false

    override init(){
        super.init()
    }
    
    convenience init(identifier:String){
        self.init()
        self.identifier = identifier
    }
    
    deinit{
        
    }
}