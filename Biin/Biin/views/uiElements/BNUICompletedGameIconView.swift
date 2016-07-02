//  BNUICircleIcon.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUICompletedGameIconView:BNView {
    
    var icon:BNIcon?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father: BNView?, color:UIColor) {
        self.init(frame: frame, father:father )
        self.backgroundColor = UIColor.clearColor()
        self.icon = BNIcon_CompletedGameIcon(color:color, scale:1, position: CGPointMake(10, 10), stroke:1, isFilled:false)
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        
    }
    
    override func setNextState(goto:BNGoto){
        
    }
}

