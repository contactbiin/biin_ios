//  AnswersManager.swift
//  biin
//  Created by Esteban Padilla on 2/25/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
//import Answers

struct SharedAnswersManager
{
    static let instance = AnswersManager()
}

class AnswersManager {

    /*
    contentName The Human-readable name of content
    contentType The category your item falls under
    contentId A unique identifier used to track the item
    */
    func logContentView_Site(site:BNSite?){
//        Answers.logContentViewWithName("\(site!.title!) - \(site!.subTitle!)", contentType: "Site", contentId: site!.identifier!, customAttributes: nil)
    }
    
    func logContentView_Element(element:BNElement?){
//        Answers.logContentViewWithName(element!.title!, contentType: "Element", contentId: element!.identifier!, customAttributes: nil)
    }
    
    func logContentView_Category(category:BNCategory?){
//        Answers.logContentViewWithName(category!.name!, contentType: "Category", contentId: category!.identifier!, customAttributes: nil)
    }
    
    func logContentView_AllSites(){
//        Answers.logContentViewWithName("All Sites View", contentType:"All Sites View", contentId:BNAppSharedManager.instance.dataManager.bnUser!.identifier!, customAttributes: nil)
    }
    
    func logContentView_About(){
//        Answers.logContentViewWithName("About", contentType:"About", contentId:BNAppSharedManager.instance.dataManager.bnUser!.identifier!, customAttributes: nil)
    }
    
    func logContentView_Collected(){
//        Answers.logContentViewWithName("Collected", contentType:"Collected", contentId:BNAppSharedManager.instance.dataManager.bnUser!.identifier!, customAttributes: nil)
    }
    
    func logContentView_Profile(){
//        Answers.logContentViewWithName("Profile", contentType:"Profile", contentId:BNAppSharedManager.instance.dataManager.bnUser!.identifier!, customAttributes: nil)
    }
    
    func logContentView_Survey(site:BNSite?){
//        Answers.logContentViewWithName("\(site!.title!) - \(site!.subTitle!)", contentType:"Show Survey", contentId:BNAppSharedManager.instance.dataManager.bnUser!.identifier!, customAttributes: nil)
    }
    
    
    /*
    method The method used to share content
    contentName The description of the content
    contentType The type or genre of content
    contentId A unique key identifying the content
    */
    func logShare_Site(site:BNSite?) {
//        Answers.logShareWithMethod("Share Site", contentName:"\(site!.title!) - \(site!.subTitle!)", contentType: "Site", contentId: site!.identifier!, customAttributes: nil)
    }
    
    func logShare_Element(element:BNElement?) {
//        Answers.logShareWithMethod("Share Element", contentName:element!.title!, contentType: "Element", contentId:element!.identifier!, customAttributes: nil)
    }
    
    func logLike_Site(site:BNSite?){
//        Answers.logCustomEventWithName("Like Site", customAttributes: [ "Site": "\(site!.title!) - \(site!.subTitle!)", "identifier":site!.identifier!])
    }
    
    func logUnLike_Site(site:BNSite?){
//        Answers.logCustomEventWithName("UnLike Site", customAttributes: [ "Site": "\(site!.title!) - \(site!.subTitle!)", "identifier":site!.identifier!])
    }
    
    func logLike_Element(element:BNElement?){
//        Answers.logCustomEventWithName("Like Element", customAttributes: [ "Element": element!.title!, "identifier":element!.identifier!])
    }
    
    func logUnLike_Element(element:BNElement?){
//        Answers.logCustomEventWithName("UnLike Element", customAttributes: [ "Element": element!.title!, "identifier":element!.identifier!])
    }
    
    func logFollow_Site(site:BNSite?){
//        Answers.logCustomEventWithName("Follow Site", customAttributes: [ "Site": "\(site!.title!) - \(site!.subTitle!)", "identifier":site!.identifier!])
    }
    
    func logUnFollow_Site(site:BNSite?){
//        Answers.logCustomEventWithName("UnFollow Site", customAttributes: [ "Site": "\(site!.title!) - \(site!.subTitle!)", "identifier":site!.identifier!])
    }
    
    func logCollect_Element(element:BNElement?){
//        Answers.logCustomEventWithName("Collect Element", customAttributes: [ "Element": element!.title!, "identifier":element!.identifier!])
    }
    
    func logUnCollect_Element(element:BNElement?){
//        Answers.logCustomEventWithName("UnCollect Element", customAttributes: [ "Element": element!.title!, "identifier":element!.identifier!])
    }
    
    func logCompletedNPS(site:BNSite?){
//        Answers.logCustomEventWithName("Completed NPS", customAttributes: [ "Site": "\(site!.title!) - \(site!.subTitle!)", "identifier":site!.identifier!])
    }
    
    func logNotCompletedNPS(site:BNSite?){
//        Answers.logCustomEventWithName("Not Completed NPS", customAttributes: [ "Site": "\(site!.title!) - \(site!.subTitle!)", "identifier":site!.identifier!])
    }
    
    func logSignUp(signMethod:String){
//        Answers.logSignUpWithMethod(signMethod, success: true, customAttributes: nil)
    }
    
    func logLogIn(loginMethod:String){
//        Answers.logLoginWithMethod(loginMethod, success: true, customAttributes: nil)
    }
    
}