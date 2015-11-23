//  ElementsContainer.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainViewContainer_Elements:BNView, UIScrollViewDelegate {

    var delegate:MainViewContainer_Elements_Delegate?
    var moreElementsBtn:UIButton?
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:EPUIScrollView?
    //weak var biin:BNBiin?
    var showcase:BNShowcase?
    var category:BNCategory?
    
    var isWorking = true
    var spacer:CGFloat = 1
//    var elements:Array<ElementMiniView>?
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
        
        moreElementsBtn = UIButton(frame: CGRectMake(screenWidth - 50, 0, 50, 38))
        moreElementsBtn!.setTitle(NSLocalizedString("More", comment: "More"), forState: UIControlState.Normal)
        moreElementsBtn!.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        moreElementsBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 11)
        moreElementsBtn!.addTarget(self, action: "moreElementsBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(moreElementsBtn!)
        
        title = UILabel(frame: CGRectMake(15, ypos, (frame.width - 75), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = category.name!
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = textColor
        
        self.addSubview(title!)

        let scrollHeight:CGFloat = SharedUIManager.instance.miniView_height// + SharedUIManager.instance.miniView_headerHeight
        
//        scroll = EPUIScrollView(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight), isHorizontal: true, text: "", space: 1, extraSpace: 0, color: UIColor.clearColor(), showRefreshControl: true)

        scroll = EPUIScrollView(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight), father:self, direction: EPUIScrollView_Direction.HORIZONTAL, refreshControl_Position: UIRefreshControl_Position.RIGHT, text: "", space: 1, extraSpace: 0, color: UIColor.clearColor(), delegate: self)
        self.addSubview(scroll!)
        
        addedElementsIdentifiers = Dictionary<String, BNElement>()
        
        addElementViews()
    }
    
    deinit{
        
    }
    
    
    override func transitionIn() {
        
    }
    
    override func transitionOut( state:BNState? ) {

        
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
        
        for (_, element) in category!.elements {
            if addedElementsIdentifiers![element._id!] == nil {
                self.showcase!.elements.append(element)
                addedElementsIdentifiers![element._id!] = element
            }
        }

        var elementPosition:Int = 1
        var xpos:CGFloat = 0
        var elementsViewed = 0
        var elements = Array<ElementMiniView>()
        
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
        
        for element in showcase!.elements {
            
            //element.showcase = showcase
            let elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, elementView_width, SharedUIManager.instance.miniView_height), father: self, element:element, elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:false, showlocation:true)
            
            if element != showcase!.elements.last {
                xpos += elementView_width + spacer
            } else  {
                xpos += (elementView_width - 1)
            }
            
            elementView.delegate = BNAppSharedManager.instance.mainViewController!.mainView!//father?.father! as! MainView
            //elementView.delegate = self
//            self.scroll!.addChild(elementView)
//            scroll!.addSubview(elementView)
            elements.append(elementView)
            elementPosition++
            
            
            
            if element.userViewed {
                elementsViewed++
            }
            
            //if elementPosition < 4 {
            elementView.requestImage()
            //}
        }
        
        self.scroll!.addMoreChildren(elements)
//        self.scroll!.setChildrenPosition()
//        scroll!.contentSize = CGSizeMake(xpos, 0)
//        scroll!.setContentOffset(CGPointZero, animated: false)
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
//    func showElementView(viewiew: ElementMiniView, element: BNElement) {
//        (father! as! MainViewContainer).showElementView(element)
//    }
    
    func moreElementsBtnAction(sender:UIButton){
        delegate!.showAllElementsViewForCategory!(self.category)
    }
    
    func clean() {
        
        
        //clean()
//        if elements?.count > 0 {
//        
//            
//            for elementView in elements! {
//                elementView.removeFromSuperview()
//                elementView.clean()
//            }
//            
//            
//            elements!.removeAll(keepCapacity: false)
//            elements = nil
//            addedElementsIdentifiers!.removeAll(keepCapacity: false)
//            addedElementsIdentifiers = nil
//        }
        self.scroll!.clean()
        
        delegate = nil
        moreElementsBtn?.removeFromSuperview()
        title?.removeFromSuperview()
        subTitle?.removeFromSuperview()
        scroll?.removeFromSuperview()
        showcase = nil
        category = nil
        
    }
}

@objc protocol MainViewContainer_Elements_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func showAllElementsView()
    optional func showAllElementsViewForCategory(category:BNCategory?)
}

