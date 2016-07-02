//  Biin_Not_Notified_State.swift
//  biin
//  Created by Esteban Padilla on 3/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class Biin_Not_Notified_State: Biin_State {
    
    override init(biin: BNBiin?) {
        super.init(biin: biin)
    }
    
    override func action() {
        switch biin!.proximity {
        case .NA:
            break
        case .INM:
            biin!.state = Biin_Not_Notified_IN_State(biin: self.biin)
            break
        case .NEAR:
            biin!.state = Biin_Not_Notified_NEAR_State(biin: self.biin)
            break
        }
    }
}