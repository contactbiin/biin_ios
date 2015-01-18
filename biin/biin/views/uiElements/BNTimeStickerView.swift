//  BNTimeStickerView.swift
//  Biin
//  Created by Esteban Padilla on 9/12/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNTimeStickerView:UIView {

    var titleLbl:UILabel?
    var timeLbl:UILabel?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position:CGPoint, text:String?, textColor:UIColor, borderColor:UIColor) {
        
        var frame = CGRectMake(position.x, position.y, 310, 30)
        self.init(frame:frame)
//        self.layer.backgroundColor = UIColor.bnRed().CGColor
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.CGColor
        
        titleLbl = UILabel(frame: CGRectMake(85, 3, 100, 22))
        titleLbl!.text = "Limited Time:"
        titleLbl!.font = UIFont(name: "Lato-Regular", size: 14)
        titleLbl!.textColor = textColor
        titleLbl!.textAlignment = NSTextAlignment.Right
        self.addSubview(titleLbl!)
        
        timeLbl = UILabel(frame: CGRectMake(190, 3, 100, 22))
        timeLbl!.text = text
        timeLbl!.font = UIFont(name: "Lato-Black", size: 14)
        timeLbl!.textColor = textColor
        self.addSubview(timeLbl!)
        
        
    }
}