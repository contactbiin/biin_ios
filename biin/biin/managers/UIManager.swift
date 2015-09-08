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
    var categoriesHeaderHeight:CGFloat = 40
    var spacer:CGFloat = 1.0
    
    //MiniView
    //Sites MiniView sizes
    var miniView_headerHeight:CGFloat = 55
    var siteMiniView_headerHeight:CGFloat = 40
    
    //Font sizes
    var miniView_titleSize:CGFloat = 0
    var miniView_subTittleSize:CGFloat = 0
    var miniView_height:CGFloat = 0
    var miniView_width:CGFloat = 0
    var miniView_columns:Int = 0
    
    //Onboarding
    var onBoardingView_ypos_1:CGFloat = 0
    var onBoardingView_spacer:CGFloat = 0

    
    //Sites View sizes
    var siteView_headerHeight:CGFloat = 40
    var siteView_bottomHeight:CGFloat = 30
    var siteView_showcaseHeight:CGFloat = 335
    var siteView_showcaseScrollHeight:CGFloat = 255
    var siteView_titleSize:CGFloat = 0
    var siteView_subTittleSize:CGFloat = 0
    
    
    //Element view sizes
    var elementView_titleSize:CGFloat = 18
    var elementView_textSize:CGFloat = 14
    var elementView_quoteSize:CGFloat = 14
    var elementView_priceList:CGFloat = 14
    var elementView_headerHeight:CGFloat = 40
    
    //Showcase and Main view positions
    var titleTop        = CGRectMake(5, 20, 0, 0)
    var subTitleTop     = CGRectMake(5, 54, 0, 0)
    var titleBottom     = CGRectMake(7, 5, 130, 18)
    var subTitleBottom  = CGRectMake(7, 23, 120, 11)
    var showcaseView_headerHeight:CGFloat = 60
    
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
    
    //Signup
    var signupView_isAnimatingLogo:Bool = true
    var signupView_ypos_1:CGFloat = 0
    var signupView_ypos_2:CGFloat = 0
    var signupView_logoSize:CGFloat = 200
    var signupView_showLogo:Bool = true
    
    //Loading
    var loadingView_logoSize:CGFloat = 1
    
    var loginView_isAnimatingLogo:Bool = true
    var loginView_ypos_1:CGFloat = 0
//    var loginView_ypos_2:CGFloat = 0
//    var loginView_ypos_3:CGFloat = 0
    
    //Error views
    var errorView_title:CGFloat = 20
    var errorView_text:CGFloat = 22
    var errorView_button:CGFloat = 18
    
    
    //Onboarding
    var onboardingSlide_TitleSize:CGFloat = 23
    var onboardingSlide_DescriptionSize:CGFloat = 21
    
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
        miniView_titleSize = 14
        miniView_subTittleSize = 10
        siteView_titleSize = 14
        siteView_subTittleSize = 12
        
        signupView_showLogo = false
        signupView_isAnimatingLogo = true
        signupView_ypos_1 = 10
        signupView_ypos_2 = 0
        signupView_logoSize = 100
        
        loginView_isAnimatingLogo = true
        loginView_ypos_1 = 220
//        loginView_ypos_2 = 130
//        loginView_ypos_3 = 150
        
        onBoardingView_ypos_1 = 10
        onBoardingView_spacer = 10
        
        loadingView_logoSize = 5
        
        onboardingSlide_DescriptionSize = 16
    }
    
    func setIPhone5Variables(){
        deviceType = BNDeviceType.iphone5
        miniView_titleSize = 14
        miniView_subTittleSize = 10
        siteView_titleSize = 14
        siteView_subTittleSize = 12
        
        signupView_showLogo = true
        signupView_isAnimatingLogo = true
        signupView_ypos_1 = 125
        signupView_ypos_2 = 140
        signupView_logoSize = 200
        
        loginView_isAnimatingLogo = true
        loginView_ypos_1 = 160
//        loginView_ypos_2 = 240
//        loginView_ypos_3 = 75
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 5
    }
    
    func setIPhone6Variables() {
        deviceType = BNDeviceType.iphone6
        miniView_titleSize = 14
        miniView_subTittleSize = 10
        siteView_titleSize = 14
        siteView_subTittleSize = 12
        
        signupView_showLogo = true
        signupView_isAnimatingLogo = false
        signupView_ypos_1 = 70
        signupView_ypos_2 = 70
        signupView_logoSize = 200
        
        loginView_isAnimatingLogo = false
        loginView_ypos_1 = 0
//        loginView_ypos_2 = 0
//        loginView_ypos_3 = 0
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 5
    }
    
    func setIPhone6PlusVariables() {
        deviceType = BNDeviceType.iphone6Plus
        miniView_titleSize = 14
        miniView_subTittleSize = 10
        siteView_titleSize = 14
        siteView_subTittleSize = 12
    
        signupView_showLogo = true
        signupView_isAnimatingLogo = false
        signupView_ypos_1 = 70
        signupView_ypos_2 = 40
        signupView_logoSize = 200
        
        loginView_isAnimatingLogo = true
        loginView_ypos_1 = 0
//        loginView_ypos_2 = 0
//        loginView_ypos_3 = 0
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 6
        
    }
    
    func setIPadVariables() {
        deviceType = BNDeviceType.ipad
        miniView_titleSize = 14
        miniView_subTittleSize = 10
        siteView_titleSize = 14
        siteView_subTittleSize = 12
        
        signupView_showLogo = true
        signupView_isAnimatingLogo = false
        signupView_ypos_1 = 0
        signupView_ypos_2 = 0
        signupView_logoSize = 200
        
        loginView_isAnimatingLogo = false
        loginView_ypos_1 = 0
//        loginView_ypos_2 = 0
//        loginView_ypos_3 = 0
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 6
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