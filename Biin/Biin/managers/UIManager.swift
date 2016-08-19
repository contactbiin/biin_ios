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
    var categoriesHeaderHeight:CGFloat = 45
    var spacer:CGFloat = 1.0
    
    //MiniView
    //Sites MiniView sizes
    var miniView_headerHeight:CGFloat = 50

    //In showcase
    var miniView_headerHeight_showcase:CGFloat = 50
    var miniView_height_showcase:CGFloat = 0
    
    //Font sizes
    var miniView_titleSize:CGFloat = 13
    var miniView_subTittleSize:CGFloat = 11
    var miniView_nutshellSize:CGFloat = 11
    var miniView_pricingSize:CGFloat = 12
    var miniView_height:CGFloat = 0
    var miniView_width:CGFloat = 0
    var miniView_columns:Int = 0
    
    
    var siteMiniView_width:CGFloat = 0
    var siteMiniView_imageheight:CGFloat = 200
    var siteMiniView_headerHeight:CGFloat = 0
    var siteMiniView_title:CGFloat = 15
    var siteMiniView_subTitle:CGFloat = 13
    
    //Onboarding
    var onBoardingView_ypos_1:CGFloat = 0
    var onBoardingView_spacer:CGFloat = 0

    
    //Hightlighs Container.
    var highlightContainer_Height:CGFloat = 300
    var highlightView_headerHeight:CGFloat = 70
    var highlightView_titleSize:CGFloat = 18
    var highlightView_subTitleSize:CGFloat = 13
    var highlightView_priceSize:CGFloat = 13
    
    //Site Container
    var sitesContainer_headerHeight:CGFloat = 60
    var sitesContainer_Height:CGFloat = 0
    
    //Banner Container
    var bannerContainer_Height:CGFloat = 150
    
    //Elements Container 
    var elementContainer_Height:CGFloat = 0
    
    //Sites View sizes
    var inSiteView_Height:CGFloat = 80
    var inSiteView_titleSize:CGFloat = 25
    var inSiteView_subTittleSize:CGFloat = 15
    var inSiteView_nutshellSize:CGFloat = 15
    
    
    var siteView_headerHeight:CGFloat = 70
    var siteView_bottomHeight:CGFloat = 30
    var siteView_showcaseHeaderHeight:CGFloat = 60
    var siteView_showcase_titleSize:CGFloat = 12
    var siteView_showcase_subTittleSize:CGFloat = 12
    var siteView_titleSize:CGFloat = 18
    var siteView_subTittleSize:CGFloat = 14
    var siteView_nutshellSize:CGFloat = 14
    
    //Element view sizes
    var elementView_titleSize:CGFloat = 30
    var elementView_subTitleSize:CGFloat = 25
    var elementView_textSize:CGFloat = 14
    var elementView_quoteSize:CGFloat = 14
    var elementView_priceList:CGFloat = 14
    var elementView_headerHeight:CGFloat = 90
    var elementView_priceTitleSize:CGFloat = 30
    
    //Showcase and Main view positions
    var titleTop        = CGRectMake(5, 20, 0, 0)
    var subTitleTop     = CGRectMake(5, 54, 0, 0)
    var titleBottom     = CGRectMake(7, 5, 130, 18)
    var subTitleBottom  = CGRectMake(7, 23, 120, 11)
//    var showcaseView_headerHeight:CGFloat = 60
    
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
    var signupView_spacer:CGFloat = 0
    var signupView_logoSize:CGFloat = 50
    var signupView_ypos_1:CGFloat = 0
    
    
//    var signupView_isAnimatingLogo:Bool = true
//    var signupView_ypos_2:CGFloat = 0
//    var signupView_showLogo:Bool = true
    
    //Loading
    
    var loadingView_logoSize:CGFloat = 1
    var loginView_isAnimatingLogo:Bool = true
    var loginView_ypos_1:CGFloat = 0
