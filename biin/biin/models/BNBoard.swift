//  BNBoard.swift
//  Biin
//  Created by Esteban Padilla on 1/5/15.
//  Copyright (c) 2015 Biin. All rights reserved.

import Foundation

class BNBoard:NSObject {
    
    var identifier:String?
    var boardDescription:String?
    var name:String?
    var elements:Array<BNElement>?// = Array<BNElement>()
    var isMine:Bool = true
    var owner:BNUser?
    var biinies:Array<BNUser>?
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    
}