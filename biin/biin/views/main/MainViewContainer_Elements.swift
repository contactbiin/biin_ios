//  ElementsContainer.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainViewContainer_Elements:BNView, UIScrollViewDelegate, ElementMiniView_Delegate, SiteView_Delegate {
    
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:UIScrollView?
    //weak var biin:BNBiin?
    var showcase:BNShowcase?
    var category:BNCategory?
    
    var isWorking = true
    var spacer:CGFloat = 1
    var elements:Array<ElementMiniView>?
    var addedElementsIdentifiers:Dictionary<String, BNElement>?


    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView? ) {
        super.init(frame: frame, father:father )
    }

    convenience init(frame: CGRect, father:BNView?, category:BNCategory, colorIndex:Int) {
        self.init(frame: frame, father:father)
        
        let screenWidth = SharedUIManager.instance.screenWidth
        
        let ypos:CGFloat = 11

        self.category = category
        
        var textColor:UIColor?
        switch colorIndex {
        case 0:
            self.backgroundColor = UIColor.lightGrayColor()
            textColor = UIColor.bnGrayDark()
        case 1:
            self.backgroundColor = UIColor.grayColor()
            textColor = UIColor.whiteColor()
        default:
            self.backgroundColor = UIColor.lightGrayColor()
            textColor = UIColor.bnGrayDark()
            break
        }
        
        title = UILabel(frame: CGRectMake(15, ypos, (frame.width - 10), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = category.name!
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = textColor
        
        self.addSubview(title!)

        let scrollHeight:CGFloat = SharedUIManager.instance.miniView_height + SharedUIManager.instance.miniView_headerHeight
        scroll = UIScrollView(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight))
        scroll!.delegate = self
        scroll!.showsHorizontalScrollIndicator = false
        scroll!.showsVerticalScrollIndicator = false
        scroll!.scrollsToTop = false
        scroll!.backgroundColor = UIColor.clearColor()
        self.addSubview(scroll!)
        
        addedElementsIdentifiers = Dictionary<String, BNElement>()
        
        addElementViews()
    }
    
    deinit{
        print("-------------- deinit in siteView_showcase")
    }
    
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {
        print("SiteView_Showcase transitionOut")
        
        //clean()
        if elements?.count > 0 {
            
            for view in scroll!.subviews {
                
                if view is ElementMiniView {
                    (view as! ElementMiniView).removeFromSuperview()
                }
            }

            elements!.removeAll(keepCapacity: false)
            addedElementsIdentifiers!.removeAll(keepCapacity: false)
        }
        
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        print("SiteView_Showcase setNextState")
        father!.setNextState(option)
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
    
    //Instance methods
    //Start all category work, download etc.
    override func getToWork(){
        isWorking = true
    }
    
    //Stop all category work, download etc.
    override func getToRest(){
        isWorking = false
    }
    
    func updateForSite(site: BNSite?){
        
    }
    
    func addElementViews(){
        
        showcase = BNShowcase()
        
        for siteDetails in category!.sitesDetails {
            
            if let site = BNAppSharedManager.instance.dataManager.sites[siteDetails.identifier!] {
               
                if let showcases = site.showcases {
                    for showcase in showcases {
                        for element in showcase.elements {
                            if element.isHighlight {
                                if addedElementsIdentifiers![element._id!] == nil {
                                    self.showcase!.elements.append(element)
                                    addedElementsIdentifiers![element._id!] = element
                                }
                            }
                        }
                    }
                }
            }
        }

        var elementPosition:Int = 1
        var xpos:CGFloat = 0
        var elementsViewed = 0
        elements = Array<ElementMiniView>()
        
        var elementView_width:CGFloat = 0
        
        if showcase!.elements.count == 1 {
            elementView_width = SharedUIManager.instance.screenWidth
        } else if showcase!.elements.count == 2 {
            elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        } else if showcase!.elements.count == 3 {
            elementView_width = ((SharedUIManager.instance.screenWidth - 2) / 2.75)
        } else {
            elementView_width = SharedUIManager.instance.miniView_width
        }
        
//        if self.site!.organization!.isLoyaltyEnabled && self.site!.organization!.loyalty!.isSubscribed {
//            isLoyaltyEnabled = true
//        }
        
        for element in showcase!.elements {
            
            
            let elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, elementView_width, SharedUIManager.instance.miniView_height), father: self, element:BNAppSharedManager.instance.dataManager.elements[element._id!], elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:false, showlocation:true)
            
            if element != showcase!.elements.last {
                xpos += elementView_width + spacer
            } else  {
                xpos += (elementView_width - 1)
            }
            
            elementView.delegate = self
            scroll!.addSubview(elementView)
            elements!.append(elementView)
            elementPosition++
            
            
            
            if element.userViewed {
                elementsViewed++
            }
            
            //if elementPosition < 4 {
            elementView.requestImage()
            //}
        }
        
        scroll!.contentSize = CGSizeMake(xpos, 0)
        scroll!.setContentOffset(CGPointZero, animated: false)
        scroll!.bounces = false
        scroll!.pagingEnabled = false
    }
    
    /* UIScrollViewDelegate Methods */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        manageElementMiniViewImageRequest()
    }// any offset changes
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //handlePan(scrollView.panGestureRecognizer)
        let mainView = father!.father! as! MainView
        mainView.delegate!.mainView!(mainView, hideMenu: false)
    }
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }// called on finger up as we are moving
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
         }// called when scroll view grinds to a halt
    
    func updatePointCounter() {

    }
    
    func updatePoints(sender:NSTimer){


    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
    }// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        
        return true
    }// return a yes if you want to scroll to the top. if not defined, assumes YES
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }// called when scrolling animation finished. may be called immediately if already at top
    
    func manageElementMiniViewImageRequest(){
        
    }
    
    //ElementMiniView_Delegate
    func showElementView(viewiew: ElementMiniView, element: BNElement) {
        (father! as! MainViewContainer).showElementView(element)
    }
}

