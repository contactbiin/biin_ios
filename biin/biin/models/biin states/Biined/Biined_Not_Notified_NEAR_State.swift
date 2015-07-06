//  Biined_Not_Notified_NEAR_State.swift
//  biin
//  Created by Esteban Padilla on 3/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class Biined_Not_Notified_NEAR_State: Biin_State {
    
    override init(biin: BNBiin?) {
        super.init(biin: biin)
        //println("init() Biined_Not_Notified_NEAR_State in biin: \(biin!.identifier!) and showcase: \(biin!.objects![biin!.currentObjectIndex].identifier!)")

        setNotificationMessage(2)
    }
    
    override func action() {
        //println("action() on Biined_Not_Notified_NEAR_State")
    }
}
