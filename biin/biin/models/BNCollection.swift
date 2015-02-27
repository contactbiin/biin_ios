//  BNBoard.swift
//  Biin
//  Created by Esteban Padilla on 1/5/15.
//  Copyright (c) 2015 Biin. All rights reserved.

import Foundation

class BNCollection:NSObject {
    
    var identifier:String?
    var subTitle:String?
    var title:String?
    var elements = Array<BNElement>()
    var sites = Array<BNSite>()
    
//    var isMine:Bool = true
//    var owner:BNUser?
//    var biinies:Array<BNUser>?
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
}