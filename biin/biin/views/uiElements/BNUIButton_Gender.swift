//  BNUIButton_Gender.swift
//  biin
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Gender:BNUIButton {
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, iconType:BNIconType) {
        self.init(frame:frame)

        self.backgroundColor = UIColor.appButtonColor()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        switch iconType {
        case .femaleSmall:
            icon = BNIcon_FemaleSmall(color: UIColor.appMainColor(), position: CGPoint(x: 10, y: 6))
            break
        case .maleSmall:
            icon = BNIcon_MaleSmall(color: UIColor.appMainColor(), position: CGPoint(x: 10, y: 6))
            break
        default:
            break
        }
    }
    
    override func showSelected() {
        self.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func showEnable() {
        self.backgroundColor = UIColor.appButtonColor() 
    }
}