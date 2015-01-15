//  BNCategory.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNCategory:NSObject {
    
    var identifier:String?
    var sites:Array<BNSite> = Array<BNSite>()
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String) {
        self.init()
        self.identifier = identifier
    }
    
    deinit {
        
    }

}