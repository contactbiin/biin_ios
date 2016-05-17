//  BNView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNView:UIView {
    
    weak var father:BNView?
    var state:BNState?
    var isAddedToScroll = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, father:BNView?) {
        super.init(frame: frame)
        self.father = father
    }
    
    //Transitioning functions
    func transitionIn() { }
    func transitionOut( state:BNState? ) { }
//    func transitionOutOnPrevious() { }
    func setNextState(goto:BNGoto){ }
    
    func adjustOnObjectContainerPan(y:CGFloat) { }
    func moveUpOnFirstTapped(){ }
    func showUserControl(value:Bool, son:BNView, point:CGPoint){ }
    func updateUserControl(position:CGPoint){ }
    func changeJoinBtnText(text:String){ }
    func refresh(){}
    func request(){}
    func requestCompleted() {}
    func updateWidth(frame:CGRect) {}
    
    //Social functions
    func awareBtnAction() { }
    func likeBtnAction() { }
    func commentBtnAction() { }
    func sendBtnAction() { }
    func removeBtnAction() { }
    
    func getToWork() { }
    func getToRest() { }
    
    
}
