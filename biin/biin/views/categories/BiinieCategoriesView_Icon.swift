//  BiinieCategoriesView_Icon.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_Icon:UIView {

    var icon:BNIcon?
    var color:UIColor?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, categoryType:BNCategoryType) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        color = UIColor.appIconColor()
        addIcon(categoryType)
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
    
    func addIcon(categoryType:BNCategoryType) {
        switch categoryType {
        case .general:
            icon = BNIcon_SmileMedium(color: color!, position: CGPoint(x: 0.5, y: 1))
            break
        case .personalcare:
            icon = BNIcon_WeightMedium(color: color!, position: CGPoint(x: 1, y: 1))
            break
        case .vacations:
            icon = BNIcon_UmbrellaMedium(color: color!, position: CGPoint(x: 1, y: 1))
            break
        case .shoes:
            icon = BNIcon_ShoeSmall(color:color!, position:CGPoint(x:2, y:5))
            break
        case .game:
            break
        case .outdoors:
            break
        case .health:
            break
        case .food:
            icon = BNIcon_BurgerMedium(color: color!, position: CGPoint(x: 0.5, y: 1))
            break
        case .sports:
            break
        case .education:
            break
        case .fashion:
            icon = BNIcon_FashionSmall(color:color!, position:CGPoint(x:1, y:6))
            break
        case .music:
            break
        case .movies:
            break
        case .technology:
            icon = BNIcon_TVMedium(color: color!, position: CGPoint(x: 1, y: 0))
            break
        case .entertaiment:
            break
        case .travel:
            break
        default:
            break
        }
    }
}