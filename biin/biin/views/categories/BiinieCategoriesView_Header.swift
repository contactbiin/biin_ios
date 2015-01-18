//  BiinieCategoriesView_Header.swift
//  biin
//  Created by Esteban Padilla on 1/16/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BiinieCategoriesView_Header: BNView {
    
    var points = Array<PointView>()
    var previousPoint:Int = 0
    
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
        self.layer.shadowOpacity = 0.35
        
        addSectionPoint()
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
    func addSectionPoint(){
        
        var totalLength:CGFloat = CGFloat((BNAppSharedManager.instance.dataManager.bnUser!.categories.count - 1) * 20)
        var space:CGFloat = (320.0 - totalLength) / 2.0
        var xpos:CGFloat = space
        
        for var i:Int = 0; i < BNAppSharedManager.instance.dataManager.bnUser!.categories.count; i++ {
            
            var point = PointView(frame: CGRectMake((xpos), 45, 12, 12), sectionIdentifier: BNAppSharedManager.instance.dataManager.bnUser!.categories[i].identifier!)
            self.points.append(point)
            self.addSubview(point)
            xpos += 20
        }
    }
}

@objc protocol BiinieCategoriesView_Header_Delegate:NSObjectProtocol {
    optional func updateCategoryStatus(view:BiinieCategoriesView_Header,  position:CGFloat)
}
