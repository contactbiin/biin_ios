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
    var vibrantColor:UIColor?
    var vibrantDarkColor:UIColor?
    var vibrantLightColor:UIColor?
    
    override init(){
        super.init()
    }
    
    convenience init(mediaType:BNMediaType, url:String, domainColor:UIColor){
        self.init()
        self.url = url
        self.mediaType = mediaType
        self.domainColor = domainColor
    }
    
    convenience init(mediaType:BNMediaType, url:String, domainColor:UIColor, vibrantColor:UIColor, vibrantDarkColor:UIColor, vibrantLightColor:UIColor){
        self.init()
        self.url = url
        self.mediaType = mediaType
        self.domainColor = domainColor
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