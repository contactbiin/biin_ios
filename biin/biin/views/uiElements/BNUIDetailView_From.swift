//
//  BNUIDetailView_From.swift
//  biin
//
//  Created by Esteban Padilla on 4/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import UIKit

class BNUIDetailView_From:UIView {
    
    var titleLbl:UILabel?
    var timeLbl:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position:CGPoint, text:String?, textColor:UIColor, borderColor:UIColor) {
        
        var frame = CGRectMake(position.x, position.y, (SharedUIManager.instance.screenWidth - 10), 30)
        self.init(frame:frame)
        self.backgroundColor = UIColor.appBackground()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = borderColor.CGColor
        
        titleLbl = UILabel(frame: CGRectMake(0, 7, ((SharedUIManager.instance.screenWidth / 2) - 5), 16))
        titleLbl!.text = NSLocalizedString("From", comment: "From")
        titleLbl!.font = UIFont(name: "Lato-Regular", size: 14)
        titleLbl!.textColor = textColor
        titleLbl!.textAlignment = NSTextAlignment.Right
        self.addSubview(titleLbl!)
        
        timeLbl = UILabel(frame: CGRectMake((SharedUIManager.instance.screenWidth / 2), 7, ((SharedUIManager.instance.screenWidth / 2) - 10), 16))
        timeLbl!.text = text
        timeLbl!.font = UIFont(name: "Lato-Black", size: 14)
        timeLbl!.textColor = textColor
        self.addSubview(timeLbl!)
        
        
    }
}
