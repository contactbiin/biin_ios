//  BNUser.swift
//  Biin
//  Created by Esteban Padilla on 9/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNUser:NSObject {
    
    var identifier:String?
    var biinName:String?
    var name:String?
    var lastName:String?
    var email:String?
    var friends:Array<BNUser>?
    var avatarUrl:String?
    var avatarImage:UIImageView? = UIImageView(image: UIImage(named:"view640X2.jpg"))
    var biins:Int?
    var following:Int?
    var followers:Int?
    var jsonUrl:String?
    
    var categories = Array<BNCategory>()
    var boards:Dictionary<String, BNBoard>?
    
    override init() {
        super.init()
    }
    
    convenience init(identifier:String, name:String, lastName:String, email:String) {
        self.init()
        self.identifier = identifier
        self.name = name
        self.lastName = lastName
        self.email = email
    }
    
    deinit {
        
    }
}
