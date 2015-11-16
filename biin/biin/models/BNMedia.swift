//  BNMedia.swift
//  Biin
//  Created by Esteban Padilla on 11/27/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNMedia:NSObject {

    var mediaType:BNMediaType?
    var url:String?
    var vibrantColor:UIColor?
    var vibrantDarkColor:UIColor?
    var vibrantLightColor:UIColor?
    
    override init(){
        super.init()
    }
    
    convenience init(mediaType:BNMediaType, url:String){
        self.init()
        self.url = url
        self.mediaType = mediaType
    }
    
    convenience init(mediaType:BNMediaType, url:String,  vibrantColor:UIColor, vibrantDarkColor:UIColor, vibrantLightColor:UIColor){
        self.init()
        self.url = url
        self.mediaType = mediaType
        self.vibrantColor = vibrantColor
        self.vibrantDarkColor = vibrantDarkColor
        self.vibrantLightColor = vibrantLightColor
    }
    
    deinit {
        
    }
}

enum BNMediaType {
    case Image
    case Video
}