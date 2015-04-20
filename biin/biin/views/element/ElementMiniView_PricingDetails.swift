//  ElementMiniView_PricingDetails.swift
//  biin
//  Created by Esteban Padilla on 4/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementMiniView_PricingDetails:BNView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father:BNView?, element:BNElement?) {
        self.init(frame:frame, father:father)
        
        var ypos:CGFloat = 0
        var spacer:CGFloat = 5
        
        if element!.hasTimming {
            var timeStickerView = BNUIDetailView_Time(position: CGPointMake(5, ypos), text:"Calculate time", textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(timeStickerView)
            ypos += 32
        }
        
        if element!.hasFromPrice {
            var fromPrice = BNUIDetailView_From(position: CGPointMake(5, ypos), text:"\(element!.currency!)\(element!.fromPrice!)", textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(fromPrice)
            ypos += 32
        }
        
        if element!.hasListPrice {
            var listPrice = BNUIDetailView_Discount(position: CGPoint(x: 5, y: ypos), title: "ORIGINAL PRICE", value: "\(element!.currency!)\(element!.listPrice!)", textColor: UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(listPrice)
            ypos += 32
        }
        
        if element!.hasDiscount {
            var discount = BNUIDetailView_Discount(position: CGPoint(x: 5, y: ypos), title: "DISCOUNT", value: "\(element!.discount!)%", textColor: UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(discount)
            ypos += 32
        }
        
        if element!.hasSaving {
            var savings = BNUIDetailView_Discount(position: CGPoint(x: 5, y: ypos), title: "SAVINGS", value:"\(element!.currency!)\(element!.savings!)", textColor: UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(savings)
            ypos += 32
        }
        
        if element!.hasPrice {
            var priceStickerView = BNUIDetailView_Price(position: CGPointMake(5, ypos), listPrice:"\(element!.currency!)\(element!.price!)", textColor: UIColor.appTextColor(), borderColor: UIColor.appButtonColor())
            self.addSubview(priceStickerView)
            ypos += 62
        }
        
        if element!.hasQuantity {
            var boxWidth = (SharedUIManager.instance.screenWidth - 14) / 3
            var quantityStickerView = BNUIDetailView_Quantity(position: CGPointMake(5, ypos), title:"QUANTITY", value:element!.quantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(quantityStickerView)
            
            var reservedStickerView = BNUIDetailView_Quantity(position: CGPointMake((boxWidth + 7), ypos), title:"RESERVED", value:element!.reservedQuantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(reservedStickerView)
            
            boxWidth += boxWidth
            var claimedStickerView = BNUIDetailView_Quantity(position: CGPointMake((boxWidth + 9), ypos), title:"CLAIMED", value:element!.claimedQuantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(claimedStickerView)
            ypos += 32
        }
        

        self.frame = CGRectMake(0, 0, frame.width, ypos)
    }
}