//  BNIcon.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class BNIcon {
    
    var color:UIColor?
    var position:CGPoint = CGPoint.zeroPoint
    var width:CGFloat = 0
    
    init(){ }
    
    func drawCanvas() { }
    func iconPath() -> UIBezierPath { return UIBezierPath() }
}

enum BNIconType {
    case none
    case biinSmall //done
    case biinMedium
    case biinLarge
    case biinItButton
    case burgerSmall
    case burgerMedium //done
    case burgerLarge
    case commentSmall //done
    case commentMedium
    case commentLarge
    case femaleSmall
    case keyholeSmall//done
    case keyholeMedium
    case keyholeLarge
    case leftArrowSmall//done
    case leftArrowMedium
    case leftArrowLarge
    case maleSmall
    case informationSmall//done
    case informationMedium
    case informationLarge
    case shareItButton
    case shareSmall //done
    case shareMedium
    case shareLarge
    case searchSmall
    case searchMedium
    case searchLarge
    case smileSmall
    case smileMedium //done
    case smileLarge
    case notificationSmall
    case notificationMedium
    case notificationLarge
}