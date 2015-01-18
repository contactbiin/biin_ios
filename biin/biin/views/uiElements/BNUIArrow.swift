//  BNUIArrow.swift
//  Biin
//  Created by Esteban Padilla on 8/12/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUIArrow:BNView {
    
    var icon:BNIcon?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father: BNView?, color:UIColor) {
        self.init(frame: frame, father:father )
        var scale = frame.height / 15.0
        self.backgroundColor = UIColor.clearColor()
        self.icon = ArrowDownIcon(color:color, scale:scale, position: CGPointMake(2, 2), stroke:1, isFilled:false)
     
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
    override func transitionIn() {
    
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(option:Int){
    
    }
}