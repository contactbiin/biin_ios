//  BNRequest_SendSharedGift.swift
//  Biin
//  Created by Esteban Padilla on 8/23/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequest_SendSharedGift: BNRequest {

    override init() {
        super.init()
    }

    deinit {

    }

    convenience init(requestString: String, errorManager: BNErrorManager?, networkManager: BNNetworkManager?, gift: BNGift?, friend: Biinie?) {
        self.init()
        self.requestString = requestString
        self.dataIdentifier = dataIdentifier
        self.requestType = BNRequestType.SendSharedGift
        self.errorManager = errorManager
        self.networkManager = networkManager
        self.gift = gift
        self.friend = friend
    }

    override func run() {

        isRunning = true
        attemps += 1

        var model = Dictionary<String, Dictionary<String, String>>()

        var modelContent = Dictionary<String, String>()
        modelContent["biinieReciever"] = self.friend!.facebook_id!
        modelContent["giftIdentifier"] = self.gift?.identifier!
        model["model"] = modelContent

        var htttpBody: NSData?
        do {
            htttpBody = try NSJSONSerialization.dataWithJSONObject(model, options: [])
        } catch _ as NSError {
            htttpBody = nil
        }

        self.networkManager!.epsNetwork!.post(self.identifier, url: self.requestString, htttpBody: htttpBody, callback: {

            (data: Dictionary<String, AnyObject>, error: NSError?) -> Void in

            if (error != nil) {
                if self.attemps == self.attempsLimit { self.requestError = BNRequestError.SendSharedGift_Failed }
                self.networkManager!.requestManager!.processFailedRequest(self, error: error)
            } else {
                self.isCompleted = true
                self.networkManager!.requestManager!.processCompletedRequest(self)
            }
        })
    }
}
