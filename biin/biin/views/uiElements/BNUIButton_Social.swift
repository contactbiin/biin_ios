//  BNUISocialButton.swift
//  Biin
//  Created by Esteban Padilla on 10/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Social:BNUIButton {
    

    var label:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, text:String, activate:Bool, iconType:BNIconType) {
        
        self.init(frame:frame)
        
        if activate {
            self.backgroundColor = UIColor.biinColor()
        } else {
            self.backgroundColor = UIColor.appButtonColor()
        }
        
        self.iconType = iconType
        createIcon()
        
        self.layer.cornerRadius  = 3
        self.layer.masksToBounds = true
        
        let iconWidth:CGFloat = 10
        let xSpace:CGFloat = 6
        let ypos:CGFloat = 1
        let xpos:CGFloat = xSpace + iconWidth
        
        label = UILabel(frame: CGRectMake(xpos, ypos, 200, 10))
        label!.text = text
        label!.textColor = UIColor.appMainColor()
        label!.font = UIFont(name: "Lato-Regular", size: 10)
        label!.sizeToFit()
        self.addSubview(label!)
        
        let width:CGFloat = label!.frame.width + xpos + xSpace
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, 15)
    }
    
    override func createIcon(){
        switch iconType {
        case .biinSmall:
            icon = BNIcon_HeartSmall(color: UIColor.appMainColor(), position: CGPointMake(3.1, 3.6))
//            icon = BNIcon_BiinSmall(color: UIColor.appMainColor(), position: CGPointMake(4, 3))
            break
//        case .biinSmall:
//            icon = BNIcon_CommentSmall(color: UIColor.appMainColor(), position: CGPointMake(3, 3))
//            break
        case .shareSmall:
            icon = BNIcon_ShareSmall(color: UIColor.appMainColor(), position: CGPointMake(6, 3.5))
            break
        default:
            break
        }
    }
    
    func setActive(){
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.backgroundColor = UIColor.biinColor()
        })
    }
    
    func setInactive(){
        UIView.animateWithDuration(0.2, animations: {()-> Void in
            self.backgroundColor = UIColor.appButtonColor()
        })
    }
    
    func updateText(text:String) {
        
        let iconWidth:CGFloat = 10
        let xSpace:CGFloat = 6
        let xpos:CGFloat = xSpace + iconWidth
        
        label!.text = text
        label!.sizeToFit()
        
        let width:CGFloat = label!.frame.width + xpos + xSpace
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, 15)
        
        setNeedsDisplay()
    }
}
