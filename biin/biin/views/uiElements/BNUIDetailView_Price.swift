//  BNUIDetailView_Time.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIDetailView_Price:UIView {
    
    var titleLbl:UILabel?
    var timeLbl:UILabel?
    
    var price:UILabel?
    
    var listPrice:UILabel?
    var listPriceTitle:UILabel?
    
    var discount:UILabel?
    var discountTitle:UILabel?
    
    var savings:UILabel?
    var savingsTitle:UILabel?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position:CGPoint, listPrice:String?, textColor:UIColor, borderColor:UIColor) {

        var width = (SharedUIManager.instance.screenWidth - 10)
        var frame = CGRectMake(position.x, position.y, width, 55)
        self.init(frame:frame)
        
        self.backgroundColor = UIColor.appBackground()
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 0.5
        
        self.price = UILabel(frame: CGRectMake(0, 10, width, 35))
        self.price!.text = listPrice
        self.price!.textAlignment = NSTextAlignment.Center
        self.price!.font = UIFont(name: "Lato-Black", size: 35)
        self.price!.textColor = textColor
        self.addSubview(self.price!)
        
    }
    
    convenience init(position:CGPoint, price:String?, listPrice:String?, discount:String?, savings:String?, textColor:UIColor, borderColor:UIColor) {
        
        var width = (SharedUIManager.instance.screenWidth - 10)
        
        var frame = CGRectMake(position.x, position.y, width, 90)
        self.init(frame:frame)
        //        self.layer.backgroundColor = UIColor.bnGreen().CGColor
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 0.5
        
        self.price = UILabel(frame: CGRectMake(0, 10, width, 35))
        self.price!.text = price
        self.price!.textAlignment = NSTextAlignment.Center
        self.price!.font = UIFont(name: "Lato-Black", size: 35)
        self.price!.textColor = textColor
        self.addSubview(self.price!)
        
        var boxWidth:CGFloat = (width / 3)
        var xpos:CGFloat = 0
        var ypos1:CGFloat = 50
        var ypos2:CGFloat = 60
        
        self.listPriceTitle = UILabel(frame: CGRectMake(xpos, ypos1, boxWidth, 13))
        self.listPriceTitle!.text = "VALUE"
        self.listPriceTitle!.textAlignment = NSTextAlignment.Center
        self.listPriceTitle!.font = UIFont(name: "Lato-Regular", size: 11)
        self.listPriceTitle!.textColor = textColor
        self.addSubview(self.listPriceTitle!)
        
        self.listPrice = UILabel(frame: CGRectMake(xpos, ypos2, boxWidth, 20))
        self.listPrice!.text = listPrice
        self.listPrice!.textAlignment = NSTextAlignment.Center
        self.listPrice!.font = UIFont(name: "Lato-Black", size: 15)
        self.listPrice!.textColor = textColor
        self.addSubview(self.listPrice!)
        
        //var crossitView = BNCrossitView(frame: CGRectMake(20, 4, 40, 12), iconColor: UIColor.redColor(), iconScale: 1, iconStroke: 1)
        //self.listPrice!.addSubview(crossitView)
        
        xpos += boxWidth
        self.discountTitle = UILabel(frame: CGRectMake(xpos, ypos1, boxWidth, 13))
        self.discountTitle!.text = "DISCOUNT"
        self.discountTitle!.textAlignment = NSTextAlignment.Center
        self.discountTitle!.font = UIFont(name: "Lato-Regular", size: 11)
        self.discountTitle!.textColor = textColor
        self.addSubview(self.discountTitle!)
        
        self.discount = UILabel(frame: CGRectMake(xpos, ypos2, boxWidth, 20))
        self.discount!.text = discount
        self.discount!.textAlignment = NSTextAlignment.Center
        self.discount!.font = UIFont(name: "Lato-Black", size: 15)
        self.discount!.textColor = textColor
        self.addSubview(self.discount!)
        
        xpos += boxWidth
        self.savingsTitle = UILabel(frame: CGRectMake(xpos, ypos1, boxWidth, 13))
        self.savingsTitle!.text = "YOU SAVE"
        self.savingsTitle!.textAlignment = NSTextAlignment.Center
        self.savingsTitle!.font = UIFont(name: "Lato-Regular", size: 11)
        self.savingsTitle!.textColor = textColor
        self.addSubview(self.savingsTitle!)
        
        self.savings = UILabel(frame: CGRectMake(xpos, ypos2, boxWidth, 20))
        self.savings!.text = savings
        self.savings!.textAlignment = NSTextAlignment.Center
        self.savings!.font = UIFont(name: "Lato-Black", size: 15)
        self.savings!.textColor = textColor
        self.addSubview(self.savings!)
        
        
        
    }
}
