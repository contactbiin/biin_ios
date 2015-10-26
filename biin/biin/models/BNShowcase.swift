//  BNShowcase.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNShowcase:NSObject {

    //TODO: jsonUrl only for testing, remove later
    var jsonUrl:String?
    var isShowcaseGameCompleted = false
    var identifier:String?
    var isRequestPending = true
    var lastUpdate:NSDate?
    var startTime:NSDate?
    var endTime:NSDate?
    
    //Context Variables
    var isDefault:Bool = false
    var isUserNotified:Bool = false
    
    //Details
    var title:String?
    var subTitle:String?
    
    //Color
    var titleColor:UIColor?
    
    //Type
    var showcaseType = BNShowcaseType.SimpleProduct
    
    //Colour
    var theme:BNShowcaseTheme?

    //Elements
    var elements:Array<BNElement> = Array<BNElement>()
    
    //var siteIdentifier:String?
    var site:BNSite?
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
}

enum BNShowcaseTheme {
    case Dark   //1
    case Light  //2
}

enum BNShowcaseType {
    case SimpleProduct      //1
    case MultipleProduct    //2
}
