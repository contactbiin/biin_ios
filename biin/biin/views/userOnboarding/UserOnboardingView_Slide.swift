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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    convenience init(frame: CGRect, title:String, text:String, imageString:String) {
        self.init(frame:frame)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        var ypos:CGFloat = 0
        var xpos:CGFloat = 0
        
        let container = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        self.addSubview(container)
        
        let titleText = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), (SharedUIManager.instance.onboardingSlide_TitleSize + 3)))
        titleText.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.onboardingSlide_TitleSize)
        titleText.textColor = UIColor.appTextColor()
        titleText.textAlignment = NSTextAlignment.Center
        titleText.text = title//NSLocalizedString("AboutText", comment: "AboutText")
        titleText.numberOfLines = 0
        titleText.sizeToFit()
        container.addSubview(titleText)
        xpos = ((screenWidth - titleText.frame.width) / 2)
        titleText.frame.origin.x = xpos
        
        ypos += ( titleText.frame.height + 20 )
        self.image = UIImageView(frame: CGRectMake(0, ypos, screenWidth, screenWidth))
        self.image!.image = UIImage(named:imageString)
        container.addSubview(image!)
        
        ypos += ( self.image!.frame.height + 10 )
        let descriptionText = UILabel(frame: CGRectMake(30, ypos, (screenWidth - 60), (SharedUIManager.instance.onboardingSlide_DescriptionSize + 3)))
        descriptionText.font = UIFont(name:"Lato-Light", size:SharedUIManager.instance.onboardingSlide_DescriptionSize)
        descriptionText.textColor = UIColor.appTextColor()
        descriptionText.textAlignment = NSTextAlignment.Center
        descriptionText.text = text//NSLocalizedString("AboutText", comment: "AboutText")
        descriptionText.numberOfLines = 0
        descriptionText.sizeToFit()
        container.addSubview(descriptionText)

        xpos = ((screenWidth - descriptionText.frame.width) / 2)
        descriptionText.frame.origin.x = xpos
        
        
        ypos += descriptionText.frame.height
        
        
        let containerYPos:CGFloat = (frame.height - ypos) / 2
        container.frame.origin.y = containerYPos
    }
}

