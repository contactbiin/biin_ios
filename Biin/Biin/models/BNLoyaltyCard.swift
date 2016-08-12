//  BNLoyaltyCard.swift
//  Biin
//  Created by Esteban Padilla on 7/27/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation

class BNLoyaltyCard:BNObject {
    
    var title:String?
    var rule:String?
    var goal:String?
    var conditions:String?
    
    var elementIdentifier:String?
    
    var isCompleted:Bool = false
    var isBiinieEnrolled = false
    var isUnavailable:Bool = false
    var startDate:NSDate?
    var endDate:NSDate?
    var slots:Array<BNLoyaltyCard_Slot> = Array<BNLoyaltyCard_Slot>()
    
    //Only to user in app UI
    var isFull:Bool = false
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addStar(){
        
        for i in (0..<slots.count) {
            if !slots[i].isFilled! {
                slots[i].isFilled = true
                
                if i == (slots.count - 1) {
                    isFull = true
                    print("IS COMPLETED")
                }
                
                break
            }
        }
    }

}

struct BNLoyaltyCard_Slot {
    init(){ }
    var isFilled:Bool?
}
