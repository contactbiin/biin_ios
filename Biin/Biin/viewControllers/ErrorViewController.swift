//  ErrorViewController.swift
//  biin
//  Created by Esteban Padilla on 7/14/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ErrorViewController: UIViewController, UIPopoverPresentationControllerDelegate, BNNetworkManagerDelegate {
    
    var internetErrorView:InternetErrorView?
    var versionErrorView:VersionErrorView?
    var serverErrorView:ServerErrorView?
    var bluetoothErrorView:BluetoothErrorView?
    var hardwareErrorView:HardwareErrorView?
    var locationErrorView:LocationErrorView?
    var notBiinieErrorView:NotBiinieErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BNAppSharedManager.instance.networkManager.delegateVC = self

        self.view.backgroundColor = UIColor.blackColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        
//        self.view.layer.cornerRadius = 5
//        self.view.layer.masksToBounds = true
    }
    
    func addInternet_ErrorView(){
        internetErrorView = InternetErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        internetErrorView!.errorViewController = self
        self.view.addSubview(internetErrorView!)
    }

    func addVersion_ErrorView(){
        versionErrorView = VersionErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        versionErrorView!.errorViewController = self
        self.view.addSubview(versionErrorView!)
    }

    
    func addServer_ErrorView(){
        serverErrorView = ServerErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        serverErrorView!.errorViewController = self
        self.view.addSubview(serverErrorView!)
    }
    
    func addBluetooth_ErrorView(){
        bluetoothErrorView = BluetoothErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        bluetoothErrorView!.errorViewController = self
        self.view.addSubview(bluetoothErrorView!)
    }
    
    func addHardware_ErrorView(){
        hardwareErrorView = HardwareErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        hardwareErrorView!.errorViewController = self
        self.view.addSubview(hardwareErrorView!)
    }
    
    func addLocation_ErrorView(){
        locationErrorView = LocationErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        locationErrorView!.errorViewController = self
        self.view.addSubview(locationErrorView!)
    }
    
    func addNotBiinie_ErrorView(){
        notBiinieErrorView = NotBiinieErrorView(frame: CGRectMake(0, 0, SharedUIManager.instance.screenWidth, SharedUIManager.instance.screenHeight), father: nil)
        notBiinieErrorView!.errorViewController = self
        self.view.addSubview(notBiinieErrorView!)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceivedAllInitialData() { }
    
    //UIPopoverPresentationControllerDelegate Methods
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Popover
    }
    
    func manager(manager: BNNetworkManager!, updateProgressView value: Float) {
        
    }
    
    func clean() {
        
        internetErrorView?.removeFromSuperview()
        internetErrorView = nil
        versionErrorView?.removeFromSuperview()
        versionErrorView = nil
        serverErrorView?.removeFromSuperview()
        serverErrorView = nil
        bluetoothErrorView?.removeFromSuperview()
        bluetoothErrorView = nil
        hardwareErrorView?.removeFromSuperview()
        hardwareErrorView = nil
        locationErrorView?.removeFromSuperview()
        locationErrorView = nil
        notBiinieErrorView?.removeFromSuperview()
        notBiinieErrorView = nil
    }
    
    func show() {
        
    }
}
