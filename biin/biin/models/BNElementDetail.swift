//  BNElementDetail.swift
//  Biin
//  Created by Esteban Padilla on 9/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

struct BNElementDetail_PriceLlist {
    var description:String?
    var currency:String?
    var price:String?
}


class BNElementDetail:NSObject {

    var elementDetailType:BNElementDetailType?
    var text:String = ""
    var body:Array<String>? //exemple: for description in price list
    var priceList:Array<BNElementDetail_PriceLlist>?
    
    override init(){
        super.init()
    }
    
    convenience init(text:String, elementDetailType:BNElementDetailType) {
        self.init()
        self.text = text
        self.elementDetailType = elementDetailType
    }
    
    deinit{
        
    }
    
}

enum BNElementDetailType {
    case Title      //1
    case Paragraph  //2
    case Quote      //3
    case ListItem   //4
    case Link       //5
    case PriceList  //6
}