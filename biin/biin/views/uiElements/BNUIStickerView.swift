//  BNUIStickerView.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIStickerView:UIView {
    
    var color:UIColor?
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
    
    convenience init(frame: CGRect, type:BNStickerType, color:UIColor) {
        self.init(frame: frame)

        self.color = color
        setCircleStickerText(type)
        
        self.layer.backgroundColor = self.color!.CGColor
        self.layer.cornerRadius = (frame.width) / 2
        
        var borderView = UIView(frame: CGRectMake(2, 2, (frame.width - 4), (frame.height - 4)))
        borderView.layer.borderColor = UIColor.appMainColor().CGColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = (frame.width - 4) / 2
        self.addSubview(borderView)

    }
    
    override func drawRect(rect:CGRect){
        //icon?.drawCanvas()
    }
    
    func setLabelText(text:String){
        text1!.text = text
        text1!.sizeToFit()
        var posx = (text1!.frame.width / 2)
        text1!.frame.origin.x = 0
        text1!.frame.origin.x -= (posx - 6)
    }
    
    func setCircleStickerText(type:BNStickerType){
        switch type {
        case .CIRCLE_FREE:
            setStickerText1(CGRectMake(0, 16, self.frame.width, 15), text:"FREE", textSize:13)
            break
        case .CIRCLE_SALE:
            setStickerText1(CGRectMake(0, 16, self.frame.width, 15), text:"SALE", textSize:13)
            break
        case .CIRCLE_BEST_OFFER:
            setStickerText1(CGRectMake(0, 10, self.frame.width, 15), text:"BEST", textSize:12)
            setStickerText2(CGRectMake(0, 22, self.frame.width, 15), text:"OFFER", textSize:11)
            break
        case .CIRCLE_FREE_GIFT:
            setStickerText1(CGRectMake(0, 10, self.frame.width, 15), text:"FREE", textSize:12)
            setStickerText2(CGRectMake(0, 22, self.frame.width, 15), text:"GIFT", textSize:11)
            break
        default:
            break
        }
    }
    
    func setCornerStickerText(type:BNStickerType){
        
    }
    
    func setStickerText1(position:CGRect, text:String, textSize:CGFloat){
        text1 = UILabel(frame: position)
        text1!.textColor = UIColor.appMainColor()
        text1!.textAlignment = NSTextAlignment.Center
        text1!.font = UIFont(name: "Lato-Black", size:textSize)
        text1!.text = text
        self.addSubview(text1!)
    }
    
    func setStickerText2(position:CGRect, text:String, textSize:CGFloat){
        text2 = UILabel(frame: position)
        text2!.textColor = UIColor.appMainColor()
        text2!.textAlignment = NSTextAlignment.Center
        text2!.font = UIFont(name: "Lato-Regular", size: textSize)
        text2!.text = text
        self.addSubview(text2!)
    }
}

