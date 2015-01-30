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
    
    var categoryNameLbl:UILabel?
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
        
        self.backgroundColor = UIColor.appMainColor()
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSizeMake(0, 3)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.25
        /*
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = frame
        addSubview(effectView)
        */
        
        categoryNameLbl = UILabel(frame: CGRectMake(0, 2, SharedUIManager.instance.screenWidth, 14))
        categoryNameLbl!.font = UIFont(name: "Lato-Regular", size: 12)
        categoryNameLbl!.textColor = UIColor.appTextColor()
        categoryNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(categoryNameLbl!)

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
        
        categoryNameLbl!.text = BNAppSharedManager.instance.dataManager.bnUser!.categories[0].name!

        
        for var i:Int = 0; i < BNAppSharedManager.instance.dataManager.bnUser!.categories.count; i++ {
            
            var point = BNUIPointView(frame: CGRectMake((xpos), 45, 14, 14), sectionIdentifier: BNAppSharedManager.instance.dataManager.bnUser!.categories[i].identifier!)
            self.points.append(point)
            self.addSubview(point)
            
            var icon = BiinieCategoriesView_Icon(frame: CGRectMake((xpos), 22, 25, 25), categoryType: BNAppSharedManager.instance.dataManager.bnUser!.categories[i].categoryType!)
            
            if i != 0 {
                icon.transform = CGAffineTransformMakeScale(0.7, 0.7)
                icon.alpha = 0.5
            } else {
                icon.frame.origin.x = point.frame.origin.x - 6
                icon.frame.origin.y = 18
            }
            
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
        
        categoryNameLbl!.alpha = 0
        
        points[previousPoint].setInactive()
        
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.icons[self.previousPoint].transform = CGAffineTransformMakeScale(0.7, 0.7)
            self.icons[self.previousPoint].alpha = 0.5
            
            if index < self.previousPoint {
                self.icons[self.previousPoint].frame.origin.x = (self.points[self.previousPoint].frame.origin.x + 3)
                self.icons[self.previousPoint].frame.origin.y = 26
            } else {
                self.icons[self.previousPoint].frame.origin.x = (self.points[self.previousPoint].frame.origin.x - 8)
                self.icons[self.previousPoint].frame.origin.y = 26
            }
        })
        
        points[index].setActive()
        UIView.animateWithDuration(0.25, animations: {()->Void in
            
            self.icons[index].transform = CGAffineTransformMakeScale(1, 1)
            self.icons[index].frame.origin.x = (self.points[index].frame.origin.x - 6)
            self.icons[index].frame.origin.y = 18
            self.icons[index].alpha = 1
        })
        
        categoryNameLbl!.text = BNAppSharedManager.instance.dataManager.bnUser!.categories[index].name!
        categoryNameLbl!.sizeToFit()
        self.categoryNameLbl!.frame.origin.x = self.points[index].frame.origin.x - (self.categoryNameLbl!.frame.width / 2) + 7
        
        UIView.animateWithDuration(0.3, animations: {()->Void in

            self.categoryNameLbl!.alpha = 1
        })
        
        previousPoint = index
        
        
    }

}

@objc protocol BiinieCategoriesView_Header_Delegate:NSObjectProtocol {
    optional func updateCategoryStatus(view:BiinieCategoriesView_Header,  position:CGFloat)
}
