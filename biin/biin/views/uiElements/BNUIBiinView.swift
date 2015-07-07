//  BNUIBiinView.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIBiinView:UIView {
    
    var icon:BNIcon?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_Biin(color: UIColor.biinColor(), position: CGPoint(x: 5, y: 5), scale:1.0)
    }
    
    convenience init(position:CGPoint, scale:CGFloat) {

        var consScale:CGFloat = 4.0
        var consWidth:CGFloat = 180.0
        var consHeight:CGFloat = 95.0
        
        var width:CGFloat = ((scale * consWidth) / consScale)
        var height:CGFloat = ((scale * consHeight) / consScale)
        
        var consPosition:CGFloat = 10.0
        var space:CGFloat = ((scale * consPosition) / consScale )
        
        self.init(frame: CGRectMake(position.x, position.y, width, height))
        self.backgroundColor = UIColor.clearColor()
        
        icon = BNIcon_Biin(color: UIColor.biinColor(), position:CGPoint(x:space, y:space), scale:scale)
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}
