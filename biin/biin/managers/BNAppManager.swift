//  BNAppManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNAppSharedManager { static let instance = BNAppManager() }

class BNAppManager {
    
    var counter = 0
    var version = "0.1.8"
    
    var dataManager:BNDataManager
    var positionManager:BNPositionManager
    var networkManager:BNNetworkManager
    var errorManager:BNErrorManager
    
    var IS_PRODUCTION_RELEASE = false
    
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
        networkManager.checkConnectivity()
    }
    
    func biinit(identifier:String, isElement:Bool){

        println("Biinit: \(identifier)")
        
        if isElement {
            dataManager.elements[identifier]?.userBiined = true
            dataManager.elements[identifier]?.biins++
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.elements.append(dataManager.elements[identifier]!)
        
            networkManager.sendBiinedElement(dataManager.bnUser!, element:dataManager.elements[identifier]!, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
        } else {
            dataManager.sites[identifier]?.userBiined = true
            dataManager.sites[identifier]?.biinedCount++
            dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]?.sites.append(dataManager.sites[identifier]!)
            
            networkManager.sendBiinedSite(dataManager.bnUser!, site: dataManager.sites[identifier]!, collectionIdentifier: dataManager.bnUser!.temporalCollectionIdentifier!)
        }
    }
    
    func shareit(identifier:String){
        println("Shareit: \(identifier)")
    }
    
    func commentit(identifier:String, comment:String){
        println("Commentit: \(identifier) comment: \(comment)")
    }
    
    func unBiinit(identifier:String, isElement:Bool){
        println("unBiinit: \(identifier)")
        
        if dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.elements.count > 0 {
            
            var index:Int = 0
            
            if isElement {
                
                dataManager.elements[identifier]?.userBiined = false
                
                for element in dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.elements {
                    index++
                    if element._id! == identifier {
                        return
                    }
                }
                
                dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.elements.removeAtIndex(index)
            } else {
                
                dataManager.sites[identifier]?.userBiined = false
                for sites in dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.sites {
                    index++
                    if sites.identifier! == identifier {
                        return
                    }
                }
                
                dataManager.bnUser!.collections![dataManager.bnUser!.temporalCollectionIdentifier!]!.sites.removeAtIndex(index)
            }
        }
        //TODO: inform backend the user remove biined element
    }
}
