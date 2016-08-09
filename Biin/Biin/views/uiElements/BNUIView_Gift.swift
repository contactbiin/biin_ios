//  BNUIView_Gift.swift
//  Biin
//  Created by Esteban Padilla on 8/9/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIView_Gift:UIView {
    
    var icon:BNIcon_BigGift?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor?) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        icon = BNIcon_BigGift(color:color!, position:SharedUIManager.instance.loyaltyCardView_Completed_GiftPosition)
    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
}
