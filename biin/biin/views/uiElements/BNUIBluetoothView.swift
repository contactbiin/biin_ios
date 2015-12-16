//  BNUIBluetoothView.swift
//  biin
//  Created by Esteban Padilla on 12/14/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIBluetoothView:UIView {
    
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
        
        let consScale:CGFloat = 3.0
        let consWidth:CGFloat = 310.0
        let consHeight:CGFloat = 310.0
        
        let width:CGFloat = ((scale * consWidth) / consScale)
        let height:CGFloat = ((scale * consHeight) / consScale)
        
//        let consPosition:CGFloat = 0.0
//        let space:CGFloat = ((scale * consPosition) / consScale )
        
        self.init(frame: CGRectMake(position.x, position.y, width, height))
        
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_Bluetooth(color: UIColor.bnYellow(), position:CGPoint(x:4, y:4), scale:scale)
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}
