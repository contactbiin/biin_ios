//  UIManager.swift
//  Biin
//  Created by Esteban Padilla on 11/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

struct SharedUIManager
{
    static let instance = UIManager()
}

class UIManager {
    
    var deviceType = BNDeviceType.none
    
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    //Menu variables
    var menuWidth:CGFloat = 220
    
    //Categories (sections) variables
    var categoriesHeaderHeight:CGFloat = 60
    var spacer:CGFloat = 1.0
    
    //MiniView
    //Sites MiniView sizes
    var miniView_headerHeight:CGFloat = 55
    
    //Font sizes
    var miniView_titleSize:CGFloat = 0
    var miniView_subTittleSize:CGFloat = 0
    var miniView_height:CGFloat = 0
    var miniView_width:CGFloat = 0
    var miniView_columns:Int = 0
    
    
    //Sites View sizes
    var siteView_headerHeight:CGFloat = 65
    var siteView_bottomHeight:CGFloat = 30
    var siteView_showcaseHeight:CGFloat = 335
    var siteView_showcaseScrollHeight:CGFloat = 255
    var siteView_titleSize:CGFloat = 0
    var siteView_subTittleSize:CGFloat = 0
    
    
    //Element view sizes
    var elementView_titleSize:CGFloat = 18
    var elementView_textSize:CGFloat = 16
    var elementView_quoteSize:CGFloat = 16
    
    //Showcase and Main view positions
    var titleTop        = CGRectMake(5, 20, 0, 0)
    var subTitleTop     = CGRectMake(5, 54, 0, 0)
    var titleBottom     = CGRectMake(7, 5, 130, 18)
    var subTitleBottom  = CGRectMake(7, 23, 120, 11)
    
    //Element positions
    var elementTitleBackground:CGRect = CGRectMake(0, 5, 320, 50)
    var elementPricing = CGRectMake(5, 260, 200, 35)
    var elementTiming = CGRectMake(12, 195, 50, 50)
    var elementQuantity = CGRectMake(5, 195, 50, 50)
    var elementTitle = CGRectMake(55, 24, 260, 25)
    var elementPositionLbl = CGRectMake(6, 3, 44, 44)
    var elementButtonView = CGRectMake(55, 7, 250, 15)
    
    var elementPointsView = CGRectMake(0, 302, 320, 20)
    var elementStickerView = CGRectMake(260, 255, 50, 50)
    
    var signupView_isAnimatingLogo:Bool = true
    var signupView_ypos_1:CGFloat = 0
    var signupView_ypos_2:CGFloat = 0
    
    var loginView_isAnimatingLogo:Bool = true
    var loginView_ypos_1:CGFloat = 0
    var loginView_ypos_2:CGFloat = 0
    var loginView_ypos_3:CGFloat = 0
    
    func setDeviceVariables(){
        
        switch screenWidth {
        case 320.0:
            if screenHeight == 480.0 {
                setIPhone4Variables()
            } else if screenHeight == 568.0 {
                setIPhone5Variables()
            }
            break
        case 375.0:
            setIPhone6Variables()
            break
        case 414:
            setIPhone6PlusVariables()
            break
        case 768:
            setIPadVariables()
            break
        default:
            break
        }
    }
    
    func setIPhone4Variables(){
        deviceType = BNDeviceType.iphone4s
        miniView_titleSize = 15
        miniView_subTittleSize = 10
        siteView_titleSize = 20
        siteView_subTittleSize = 12
        
        signupView_isAnimatingLogo = true
        signupView_ypos_1 = 125
        signupView_ypos_2 = 0
        
        loginView_isAnimatingLogo = false
        loginView_ypos_1 = 0
        loginView_ypos_2 = 130
        loginView_ypos_3 = 150
        
    }
    
    func setIPhone5Variables(){
        deviceType = BNDeviceType.iphone5
        miniView_titleSize = 15
        miniView_subTittleSize = 10
        siteView_titleSize = 20
        siteView_subTittleSize = 12
        
        signupView_isAnimatingLogo = true
        signupView_ypos_1 = 115
        signupView_ypos_2 = 125
        
        loginView_isAnimatingLogo = true
        loginView_ypos_1 = 25
        loginView_ypos_2 = 30
        loginView_ypos_3 = 55
    }
    
    func setIPhone6Variables() {
        deviceType = BNDeviceType.iphone6
        miniView_titleSize = 15
        miniView_subTittleSize = 10
        siteView_titleSize = 20
        siteView_subTittleSize = 12
        
        signupView_isAnimatingLogo = false
        signupView_ypos_1 = 70
        signupView_ypos_2 = 70
        
        loginView_isAnimatingLogo = true
        loginView_ypos_1 = 0
        loginView_ypos_2 = 0
        loginView_ypos_3 = 0
    }
    
    func setIPhone6PlusVariables() {
        deviceType = BNDeviceType.iphone6Plus
        miniView_titleSize = 15
        miniView_subTittleSize = 10
        siteView_titleSize = 20
        siteView_subTittleSize = 12
    
        signupView_isAnimatingLogo = false
        signupView_ypos_1 = 70
        signupView_ypos_2 = 40
        
        loginView_isAnimatingLogo = true
        loginView_ypos_1 = 0
        loginView_ypos_2 = 0
        loginView_ypos_3 = 0
        
    }
    
    func setIPadVariables() {
        deviceType = BNDeviceType.ipad
        miniView_titleSize = 15
        miniView_subTittleSize = 10
        siteView_titleSize = 20
        siteView_subTittleSize = 12
        
        signupView_isAnimatingLogo = false
        signupView_ypos_1 = 0
        signupView_ypos_2 = 0
        
        loginView_isAnimatingLogo = false
        loginView_ypos_1 = 0
        loginView_ypos_2 = 0
        loginView_ypos_3 = 0
    }
    
    
    func removeSpecielCharacter(text:String ) -> String {
        
        var formatted = ""
        
        for c in text {
            switch (c) {
            case "\"", "/", "*", " ", "&", "{", "}", "[", "]", "+", "=", "^", "'", ",", "#", "(", ")", ":", ";", "-", "?":
                continue
            default:
                formatted.append(c)
                break
            }
        }
        
        return formatted
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
//        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
//            return emailTest.evaluateWithObject(testStr)
//        }
        
        return true
    }
    
}

enum BNDeviceType {
    case none
    case iphone4s
    case iphone5
    case iphone6
    case iphone6Plus
    case ipad
}