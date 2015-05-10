//  BNUIButton_Loging.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
class BNUIButton_Loging:BNUIButton {
    
    var position:CGPoint?
    var size:CGSize?
    var radius:CGFloat?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect, color:UIColor, text:String){
        self.init(frame:frame)
        
        self.backgroundColor = color
        
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        self.layer.masksToBounds = true

        self.color = color
        self.position = CGPoint(x:3, y:3 )
        self.size = CGSize(width: (frame.width - 5), height: (frame.height - 5))
        
        var label = UILabel(frame: CGRectMake(0, ((frame.height - 20) / 2), frame.width, 20))
        label.text = text
        label.textColor = UIColor.appMainColor()
        label.font = UIFont(name: "Lato-Light", size: 18)
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
    }
    
//    override func showDisable(){
//        if self.enabled {
//            color = UIColor.bnGray()
//            self.enabled = false
//            setNeedsDisplay()
//        }
//    }
//    
//    override func showEnable(){
//        if !self.enabled {
//            color = UIColor.bnGreen()
//            self.enabled = true
//            setNeedsDisplay()
//        }
//    }
//    

}
