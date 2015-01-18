//  BNQuantityStickerView.swift
//  Biin
//  Created by Esteban Padilla on 9/12/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNQuantityStickerView:UIView {
    
    var titleLbl:UILabel?
    var valueLbl:UILabel?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position:CGPoint, title:String?, value:String?, textColor:UIColor!, borderColor:UIColor ) {
        
        var frame = CGRectMake(position.x, position.y, 102, 30)
        self.init(frame:frame)
//        self.layer.backgroundColor = UIColor.bnBlueDark().CGColor
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 1
        
        
        self.titleLbl = UILabel(frame: CGRectMake(0, 3, 102, 11))
        self.titleLbl!.text = title
        self.titleLbl!.textAlignment = NSTextAlignment.Center
        self.titleLbl!.font = UIFont(name: "Lato-Regular", size: 8)
        self.titleLbl!.textColor = textColor
        self.addSubview(self.titleLbl!)
        
        
        self.valueLbl = UILabel(frame: CGRectMake(0, 12, 102, 13))
        self.valueLbl!.text = value
        self.valueLbl!.textAlignment = NSTextAlignment.Center
        self.valueLbl!.font = UIFont(name: "Lato-Black", size: 11)
        self.valueLbl!.textColor = textColor
        self.addSubview(self.valueLbl!)
    }
}
