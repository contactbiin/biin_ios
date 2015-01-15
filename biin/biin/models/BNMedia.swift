//  BNMedia.swift
//  Biin
//  Created by Esteban Padilla on 11/27/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNMedia:NSObject {

    var mediaType:BNMediaType?
    var url:String?
    var domainColor:UIColor?
   
    override init(){
        super.init()
    }
    
    convenience init(mediaType:BNMediaType, url:String, domainColor:UIColor){
        self.init()
        self.url = url
        self.mediaType = mediaType
        self.domainColor = domainColor
    }
    
    deinit {
        
    }
}

enum BNMediaType {
    case Image
    case Video
}