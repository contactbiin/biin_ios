//  BNIcon.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class BNIcon {
    
    var color:UIColor?
    var position:CGPoint = CGPoint.zero
    var width:CGFloat = 0
    var strokeWidth:CGFloat = 0
    var scale:CGFloat = 1
    
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
    case emailSmall
    case emailMedium
    case femaleSmall
    case friendsMedium
    case informationSmall//done
    case informationMedium
    case informationLarge
    case leftArrowSmall//done
    case leftArrowMedium
    case leftArrowLarge
    case maleSmall
    case menuMedium
    case notification
    case phoneMedium
    case profileMedium//Done
    case shareItButton
    case shareSmall //done
    case shareMedium
    case shareLarge
    case searchSmall
    case searchMedium
    case searchLarge
    case settingsMedium
    case x_small
    case gift
    case loyaltyWallet

}