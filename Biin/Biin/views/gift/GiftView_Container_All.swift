//  GiftView_Container_All.swift
//  Biin
//  Created by Esteban Padilla on 7/2/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreLocation


class GiftView_Container_All: BNView {
    
    var elementContainers:Array <MainView_Container_Elements>?
    var scroll:BNScroll?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        //NSLog("MainViewContainer init()")
        
        self.backgroundColor = UIColor.appBackground()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        self.scroll = BNScroll(frame: CGRectMake(0, 0, screenWidth, (screenHeight - 20)), father: self, direction: BNScroll_Direction.VERTICAL, space: 0, extraSpace: 45, color: UIColor.darkGrayColor(), delegate: nil)
        self.addSubview(scroll!)

        
        elementContainers = Array<MainView_Container_Elements>()
        //updateContainer()
        
    }
    
    func refreshButtonAction(sender:UIButton) {
        
        //NSLog("BIIN - refreshButtonAction")
        
        let vc = LoadingViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        BNAppSharedManager.instance.mainViewController!.presentViewController(vc, animated: true, completion: nil)
        
        if SimulatorUtility.isRunningSimulator {
            BNAppSharedManager.instance.positionManager.userCoordinates = CLLocationCoordinate2DMake(9.923165731693336, -84.03725208107909)
        }
        
        BNAppSharedManager.instance.dataManager.clean()
        BNAppSharedManager.instance.dataManager.requestInitialData()
    }
    
    func updateContainer(){
        /*
        if BNAppSharedManager.instance.dataManager.sites_ordered.count == 0 {
            //NSLog("BIIN ----------------------------------------------------")
            //NSLog("BIIN - not sites in list, request data again")
            //NSLog("BIIN - sites:\(BNAppSharedManager.instance.dataManager.sites.count)")
            //NSLog("BIIN - elements_by_identifier:\(BNAppSharedManager.instance.dataManager.elements_by_identifier.count)")
            //NSLog("BIIN ----------------------------------------------------")
            self.refreshButtonAction(UIButton())
            
            
        } else {
            
            let screenWidth = SharedUIManager.instance.screenWidth
            //let screenHeight = SharedUIManager.instance.screenHeight
            var ypos:CGFloat = 0
            let spacer:CGFloat = 0
            var height:CGFloat = 0
            
            SharedUIManager.instance.highlightContainer_Height = SharedUIManager.instance.screenWidth + SharedUIManager.instance.sitesContainer_headerHeight
            
            
            
            ypos += height
            
            height = SharedUIManager.instance.siteMiniView_imageheight + SharedUIManager.instance.sitesContainer_headerHeight + SharedUIManager.instance.siteMiniView_headerHeight// + 1
            
            
            
            var colorIndex:Int = 0
            for category in BNAppSharedManager.instance.dataManager.bnUser!.categories {
                
                if isThereElementsInCategory(category) {
                    
                    let elementContainer = MainViewContainer_Elements(frame: CGRectMake(0, ypos, screenWidth, SharedUIManager.instance.elementContainer_Height), father: self, category:category, colorIndex:colorIndex)
                    elementContainer.delegate = (self.father! as! MainView)
                    ypos += (SharedUIManager.instance.elementContainer_Height + spacer)
                    self.scroll!.addChild(elementContainer)
                    self.elementContainers!.append(elementContainer)
                    
                    colorIndex += 1
                    if colorIndex  > 1 {
                        colorIndex = 0
                    }
                }
                
            }
            
            ypos += SharedUIManager.instance.categoriesHeaderHeight
            self.scroll!.setChildrenPosition()
            
        }
        
        */
    }
    

    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {

        state!.action()
    }
    
    override func setNextState(goto:BNGoto){
        father!.setNextState(goto)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            
        }else{
            father!.updateUserControl(position)
        }
    }
    
    override func refresh() { }

    override func clean(){
        if elementContainers?.count > 0 {
            
            for elementContainer in elementContainers! {
                elementContainer.clean()
                elementContainer.removeFromSuperview()
            }
            
            elementContainers!.removeAll(keepCapacity: false)
        }
        
        elementContainers = nil
        scroll!.removeFromSuperview()
        fade!.removeFromSuperview()
    }
}
