//  Biined_Notified_State.swift
//  biin
//  Created by Esteban Padilla on 3/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class Biined_Notified_State: Biin_State {
    
    override init(biin: BNBiin?) {
        super.init(biin: biin)
        println("init() Biined_Not_Notified_State in biin: \(biin!.identifier!) and showcase: \(biin!.showcases![biin!.currentShowcaseIndex].identifier!)")

    }
    
    override func action() {
        println("action() on Biined_Notified_State")
    }
}
