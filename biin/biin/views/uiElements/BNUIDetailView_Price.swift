//  BNUIDetailView_Time.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIDetailView_Price:UIView {
    
    var price:UILabel?
    var priceTitle:UILabel?
    
    var listPrice:UILabel?
    var listPriceTitle:UILabel?
    
    var discount:UILabel?
    var discountTitle:UILabel?
    
    var savings:UILabel?
    var savingsTitle:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position:CGPoint, listPrice:String?, textColor:UIColor, borderColor:UIColor) {

        let width = (SharedUIManager.instance.screenWidth - 10)
        let frame = CGRectMake(position.x, position.y, width, 60)
        self.init(frame:frame)
        
        self.backgroundColor = UIColor.bnGreen()
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 0.5
        
        self.priceTitle = UILabel(frame: CGRectMake(0, 5, width, 13))
        self.priceTitle!.text = NSLocalizedString("Price", comment: "Price")
        self.priceTitle!.textAlignment = NSTextAlignment.Center
        self.priceTitle!.font = UIFont(name: "Lato-Regular", size: 11)
        self.priceTitle!.textColor = textColor
        self.addSubview(self.priceTitle!)
        
        self.price = UILabel(frame: CGRectMake(0, 16, width, 35))
        self.price!.text = listPrice
        self.price!.textAlignment = NSTextAlignment.Center
        self.price!.font = UIFont(name: "Lato-Black", size: 35)
        self.price!.textColor = UIColor.whiteColor()
        self.addSubview(self.price!)
        
    }
    
    //TODO: Check if thei contructor is use otherwise remove
    convenience init(position:CGPoint, price:String?, listPrice:String?, discount:String?, savings:String?, textColor:UIColor, borderColor:UIColor) {
        
        let width = (SharedUIManager.instance.screenWidth - 10)
        
        let frame = CGRectMake(position.x, position.y, width, 100)
        self.init(frame:frame)
        self.backgroundColor = UIColor.appBackground()
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 0.5
        
        self.priceTitle = UILabel(frame: CGRectMake(0, 10, width, 13))
        self.priceTitle!.text = NSLocalizedString("Price", comment: "Price")
        self.priceTitle!.textAlignment = NSTextAlignment.Center
        self.priceTitle!.font = UIFont(name: "Lato-Regular", size: 11)
        self.priceTitle!.textColor = textColor
        self.addSubview(self.priceTitle!)
        
        
        self.price = UILabel(frame: CGRectMake(0, 20, width, 35))
        self.price!.text = price
        self.price!.textAlignment = NSTextAlignment.Center
        self.price!.font = UIFont(name: "Lato-Black", size: 35)
        self.price!.textColor = UIColor.bnGreen()
        self.addSubview(self.price!)
        
        let boxWidth:CGFloat = (width / 3)
        var xpos:CGFloat = 0
        let ypos1:CGFloat = 60
        let ypos2:CGFloat = 70
        
        self.listPriceTitle = UILabel(frame: CGRectMake(xpos, ypos1, boxWidth, 13))
        self.listPriceTitle!.text = NSLocalizedString("Value", comment: "Value")
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
        self.discountTitle!.text = NSLocalizedString("Discount", comment: "Discount")
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
        self.savingsTitle!.text = NSLocalizedString("YouSave", comment: "YouSave")
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
