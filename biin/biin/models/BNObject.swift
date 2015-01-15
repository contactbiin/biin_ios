//  BNObject.swift
//  Biin
//  Created by Esteban Padilla on 6/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNObject {
    
    var title1:String?
    var title2:String?
    var objectDescription:String?
    var imageUrl:String?
    var objectImage:UIImageView?
    
    init(title1:String, title2:String, objectDescription:String, imageName:String) {
        self.title1 = title1
        self.title2 = title2
        self.objectDescription = objectDescription
        self.imageUrl = imageName
//        self.objectImage = UIImageView(image: UIImage(named:imageName))
    }
    
    deinit {
        
    }
}
