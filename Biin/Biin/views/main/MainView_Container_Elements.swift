//  MainView_Container_Elements.swift
//  biin
//  Created by Esteban Padilla on 9/24/15.
//  Copyright © 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class MainView_Container_Elements:BNView {

    var delegate:MainView_Container_Elements_Delegate?
    var moreElementsBtn:BNUIButton_More?
    var title:UILabel?
    var subTitle:UILabel?
    var scroll:BNScroll?
    var category:BNCategory?
    
    var isWorking = true
    var spacer:CGFloat = 1

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
        
        let ypos:CGFloat = 21

        self.category = category
        
        var textColor:UIColor?
//        switch colorIndex {
//        case 0:
            self.backgroundColor = UIColor.bnCategoriesColor()
            category.backgroundColor = UIColor.bnCategoriesColor()
            textColor = UIColor.whiteColor()
//        case 1:
//            self.backgroundColor = UIColor.darkGrayColor()
//            category.backgroundColor = UIColor.grayColor()
//            textColor = UIColor.whiteColor()
//        default:
//            self.backgroundColor = UIColor.darkGrayColor()
//            category.backgroundColor = UIColor.lightGrayColor()
//            textColor = UIColor.whiteColor()
//            break
//        }
        
        moreElementsBtn = BNUIButton_More(frame: CGRectMake((screenWidth - SharedUIManager.instance.sitesContainer_headerHeight), 0, SharedUIManager.instance.sitesContainer_headerHeight, SharedUIManager.instance.sitesContainer_headerHeight))
        moreElementsBtn!.icon!.color = textColor

//        moreElementsBtn!.setTitle(NSLocalizedString("More", comment: "More"), forState: UIControlState.Normal)
//        moreElementsBtn!.setTitleColor(textColor, forState: UIControlState.Normal)
//        moreElementsBtn!.titleLabel!.font = UIFont(name: "Lato-Regular", size: 11)
        moreElementsBtn!.addTarget(self, action: #selector(self.moreElementsBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(moreElementsBtn!)
        
        title = UILabel(frame: CGRectMake(15, ypos, (frame.width - 60), (SharedUIManager.instance.siteView_showcase_titleSize + 4)))
        title!.font = UIFont(name:"Lato-Regular", size:SharedUIManager.instance.siteView_showcase_titleSize)
        let titleText = NSLocalizedString(category.identifier!, comment: "category_identifier!").uppercaseString
        let attributedString = NSMutableAttributedString(string:titleText)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(5), range: NSRange(location: 0, length:(titleText.characters.count)))
        title!.attributedText = attributedString
        title!.textColor = textColor
        //title!.sizeToFit()
        
        self.addSubview(title!)

        let scrollHeight:CGFloat = SharedUIManager.instance.miniView_height//+ SharedUIManager.instance.miniView_headerHeight
        
        scroll = BNScroll(frame: CGRectMake(0, (SharedUIManager.instance.sitesContainer_headerHeight - 1), screenWidth, scrollHeight), father:self, direction: BNScroll_Direction.HORIZONTAL, space: 1, extraSpace: 0, color: UIColor.clearColor(), delegate: nil)
        self.addSubview(scroll!)
        
        addElementViews()
    }
    
    deinit{ }
    
    override func transitionIn() { }
    
    override func transitionOut( state:BNState? ) { }
    
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
    
    func isElementAdded(identifier:String) -> Bool {
        for view in scroll!.children {
            if (view as! ElementMiniView).element!.identifier! == identifier {
                return true
            }
        }
        return false
    }
    
    
    func addElementViews(){

        var elementPosition:Int = 1
        let xpos:CGFloat = 0
        var elementsViewed = 0
        var elements = Array<ElementMiniView>()
        
        var elementView_width:CGFloat = 0
        
        if category!.elements.count == 1 {
            elementView_width = SharedUIManager.instance.screenWidth
        } else if category!.elements.count == 2 {
            elementView_width = ((SharedUIManager.instance.screenWidth - 1) / 2)
        } else {
            elementView_width = SharedUIManager.instance.miniView_width
        }
        
        for element_data  in category!.elements {
            
            if !isElementAdded(element_data.identifier) {
                if let element = BNAppSharedManager.instance.dataManager.elements[element_data.identifier] {
                    if element.showcase == nil {
                        element.showcase = BNAppSharedManager.instance.dataManager.showcases[element_data.showcase]
                    }
                    
                    if element.showcase!.site == nil {
                        element.showcase!.site = BNAppSharedManager.instance.dataManager.sites[element_data.site]
                    }
                    
                    let elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, elementView_width, SharedUIManager.instance.miniView_height), father: self, element:element, elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:false, showlocation:true)
                    elementView.delegate = BNAppSharedManager.instance.mainViewController!.mainView!//father?.father! as! MainView
                    elements.append(elementView)
                    elementPosition += 1
                    
                    if element.userViewed {
                        elementsViewed += 1
                    }
                    
                    elementView.requestImage()
                }
            }
        }
        
        /*
        for (element_id, element) in category!.elements {
            if element._id != nil {
                if !isElementAdded(element._id!) {

                    let elementView = ElementMiniView(frame: CGRectMake(xpos, spacer, elementView_width, SharedUIManager.instance.miniView_height), father: self, element:element, elementPosition:elementPosition, showRemoveBtn:false, isNumberVisible:false, showlocation:true)
                    elementView.delegate = BNAppSharedManager.instance.mainViewController!.mainView!//father?.father! as! MainView
                    elements.append(elementView)
                    elementPosition += 1
                    
                    if element.userViewed {
                        elementsViewed += 1
                    }

                    elementView.requestImage()
                }

            } else {
                category!.elements.removeValueForKey(element_id)
            }
        }
        */
        self.scroll!.addMoreChildren(elements)
    }
    
    func updatePointCounter() { }
    
    func updatePoints(sender:NSTimer){ }
    
    func manageElementMiniViewImageRequest(){ }
    
    func moreElementsBtnAction(sender:UIButton){
        delegate!.showAllElementsViewForCategory!(self.category)
    }
    
    override func clean() {
        
        self.scroll!.clean()
        
        delegate = nil
        moreElementsBtn?.removeFromSuperview()
        title?.removeFromSuperview()
        subTitle?.removeFromSuperview()
        scroll?.removeFromSuperview()
        category = nil
        
    }
    
    override func refresh() {
        addElementViews()
    }
    
    override func request() {
        BNAppSharedManager.instance.dataManager.requestElementsForCategory(self.category!, view: self)
    }
    
    override func requestCompleted() {
        self.addElementViews()
        self.scroll!.requestCompleted()
    }
}

@objc protocol MainView_Container_Elements_Delegate:NSObjectProtocol {
    ///Update categories icons on header
    optional func showAllElementsView()
    optional func showAllElementsViewForCategory(category:BNCategory?)
}

