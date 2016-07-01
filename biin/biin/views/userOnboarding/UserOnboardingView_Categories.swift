//  UserOnboarding_Categories.swift
//  biin
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class UserOnboardingView_Categories:UIView {

    var delegate:UserOnboardingView_Categories_Delegate?

    var biinLogo:BNUIBiinView?
    var welcomeLbl:UILabel?
    var welcomeDescLbl:UILabel?
    
//    var title:UILabel?
//    var selectedLbl:UILabel?
    var startBtn:UIButton?
    var categoriesSelected = Dictionary<String, String>()
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        var ypos:CGFloat = 0
//        title = UILabel(frame:CGRectMake(0, ypos, (screenWidth / 2), 45))
//        title!.textColor = UIColor.appTextColor()
//        title!.font = UIFont(name: "Lato-Black", size: 20)
//        title!.text = NSLocalizedString("WhatAreYouInterest", comment:"WhatAreYouInterest")
//        title!.numberOfLines = 2
//        title!.textAlignment  = NSTextAlignment.Center
//        title!.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        title!.sizeToFit()
//        self.addSubview(title!)
//        
//        var xpos:CGFloat = (screenWidth - title!.frame.width) / 2
//        title!.frame.origin.x = xpos

        
        biinLogo = BNUIBiinView(position:CGPoint(x:0, y:ypos), scale:SharedUIManager.instance.signupView_logoSize)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
        biinLogo!.icon!.color = UIColor.blackColor()
        self.addSubview(biinLogo!)
        biinLogo!.setNeedsDisplay()
        
        ypos += (biinLogo!.frame.height + 20)
        welcomeLbl = UILabel(frame: CGRectMake(0, ypos, screenWidth, 23))
        welcomeLbl!.text = NSLocalizedString("Wellcome", comment: "Wellcome")
        welcomeLbl!.textAlignment = NSTextAlignment.Center
        welcomeLbl!.textColor = UIColor.darkGrayColor()
        welcomeLbl!.font = UIFont(name: "Lato-Light", size: 20)
        self.addSubview(welcomeLbl!)
        
        ypos += (welcomeLbl!.frame.height + 5)
        welcomeDescLbl = UILabel(frame: CGRectMake(20, ypos, (screenWidth - 40), 0))
        welcomeDescLbl!.text = NSLocalizedString("StartDesc", comment: "StartDesc")
        welcomeDescLbl!.textColor = UIColor.darkGrayColor()
        welcomeDescLbl!.font = UIFont(name: "Lato-Light", size: 14)
        welcomeDescLbl!.textAlignment = NSTextAlignment.Center
        welcomeDescLbl!.numberOfLines = 4
        welcomeDescLbl!.sizeToFit()
        self.addSubview(welcomeDescLbl!)
        
        ypos += (welcomeDescLbl!.frame.height + 30)
        startBtn = UIButton(frame: CGRectMake(5, ypos, (screenWidth - 10), 60))
        startBtn!.backgroundColor = UIColor.biinOrange()
        startBtn!.layer.cornerRadius = 2
        startBtn!.setTitle(NSLocalizedString("Start", comment: "Start"), forState: UIControlState.Normal)
        startBtn!.titleLabel!.font = UIFont(name: "Lato-Black", size: 15)
        startBtn!.addTarget(self, action: #selector(self.startBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(startBtn!)
        
        ypos = ((screenHeight - ypos) / 2)
        biinLogo!.frame.origin.y = ypos
        ypos += (biinLogo!.frame.height + 20)
        welcomeLbl!.frame.origin.y = ypos
        ypos += (welcomeLbl!.frame.height + 5)
        welcomeDescLbl!.frame.origin.y = ypos
        ypos += (welcomeDescLbl!.frame.height + 30)
        startBtn!.frame.origin.y = ypos
//        var buttonCounter:Int = 1
//        var xpos:CGFloat = (screenWidth - 295) / 2
        //ypos += textBg.frame.height + 10
        //var space:CGFloat = 5
        
        //var line = UIView(frame: CGRectMake(5, (ypos - 10), (screenWidth - 10), 0.5))
        //line.backgroundColor = UIColor.appBackground()
        //self.addSubview(line)
        
        for category in BNAppSharedManager.instance.dataManager.categories! {
            
//            let button = BNUIButton_Category(frame: CGRectMake(xpos, ypos, 70, 70), categoryIdentifier:category.identifier!, iconType: BNIconType.burgerSmall, text:category.name!, selectedColor:UIColor.biinColor(), unSelectedColor:UIColor.appBackground())
//            button.addTarget(self, action: "categoryBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
//            if  category.name! == "Shoes" ||
//                category.name! == "Food" ||
//                category.name! == "Fashion" ||
//                category.name! == "Technology" {
//                    
                categoriesSelected[category.identifier!] = category.identifier!
//                button.showSelected()
//            }
            
//            self.addSubview(button)
//            buttonCounter++
//            
//            if buttonCounter <= 4 {
//                xpos += 75
//            } else {
//                xpos = (screenWidth - 295) / 2
//                ypos += 75
//                buttonCounter = 1
//            }
        }
//
//        selectedLbl = UILabel(frame:CGRectMake(10, ypos, (screenWidth - 20), 12))
//        selectedLbl!.textColor = UIColor.appTextColor()
//        selectedLbl!.font = UIFont(name: "Lato-Light", size: 11)
//        selectedLbl!.textAlignment  = NSTextAlignment.Center
//        selectedLbl!.text = NSLocalizedString("CategoriesMsj", comment:"CategoriesMsj")
//        selectedLbl!.numberOfLines = 0
//        selectedLbl!.sizeToFit()
//        self.addSubview(selectedLbl!)
        
        
//        let descriptionText = UILabel(frame: CGRectMake(10, ypos, (screenWidth - 20), 14))
//        descriptionText.font = UIFont(name:"Lato-Light", size:11)
//        descriptionText.textColor = UIColor.appTextColor()
//        descriptionText.textAlignment = NSTextAlignment.Center
//        descriptionText.text = NSLocalizedString("CategoriesMsj", comment:"CategoriesMsj")
//        descriptionText.numberOfLines = 0
//        descriptionText.sizeToFit()
//        self.addSubview(descriptionText)
//        
//        let x_space:CGFloat = ( SharedUIManager.instance.screenWidth - descriptionText.frame.width ) / 2
//        descriptionText.frame.origin.x = x_space
        

    }
    
//    func categoryBtnAction(sender:BNUIButton_Category){
//        sender.showSelected()
//
//        if categoriesSelected[sender.categoryIdentifier!] == nil {
//            categoriesSelected[sender.categoryIdentifier!] = sender.categoryIdentifier!
//        } else {
//            categoriesSelected[sender.categoryIdentifier!] = nil
//        }
//    }
    
    func startBtnAction(sender:BNUIButton_Loging){
        delegate!.startOnBiin!(self)
        //delegate!.showProgress!(self)
        //BNAppSharedManager.instance.networkManager.sendBiinieCategories(BNAppSharedManager.instance.dataManager.bnUser!, categories: categoriesSelected)
    }
}

@objc protocol UserOnboardingView_Categories_Delegate:NSObjectProtocol {
    optional func startOnBiin(view:UIView)
    optional func showProgress(view:UIView)
    optional func showSelectCategories(view:UIView)
}