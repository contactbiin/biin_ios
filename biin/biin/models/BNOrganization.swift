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
    var loyalty:BNLoyalty?
    
    var media:Array<BNMedia> = Array<BNMedia>()
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String, loyalty:BNLoyalty){
        self.init()
        self.identifier = identifier
        self.loyalty = loyalty
    }
    
    deinit{
        
    }
    
}