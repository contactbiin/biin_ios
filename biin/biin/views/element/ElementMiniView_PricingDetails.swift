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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father:BNView?, element:BNElement?) {
        self.init(frame:frame, father:father)
        
        print("element identifier: \(element!.identifier!)")
        
        var ypos:CGFloat = 5
        //var spacer:CGFloat = 5
        
        if element!.hasTimming {
            let timeStickerView = BNUIDetailView_Time(position: CGPointMake(5, ypos), text:"Calculate time", textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(timeStickerView)
            ypos += 32
        }
        
        if element!.hasFromPrice {
            let fromPrice = BNUIDetailView_From(position: CGPointMake(5, ypos), text:"\(element!.currency!)\(element!.price!)", textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(fromPrice)
            ypos += 32
        }
        
        if element!.hasListPrice {
            let listPrice = BNUIDetailView_Discount(position: CGPoint(x: 5, y: ypos), title: NSLocalizedString("LimitedTime", comment: "LimitedTime"), value: "\(element!.currency!)\(element!.listPrice!)", textColor: UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(listPrice)
            ypos += 32
        }
        
        if element!.hasDiscount {
            let discount = BNUIDetailView_Discount(position: CGPoint(x: 5, y: ypos), title:NSLocalizedString("Discount", comment: "Discount"), value: "\(element!.discount!)%", textColor: UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(discount)
            ypos += 32
        }
        
        if element!.hasSaving {
            let savings = BNUIDetailView_Discount(position: CGPoint(x: 5, y: ypos), title:NSLocalizedString("Savings", comment: "Savings"), value:"\(element!.currency!)\(element!.savings!)", textColor: UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(savings)
            ypos += 32
        }
        
        if element!.hasPrice {
            let priceStickerView = BNUIDetailView_Price(position: CGPointMake(5, ypos), listPrice:"\(element!.currency!)\(element!.price!)", textColor: UIColor.appTextColor(), borderColor: UIColor.appButtonColor())
            self.addSubview(priceStickerView)
            ypos += 62
        }
        
        if element!.hasQuantity {
            var boxWidth = (SharedUIManager.instance.screenWidth - 14) / 3
            let quantityStickerView = BNUIDetailView_Quantity(position: CGPointMake(5, ypos), title:NSLocalizedString("Quantity", comment: "Quantity"), value:element!.quantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(quantityStickerView)
            
            let reservedStickerView = BNUIDetailView_Quantity(position: CGPointMake((boxWidth + 7), ypos), title:NSLocalizedString("Reserve", comment: "Reserve"), value:element!.reservedQuantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(reservedStickerView)
            
            boxWidth += boxWidth
            let claimedStickerView = BNUIDetailView_Quantity(position: CGPointMake((boxWidth + 9), ypos), title:NSLocalizedString("Claimed", comment: "Claimed"), value:element!.claimedQuantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(claimedStickerView)
            ypos += 32
        }
        

        self.frame = CGRectMake(0, 0, frame.width, ypos)
    }
}