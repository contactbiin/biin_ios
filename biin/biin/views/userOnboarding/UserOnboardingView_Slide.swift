//  UserOnboardingView_Slide.swift
//  biin
//  Created by Esteban Padilla on 2/19/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingView_Slide:UIView {
    
    
//    var title:UILabel?
//    var text:UILabel?
    var image:UIImageView?
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    convenience init(frame: CGRect, title:String, text:String, imageString:String) {
        self.init(frame:frame)
        
        var screenWidth = SharedUIManager.instance.screenWidth
        var ypos:CGFloat = 0
        
        var container = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        self.addSubview(container)
        
        var titleText = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 26))
        titleText.font = UIFont(name:"Lato-Black", size:23)
        titleText.textColor = UIColor.appTextColor()
        titleText.textAlignment = NSTextAlignment.Center
        titleText.text = title//NSLocalizedString("AboutText", comment: "AboutText")
        titleText.numberOfLines = 0
        //titleText.sizeToFit()
        container.addSubview(titleText)
        
        ypos += ( titleText.frame.height + 20 )
        self.image = UIImageView(frame: CGRectMake(0, ypos, screenWidth, screenWidth))
        self.image!.image = UIImage(named:imageString)
        container.addSubview(image!)
        
        ypos += ( self.image!.frame.height + 20 )
        var descriptionText = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), 24))
        descriptionText.font = UIFont(name:"Lato-Light", size:21)
        descriptionText.textColor = UIColor.appTextColor()
        descriptionText.textAlignment = NSTextAlignment.Center
        descriptionText.text = text//NSLocalizedString("AboutText", comment: "AboutText")
        descriptionText.numberOfLines = 0
        descriptionText.sizeToFit()
        container.addSubview(descriptionText)
        
        ypos += descriptionText.frame.height
        
        
        var containerYPos:CGFloat = (frame.height - ypos) / 2
        container.frame.origin.y = containerYPos
    }
}

