//  Biined_Not_Notified_State.swift
//  biin
//  Created by Esteban Padilla on 3/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class Biined_Not_Notified_State: Biin_State {
    
    override init(biin: BNBiin?) {
        super.init(biin: biin)
        //println("init() Biined_Not_Notified_State in biin: \(biin!.identifier!) and object: \(biin!.objects![biin!.currentObjectIndex].identifier!)")
    }
    
    override func action() {
        switch biin!.proximity {
        case .NA:
            //println("action() on Biined_Not_Notified_State - NA")
            break
        case .INM:
            biin!.state = Biined_Not_Notified_IN_State(biin: self.biin)
            //println("action() on Biined_Not_Notified_State - INM")
            break
        case .NEAR:
            biin!.state = Biined_Not_Notified_NEAR_State(biin: self.biin)
            //println("action() on Biined_Not_Notified_State - NEAR")
            break
//        default:
//            break
        }
    }
}

