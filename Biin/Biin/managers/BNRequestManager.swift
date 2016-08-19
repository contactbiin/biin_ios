//  BNRequestManager.swift
//  Biin
//  Created by Esteban Padilla on 7/2/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNRequestManager: NSObject {
    
    var errorManager:BNErrorManager?
    var networkManager:BNNetworkManager?
    
    var queue = Dictionary<Int, BNRequest>()
    
    init(networkManager:BNNetworkManager, errorManager:BNErrorManager) {
        super.init()
        self.networkManager = networkManager
        self.errorManager = errorManager
    }
    
    func resume(){
        run()
    }
    
    func processRequest(request:BNRequest) {
        addRequestToQueue(request)
        run()
    }
    
    func processCompletedRequest(request:BNRequest) {
        
        switch request.requestType {
        case .InitialData: self.networkManager!.initialData_Completed()
        case .VersionCheck: self.networkManager!.versionCheck_Completed()
        case .Biinie: self.networkManager!.biinie_Completed(request.biinie)
        case .SendBiinieActions: self.networkManager!.sendBiinieActions_Completed()
        case .SendBiinieToken: self.networkManager!.sendBiinieToken_Completed()
        case .Login: self.networkManager!.login_Completed()
        case .Login_Facebook: self.networkManager!.login_Facebook_Completed()
        case .Register, .Register_Facebook, .SendBiinie: self.networkManager!.register_Completed()
        case .SendBiinie_Update: self.networkManager!.sendBiinie_Update_Completed()
        case .SendClaimedGift: self.networkManager!.sendClaimedGift_Completed()
        case .SendRefusedGift: self.networkManager!.sendRefusedGift_Completed()
        case .SendBiinieOnEnterSite: self.networkManager!.sendBiinieOnEnterSite_Completed()
        case .SendBiinieOnExitSite: self.networkManager!.sendBiinieOnExitSite_Completed()
        default:
            break
        }
        
        request.clean()
        removeRequestFromQueue(request.identifier)
    }
    
    func processFailedRequest(request:BNRequest, error:NSError?){
        switch request.requestError {
        case .None:
            if request.attemps < request.attempsLimit {
                request.isRunning = false
                run()
            }
            break
        case .InitialData_Failed: self.networkManager!.initialData_Failed()
        case .VersionCheck_NeedsUpdate: self.networkManager!.versionCheck_Failed()
        case .Biinie_Failed: break
        case .Biinie_NotRegistered: self.networkManager!.biinie_NotRegistered()
        case .SendBiinieToken_Failed: self.networkManager!.sendBiinieToken_Failed()
        case .SendBiinie_Failed: self.networkManager!.sendBiinie_Failed()
        case .Login_Failed:
            self.networkManager!.login_Failed()
            request.clean()
            removeRequestFromQueue(request.identifier)
            break
        case .Login_Facebook_Failed:
            self.networkManager!.login_Facebook_Failed()
            request.clean()
            removeRequestFromQueue(request.identifier)
            break
        case .Register_Failed, .Register_Facebook_Failed:
            self.networkManager!.register_Failed()
            request.clean()
            removeRequestFromQueue(request.identifier)
            break
        case .Internet_Failed:
            request.reset()
            self.networkManager!.internet_Failed()
        break
        case .SendClaimedGift_Failed:
            break
        case .SendRefusedGift_Failed:
            request.clean()
            removeRequestFromQueue(request.identifier)
            break
        case .DoNotShowError:
            request.clean()
            removeRequestFromQueue(request.identifier)
            break
        case .SendBiinieOnExitSite_Failed, .SendBiinieOnEnterSite_Failed:
            request.clean()
            removeRequestFromQueue(request.identifier)
            break
        default:
            break
        }
    }
    
    private func stop(){
        if queue.count == 0 {
            
        }
    }
    
    private func run(){
        for (_, request) in queue {
            if !request.isRunning {
                request.run()
            }
        }
    }
    
    private func addRequestToQueue(request:BNRequest){
        queue[request.identifier] = request
        self.run()
    }
    
    private func removeRequestFromQueue(identifier:Int) {
        queue.removeValueForKey(identifier)
        self.stop()
    }
    
    func isQueued(url:String) -> Bool {
        for (_, request) in queue {
            if request.requestString == url {
                return true
            }
        }
        return false
    }
}