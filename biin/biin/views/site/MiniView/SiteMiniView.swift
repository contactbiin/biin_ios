//  SiteMiniView.swift
//  biin
//  Created by Esteban Padilla on 1/17/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class SiteMiniView: BNView {
    
    var delegate:SiteMiniView_Delegate?
    var site:BNSite?
    var image:BNUIImageView?
    var header:SiteMiniView_Header?
    var imageRequested = false
    
    var collectionScrollPosition:Int = 0
    
//    override init() {
//        super.init()
//    }
    
    var isPositionedInFather = false
    var isReadyToRemoveFromFather = true
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame:CGRect, father:BNView?, site:BNSite?){
        self.init(frame: frame, father:father )
        
//        self.layer.borderColor = UIColor.appMainColor().CGColor
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        //self.layer.shadowOffset = CGSizeMake(0, 0.5)
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0.25
        
        self.site = site
        
        if site!.media.count > 0 {
            if let color = site!.media[0].domainColor {
                self.backgroundColor = color
            } else {
                self.backgroundColor = UIColor.appMainColor()
            }
        } else {
            self.backgroundColor = UIColor.appMainColor()
        }


        //Positioning image
        let imageSize = frame.width
        //let xpos = ((imageSize - frame.width) / 2 ) * -1
        image = BNUIImageView(frame: CGRectMake(0, 0, imageSize, imageSize), color:site!.media[0].vibrantColor!)
        //image!.alpha = 0
        self.addSubview(image!)
        
        header = SiteMiniView_Header(frame: CGRectMake(0, SharedUIManager.instance.siteMiniView_imageheight, frame.width, SharedUIManager.instance.siteMiniView_headerHeight), father: self, site: site, showShareButton:true)
        self.addSubview(header!)
        //header!.updateSocialButtonsForSite(site)
        
//        var nutshell = UILabel(frame: CGRectMake(10, 100, (frame.width - 20), 14))
//        nutshell.font = UIFont(name:"Lato-Black", size:12)
//        nutshell.textColor = UIColor.whiteColor()
//        nutshell.text = site!.nutshell!
//        nutshell.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
//        nutshell.shadowOffset = CGSize(width: 1, height: 1)
//        nutshell.numberOfLines = 0
//        nutshell.sizeToFit()
//        //self.addSubview(nutshell)
//        nutshell.frame.origin.y = (frame.height - (nutshell.frame.height + 10))
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isFirstResponder()
        
        requestImage()
    }
    
    override func transitionIn() {
        print("trasition in on SiteMiniView")
    }
    
    override func transitionOut( state:BNState? ) {
        print("trasition out on SiteMiniView")
    }
    
    override func setNextState(goto:BNGoto){
        //Start transition on root view controller
        father!.setNextState(goto)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            print("showUserControl: SiteMiniView")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            print("updateUserControl: SiteMiniView")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    func requestImage(){
        
        if imageRequested { return }

        imageRequested = true
        
        if site!.media.count > 0 {
            BNAppSharedManager.instance.networkManager.requestImageData(site!.media[0].url!, image: image)
        } else {
            image!.image =  UIImage(named: "noImage.jpg")
            image!.showAfterDownload()
        }
    }
    
    /* Gesture hadlers */
    func handleTap(sender:UITapGestureRecognizer) {
        
        //let siteContainer = father as! BiinieCategoriesView_SitesContainer
        //let position = father!.father!.convertRect(self.frame, fromView: siteContainer.scroll!)
        delegate!.showSiteView!(self)
        
        //Trigered transition to showcase view.
        //var view = sender.view as SectionBotomView
        
        //Get the bottomView's position
        //var position = father!.convertRect(view.frame, fromView: scroll!)
        
        //tappedIndex = getSectionBotomViewIndex(view)
        //sectionsViewDelegate!.showShowcaseFromBottom!(self, position:position, showcaseKey:view.showcaseKey)
        
    }
    
    func clean() {
        print("SiteMiniView clean()")
        site = nil
        image!.removeFromSuperview()
        header!.removeFromSuperview()
    }
}

@objc protocol SiteMiniView_Delegate:NSObjectProtocol {
    optional func showSiteView(view:SiteMiniView)
}
