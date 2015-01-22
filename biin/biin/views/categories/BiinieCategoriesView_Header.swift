//  BiinieCategoriesView_Header.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_Header: BNView, BiinieCategoriesView_Delegate {
    
    
    var points = Array<BNUIPointView>()
    var icons = Array<UIView>()
    var previousPoint:Int = 0
    
    var notificationBtn:BNUIButton?
    var notificationRedCircle:BNUINotificationView_RedCircle?
    var searchBtn:BNUIButton?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSizeMake(0, 3)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.25

        addButtons()
        addCategoriesPoints()
    }
    
    override func transitionIn() {
        println("trasition in on CategoriesView_Header")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on CategoriesView_Header")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: CategoriesView_Header")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: CategoriesView_Header")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    //Instance Methods
    func addButtons(){
        
        notificationRedCircle = BNUINotificationView_RedCircle(position: CGPoint(x: 22, y: 14))
        notificationBtn = BNUIButton(position: CGPoint(x:2, y: 10), text: "", iconType: BNIconType.notificationMedium, hasLabel: false)
        notificationBtn!.addTarget(self, action: "showNotification:", forControlEvents: UIControlEvents.TouchUpInside)
        
        searchBtn = BNUIButton(position: CGPoint(x: (SharedUIManager.instance.screenWidth - 45), y: 10), text: "", iconType: BNIconType.searchMedium, hasLabel: false)
        searchBtn!.addTarget(self, action: "showSearchView:", forControlEvents: UIControlEvents.TouchUpInside)

        self.addSubview(notificationBtn!)
        self.addSubview(notificationRedCircle!)
        self.addSubview(searchBtn!)
        
        notificationRedCircle!.setNotifitionNumber(23)
        
    }
    
    func addCategoriesPoints(){
        
        var totalLength:CGFloat = CGFloat((BNAppSharedManager.instance.dataManager.bnUser!.categories.count - 1) * 20)
        var space:CGFloat = (SharedUIManager.instance.screenWidth - totalLength) / 2.0
        var xpos:CGFloat = (space - 5)
        
        for var i:Int = 0; i < BNAppSharedManager.instance.dataManager.bnUser!.categories.count; i++ {
            
            var point = BNUIPointView(frame: CGRectMake((xpos), 45, 14, 14), sectionIdentifier: BNAppSharedManager.instance.dataManager.bnUser!.categories[i].identifier!)
            self.points.append(point)
            self.addSubview(point)
            
            var icon = UIView(frame: CGRectMake((xpos + 5), 22, 25, 25))
            icon.backgroundColor = UIColor.redColor()
            icon.layer.cornerRadius = 5
            self.icons.append(icon)
            self.addSubview(icon)
            
            xpos += 20
        }
        
        points[0].setActive()
    }
    
    func showNotification(quantity:Int){
        
        notificationRedCircle!.setNotifitionNumber(quantity)
        //TODO: animate button and circle here
    }
    
    func showSearchView(sender:BNUIButton){
        //TODO: show search view here
    }
    
    func showNotificationsView(sender:BNUIButton) {
        //TODO: show notifications view here
    }
    
    func updateCategoriesControl(view: BiinieCategoriesView, position: CGFloat) {
        //TODO: update categories control here.
        //println("position: \(position)")
        //aView!.frame.origin.x = position
    }
    
    func updateCategoriesPoints(view: BiinieCategoriesView, index: Int) {

//        for var i = 0; i < points.count; i++ {
//            if i == index {
//                points[i].setActive()
//                UIView.animateWithDuration(0.25, animations: {()->Void in
//                    self.icons[i].transform = CGAffineTransformMakeScale(0.5, 0.5)
//                })
//            } else {
//                points[i].setInactive()
//            }
//        }
        
        
        points[previousPoint].setInactive()
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.icons[self.previousPoint].transform = CGAffineTransformMakeScale(0.75, 0.75)
            
            if index < self.previousPoint {
                self.icons[self.previousPoint].frame.origin.x = (self.points[self.previousPoint].frame.origin.x + 4)
                self.icons[self.previousPoint].frame.origin.y = 25
            } else {
                self.icons[self.previousPoint].frame.origin.x = (self.points[self.previousPoint].frame.origin.x - 10)
                self.icons[self.previousPoint].frame.origin.y = 25
            }
        })
        
        points[index].setActive()
        UIView.animateWithDuration(0.25, animations: {()->Void in
            
            self.icons[index].transform = CGAffineTransformMakeScale(1, 1)
            self.icons[index].frame.origin.x = (self.points[index].frame.origin.x - 6)
            self.icons[index].frame.origin.y = 18
//            if self.previousPoint < index {

//            }else {
//                self.icons[index].frame.origin.x = (self.icons[index].frame.origin.x - 10 )
//            }
            
//            if index > (self.icons.count - 1) {
//                self.icons[self.previousPoint].frame.origin.x = (self.icons[self.previousPoint].frame.origin.x - 10 )
//            }
            
//            if index < (self.icons.count - 1) {
//                self.icons[(index + 1)].frame.origin.x = (self.icons[index + 1].frame.origin.x + 10 )
//            }
            
        })
        
        previousPoint = index
    }

}

@objc protocol BiinieCategoriesView_Header_Delegate:NSObjectProtocol {
    optional func updateCategoryStatus(view:BiinieCategoriesView_Header,  position:CGFloat)
}
