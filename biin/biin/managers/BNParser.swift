//  BNParser.swift
//  biin
//  Created by Alison Padilla on 9/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNParser {
    
    init(){
    
    }

    class func findBool(name:String, dictionary:NSDictionary) -> Bool {
        var value = self.findInt(name, dictionary: dictionary)
        
        if value == 1 {
            return true
        } else {
            return false
        }
    }
    
    class func findInt(name:String, dictionary:NSDictionary) ->Int? {
        return (dictionary[name] as? String)?.toInt()
    }
    
    class func findFloat(name:String, dictionary:NSDictionary) ->Float? {
        return NSString(string:(dictionary[name] as? String)!).floatValue
    }
    
    class func findString(name:String, dictionary:NSDictionary) ->String? {
        return dictionary[name] as? String
    }
}