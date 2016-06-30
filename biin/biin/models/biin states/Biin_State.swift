//  Biin_State.swift
//  biin
//  Created by Esteban Padilla on 3/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class Biin_State {
    
    
    var biin:BNBiin?
    var waitingTime:CGFloat = 0
    var message:String?
    
    init(biin:BNBiin?) {
        self.biin = biin
    }
    
    deinit {
        
    }
    
    func action(){
        
    }
    
    func setNotificationMessage(value:Int){
        switch value {
        case 1://message 1
            break
        case 2://message 2
            break
        case 3://generic message
            break
        default:
            break
        }
    }
    
    func setNotificationWaitingTime(value:CGFloat) {
        waitingTime = value
    }
    
    func setNextState(biin:BNBiin) {
        
    }
}