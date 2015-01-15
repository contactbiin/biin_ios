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
//        println("BNErrorManager init")
    }
    
    func showAlert(error:NSError?) {
        if !self.isAlertOn {
            //TODO: change UIAlert to UIController.
            println("Error:" + error!.localizedDescription )
        
            var alertView = UIAlertView()
            alertView.addButtonWithTitle("Ok")
            alertView.title = "Error"
            alertView.message = error!.localizedDescription
            alertView.show()
            
            var bnError = BNError(code: "\(error!.code)", title: error!.description, errorDescription: error!.localizedDescription, proximityUUID: "none", region: "none", errorType:BNErrorType.none)
            delegateNM!.manager!(self, saveError: bnError)
            
            isAlertOn = true
        }
    }
    
    // before animation and hiding view
    func alertView(alertView: UIAlertView!, willDismissWithButtonIndex buttonIndex: Int) {
        isAlertOn = false
    }

}

@objc protocol BNErrorManagerDelegate:NSObjectProtocol {
    optional func manager(manager:BNErrorManager!, saveError error:BNError)
}
