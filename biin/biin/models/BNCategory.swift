//  BNCategory.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

struct BNCategorySiteDetails {
    init(){ }
    var identifier:String?
    var json:String?
}

class BNCategory:NSObject {
    
    var identifier:String?
    var sitesDetails:Array<BNCategorySiteDetails> = Array<BNCategorySiteDetails>()
    
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