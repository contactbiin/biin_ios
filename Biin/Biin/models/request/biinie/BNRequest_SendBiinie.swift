//  BNRequest_SendBiinie.swift
//  biin
//  Created by Alison Padilla on 9/3/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendBiinie:BNRequest {
    
    var isUpdate = false
    
    override init() {
        super.init()
    }
    
    deinit{
        
    }
    
    convenience init(requestString:String, errorManager:BNErrorManager?, networkManager:BNNetworkManager?, biinie:Biinie?) {
        
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.biinie  = biinie
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        if self.biinie!.identifier == "none" {
            isUpdate = false
            self.requestType = BNRequestType.SendBiinie
        } else {
            isUpdate = true
            self.requestType = BNRequestType.SendBiinie_Update
        }
        
        var model = Dictionary<String, Dictionary <String, AnyObject>>()
        var modelContent = Dictionary<String, AnyObject>()
        modelContent["firstName"] = self.biinie!.firstName!
        modelContent["lastName"] = self.biinie!.lastName!
        modelContent["email"] = self.biinie!.email!
        modelContent["password"] = self.biinie!.password!
        modelContent["gender"] = self.biinie!.gender!
        modelContent["facebook_id"] = self.biinie!.facebook_id!

        
        if self.biinie!.facebookAvatarUrl == "" {
            modelContent["facebookAvatarUrl"] = "none"
        } else {
            modelContent["facebookAvatarUrl"] = self.biinie!.facebookAvatarUrl!
        }
            
        if self.biinie!.isEmailVerified! {
            modelContent["isEmailVerified"] = "1"
        } else {
            modelContent["isEmailVerified"] = "0"
        }
        
        if self.biinie!.birthDate != nil {
            modelContent["birthDate"] = self.biinie!.birthDate!.bnDateFormatt()
        }
        
        if self.biinie!.friends.count > 0 {
            var friends = Array<String>()
            
            for biinie in self.biinie!.friends {
                friends.append(biinie.facebook_id!)
            }
            
            modelContent["facebookFriends"] = friends
        }
        
        model["model"] = modelContent
        
        var htttpBody:NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options:[])
        } catch _ as NSError {
            htttpBody = nil
        }
        
        self.networkManager!.epsNetwork!.post(self.identifier, url:self.requestString, htttpBody:htttpBody, callback: {
            
            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in
            
            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.Internet_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                
                if let registerData = data["data"] as? NSDictionary {
                    
                    let result = BNParser.findBool("result", dictionary: data)
                    let identifier = BNParser.findString("identifier", dictionary: registerData)

                    if result {
                        
                        if !self.isUpdate {
                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier: identifier)
                        }
                        
                        self.isCompleted = true
                        self.networkManager!.requestManager?.processCompletedRequest(self)
                        
                    } else {
                        self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                    }
                }
            }
        })
    }
}