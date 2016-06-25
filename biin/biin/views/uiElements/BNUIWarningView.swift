//  BNUIWarningView.swift
//  biin
//  Created by Esteban Padilla on 7/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIWarningView:UIView {
    
    var icon:BNIcon?
    
    //    override init() {
    //        super.init()
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.clearColor()
        //icon = BNIcon_Warning (color: UIColor.bnRed(), position: CGPoint(x: 5, y: 5), scale:1.0)
    }
    
    convenience init(position:CGPoint, scale:CGFloat) {
        
        let consScale:CGFloat = 4.0
        let consWidth:CGFloat = 350.0
        let consHeight:CGFloat = 350.0
        
        let width:CGFloat = ((scale * consWidth) / consScale)
        let height:CGFloat = ((scale * consHeight) / consScale)
        
        let consPosition:CGFloat = 1.0
        let space:CGFloat = ((scale * consPosition) / consScale )
        
        self.init(frame: CGRectMake(position.x, position.y, width, height))
        
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_Warning(color: UIColor.biinOrange(), position:CGPoint(x:space, y:space), scale:scale)
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}
