//  ElementView_Details.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementView_Details:BNView {

    var elementIdentifier:String?
    var biinitBtn:BNUIButton_BiinItLarge?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father:BNView?, element:BNElement?) {
        self.init(frame:frame, father:father)
        
        self.backgroundColor = UIColor.appMainColor()
        
        elementIdentifier = element!._id
        var titleSize:CGFloat = SharedUIManager.instance.elementView_titleSize
        var textSize:CGFloat = SharedUIManager.instance.elementView_textSize
        var quoteSize:CGFloat = SharedUIManager.instance.elementView_quoteSize
        var ypos:CGFloat = 15
        var spacer:CGFloat = 5
        
        var nutshellDescriptionTitle = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), (SharedUIManager.instance.siteView_titleSize + 2)))
        nutshellDescriptionTitle.font = UIFont(name: "Lato-Regular", size:titleSize)
        nutshellDescriptionTitle.textColor = UIColor.appTextColor()
        nutshellDescriptionTitle.text = element!.nutshellDescriptionTitle!
        nutshellDescriptionTitle.numberOfLines = 0
        nutshellDescriptionTitle.sizeToFit()
        self.addSubview(nutshellDescriptionTitle)
        
        ypos += nutshellDescriptionTitle.frame.height + spacer
        
        var nutshellDescription = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), (SharedUIManager.instance.miniView_subTittleSize + 2)))
        nutshellDescription.font = UIFont(name:"Lato-Light", size:textSize)
        nutshellDescription.textColor = UIColor.appTextColor()
        nutshellDescription.text = element!.nutshellDescription!
        nutshellDescription.numberOfLines = 0
        nutshellDescription.sizeToFit()
        self.addSubview(nutshellDescription)
        
        ypos += nutshellDescription.frame.height + spacer
        
        var showBenefitDescription = false
        //Timing Stickers
        if element!.hasTimming {
            ypos += 20 //Spacing
            var timeStickerView = BNUIDetailView_Time(position: CGPointMake(5, ypos), text:"30h", textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(timeStickerView)
            showBenefitDescription = true
        }
        
        //Pricing Stickers
        if element!.hasListPrice {
            ypos += 32
            var priceStickerView = BNUIDetailView_Price(position: CGPointMake(5, ypos), price:element!.price, listPrice:element!.listPrice, discount:element!.discount, savings: element!.savings, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(priceStickerView)
            showBenefitDescription = true
            if !element!.hasQuantity {
                ypos += 50
            }
        }
        
        //Quantity Stickers
        if element!.hasQuantity {
            if element!.hasListPrice {
                ypos += 92
            } else {
                ypos += 20
            }
            
            var boxWidth = (SharedUIManager.instance.screenWidth - 14) / 3
            var quantityStickerView = BNUIDetailView_Quantity(position: CGPointMake(5, ypos), title:"QUANTITY", value:element!.quantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(quantityStickerView)
            
            var reservedStickerView = BNUIDetailView_Quantity(position: CGPointMake((boxWidth + 7), ypos), title:"RESERVED", value:element!.reservedQuantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(reservedStickerView)

            boxWidth += boxWidth
            var claimedStickerView = BNUIDetailView_Quantity(position: CGPointMake((boxWidth + 9), ypos), title:"CLAIMED", value:element!.claimedQuantity, textColor:UIColor.appTextColor(), borderColor:UIColor.appButtonColor())
            self.addSubview(claimedStickerView)
            showBenefitDescription = true
        }
        
        ypos += 30
        
        for detail in element!.details {
            switch detail.elementDetailType! {
            case .Title:      //1
                ypos += 25
                var title = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 20))
                title.font = UIFont(name: "Lato-Regular", size: titleSize)
                title.text = detail.text
                title.textColor = UIColor.appTextColor()
                title.numberOfLines = 0
                title.sizeToFit()
                title.alpha = 1
                self.addSubview(title)
                ypos += title.frame.height
                break
            case .Paragraph:  //2
                ypos += 5
                var paragraph = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 0))
                paragraph.font = UIFont(name: "Lato-Light", size: textSize)
                paragraph.text = detail.text
                paragraph.textColor = UIColor.appTextColor()
                paragraph.numberOfLines = 0
                paragraph.sizeToFit()
                paragraph.alpha = 1
                self.addSubview(paragraph)
                ypos += paragraph.frame.height
                break
            case .Quote:      //3
                ypos += 25
                var quote = UILabel(frame: CGRectMake(20, ypos, (frame.width - 40), 0))
                quote.text = detail.text
                quote.textColor = UIColor.appTextColor()
                quote.font = UIFont(name: "Lato-Regular", size: quoteSize)
                quote.numberOfLines = 0
                quote.sizeToFit()
                quote.alpha = 1
                self.addSubview(quote)
                
                var quoteView = UIView(frame: CGRectMake(10, (ypos - 5), 2, (quote.frame.height + 10)))
                quoteView.backgroundColor = UIColor.biinColor()
                self.addSubview(quoteView)
                
                ypos += quoteView.frame.height
                break
            case .ListItem:   //4
                ypos += 5
                for listItem in detail.body! {
                    ypos += 5
                    var item = UILabel(frame: CGRectMake(25, ypos, (frame.width - 50), 0))
                    item.text = listItem
                    item.textColor = UIColor.appTextColor()
                    item.font = UIFont(name: "Lato-Light", size: textSize)
                    item.numberOfLines = 0
                    item.sizeToFit()
                    item.alpha = 1
                    self.addSubview(item)
                    
                    var yposition = ypos + 6
                    var pointView = UIView(frame: CGRectMake(10, (yposition), 6, 6))
                    pointView.backgroundColor = UIColor.appTextColor()
                    pointView.layer.cornerRadius = 3
                    self.addSubview(pointView)
                    
                    ypos += item.frame.height
                }
                ypos += 5
                break
            case .Link:       //5
                ypos += 25
                var link = UILabel(frame: CGRectMake(10, ypos, (frame.width - 20), 0))
                link.text = detail.text
                link.textColor = UIColor.appTextColor()
                link.font = UIFont(name: "Lato-Light", size: textSize)
                link.numberOfLines = 0
                link.sizeToFit()
                link.alpha = 1
                self.addSubview(link)
                ypos += link.frame.height
                break
            default:
                break
            }
        }
        
        ypos += 40 //space
        biinitBtn = BNUIButton_BiinItLarge(frame: CGRectMake(((SharedUIManager.instance.screenWidth / 2) - 42), ypos, 84, 84))
        biinitBtn!.addTarget(self, action: "biinIt:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(biinitBtn!)
        
        ypos += 90
        
        var biinitLbl = UILabel(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, (titleSize + 2)))
        biinitLbl.font = UIFont(name: "Lato-Regular", size:titleSize)
        biinitLbl.textColor = UIColor.appTextColor()
        biinitLbl.textAlignment = NSTextAlignment.Center
        biinitLbl.text = "Biin it!"
        self.addSubview(biinitLbl)
        
        ypos += 50 //Last space
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, ypos)
        
        
    }
    
    override func transitionIn() {
        println("trasition in on ElementView_Details")
    }
    
    override func transitionOut( state:BNState? ) {
        println("trasition out on ElementView_Details")
    }
    
    override func setNextState(option:Int){
        //Start transition on root view controller
        father!.setNextState(option)
    }
    
    override func showUserControl(value:Bool, son:BNView, point:CGPoint){
        if father == nil {
            println("showUserControl: ElementView_Details")
        }else{
            father!.showUserControl(value, son:son, point:point)
        }
    }
    
    override func updateUserControl(position:CGPoint){
        if father == nil {
            println("updateUserControl: ElementView_Details")
        }else{
            father!.updateUserControl(position)
        }
    }
    
    func biinIt(sender:BNUIButton_BiinItLarge) {
        BNAppSharedManager.instance.biinit(elementIdentifier!, isElement:true)
        biinitBtn!.showDisable()
    }
}

