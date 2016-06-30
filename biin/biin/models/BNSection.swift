//  BNSection.swift
//  Biin
//  Created by Esteban Padilla on 7/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNSectionDetails {
    var showcase = "", biin = "", site = ""
}

class BNSection:NSObject {
    
    var identifier:String?
    var data:Array<BNSectionDetails> = Array<BNSectionDetails>()
    
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