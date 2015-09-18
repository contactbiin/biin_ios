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

    override init() {
        super.init()
    }
    
    convenience init(at:NSDate, did:BiinieActionType, to:String, actionCounter:Int) {
        self.init()
        self.key = "key\(actionCounter)"
        self.at = at
        self.did = did
        self.to = to
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.key = aDecoder.decodeObjectForKey("key") as? String
        self.at  = aDecoder.decodeObjectForKey("at") as? NSDate
        self.to  = aDecoder.decodeObjectForKey("to") as? String
        
        let value = aDecoder.decodeIntForKey("did")
        switch value {
        case 0:
            self.did = .NONE
        case 1:
            self.did = .ENTER_BIIN_REGION
        case 2:
            self.did = .EXIT_BIIN_REGION
        case 3:
            self.did = .ENTER_BIIN
        case 4:
            self.did = .EXIT_BIIN
        case 5:
            self.did = .VIEWED_ELEMENT
        case 6:
            self.did = .BIIN_NOTIFIED
        case 7:
            self.did = .NOTIFICATION_OPENED
        case 8:
            self.did = .ENTER_SITE_VIEW
        case 9:
            self.did = .LEAVE_SITE_VIEW
        case 10:
            self.did = .ENTER_ELEMENT_VIEW
        case 11:
            self.did = .LEAVE_ELEMENT_VIEW
        case 12:
            self.did = .BIINED_ELEMENT
        case 13:
            self.did = .BIINED_SITE
        case 14:
            self.did = .LIKE_SITE
        case 15:
            self.did = .UNLIKE_SITE
        case 16:
            self.did = .FOLLOW_SITE
        case 17:
            self.did = .UNFOLLOW_SITE
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
    case ENTER_BIIN //3
    case EXIT_BIIN //4
    case VIEWED_ELEMENT //5
    case BIIN_NOTIFIED // 6
    case NOTIFICATION_OPENED //7
    case ENTER_SITE_VIEW  //8
    case LEAVE_SITE_VIEW  //9
    case ENTER_ELEMENT_VIEW  //10
    case LEAVE_ELEMENT_VIEW  //11
    case BIINED_ELEMENT // 12
    case BIINED_SITE // 13
    case LIKE_SITE//14
    case UNLIKE_SITE//15
    case FOLLOW_SITE//16
    case UNFOLLOW_SITE//17
}
