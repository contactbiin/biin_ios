//  BNElementDetail.swift
//  Biin
//  Created by Esteban Padilla on 9/26/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation

class BNElementDetail:NSObject {


    var elementDetailType:BNElementDetailType?
    var text:String = ""
    var body:Array<String>?// = Array<String>()
    
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
}