//    var loginView_ypos_2:CGFloat = 0
//    var loginView_ypos_3:CGFloat = 0
    
    //Error views
    var errorView_headerHeoght:CGFloat = 40
    var errorView_title:CGFloat = 18
    var errorView_text:CGFloat = 22
    var errorView_button:CGFloat = 18
    
    
    //Onboarding
    var onboardingSlide_TitleSize:CGFloat = 20
    var onboardingSlide_DescriptionSize:CGFloat = 15
    var columns:Int = 2
    
    //Detail View
    var detailView_title:CGFloat = 20
    var detailView_text:CGFloat = 13
    var detailView_quoteSize:CGFloat = 15
    var detailView_priceList:CGFloat = 13
    
    var mainView_TitleSize:CGFloat = 18
    var mainView_HeaderSize:CGFloat = 80
    var mainView_StatusBarHeight:CGFloat = 20
    var mainView_OptionsBarHeight:CGFloat = 60
    
    var giftView_height:CGFloat = 210
    var giftView_imageSize:CGFloat = 140
    var giftView_bottomHeight:CGFloat = 55

    var notificationView_height:CGFloat = 90
    var notificationView_imageSize:CGFloat = 80
    var notificationView_TitleSize:CGFloat = 18
    var notificationView_TextSize:CGFloat = 13
    
    var loyaltyWalletView_height:CGFloat = 120
    var loyaltyWalletView_imageSize:CGFloat = 110
    var loyaltyWalletView_TitleSize:CGFloat = 20
    var loyaltyWalletView_SubTitleSize:CGFloat = 15
    var loyaltyWalletView_TextSize:CGFloat = 12
    
    var loyaltyCardView_SlotWidth:CGFloat = 70
    var loyaltyCardView_StarPosition:CGPoint = CGPoint(x: 16.5, y: 16.5)
    var loyaltyCardView_LastSpace:CGFloat = 25
    
    var alertView_Width:CGFloat = 280
    
    var loyaltyCardView_Completed_TitleSize:CGFloat = 50
    var loyaltyCardView_Completed_Text1Size:CGFloat = 22
    var loyaltyCardView_Completed_Text2Size:CGFloat = 16
    var loyaltyCardView_Completed_GiftPosition:CGPoint = CGPoint(x: 5, y: 5)
    
    var friendView_height:CGFloat = 80
    var friendView_imageSize:CGFloat = 70
    
    
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
        
        var viewWidth:CGFloat = 0
        var viewHeight:CGFloat = 0
        
        switch deviceType {
        case .iphone4s, .iphone5:
            viewWidth = (screenWidth + 30) / 2
            viewHeight = screenHeight / 3.5
            columns = 2
            break
        case .iphone6:
            viewWidth = (screenWidth + 20) / 2
            viewHeight = screenHeight / 3.5
            columns = 2
            break
        case .iphone6Plus:
            viewWidth = (screenWidth - 40) / 2.1
            viewHeight = screenHeight / 4.5
            columns = 3
            break
        case .ipad:
            viewWidth = (screenWidth - 40) / 3
            viewHeight = screenHeight / 3
            columns = 3
            break
        default:
            break
        }
        
        self.miniView_width = viewWidth
        self.miniView_height = viewHeight + miniView_headerHeight
        self.miniView_height_showcase = viewHeight + miniView_headerHeight_showcase

        siteMiniView_imageheight = (screenWidth / 2) - 1
        elementContainer_Height = miniView_height + sitesContainer_headerHeight + 1
    }
    
    func setIPhone4Variables(){
        deviceType = BNDeviceType.iphone4s
//        miniView_titleSize = 14
//        miniView_subTittleSize = 10
//        siteView_titleSize = 30
//        siteView_subTittleSize = 20
        signupView_spacer = 25
        signupView_logoSize = 0.75
        signupView_ypos_1 = 35
        loginView_ypos_1 = 35

//        signupView_showLogo = false
//        signupView_isAnimatingLogo = true
//        signupView_ypos_2 = 0
        
//        loginView_isAnimatingLogo = true
//        loginView_ypos_1 = 220
//        loginView_ypos_2 = 130
//        loginView_ypos_3 = 150
        
        onBoardingView_ypos_1 = 10
        onBoardingView_spacer = 10
        
        loadingView_logoSize = 5
        
        onboardingSlide_DescriptionSize = 16
        
        siteMiniView_headerHeight = 65
        
        loyaltyCardView_SlotWidth = 60
        loyaltyCardView_StarPosition = CGPoint(x: 11.5, y: 11.5)
        loyaltyCardView_LastSpace = 5
    }
    
    func setIPhone5Variables(){
        deviceType = BNDeviceType.iphone5
//        miniView_titleSize = 14
//        miniView_subTittleSize = 10
//        siteView_titleSize = 30
//        siteView_subTittleSize = 20
        
        signupView_spacer = 50
        signupView_logoSize = 0.75
        signupView_ypos_1 = 35
        loginView_ypos_1 = 35


        
        
//        signupView_showLogo = true
//        signupView_isAnimatingLogo = true
//        signupView_ypos_2 = 140
        
//        loginView_isAnimatingLogo = true
//        loginView_ypos_1 = 160
//        loginView_ypos_2 = 240
//        loginView_ypos_3 = 75
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 5
        
        siteMiniView_headerHeight = 65
        
        loyaltyCardView_SlotWidth = 60
        loyaltyCardView_StarPosition = CGPoint(x: 11.5, y: 11.5)
        loyaltyCardView_LastSpace = 5
    }
    
    func setIPhone6Variables() {
        deviceType = BNDeviceType.iphone6
//        miniView_titleSize = 14
//        miniView_subTittleSize = 10
//        siteView_titleSize = 30
//        siteView_subTittleSize = 20
        signupView_spacer = 75
        signupView_logoSize = 1.0
        signupView_ypos_1 = 75
        loginView_ypos_1 = 50

        
        
//        signupView_showLogo = true
//        signupView_isAnimatingLogo = false
//        signupView_ypos_2 = 70
        
//        loginView_isAnimatingLogo = false
//        loginView_ypos_1 = 0
//        loginView_ypos_2 = 0
//        loginView_ypos_3 = 0
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 5
        
        siteMiniView_headerHeight = 65
        loyaltyCardView_LastSpace = 5
    }
    
    func setIPhone6PlusVariables() {
        
        signupView_spacer = 100
        signupView_logoSize = 1.0
        signupView_ypos_1 = 130
        loginView_ypos_1 = 50
        
        deviceType = BNDeviceType.iphone6Plus
//        miniView_titleSize = 14
//        miniView_subTittleSize = 10
//        siteView_titleSize = 30
//        siteView_subTittleSize = 20
    
//        signupView_showLogo = true
//        signupView_isAnimatingLogo = false
//
//        signupView_ypos_2 = 40

        
//        loginView_isAnimatingLogo = true
//        loginView_ypos_1 = 0
//        loginView_ypos_2 = 0
//        loginView_ypos_3 = 0
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 6
        siteMiniView_headerHeight = 65
    }
    
    func setIPadVariables() {
        deviceType = BNDeviceType.ipad
//        miniView_titleSize = 14
//        miniView_subTittleSize = 10
//        siteView_titleSize = 30
//        siteView_subTittleSize = 20
        
        signupView_spacer = 100
        signupView_logoSize = 1.0
        signupView_ypos_1 = 200

        
//        signupView_showLogo = true
//        signupView_isAnimatingLogo = false
//        signupView_ypos_1 = 0
//        signupView_ypos_2 = 0
        
        loginView_isAnimatingLogo = false
        loginView_ypos_1 = 0
//        loginView_ypos_2 = 0
//        loginView_ypos_3 = 0
        
        onBoardingView_ypos_1 = 30
        onBoardingView_spacer = 40
        
        loadingView_logoSize = 6
        siteMiniView_headerHeight = 65
    }
    
    
    func removeSpecielCharacter(text:String ) -> String {
        
        var formatted = ""
        
        for c in text.characters {
            switch (c) {
            case "\"", "/", "*", "&", "{", "}", "[", "]", "+", "=", "^", "'", ",", "#", "(", ")", ":", ";", "-", "?":
                continue
            default:
                formatted.append(c)
                break
            }
        }
        
        return formatted
    }
    
    func fixEmptySpace(text:String) -> String {
        var formatted = ""
        
        for c in text.characters {
            
            switch (c) {
            case " ":
                formatted += "%"
                formatted += "2"
                formatted += "0"
                break
            default:
                formatted.append(c)
                break
            }
            

        }
        
        return formatted
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        //let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
//        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
//            return emailTest.evaluateWithObject(testStr)
//        }
        
        return true
    }
    
    func getStringLength(text:String, fontName:String, fontSize:CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRectMake(0, 0, 0, 0))
        label.font = UIFont(name: fontName, size:fontSize)
        label.text = text
        label.sizeToFit()
        return label.frame.width
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