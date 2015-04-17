//  UserOnboardingView_Slide.swift
//  biin
//  Created by Esteban Padilla on 2/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingView_Slide:UIView {
    
    
    var title:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.biinColor()
    }
    
    convenience init(frame: CGRect, title:String?) {
        self.init(frame:frame)
        
        var screenWidth = SharedUIManager.instance.screenWidth
        self.title = UILabel(frame: CGRectMake(0, 50, screenWidth, 30))
        self.title!.text = title!
        self.title!.font = UIFont(name: "Lato-Regular", size: 22)
        self.title!.textColor = UIColor.appMainColor()
        self.title!.textAlignment = NSTextAlignment.Center
        self.addSubview(self.title!)
    }
}

