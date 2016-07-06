//  CollectionsView.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class CollectionsView: BNView, ElementView_Delegate {
    
    var delegate:CollectionsView_Delegate?
    var title:UILabel?
    var backBtn:BNUIButton_Back?
//    var fade:UIView?
    
    var biinieAvatar:BNUIImageView?
    var biinieNameLbl:UILabel?
    var biinieUserNameLbl:UILabel?
    
    var scroll:UIScrollView?
    var collections:Array<CollectionsView_Collection>?
    
    var elementView:ElementView?
    var isShowingElementView = false
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
        
        self.backgroundColor = UIColor.appMainColor()
        
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        
        var ypos:CGFloat = 12
        title = UILabel(frame: CGRectMake(6, ypos, screenWidth, (SharedUIManager.instance.siteView_titleSize + 3)))
        title!.font = UIFont(name:"Lato-Black", size:SharedUIManager.instance.siteView_titleSize)
        title!.textColor = UIColor.appTextColor()
        title!.textAlignment = NSTextAlignment.Center
        title!.text = NSLocalizedString("Collections", comment: "title")
        self.addSubview(title!)
        
        backBtn = BNUIButton_Back(frame: CGRectMake(0, 10, 50, 50))
        backBtn!.addTarget(self, action: #selector(self.backBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn!)
        
        //let headerWidth = screenWidth - 60
        //var xpos:CGFloat = (screenWidth - headerWidth) / 2
        
        /*
        var biinieAvatarView = UIView(frame: CGRectMake(xpos, ypos, 92, 92))
        biinieAvatarView.layer.cornerRadius = 35
        biinieAvatarView.layer.borderColor = UIColor.appBackground().CGColor
        biinieAvatarView.layer.borderWidth = 6
        biinieAvatarView.layer.masksToBounds = true
        self.addSubview(biinieAvatarView)
        
        if BNAppSharedManager.instance.dataManager.bnUser!.imgUrl != "" {
        biinieAvatar = BNUIImageView(frame: CGRectMake(1, 1, 90, 90))
        //biinieAvatar!.alpha = 0
        biinieAvatar!.layer.cornerRadius = 30
        biinieAvatar!.layer.masksToBounds = true
        biinieAvatarView.addSubview(biinieAvatar!)
        BNAppSharedManager.instance.networkManager.requestImageData(BNAppSharedManager.instance.dataManager.bnUser!.imgUrl!, image: biinieAvatar)
        } else  {
        var initials = UILabel(frame: CGRectMake(0, 25, 90, 40))
        initials.font = UIFont(name: "Lato-Light", size: 38)
        initials.textColor = UIColor.appMainColor()
        initials.textAlignment = NSTextAlignment.Center
        initials.text = "\(first(BNAppSharedManager.instance.dataManager.bnUser!.firstName!)!)\(first(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)!)"
        biinieAvatarView.addSubview(initials)
        biinieAvatarView.backgroundColor = UIColor.biinColor()
        }

        
        
        //        biinieNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 30), (headerWidth - 95), 20))
        biinieNameLbl = UILabel(frame: CGRectMake(6, 25, (screenWidth - 20), 20))
        biinieNameLbl!.font = UIFont(name: "Lato-Regular", size: 22)
        biinieNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.firstName!) \(BNAppSharedManager.instance.dataManager.bnUser!.lastName!)"
        biinieNameLbl!.textColor = UIColor.biinColor()
        biinieNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(biinieNameLbl!)
        
        //biinieUserNameLbl = UILabel(frame: CGRectMake((xpos + 100), (ypos + 50), (headerWidth - 95), 14))
        biinieUserNameLbl = UILabel(frame: CGRectMake(6, 45, (screenWidth - 20), 14))
        biinieUserNameLbl!.font = UIFont(name: "Lato-Light", size: 12)
        biinieUserNameLbl!.text = "\(BNAppSharedManager.instance.dataManager.bnUser!.biinName!)"
        biinieUserNameLbl!.textColor = UIColor.appTextColor()
        biinieUserNameLbl!.textAlignment = NSTextAlignment.Center
        self.addSubview(biinieUserNameLbl!)
        */
        
        ypos = SharedUIManager.instance.siteView_headerHeight
        let line = UIView(frame: CGRectMake(0, ypos, screenWidth, 0.5))
        line.backgroundColor = UIColor.appButtonColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, ypos, screenWidth, (screenHeight - ypos)))
        self.addSubview(scroll!)
        self.addSubview(line)
        
        //Add collections here.
        addCollections()
        
        fade = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        fade!.backgroundColor = UIColor.blackColor()
        fade!.alpha = 0
        self.addSubview(fade!)
        
        elementView = ElementView(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight), father: self, showBiinItBtn:false)
        elementView!.delegate = self
        self.addSubview(elementView!)
        
        //var showMenuSwipe = UIScreenEdgePanGestureRecognizer(target: father!, action: "showMenu:")
        //showMenuSwipe.edges = UIRectEdge.Left
        //elementView!.scroll!.addGestureRecognizer(showMenuSwipe)
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func transitionIn() {
        UIView.animateWithDuration(0.25, animations: {()->Void in
            self.frame.origin.x = 0
        })
    }
    
    override func transitionOut( state:BNState? ) {
        state!.action()
        
        if state!.stateType == BNStateType.MainViewContainerState
            || state!.stateType == BNStateType.SiteState {
                
                UIView.animateWithDuration(0.25, animations: {()-> Void in
                    self.frame.origin.x = SharedUIManager.instance.screenWidth
                })
                
        } else {
            
            UIView.animateWithDuration(0.25, animations: {()-> Void in
                self.fade!.alpha = 0.25
            })
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.hideView(_:)), userInfo: nil, repeats: false)
        }
    }
    
    func hideView(sender:NSTimer){
        self.frame.origin.x = SharedUIManager.instance.screenWidth
        self.fade!.alpha = 0
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
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
    
    //Instance Methods
    func backBtnAction(sender:UIButton) {
        delegate!.hideCollectionsView!(self)
        //delegate!.hideElementView!(elementMiniView)
    }
    
    func addCollections(){
        
        //clean()
        if collections?.count > 0 {
            collections!.removeAll(keepCapacity: false)
        }
        
        collections = Array<CollectionsView_Collection>()
        
        let height:CGFloat = SharedUIManager.instance.elementView_headerHeight + SharedUIManager.instance.miniView_height + 15
        var ypos:CGFloat = 0
        
        for (_, collection) in BNAppSharedManager.instance.dataManager.biinie!.collections! {
            
            let collectionView = CollectionsView_Collection(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, height), father: self, collection: collection)
            
            collections!.append(collectionView)
            scroll!.addSubview(collectionView)
            ypos += height
            ypos += 1
        }
        
        scroll!.contentSize = CGSizeMake(0, ypos)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
    }
    
    override func refresh(){
        for collectionView in self.collections! {
            collectionView.refresh()
        }
    }
    
    func showElementView(element:BNElement){
        
//        elementView!.updateElementData(element, showSiteBtn:true)
//        
//        UIView.animateWithDuration(0.3, animations: {()-> Void in
//            self.elementView!.frame.origin.x = 0
//            self.fade!.alpha = 0.25
//        })
    }
    
    func hideElementView(element:BNElement) {
        
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.elementView!.frame.origin.x = SharedUIManager.instance.screenWidth
            self.fade!.alpha = 0
            }, completion: {(completed:Bool)-> Void in
                
//                if !view!.element!.userViewed {
//                    view!.userViewedElement()
//                }
                
                self.elementView!.clean()
        })
    }
    
//    func updateHighlightsContainer() {
//        (father as! MainView).updateHighlightsContainer()
//    }
}

@objc protocol CollectionsView_Delegate:NSObjectProtocol {
    optional func hideCollectionsView(view:CollectionsView)
}
