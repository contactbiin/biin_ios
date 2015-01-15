//  BNAppManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNAppSharedManager { static let instance = BNAppManager() }

class BNAppManager {
    
    var counter = 0
    var version = "0.1.7"
    
    var dataManager:BNDataManager
    var positionManager:BNPositionManager
    var networkManager:BNNetworkManager
    var errorManager:BNErrorManager
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    
    var deviceType = BNDeviceType.none
    
    init(){
        self.counter++

        errorManager = BNErrorManager()
        dataManager = BNDataManager(errorManager:errorManager)
        positionManager = BNPositionManager(errorManager:errorManager)
        networkManager = BNNetworkManager(errorManager:errorManager)
        
        networkManager.delegateDM = dataManager
        dataManager.delegateNM = networkManager
        dataManager.delegatePM = positionManager
        positionManager.delegateDM = dataManager
        errorManager.delegateNM = networkManager
        
        //1. Code Flow - Checks connectivity first.
        //networkManager.checkConnectivity()
        
        checkDeviceType()
    }
    
    func checkDeviceType(){
        println("checkDeviceType()")
    }
}

enum BNDeviceType {
    case none
    case iphone4s
    case iphone5
    case iphone6
    case iphone6Plus
    case ipad2
    case ipadRetina
    case ipadAir
}
