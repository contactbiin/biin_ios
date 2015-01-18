//  BNUIButton.swift
//  Biin
//  Created by Esteban Padilla on 8/2/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton:UIButton {

    var icon:BNIcon?
    var iconView:BNIconView?
    var iconType = BNUIIConType.None
    
    var label:UILabel?
    var iconAlignment:BNUIIconAlignment?
    var isIconFilled:Bool = false
    var color:UIColor = UIColor.whiteColor()
    var iconColor:UIColor = UIColor.bnWhite()
    var iconStroke:CGFloat = 1.0
    var iconScale:CGFloat = 1.0
    
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor, iconColor:UIColor, iconStroke:CGFloat, iconType:BNUIIConType, iconAlignment:BNUIIconAlignment, isIconFilled:Bool, fontSize:CGFloat, hasLabel:Bool) {

        self.init(frame: frame)
        
//        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        self.color = color
        self.iconColor = iconColor
        self.iconStroke = iconStroke
        self.iconAlignment = iconAlignment
        self.isIconFilled = isIconFilled
        self.iconType = iconType
        self.iconScale = 1//(frame.height * 0.9) / 60.0
        setButtonIcon(iconType)
        
        if hasLabel {
            var labelPosition = CGRectMake(18, 2, 22, 12)
            label =  UILabel(frame: labelPosition)
            label!.textColor = iconColor
            label!.textAlignment = NSTextAlignment.Center
            //TODO: Auto adjust text size.
            label!.font = UIFont(name: "Lato-Medium", size: 12)
            self.addSubview(label!)
        }
        
        
//        iconView = BNIconView(frame: CGRectMake(0, 0, frame.height, frame.height), icon:self.icon!)
//        iconView!.backgroundColor = UIColor.clearColor()
//        self.addSubview(iconView!)
        
//        self.layer.cornerRadius  = frame.width / 2
//        self.layer.borderWidth = 1
//        self.layer.borderColor = color.CGColor
    }
    
    override func drawRect(rect: CGRect) {
        
        if iconType != BNUIIConType.None {
            icon?.drawCanvas()
        }
//        iconView!.icon!.drawCanvas()
    }
    
    func setButtonIcon( iconType:BNUIIConType ){
        
        switch iconType {
        case .Search:
            icon = SearchIcon(color:iconColor, scale:iconScale, position: CGPointMake(5, 2), stroke:iconStroke, isFilled:isIconFilled)
        case .Pin:
            icon = PinIcon(color:iconColor, scale:iconScale, position: CGPointMake(5, 1), stroke:iconStroke, isFilled:isIconFilled)
//        case .Comment:
//            icon = MessageIcon(color:iconColor, scale:iconScale, position: CGPointMake(3, 3), stroke:iconStroke, isFilled:isIconFilled)
        case .CommentSmall:
            icon = CommentSmallIcon(color:iconColor, scale:iconScale, position: CGPointMake(4, 4), stroke:iconStroke, isFilled:isIconFilled)
//        case .CommentCircle:
//            icon = MessageIcon(color:iconColor, scale:iconScale, position: CGPointMake(12, 13), stroke:iconStroke, isFilled:isIconFilled)
//        case .CommentCircleSmall:
//            icon = MessageIcon(color:iconColor, scale:iconScale, position: CGPointMake(12, 13), stroke:iconStroke, isFilled:isIconFilled)
//        case .Like:
//            icon = LikeIcon(color:iconColor, scale:iconScale, position: CGPointMake(3, 3), stroke:iconStroke, isFilled:isIconFilled)
        case .LikeSmall:
            icon = LikeSmallIcon(color:iconColor, scale:iconScale, position: CGPointMake(4, 4), stroke:iconStroke, isFilled:isIconFilled)
        case .LikeCircle:
            icon = LikeIcon(color:iconColor, scale:iconScale, position: CGPointMake(11, 13), stroke:iconStroke, isFilled:isIconFilled)
        case .LikeCircleSmall:
            icon = LikeIcon(color:iconColor, scale:0.65, position: CGPointMake(5.5, 7), stroke:iconStroke, isFilled:isIconFilled)
        case .Close:
            icon = CloseIcon(color: iconColor, scale:iconScale, position: CGPointMake(4, 4), stroke: iconStroke, isFilled: isIconFilled)
        case .CloseCircle:
            icon = CloseIcon(color: iconColor, scale: iconScale, position: CGPointMake(8, 8), stroke: iconStroke, isFilled: isIconFilled)
        case .Cup:
            icon = CupIcon(color: iconColor, scale: iconScale, position: CGPointMake(6, 6), stroke: iconStroke, isFilled: isIconFilled)
        case .Bookmark:
            icon = BookmarkIcon(color: iconColor, scale: 0.7, position: CGPointMake(5, 4), stroke: 2, isFilled: isIconFilled)
        case .BookmarkCircle:
            icon = BookmarkIcon(color: iconColor, scale: iconScale, position: CGPointMake(13, 13), stroke: iconStroke, isFilled: isIconFilled)
        case .Home:
            icon = HomeIcon(color: iconColor, scale: iconScale, position: CGPointMake(13, 13), stroke: iconStroke, isFilled: isIconFilled)
        case .Map:
            icon = MapIcon(color: iconColor, scale: iconScale, position: CGPointMake(7, 6), stroke: iconStroke, isFilled: isIconFilled)
        case .ArrowDown:
            icon = ArrowDownIcon(color: iconColor, scale: iconScale, position: CGPointMake(7, 12), stroke: iconStroke, isFilled: isIconFilled)
        case .ArrowRight:
            icon = ArrowRightIcon(color: iconColor, scale: iconScale, position: CGPointMake(18, 12), stroke: iconStroke, isFilled: isIconFilled)
        case .ArrowLeft:
            icon = ArrowLeftIcon(color: iconColor, scale: iconScale, position: CGPointMake(15, 12), stroke: iconStroke, isFilled: isIconFilled)
        case .Star:
            icon = StarIcon(color: iconColor, scale: iconScale, position: CGPointMake(9, 9), stroke: iconStroke, isFilled: isIconFilled)
        case .Pig:
            icon = PigIcon(color: iconColor, scale: iconScale, position: CGPointMake(9, 9), stroke: iconStroke, isFilled: isIconFilled)
        case .Question:
            icon = QuestionIcon(color: iconColor, scale: iconScale, position: CGPointMake(15, 13), stroke: iconStroke, isFilled: isIconFilled)
        case .Basket:
            icon = BasketIcon(color: iconColor, scale: iconScale, position: CGPointMake(10, 9), stroke: iconStroke, isFilled: isIconFilled)
        case .GarbageCan:
            icon = GarbageCanIcon(color: iconColor, scale: iconScale, position: CGPointMake(11.5, 11), stroke: iconStroke, isFilled: isIconFilled)
//        case .Send:
//            icon = SendIcon(color: iconColor, scale: iconScale, position: CGPointMake(6, 12), stroke: iconStroke, isFilled: isIconFilled)
        case .SendSmall:
            icon = SendSmallIcon(color: iconColor, scale:iconScale, position: CGPointMake(4, 4), stroke: iconStroke, isFilled: isIconFilled)
        case .BiinBSmall:
            icon = BiinBIcon(color: iconColor, scale:iconScale, position: CGPointMake(6, 4), stroke:iconStroke, isFilled: isIconFilled)
        case .BiinBBig:
            icon = BiinBIcon(color: iconColor, scale:3.5, position: CGPointMake(26, 20), stroke:iconStroke, isFilled: isIconFilled)
        default:
            break
            
        }
    }
    
    func showFX(){
        var scale = self.icon!.scale
        
        UIView.animateWithDuration(0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15, options:UIViewAnimationOptions.CurveEaseIn, animations: {()-> Void in
//                self.iconView!.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: {(completed:Bool)-> Void in
//                self.iconView!.transform = CGAffineTransformMakeScale(1, 1)
        })
    }
}

enum BNUIIconAlignment {
    case None
    case Left
    case Right
    case Up
    case Down
    case Center
}

enum BNUIIConType {
    case None
    case ArrowDown
    case ArrowRight
    case ArrowLeft
    case Basket
    case Bookmark
    case BookmarkCircle
    case BiinBSmall
    case BiinBBig
    case Comment
    case CommentSmall
    case CommentCircle //remove
    case CommentCircleSmall //remove
    case Close
    case CloseCircle
    case Cup
    case GarbageCan
    case Home
    case Pin
    case Pig
    case Question
    case Like
    case LikeCircle //remove later
    case LikeCircleSmall //remove later
    case LikeSmall
    case Map
    case Search
    case Send
    case SendSmall
    case Star
}
