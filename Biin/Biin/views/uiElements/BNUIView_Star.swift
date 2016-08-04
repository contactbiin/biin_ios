//  BNUIView_Star.swift
//  Biin
//  Created by Esteban Padilla on 7/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIView_Star:UIView {
    
    var icon:BNIcon_Star?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor?, isFilled:Bool) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = frame.width / 2
        self.layer.borderWidth = 2
        
        if isFilled {
            self.layer.borderColor = color!.CGColor
            icon = BNIcon_Star(color: color!, position:SharedUIManager.instance.loyaltyCardView_StarPosition)
        } else {
            self.layer.borderColor = UIColor.bnGrayLight().CGColor
            icon = BNIcon_Star(color: UIColor.bnGrayLight() , position:SharedUIManager.instance.loyaltyCardView_StarPosition)
        }
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
    func fill(color:UIColor){
        self.layer.borderColor = color.CGColor
        icon?.color = color
        setNeedsDisplay()
    }
}