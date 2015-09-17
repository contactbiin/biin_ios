//
//  BNUIIconView.swift
//  biin
//
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class BNUIIconView: UIView {

    var icon:BNIcon?
    var color:UIColor?
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, categoryType:BNCategoryType) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        addIcon(categoryType)
    }
    
    convenience init(frame: CGRect, color:UIColor) {
        self.init(frame:frame)
        self.color = color
    }
    
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
    
    func addIcon(categoryType:BNCategoryType) {
 
    }
}