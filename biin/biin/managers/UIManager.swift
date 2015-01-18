//  UIManager.swift
//  Biin
//  Created by Esteban Padilla on 11/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct SharedUIManager
{
    static let instance = UIManager()
}

class UIManager {
    
    var deviceType = BNDeviceType.none
    
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    
    //Menu variables
    var menuWidth:CGFloat = 220.0
    
    //Categories (sections) variables
    var categoriesHeaderHeight:CGFloat = 60.0
    var spacer:CGFloat = 1.0
    
    //Showcase and Main view positions
    var titleTop        = CGRectMake(5, 20, 0, 0)
    var subTitleTop     = CGRectMake(5, 54, 0, 0)
    var titleBottom     = CGRectMake(7, 5, 130, 18)
    var subTitleBottom  = CGRectMake(7, 23, 120, 11)
    
    //Element positions
    var elementTitleBackground:CGRect = CGRectMake(0, 5, 320, 50)
    var elementPricing = CGRectMake(5, 260, 200, 35)
    var elementTiming = CGRectMake(12, 195, 50, 50)
    var elementQuantity = CGRectMake(5, 195, 50, 50)
    var elementTitle = CGRectMake(55, 24, 260, 25)
    var elementPositionLbl = CGRectMake(6, 3, 44, 44)
    var elementButtonView = CGRectMake(55, 7, 250, 15)
    
    var elementPointsView = CGRectMake(0, 302, 320, 20)
    var elementStickerView = CGRectMake(260, 255, 50, 50)
    
    
}

enum BNDeviceType {
    case none
    case iphone4s
    case iphone5
    case iphone6
    case iphone6Plus
    case ipad
}