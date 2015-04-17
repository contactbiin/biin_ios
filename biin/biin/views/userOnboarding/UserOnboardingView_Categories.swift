//  UserOnboarding_Categories.swift
//  biin
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingView_Categories:UIView {

    var delegate:UserOnboardingView_Categories_Delegate?
    var title:UILabel?
    var startBtn:BNUIButton_Loging?
    var categoriesSelected = Dictionary<String, String>()
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.biinColor()
        
        var screenWidth = SharedUIManager.instance.screenWidth
        
        title = UILabel(frame:CGRectMake(0, 30, (screenWidth / 2), 45))
        title!.textColor = UIColor.appMainColor()
        title!.font = UIFont(name: "Lato-Regular", size: 20)
        title!.text = "What are you interested in?"
        title!.numberOfLines = 2
        title!.textAlignment  = NSTextAlignment.Center
        title!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        title!.sizeToFit()
        self.addSubview(title!)
        
        var xpos:CGFloat = (screenWidth - title!.frame.width) / 2
        title!.frame.origin.x = xpos
        
        var buttonCounter:Int = 1
        xpos = (screenWidth - 295) / 2
        var ypos:CGFloat = 110
        var space:CGFloat = 5
        
        var line = UIView(frame: CGRectMake(5, (ypos - 10), (screenWidth - 10), 0.5))
        line.backgroundColor = UIColor.appBackground()
        self.addSubview(line)
        
        for category in BNAppSharedManager.instance.dataManager.categories! {
            
            var button = BNUIButton_Category(frame: CGRectMake(xpos, ypos, 70, 70), categoryIdentifier:category.identifier!, iconType: BNIconType.burgerSmall, text:category.name!, selectedColor:UIColor.bnGrayDark(), unSelectedColor:UIColor.appMainColor())
            button.addTarget(self, action: "categoryBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
            buttonCounter++
            
            if buttonCounter <= 4 {
                xpos += 75
            } else {
                xpos = (screenWidth - 295) / 2
                ypos += 75
                buttonCounter = 1
            }
        }
        
        ypos += 40
        startBtn = BNUIButton_Loging(frame: CGRect(x:((screenWidth - 195) / 2), y: ypos, width: 195, height: 65), color:UIColor.bnGreen(), text:"Start!")
        startBtn!.addTarget(self, action: "startBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(startBtn!)
    }
    
    func categoryBtnAction(sender:BNUIButton_Category){
        sender.showSelected()

        if categoriesSelected[sender.categoryIdentifier!] == nil {
            categoriesSelected[sender.categoryIdentifier!] = sender.categoryIdentifier!
        } else {
            categoriesSelected[sender.categoryIdentifier!] = nil
        }
    }
    
    func startBtnAction(sender:BNUIButton_Loging){
        
        delegate!.showProgress!(self)
        
        BNAppSharedManager.instance.networkManager.sendBiinieCategories(BNAppSharedManager.instance.dataManager.bnUser!, categories: categoriesSelected)
    }
}

@objc protocol UserOnboardingView_Categories_Delegate:NSObjectProtocol {
    optional func startOnBiin(view:UIView)
    optional func showProgress(view:UIView)
    optional func showSelectCategories(view:UIView)
}