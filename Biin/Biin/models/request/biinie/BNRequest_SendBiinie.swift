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
    
    convenience init(requestString:String, errorManager:BNErrorManager, networkManager:BNNetworkManager, user:Biinie) {
        
        self.init()
        self.requestString = requestString
        self.dataIdentifier = ""
        self.requestType = BNRequestType.SendBiinie
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.user  = user
    }
    
    override func run() {
        
        isRunning = true
        attemps += 1
        
        if self.user!.identifier == "none" {
            isUpdate = false
            self.requestType = BNRequestType.SendBiinie
        } else {
            isUpdate = true
            self.requestType = BNRequestType.SendBiinie_Update
        }
        
        var model = Dictionary<String, Dictionary <String, AnyObject>>()
        var modelContent = Dictionary<String, AnyObject>()
        modelContent["firstName"] = self.user!.firstName!
        modelContent["lastName"] = self.user!.lastName!
        modelContent["email"] = self.user!.email!
        modelContent["password"] = self.user!.password!
        modelContent["gender"] = self.user!.gender!
        modelContent["facebook_id"] = self.user!.facebook_id!

        
        if self.user!.facebookAvatarUrl == "" {
            modelContent["facebookAvatarUrl"] = "none"
        } else {
            modelContent["facebookAvatarUrl"] = self.user!.facebookAvatarUrl!
        }
            
        if self.user!.isEmailVerified! {
            modelContent["isEmailVerified"] = "1"
        } else {
            modelContent["isEmailVerified"] = "0"
        }
        
        if self.user!.birthDate != nil {
            modelContent["birthDate"] = self.user!.birthDate!.bnDateFormatt()
        }
        
        if self.user!.friends.count > 0 {
            var friends = Array<String>()
            
            for biinie in self.user!.friends {
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
                        
                        self.isCompleted = true
                        self.networkManager!.requestManager?.processCompletedRequest(self)
                        
                        if !self.isUpdate {
                            self.networkManager!.delegateDM!.manager!(self.networkManager!, didReceivedUserIdentifier: identifier)
                        }
                        
                    } else {
                        self.networkManager!.requestManager!.processFailedRequest(self, error: nil)
                    }
                }
            }
        })
    }
}