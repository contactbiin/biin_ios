//  BNUIPricesView.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

import Foundation
import UIKit

class BNUIPricesView:UIView {

    var newPrice:UILabel?
    var oldPrice:UILabel?
    var icon:BNIcon?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, listPrice:String ) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.appTextColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.oldPrice = UILabel(frame: CGRectMake(10, 5, self.frame.width, 12))
        self.oldPrice!.textColor = UIColor.whiteColor()
        self.oldPrice!.textAlignment = NSTextAlignment.Left
        self.oldPrice!.font = UIFont(name: "Lato-Regular", size:10)
        self.oldPrice!.text = listPrice
        self.oldPrice!.sizeToFit()
        self.addSubview(self.oldPrice!)
        
        var width:CGFloat = self.oldPrice!.frame.width + 15
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.height)
    }
    
    convenience init(frame: CGRect, oldPrice:String, newPrice:String) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.appTextColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true

        self.oldPrice = UILabel(frame: CGRectMake(10, 5, self.frame.width, 12))
        self.oldPrice!.textColor = UIColor.whiteColor()
        self.oldPrice!.textAlignment = NSTextAlignment.Left
        self.oldPrice!.font = UIFont(name: "Lato-Regular", size:10)
        self.oldPrice!.text = oldPrice
        self.oldPrice!.sizeToFit()
        self.addSubview(self.oldPrice!)
        
        self.newPrice = UILabel(frame: CGRectMake(10, 18, self.frame.width, 12))
        self.newPrice!.textColor = UIColor.whiteColor()
        self.newPrice!.textAlignment = NSTextAlignment.Left
        self.newPrice!.font = UIFont(name: "Lato-Regular", size:10)
        self.newPrice!.text = newPrice
        self.newPrice!.sizeToFit()
        self.addSubview(self.newPrice!)

        var width:CGFloat = 0
        if self.newPrice!.frame.width > self.oldPrice!.frame.width {
            width = self.newPrice!.frame.width + 15
        } else {
            width = self.oldPrice!.frame.width + 15

        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.height)
        
        icon = BNIcon_RedX(color: UIColor.bnRed(), position: CGPoint(x: 13, y: 8))
        icon!.width = self.oldPrice!.frame.width / 30
        //icon = BNIcon_PigSmall(color:UIColor.bnRed(), position: CGPointMake(9, 5))
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}