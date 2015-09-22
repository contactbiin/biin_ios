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
    
    convenience init(frame: CGRect, text:String, textSize:CGFloat, color:UIColor ) {
        self.init(frame:frame)
        

        
        self.backgroundColor = UIColor.clearColor()
        //        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //        var fontSize1:CGFloat = 20
        //        var fontSize2:CGFloat = 25
        //        var ypos1:CGFloat = 4
        //        var ypos2:CGFloat = 26
        //        var x_ypos:CGFloat = 4
        //        var spacer:CGFloat = 40
        //        var strokeWidth:CGFloat = 2
        //
        //        if isMini {
        //            fontSize1 = 11
        //            fontSize2 = 14
        //            ypos1 = 4
        //            ypos2 = 16
        //            x_ypos = 0
        //            spacer = 20
        //            strokeWidth = 1
        //        }
        
  
        

        icon = BNIcon_PricingBig(color: color, position: CGPoint(x:0, y:0), text:text, size:frame.width, textSize:textSize)

    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
    
}