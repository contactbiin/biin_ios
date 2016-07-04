//  BNErrorManager.swift
//  Biin
//  Created by Esteban Padilla on 6/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNErrorManager:NSObject, UIAlertViewDelegate
{
    var delegateNM:BNErrorManagerDelegate?
    var currentViewController:UIViewController?
    var isAlertOn:Bool = false
    
    override init(){
        super.init()
    }
    
    func showAlert(error:NSError?) {
        if !self.isAlertOn {
            
            let vc = ErrorViewController()
            vc.addInternet_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
            
            
            let bnError = BNError(code: "\(error!.code)", title: error!.description, errorDescription: error!.localizedDescription, proximityUUID: "none", region: "none", errorType:BNErrorType.none)
            delegateNM!.manager!(self, saveError: bnError)
            
            isAlertOn = true
        }
    }
    
    func showAlertOnStart(error:NSError?) {
        if !self.isAlertOn {

            let vc = ErrorViewController()
            vc.addInternet_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
        
            //var bnError = BNError(code: "\(error!.code)", title: error!.description, errorDescription: error!.localizedDescription, proximityUUID: "none", region: "none", errorType:BNErrorType.none)
            //delegateNM!.manager!(self, saveError: bnError)
            
            isAlertOn = true
        }
    }
    

    func showLocationServiceError(){
        if !self.isAlertOn {
            
            isAlertOn = true
            
            let vc = ErrorViewController()
            vc.addLocation_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
            
            
        }
    }
    
    
    
    
    func showInternetError(){

        if !self.isAlertOn {
            isAlertOn = true
//            let vc = ErrorViewController()
//            vc.addInternet_ErrorView()
//            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
//            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            let internetErrorView = InternetErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
            BNAppSharedManager.instance.errorManager.currentViewController!.view.addSubview(internetErrorView)
            
        }
    }
    
    func showVersionError(){
        
        if !self.isAlertOn {
            isAlertOn = true
            
            /*
            let vc = ErrorViewController()
            vc.addVersion_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
            */
            
            let versionErrorView = VersionErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
            BNAppSharedManager.instance.errorManager.currentViewController!.view.addSubview(versionErrorView)
            
        }
    }
    
    func showServerError(){
        
        if !self.isAlertOn {
            
            isAlertOn = true
            let vc = ErrorViewController()
            vc.addServer_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
        }
    }

    
    func showHardwareNotSupportedError(){
        
        if !self.isAlertOn {
            
            isAlertOn = true
            
            let vc = ErrorViewController()
            vc.addHardware_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
        }
    }
    
    
    func showBluetoothError(){
        
        if !self.isAlertOn {
            
            isAlertOn = true
            
            let vc = ErrorViewController()
            vc.addBluetooth_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
        }
    }
    
    
    
    func showNotBiinieError(){
        
        if !self.isAlertOn {
            
            isAlertOn = true
            
            let vc = ErrorViewController()
            vc.addNotBiinie_ErrorView()
            vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
            currentViewController!.presentViewController(vc, animated: true, completion: nil)
            BNAppSharedManager.instance.errorManager.currentViewController = vc
        }
    }

    
    // before animation and hiding view
//    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
//        isAlertOn = false
//    }

}

@objc protocol BNErrorManagerDelegate:NSObjectProtocol {
    optional func manager(manager:BNErrorManager!, saveError error:BNError)
}
