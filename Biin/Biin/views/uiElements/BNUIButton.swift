//  BNUIButton.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
class BNUIButton:UIButton {

    var color:UIColor?
    var icon:BNIcon?
    var iconType:BNIconType = BNIconType.none
    var isButtonSelected = false
    
    //override init() {
     //   super.init()
    //}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(self.showPressed(_:)), forControlEvents: UIControlEvents.TouchDown)
        
    }
    
//    convenience init(position:CGPoint, iconType:BNIconType) {
//        
//        self.init(frame:CGRectMake(position.x, position.y, 40, 40))
//        
//        self.iconType = iconType
//        createIcon()
//        
//        self.layer.cornerRadius  = 3
//        self.layer.masksToBounds = true
//    }
    
    override func drawRect(rect: CGRect) {
        icon?.drawCanvas()
    }
    
    func createIcon(){
        switch iconType {
        case .searchMedium:
            icon = BNIcon_SearchMedium(color: UIColor.appIconColor(), position: CGPointMake(9, 8))
            break
        default:
            break
        }
    }
    
    func showPressed(sender:BNUIButton){
        
    }
    
    func showSelected(){
        self.backgroundColor = UIColor.bnGrayLight()
    }
    
    func showEnable(){
        self.enabled = true
        self.backgroundColor = UIColor.darkGrayColor()
    }
    
    func showDisable(){
        self.enabled = false
        self.backgroundColor = UIColor.appBackground()
    }
}