//  Biin_Not_Notified_IN_State.swift
//  biin
//  Created by Esteban Padilla on 3/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class Biin_Not_Notified_IN_State: Biin_State {
    
    override init(biin: BNBiin?) {
        super.init(biin: biin)
        println("init on Biin_Not_Notified_IN_State")
        setNotificationMessage(1)
        setNotificationWaitingTime(10.0)
    }
}