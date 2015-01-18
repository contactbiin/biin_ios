//  BNIcon.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class BNIcon {
    
    var color:UIColor?
    var scale:CGFloat = 1.0
    var position:CGPoint = CGPoint.zeroPoint
    var stroke:CGFloat = 1.0
    var isFilled:Bool = false
    
    init(){ }
    
    func drawCanvas() { }
    func iconPath() -> UIBezierPath { return UIBezierPath() }
}