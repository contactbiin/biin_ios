//  BNCategory.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct BNCategorySiteDetails {
    init(){ }
    var identifier:String?
    var json:String?
    var biinieProximity:Float?
}

class BNCategory:NSObject {
    
    var identifier:String?
    var name:String?
    //var categoryType:BNCategoryType?
    var sitesDetails:Array<BNCategorySiteDetails> = Array<BNCategorySiteDetails>()
    var isDownloaded = false
    var isUserCategory = false
    var hasSites = false
    var elements:Array<BNElementRelationShip> = Array<BNElementRelationShip>()
//    var elements:Dictionary<String, BNElement> = Dictionary<String, BNElement>()
//    var elements:Array<BNElement> = Array<BNElement>()
    var priority = 1
    var backgroundColor:UIColor?
    
    override init(){
        super.init()
    }
    
    convenience init(identifier:String) {
        self.init()
        self.identifier = identifier
        //addIconType()
    }
    
    convenience init(identifier:String, name:String) {
        self.init()
        self.identifier = identifier
        self.name = name
        //addIconType()
    }
    
    deinit { }

    func addIconType(){
//        if identifier == "category1" {
//            categoryType = BNCategoryType.personalcare
//        } else if identifier == "category2" {
//            categoryType = BNCategoryType.vacations
//        } else if identifier == "category3" {
//            categoryType = BNCategoryType.shoes
//        } else if identifier == "category4" {
//            categoryType = BNCategoryType.game
//        } else if identifier == "category5" {
//            categoryType = BNCategoryType.outdoors
//        } else if identifier == "category6" {
//            categoryType = BNCategoryType.health
//        } else if identifier == "category7" {
//            categoryType = BNCategoryType.food
//        } else if identifier == "category8" {
//            categoryType = BNCategoryType.sports
//        } else if identifier == "category9" {
//            categoryType = BNCategoryType.education
//        } else if identifier == "category10" {
//            categoryType = BNCategoryType.fashion
//        } else if identifier == "category11" {
//            categoryType = BNCategoryType.music
//        } else if identifier == "category12" {
//            categoryType = BNCategoryType.movies
//        } else if identifier == "category13" {
//            categoryType = BNCategoryType.technology
//        } else if identifier == "category14" {
//            categoryType = BNCategoryType.entertaiment
//        } else if identifier == "category15" {
//            categoryType = BNCategoryType.travel
//        } else if identifier == "general"{
//            categoryType = BNCategoryType.general
//        } else {
//            categoryType = BNCategoryType.none
//        }
    }
}

enum BNCategoryType {
    case none
    case general
    case personalcare
    case vacations
    case shoes
    case game
    case outdoors
    case health
    case food
    case sports
    case education
    case fashion
    case music
    case movies
    case technology
    case entertaiment
    case travel
}