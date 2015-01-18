//  BNUICircleIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/5/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUICircleIcon:BNView {
    
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
        self.backgroundColor = UIColor.clearColor()
        self.icon = CompletedCircleIcon(color:color, scale:1, position: CGPointMake(2, 2), stroke:1, isFilled:false)
        
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
