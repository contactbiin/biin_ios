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

    convenience init(frame: CGRect, price:String, isMini:Bool) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //var fontSize1:CGFloat = 18
        var fontSize2:CGFloat = 28
        //var ypos1:CGFloat = 6
        var ypos2:CGFloat = 5
        var x_ypos:CGFloat = 10
        var spacer:CGFloat = 30
        
        if isMini {
            //fontSize1 = 10
            fontSize2 = 16
            //ypos1 = 6
            ypos2 = 3
            x_ypos = 5
            spacer = 15
        }
        
        var size2 = getStringLength(price, fontName: "Lato-Black", fontSize: fontSize2)
        var width:CGFloat = size2 + spacer
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.height)
        
//        self.oldPrice = UILabel(frame: CGRectMake(0, ypos1, width, (fontSize1 + 2)))
//        self.oldPrice!.textColor = UIColor.appButtonColor()
//        self.oldPrice!.textAlignment = NSTextAlignment.Center
//        self.oldPrice!.font = UIFont(name: "Lato-Regular", size:fontSize1)
//        self.oldPrice!.text = "PRICE"
//        self.addSubview(self.oldPrice!)
        
        self.newPrice = UILabel(frame: CGRectMake(0, ypos2, width, (fontSize2 + 2)))
        self.newPrice!.textColor = UIColor.yellowColor()
        self.newPrice!.textAlignment = NSTextAlignment.Center
        self.newPrice!.font = UIFont(name: "Lato-Black", size:fontSize2)
        self.newPrice!.text = price
        self.addSubview(self.newPrice!)
    }
    
    convenience init(frame: CGRect, oldPrice:String, newPrice:String, percentage:String, isMini:Bool) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        var fontSize1:CGFloat = 20
        var fontSize2:CGFloat = 28
        var ypos1:CGFloat = 3
        var ypos2:CGFloat = 25
        var x_ypos:CGFloat = 4
        var spacer:CGFloat = 40
        var strokeWidth:CGFloat = 2
        
        if isMini {
            fontSize1 = 11
            fontSize2 = 16
            ypos1 = 3
            ypos2 = 15
            x_ypos = 0
            spacer = 20
            strokeWidth = 1
        }
        
        
        var size1 = getStringLength(oldPrice, fontName: "Lato-Regular", fontSize: (fontSize1 + 2))
        var size2 = getStringLength(newPrice, fontName: "Lato-Black", fontSize: (fontSize2 + 2))
        
        var width:CGFloat = 0
        if size2 > size1 {
            width = size2 + spacer
        } else {
            width = size1 + spacer
            
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.height)

        self.oldPrice = UILabel(frame: CGRectMake(0, ypos1, width, (fontSize1 + 2)))
        self.oldPrice!.textColor = UIColor.appButtonColor()
        self.oldPrice!.textAlignment = NSTextAlignment.Center
        self.oldPrice!.font = UIFont(name: "Lato-Regular", size:fontSize1)
        self.oldPrice!.text = oldPrice
        self.addSubview(self.oldPrice!)
        
        self.newPrice = UILabel(frame: CGRectMake(0, ypos2, width, (fontSize2 + 2)))
        self.newPrice!.textColor = UIColor.yellowColor()
        self.newPrice!.textAlignment = NSTextAlignment.Center
        self.newPrice!.font = UIFont(name: "Lato-Black", size:fontSize2)
        self.newPrice!.text = newPrice
        self.addSubview(self.newPrice!)

        var xpos:CGFloat = ( width - size1 ) / 2
        
        var xView = BNUIView_PriceX(frame: CGRectMake(0, 0, width, 30), color: UIColor.appButtonColor(), position: CGPoint(x:xpos, y: x_ypos), size: (size1 - 3), strokeWidth:strokeWidth)
        self.addSubview(xView)
        
        if isMini {
            icon = BNIcon_Pricing(color: UIColor.blackColor(), position: CGPoint(x: -9, y: -9), text:percentage)
        } else {
            icon = BNIcon_PricingBig(color: UIColor.blackColor(), position: CGPoint(x:-2, y:-2), text:percentage)
        }
        
    }
    
    convenience init(frame: CGRect, price:String, from:String, isMini:Bool) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        var fontSize1:CGFloat = 18
        var fontSize2:CGFloat = 28
        var ypos1:CGFloat = 3
        var ypos2:CGFloat = 25
        var x_ypos:CGFloat = 10
        var spacer:CGFloat = 40
        
        if isMini {
            fontSize1 = 10
            fontSize2 = 16
            ypos1 = 3
            ypos2 = 15
            x_ypos = 5
            spacer = 20
        }
        
        var size2 = getStringLength(price, fontName: "Lato-Black", fontSize: fontSize2)
        var width:CGFloat = size2 + spacer

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.height)
        
        self.oldPrice = UILabel(frame: CGRectMake(0, ypos1, width, (fontSize1 + 2)))
        self.oldPrice!.textColor = UIColor.appButtonColor()
        self.oldPrice!.textAlignment = NSTextAlignment.Center
        self.oldPrice!.font = UIFont(name: "Lato-Regular", size:fontSize1)
        self.oldPrice!.text = from
        self.addSubview(self.oldPrice!)
        
        self.newPrice = UILabel(frame: CGRectMake(0, ypos2, width, (fontSize2 + 2)))
        self.newPrice!.textColor = UIColor.yellowColor()
        self.newPrice!.textAlignment = NSTextAlignment.Center
        self.newPrice!.font = UIFont(name: "Lato-Black", size:fontSize2)
        self.newPrice!.text = price
        self.addSubview(self.newPrice!)
    }
    
    func getStringLength(text:String, fontName:String, fontSize:CGFloat) -> CGFloat {
        var label = UILabel(frame: CGRectMake(0, 0, 0, 0))
        label.font = UIFont(name: fontName, size:fontSize)
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
    override func drawRect(rect:CGRect){
        icon?.drawCanvas()
    }
}