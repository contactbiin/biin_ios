//  BNObject.swift
//  Biin
//  Created by Esteban Padilla on 6/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNObject: NSObject, NSCoding {
    
    var identifier:String?
    
    override init() {
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
    
    }
    
    deinit {
        
    }
}
