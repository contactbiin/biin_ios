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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        //icon = BNIcon_Biin(color: UIColor.grayColor(), position: CGPoint(x: 5, y: 5), scale:1.0)
    }
    
    convenience init(position:CGPoint, scale:CGFloat) {

        //let consScale:CGFloat = 1.0
        let consWidth:CGFloat = 230.0
        let consHeight:CGFloat = 130.0
        
        let width:CGFloat = (scale * consWidth)
        let height:CGFloat = (scale * consHeight)
        
        let consPosition:CGFloat = 10.0
        let space:CGFloat = (scale * consPosition)
        
        self.init(frame: CGRectMake(position.x, position.y, width, height))
        //self.backgroundColor = UIColor.bnRed()
        
        icon = BNIcon_Biin(color: UIColor.whiteColor(), position:CGPoint(x:space, y:space), scale:scale)
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}
