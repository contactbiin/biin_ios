//  NotificationsView_Notification.swift
//  biin
//  Created by Esteban Padilla on 3/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class NotificationsView_Notification: BNView {
    
    var image:BNUIImageView?
    var title:UILabel?
    var text:UILabel?
    
    weak var site:BNSite?
    weak var element:BNElement?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame)
        self.father = father
        
        self.backgroundColor = UIColor.appMainColor()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var screenHeight = SharedUIManager.instance.screenHeight
        
        title = UILabel(frame: CGRectMake(0, 3, screenWidth, 12))
        title!.text = "Profile"
        title!.textColor = UIColor.appTextColor()
        title!.font = UIFont(name: "Lato-Light", size: 10)
        title!.textAlignment = NSTextAlignment.Center
        self.addSubview(title!)
    }
    
    convenience init(frame: CGRect, father: BNView?, site:BNSite?) {
        self.init(frame:frame, father:father)
        self.site = site
    }

    convenience init(frame: CGRect, father: BNView?, element:BNElement?) {
        self.init(frame:frame, father:father)
        self.element = element
    }
    
}
