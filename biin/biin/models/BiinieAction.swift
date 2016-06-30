//
//  BiinieAction.swift
//  biin
//
//  Created by Esteban Padilla on 3/24/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation

class BiinieAction:NSObject, NSCoding {

    var key:String?
    var at:NSDate?
    var did:BiinieActionType?
    var to:String?
    var by:String?
    
    override init() {
        super.init()
    }
    
    convenience init(at:NSDate, did:BiinieActionType, to:String, by:String, actionCounter:Int) {
        self.init()
        self.key = "key\(actionCounter)"
        self.at = at
        self.did = did
        self.to = to
        self.by = by
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.key = aDecoder.decodeObjectForKey("key") as? String
        self.at  = aDecoder.decodeObjectForKey("at") as? NSDate
        self.to  = aDecoder.decodeObjectForKey("to") as? String
        
        if let by_store = aDecoder.decodeObjectForKey("by") as? String {
            self.by = by_store
        } else {
            self.by = ""
        }
        
        let value = aDecoder.decodeIntForKey("did")
        switch value {
        case 0:
            self.did = .NONE
        case 1:
            self.did = .ENTER_BIIN_REGION
        case 2:
            self.did = .EXIT_BIIN_REGION
        case 3:
            self.did = .BIIN_NOTIFIED
        case 4:
            self.did = .NOTIFICATION_OPENED
        case 5:
            self.did = .ENTER_ELEMENT_VIEW
        case 6:
            self.did = .EXIT_ELEMENT_VIEW
        case 7:
            self.did = .LIKE_ELEMENT
        case 8:
            self.did = .UNLIKE_ELEMENT
        case 9:
            self.did = .COLLECTED_ELEMENT
        case 10:
            self.did = .UNCOLLECTED_ELEMENT
        case 11:
            self.did = .SHARE_ELEMENT
        case 12:
            self.did = .ENTER_SITE_VIEW
        case 13:
            self.did = .EXIT_SITE_VIEW
        case 14:
            self.did = .LIKE_SITE
        case 15:
            self.did = .UNLIKE_SITE
        case 16:
            self.did = .FOLLOW_SITE
        case 17:
            self.did = .UNFOLLOW_SITE
        case 18:
            self.did = .SHARE_SITE
        case 19:
            self.did = .ENTER_BIIN
        case 20:
            self.did = .EXIT_BIIN
        case 21:
            self.did = .OPEN_APP
        case 22:
            self.did = .CLOSE_APP
        case 23:
            self.did = .BEACON_BATTERY
        default:
            break
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let key = self.key {
            aCoder.encodeObject(key, forKey: "key")
        }
        
        if let at = self.at {
            aCoder.encodeObject(at, forKey: "at")
        }
        
        if let did = self.did?.hashValue {
            aCoder.encodeInteger(did, forKey: "did")
        }
        
        if let to = self.to {
            aCoder.encodeObject(to, forKey: "to")
        }
        
        if let by = self.by {
            aCoder.encodeObject(by, forKey: "by")
        }
    }
    
    deinit {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: self.key!)
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(self.key!)
    }
    
    class func loadSaved(key:String) -> BiinieAction? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BiinieAction
        }
        
        return nil
    }
}

enum BiinieActionType {
    case NONE //0
    case ENTER_BIIN_REGION //1
    case EXIT_BIIN_REGION //2
    case BIIN_NOTIFIED // 3
    case NOTIFICATION_OPENED //4
    
    case ENTER_ELEMENT_VIEW  //5
    case EXIT_ELEMENT_VIEW  //6
    case LIKE_ELEMENT//7
    case UNLIKE_ELEMENT//8
    case COLLECTED_ELEMENT // 9
    case UNCOLLECTED_ELEMENT // 10
    case SHARE_ELEMENT//11
    
    case ENTER_SITE_VIEW  //12
    case EXIT_SITE_VIEW  //13
    case LIKE_SITE//14
    case UNLIKE_SITE//15
    case FOLLOW_SITE//16
    case UNFOLLOW_SITE//17
    case SHARE_SITE//18
    
    case ENTER_BIIN//19
    case EXIT_BIIN//20
    
    case OPEN_APP//21
    case CLOSE_APP//22
    
    case BEACON_BATTERY//23
}
