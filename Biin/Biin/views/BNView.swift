//  BNView.swift
//  Biin
//  Created by Esteban Padilla on 7/25/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class BNView:UIView {
    
    weak var father:BNView?
    var fade:UIView?
    var state:BNState?
    var isAddedToScroll = false
    var isAllDownloaded = false
    weak var model:BNObject?
    
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
    
    func addFade() {
        fade = UIView(frame:CGRectMake(0, 0, frame.width, frame.height))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
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
    
    
    
    func clean() {
        if fade != nil {
            fade!.removeFromSuperview()
            fade = nil
        }
    }
    
    func getToWork() { }
    func getToRest() { }
    
    func showFade(){
        if fade != nil {
            self.bringSubviewToFront(self.fade!)
            UIView.animateWithDuration(0.2, animations: {()-> Void in
                self.fade!.alpha = 0.75
            })
        }
    }
    
    func hideFade(){
        self.bringSubviewToFront(self.fade!)
        UIView.animateWithDuration(0.5, animations: {()-> Void in
            self.fade!.alpha = 0
        })
    }
    
}
