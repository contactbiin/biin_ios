//  BNSticker.swift
//  Biin
//  Created by Esteban Padilla on 11/27/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNSticker:NSObject {

    var type:BNStickerType = .NONE
    var color:UIColor?
    
    override init(){
        super.init()
    }
    
    convenience init(type:BNStickerType, color:UIColor) {
        self.init()
        self.type = type
        self.color = color
    }
    
    deinit {
        
    }
}


enum BNStickerType {
    case NONE
    case CIRCLE_FREE
    case CIRCLE_SALE
    case CIRCLE_BEST_OFFER
    case CIRCLE_FREE_GIFT
}
