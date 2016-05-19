//  BNShowcase.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNShowcase:NSObject {

    var _id:String?
    var identifier:String?
    var isShowcaseGameCompleted = false
    var isRequestPending = true
    var lastUpdate:NSDate?
    
    //Context Variables
    var isDefault:Bool = false
    var isUserNotified:Bool = false
    
    //Details
    var title:String?
    var subTitle:String?
    
    //Elements
    var elements:Array<String> = Array<String>()
    var elements_quantity:Int = 0
    var batch:Int = 1
    
    //var siteIdentifier:String?
    weak var site:BNSite?
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
}

