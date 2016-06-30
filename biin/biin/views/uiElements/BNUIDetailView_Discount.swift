//  BNUIDetailView_Discount.swift
//  biin
//  Created by Esteban Padilla on 4/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIDetailView_Discount:UIView {
    
    var titleLbl:UILabel?
    var valueLbl:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position:CGPoint, title:String?, value:String?, textColor:UIColor!, borderColor:UIColor ) {
        
        
        //var boxWidth = (SharedUIManager.instance.screenWidth - 14) / 3
        let frame = CGRectMake(position.x, position.y, (SharedUIManager.instance.screenWidth - 10), 30)
        self.init(frame:frame)
        self.backgroundColor = UIColor.appButtonColor()
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 0.5
        
        
        self.titleLbl = UILabel(frame: CGRectMake(0, 3, (SharedUIManager.instance.screenWidth - 10), 11))
        self.titleLbl!.text = title
        self.titleLbl!.textAlignment = NSTextAlignment.Center
        self.titleLbl!.font = UIFont(name: "Lato-Regular", size: 8)
        self.titleLbl!.textColor = textColor
        self.addSubview(self.titleLbl!)
        
        
        self.valueLbl = UILabel(frame: CGRectMake(0, 12, (SharedUIManager.instance.screenWidth - 10), 13))
        self.valueLbl!.text = value
        self.valueLbl!.textAlignment = NSTextAlignment.Center
        self.valueLbl!.font = UIFont(name: "Lato-Black", size: 11)
        self.valueLbl!.textColor = textColor
        self.addSubview(self.valueLbl!)
    }
}
