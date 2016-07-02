//  BNAppAction.swift
//  biin
//  Created by Esteban Padilla on 6/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNAppAction:NSObject {
    
    var identifier:String?
    var actionType:BnAppActionType?
    
    override init() {
        super.init()
    }
    
    convenience init (identifier:String, actionType:BnAppActionType){
        self.init()
        self.identifier = identifier
        self.actionType = actionType
    }
    
    deinit {
        
    }
}

enum BnAppActionType {
    case OPEN_ELEMENT
    case OPEN_SITE
}