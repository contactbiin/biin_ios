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
        var ypos:CGFloat = 20
        var titleText = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), (SharedUIManager.instance.siteView_titleSize + 3)))
        titleText.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        titleText.textColor = UIColor.appTextColor()
        titleText.textAlignment = NSTextAlignment.Center
        titleText.text = title//NSLocalizedString("AboutText", comment: "AboutText")
        titleText.numberOfLines = 0
        //titleText.sizeToFit()
        self.addSubview(titleText)
        
        ypos += ( titleText.frame.height + 20 )
        self.image = UIImageView(frame: CGRectMake(0, ypos, screenWidth, screenWidth))
        self.image!.image = UIImage(named:imageString)
        self.addSubview(image!)
        
        ypos += ( self.image!.frame.height + 20 )
        var descriptionText = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), (SharedUIManager.instance.siteView_subTittleSize + 3)))
        descriptionText.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.siteView_subTittleSize)
        descriptionText.textColor = UIColor.appTextColor()
        descriptionText.textAlignment = NSTextAlignment.Center
        descriptionText.text = text//NSLocalizedString("AboutText", comment: "AboutText")
        descriptionText.numberOfLines = 0
        descriptionText.sizeToFit()
        self.addSubview(descriptionText)
    }
}

