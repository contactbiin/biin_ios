//  BNUIButton_Category.swift
//  biin
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIButton_Category:BNUIButton {
    
    var categoryIdentifier:String?
    var categoryName:String?
    var label:UILabel?
    var selectedColor:UIColor?
    var unSelectedColor:UIColor?
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, categoryIdentifier:String?, iconType:BNIconType, text:String, selectedColor:UIColor, unSelectedColor:UIColor) {
        
        self.init(frame:frame)
        self.categoryIdentifier = categoryIdentifier
        self.categoryName = text
        self.iconType = iconType
        
        self.selectedColor = selectedColor
        self.unSelectedColor = unSelectedColor
        
        createIcon()
        
        self.layer.cornerRadius  = frame.width / 3
        self.layer.borderWidth = 3
        self.layer.borderColor = self.unSelectedColor!.CGColor
        self.layer.masksToBounds = true
        
        //var iconWidth:CGFloat = 10
        //var xSpace:CGFloat = 6
        let ypos:CGFloat = 38
        //var xpos:CGFloat = 0
        
        label = UILabel(frame: CGRectMake(5, ypos, (frame.width - 10), 24))
        label!.textColor = self.unSelectedColor!
        label!.font = UIFont(name: "Lato-Regular", size: 10)
        label!.textAlignment  = NSTextAlignment.Center
        label!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label!.numberOfLines = 2
        label!.text = NSLocalizedString(categoryIdentifier!, comment:categoryIdentifier!)
        self.addSubview(label!)
    }
    
    /*
    categories!.append(BNCategory(identifier: "Personal Care"))
    categories!.append(BNCategory(identifier: "Shoes"))
    categories!.append(BNCategory(identifier: "Games"))
    categories!.append(BNCategory(identifier: "Outdoors"))
    categories!.append(BNCategory(identifier: "Health"))
    categories!.append(BNCategory(identifier: "Food"))
    categories!.append(BNCategory(identifier: "Sports"))
    categories!.append(BNCategory(identifier: "Education"))
    categories!.append(BNCategory(identifier: "Fashion"))
    categories!.append(BNCategory(identifier: "Music"))
    categories!.append(BNCategory(identifier: "Movies"))
    categories!.append(BNCategory(identifier: "Technology"))
    categories!.append(BNCategory(identifier: "Cars"))
    categories!.append(BNCategory(identifier: "Entertaiment"))
    categories!.append(BNCategory(identifier: "Travel"))
    categories!.append(BNCategory(identifier: "Bars"))
    */
    override func createIcon(){
        switch categoryName! {
        case "Personal Care":
            icon = BNIcon_PersonalCareMedium(color: self.unSelectedColor!, position: CGPointMake(14, 12))
            break
        case "Shoes":
            icon = BNIcon_ShoeMedium(color: self.unSelectedColor!, position: CGPointMake(20, 14))
            break
        case "Games":
            icon = BNIcon_GamesMedium(color: self.unSelectedColor!, position: CGPointMake(18, 15))
            break
        case "Outdoors":
            icon = BNIcon_OutdoorsMedium(color: self.unSelectedColor!, position: CGPointMake(25, 14))
            break
        case "Health":
            icon = BNIcon_HealthMedium(color: self.unSelectedColor!, position: CGPointMake(23, 15))
            break
        case "Food":
            icon = BNIcon_FoodMedium(color: self.unSelectedColor!, position: CGPointMake(22, 15))
            break
        case "Sports":
            icon = BNIcon_SportMedium(color: self.unSelectedColor!, position: CGPointMake(24, 15))
            break
        case "Education":
            icon = BNIcon_EducationMedium(color: self.unSelectedColor!, position: CGPointMake(18, 15))
            break
        case "Fashion":
            icon = BNIcon_FashionMedium(color: self.unSelectedColor!, position: CGPointMake(17, 13))
            break
        case "Music":
            icon = BNIcon_MusicMedium(color: self.unSelectedColor!, position: CGPointMake(23, 13))
            break
        case "Movies":
            icon = BNIcon_MoviesMedium(color: self.unSelectedColor!, position: CGPointMake(22, 13))
            break
        case "Technology":
            icon = BNIcon_TechnologyMedium(color: self.unSelectedColor!, position: CGPointMake(27, 13))
            break
        case "Cars":
            icon = BNIcon_CarsMedium(color: self.unSelectedColor!, position: CGPointMake(18, 16))
            break
        case "Entertaiment":
            icon = BNIcon_EntertaimentMedium(color: self.unSelectedColor!, position: CGPointMake(23, 14))
            break
        case "Travel":
            icon = BNIcon_TravelMedium(color: self.unSelectedColor!, position: CGPointMake(25, 14))
            break
        case "Bars":
            icon = BNIcon_BarMedium(color: self.unSelectedColor!, position: CGPointMake(24, 14))
            break
        default:
            break
        }
    }
    
    override func showSelected() {
        
        if isButtonSelected {
            self.layer.borderColor = self.unSelectedColor!.CGColor
            self.label!.textColor = self.unSelectedColor!
            self.icon!.color = self.unSelectedColor!
            setNeedsDisplay()
        } else {
            self.layer.borderColor = self.selectedColor!.CGColor
            self.label!.textColor = self.selectedColor!
            self.icon!.color = self.selectedColor!
            setNeedsDisplay()
      
        }
        
        
        
        isButtonSelected = !isButtonSelected
    }
}


