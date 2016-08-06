//  BNLoyalty.swift
//  Biin
//  Created by Esteban Padilla on 12/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation


class BNLoyalty:BNObject {
    
    
    var organizationIdentifier:String?
    var loyaltyCard:BNLoyaltyCard?
    
    override init() {
        super.init()
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addStar(){
        loyaltyCard?.addStar()
    }
}
