//  BNBadge.swift
//  Biin
//  Created by Esteban Padilla on 12/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNBadge:NSObject {

    var identifier:String?
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String){
        self.init()
        self.identifier = identifier
    }
    
    deinit {
        
    }
}