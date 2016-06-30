//  ElementMiniView_Precentage.swift
//  biin
//  Created by Esteban Padilla on 9/21/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView_Precentage: UIView {

    var icon:BNIcon?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, text:String, textSize:CGFloat, textColor:UIColor, color:UIColor, textPosition:CGPoint) {
        self.init(frame:frame)
        
        self.backgroundColor = UIColor.clearColor()

        self.layer.masksToBounds = true
        
        icon = BNIcon_Percentage(color: color, position: CGPoint(x:0, y:0), text:text, textcolor:textColor, size:frame.width, textSize:textSize, textPosition:textPosition)
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
    
}