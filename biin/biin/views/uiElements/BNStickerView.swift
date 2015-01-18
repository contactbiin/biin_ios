//  BNStickerView.swift
//  Biin
//  Created by Esteban Padilla on 12/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNStickerView:UIView {
    
    var icon:CircleStickerIcon?
    var color:UIColor?
    var textColor:UIColor?
    var text1:UILabel?
    var text2:UILabel?
    var text1Pos:CGRect?
    var text2Pos:CGRect?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, type:BNStickerType, color:UIColor, textColor:UIColor) {
        self.init(frame: frame)
        self.color = color
        self.textColor = textColor
        setStickerBackground(type)
        
//        text1 = UILabel(frame: CGRectMake(0, 13, 100, 20))
//        var angle:CGFloat = CGFloat(M_PI / 4)
//        angle = angle * -1
//        text1!.transform = CGAffineTransformMakeRotation(angle)
//        text1!.textColor = UIColor.whiteColor()
//        text1!.textAlignment = NSTextAlignment.Center
//        text1!.font = UIFont(name: "Lato-Black", size: 13)
//        text1!.text = "HOLA"
//        self.addSubview(text1!)
        
    }
    
    convenience init(frame: CGRect, pointColor:UIColor) {
        self.init(frame:frame)
        self.color = pointColor
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
    
    func setLabelText(text:String){
        text1!.text = text
        text1!.sizeToFit()
        var posx = (text1!.frame.width / 2)
        text1!.frame.origin.x = 0
        text1!.frame.origin.x -= (posx - 6)
    }
    
    func setStickerBackground(type:BNStickerType){
        switch type {
            case .CIRCLE_FREE, .CIRCLE_SALE, .CIRCLE_BEST_OFFER, .CIRCLE_FREE_GIFT:
            icon = CircleStickerIcon(color:self.color!, scale: 1, position: CGPointMake(0, 0), stroke: 0, isFilled: false)
            icon!.colorLines = textColor!
            icon!.starColor = textColor!
            setCircleStickerText(type)
            break
        default:
            break
        }
    }

    /*
    func setFlagStickerText(type:BNStickerType) {
        switch type {
        case .FLAG_FREE:
            setStickerText1(CGRectMake(11, 7, 45, 15), text:"FREE")
            break
        case .FLAG_SALE:
            setStickerText1(CGRectMake(11, 7, 45, 15), text:"SALE")
            break
        case .FLAG_BEST_OFFER:
            setStickerText1(CGRectMake(11, 1, 45, 15), text:"BEST")
            setStickerText2(CGRectMake(11, 13, 45, 15), text:"OFFER")
            break
        case .FLAG_FREE_GIFT:
            setStickerText1(CGRectMake(11, 1, 45, 15), text:"FREE")
            setStickerText2(CGRectMake(11, 13, 45, 15), text:"GIFT")
            break
        default:
            break
        }
    }
    */


    func setCircleStickerText(type:BNStickerType){
        switch type {
        case .CIRCLE_FREE:
            setStickerText1(CGRectMake(0, 16, 47, 15), text:"FREE", textSize:13)
            break
        case .CIRCLE_SALE:
            setStickerText1(CGRectMake(0, 16, 47, 15), text:"SALE", textSize:13)
            break
        case .CIRCLE_BEST_OFFER:
            setStickerText1(CGRectMake(0, 10, 47, 15), text:"BEST", textSize:12)
            setStickerText2(CGRectMake(0, 22, 47, 15), text:"OFFER", textSize:11)
            break
        case .CIRCLE_FREE_GIFT:
            setStickerText1(CGRectMake(0, 10, 47, 15), text:"FREE", textSize:12)
            setStickerText2(CGRectMake(0, 22, 47, 15), text:"GIFT", textSize:11)
            break
        default:
            break
        }
    }
    
    func setCornerStickerText(type:BNStickerType){
        
    }
    
    func setStickerText1(position:CGRect, text:String, textSize:CGFloat){
        text1 = UILabel(frame: position)
        //var angle:CGFloat = CGFloat(M_PI / 4)
        //angle = angle * -1
        //text1!.transform = CGAffineTransformMakeRotation(angle)
        text1!.textColor = textColor
        text1!.textAlignment = NSTextAlignment.Center
        text1!.font = UIFont(name: "Lato-Black", size:textSize)
        text1!.text = text
        self.addSubview(text1!)
    }
    
    func setStickerText2(position:CGRect, text:String, textSize:CGFloat){
        text2 = UILabel(frame: position)
        //var angle:CGFloat = CGFloat(M_PI / 4)
        //angle = angle * -1
        //text1!.transform = CGAffineTransformMakeRotation(angle)
        text2!.textColor = textColor
        text2!.textAlignment = NSTextAlignment.Center
        text2!.font = UIFont(name: "Lato-Regular", size: textSize)
        text2!.text = text
        self.addSubview(text2!)
    }
}
