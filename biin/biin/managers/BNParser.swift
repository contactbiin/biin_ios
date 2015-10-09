//  BNParser.swift
//  biin
//  Created by Alison Padilla on 9/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNParser {
    
    init(){
    
    }

    class func findBool(name:String, dictionary:NSDictionary) -> Bool {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return true
        } else {
            return false
        }
    }
    
    class func findInt(name:String, dictionary:NSDictionary) ->Int? {
        let value =  Int(dictionary[name] as! String)
        return value
    }
    
    class func findFloat(name:String, dictionary:NSDictionary) ->Float? {
        return NSString(string:(dictionary[name] as? String)!).floatValue
    }
    
    class func findString(name:String, dictionary:NSDictionary) ->String? {
        return dictionary[name] as? String
    }
    
    class func findNSDictionary(name:String, dictionary:NSDictionary) ->NSDictionary? {
        return dictionary[name] as? NSDictionary
    }
    
    class func findNSArray(name:String, dictionary:NSDictionary) ->NSArray? {
        return dictionary[name] as? NSArray
    }
    
    class func findNSUUID(name:String, dictionary:NSDictionary) ->NSUUID? {
        var uuid:NSUUID?
        uuid = NSUUID(UUIDString:(dictionary[name] as? String)!)
        return uuid
    }
    
    class func findNSDate(name:String, dictionary:NSDictionary) ->NSDate? {
        let date:NSDate? = NSDate(dateString:(dictionary[name] as? String)!)
        return date
    }
    
    class func findBNBiinType(name:String, dictionary:NSDictionary) -> BNBiinType {
        let value:Int = self.findInt(name, dictionary: dictionary)!
        switch value {
        case 0:
            return BNBiinType.NONE
        case 1:
            return BNBiinType.EXTERNO
        case 2:
            return BNBiinType.INTERNO
        case 3:
            return BNBiinType.PRODUCT
        default:
            return BNBiinType.NONE
        }
    }
    
    class func findBNElementType(name:String, dictionary:NSDictionary) -> BNElementType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNElementType.Simple
        } else if value == 2 {
            return BNElementType.Informative
        } else if value == 3 {
            return BNElementType.Benefit
        } else {
            return BNElementType.Simple
        }
    }
    
    class func findBNElementDetailType(name:String, dictionary:NSDictionary) -> BNElementDetailType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNElementDetailType.Title
        } else if value == 2 {
            return BNElementDetailType.Paragraph
        } else if value == 3 {
            return BNElementDetailType.Quote
        } else if value == 4 {
            return BNElementDetailType.ListItem
        } else if value == 5 {
            return BNElementDetailType.Link
        } else if value == 6 {
            return BNElementDetailType.PriceList
        } else {
            return BNElementDetailType.Title
        }
    }
    
    class func findBNShowcaseTheme(name:String, dictionary:NSDictionary) -> BNShowcaseTheme {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNShowcaseTheme.Dark
        } else if value == 2 {
            return BNShowcaseTheme.Light
        } else {
            return BNShowcaseTheme.Light
        }
    }
    
    class func findBNShowcaseType(name:String, dictionary:NSDictionary) -> BNShowcaseType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNShowcaseType.SimpleProduct
        } else if value == 2 {
            return BNShowcaseType.MultipleProduct
        } else {
            return BNShowcaseType.SimpleProduct
        }
    }
    
    class func findBNStickerType(name:String, dictionary:NSDictionary) -> BNStickerType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNStickerType.CIRCLE_FREE
        } else if value == 2 {
            return BNStickerType.CIRCLE_SALE
        } else if value == 3 {
            return BNStickerType.CIRCLE_BEST_OFFER
        } else if value == 4 {
            return BNStickerType.CIRCLE_FREE_GIFT
        } else {
            return BNStickerType.NONE
        }
    }
    
    class func findNotificationType(name:String, dictionary:NSDictionary) -> BNNotificationType {
        let value = self.findInt(name, dictionary: dictionary)
        if value == 1 {
            return BNNotificationType.STIMULUS
        } else if value == 2 {
            return BNNotificationType.ENGAGE
        } else if value == 3{
            return BNNotificationType.CONVERT
        } else {
            return BNNotificationType.STIMULUS
        }
    }
    
    class func findMediaType(name:String, dictionary:NSDictionary) -> BNMediaType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNMediaType.Image
        } else if value == 2 {
            return BNMediaType.Video
        } else {
            return BNMediaType.Image
        }
    }
    
    class func findBiinObjectType(name:String, dictionary:NSDictionary) -> BNBiinObjectType {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return BNBiinObjectType.ELEMENT
        } else if value == 2 {
            return BNBiinObjectType.SHOWCASE
        } else {
            return BNBiinObjectType.NONE
        }
    }
    
    class func findUIColor(name:String, dictionary:NSDictionary) ->UIColor? {
        return self.colorFromString(dictionary[name] as? String)
    }
    
    class func findCurrency(name:String, dictionary:NSDictionary) -> String {
        let value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return "$"
        } else if value == 2 {
            return "￠"
        } else if value ==  3 {
            return "€"
        } else {
            return "$"
        }
    }
    
    class func colorFromString(color:String?)->UIColor? {
        
        if color == nil || color == "" {
            return UIColor.appTextColor()
        }
        
        var r = ""
        var g = ""
        var b = ""
    
        var counter = 0
        
        for c in (color!).characters {
            
            switch (c) {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if counter == 0 {
                    r.append(c)
                } else if counter == 1 {
                    g.append(c)
                } else if counter == 2 {
                    b.append(c)
                }
                continue
            case ",":
                counter++
                continue
            default:
                break
            }
        }
        
        return UIColor(red: (CGFloat(Int(r)!) / 255), green: (CGFloat(Int(g)!) / 255), blue:(CGFloat(Int(b)!) / 255), alpha: 1.0)
    }
}