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
    var vibrantClr:UIColor?
    var darkVibrantClr:UIColor?
    var lightVibrantClr:UIColor?
    
    override init(){
        super.init()
    }
    
    convenience init(mediaType:BNMediaType, url:String, domainColor:UIColor){
        self.init()
        self.url = url
        self.mediaType = mediaType
        self.domainColor = domainColor
    }
    
    convenience init(mediaType:BNMediaType, url:String, domainColor:UIColor, vibrantClr:UIColor, darkVibrantClr:UIColor, lightVibrantClr:UIColor){
        self.init()
        self.url = url
        self.mediaType = mediaType
        self.domainColor = domainColor
        self.vibrantClr = vibrantClr
        self.darkVibrantClr = darkVibrantClr
        self.lightVibrantClr = lightVibrantClr
    }
    
    deinit {
        
    }
}

enum BNMediaType {
    case Image
    case Video
}