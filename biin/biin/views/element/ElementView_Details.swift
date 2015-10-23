//  ElementView_Details.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class ElementView_Details:BNView {

    var elementIdentifier:String?
    var biinitBtn:BNUIButton_BiinItLarge?
  
    var title:UILabel?
    var subTitle:UILabel?
    
    var labels:Array<UILabel>?
    var detailViews:Array<UIView>?
    
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, father:BNView?) {
        super.init(frame: frame, father:father )
    }
    
    convenience init(frame: CGRect, father:BNView?, element:BNElement?) {
        self.init(frame:frame, father:father)
        
        self.backgroundColor = UIColor.appMainColor()
        
        self.labels = Array<UILabel>()
        self.detailViews = Array<UIView>()
        
        elementIdentifier = element!._id
        
        let titleSize:CGFloat = SharedUIManager.instance.detailView_title
        let textSize:CGFloat = SharedUIManager.instance.detailView_text
        let quoteSize:CGFloat = SharedUIManager.instance.detailView_quoteSize
        let priceListSize:CGFloat = SharedUIManager.instance.detailView_priceList
        var ypos:CGFloat = 10
        let xpos:CGFloat = 20
        //var spacer:CGFloat = 5

        var detailCounter = 0
        var ySpace:CGFloat = 0
        var addSpaceForQuote = false
        
        
        self.title = UILabel(frame: CGRectMake(0, 0, 0, 0))
        self.subTitle = UILabel(frame: CGRectMake(0, 0, 0, 0))
        
        self.title!.frame = CGRectMake(20, ypos, (frame.width - 40), 0)
        self.title!.textColor = UIColor.appTextColor()
        self.title!.textAlignment = NSTextAlignment.Left
        self.title!.font = UIFont(name: "Lato-Regular", size:SharedUIManager.instance.elementView_titleSize)
        self.title!.text = element!.title!
        self.title!.numberOfLines = 2
        self.title!.sizeToFit()
        self.addSubview(self.title!)
        
        ypos += self.title!.frame.height + 2
        self.subTitle!.frame = CGRectMake(20, ypos, (frame.width - 40), (SharedUIManager.instance.elementView_subTitleSize + 2))
        self.subTitle!.textColor = UIColor.appTextColor()
        self.subTitle!.textAlignment = NSTextAlignment.Left
        self.subTitle!.font = UIFont(name: "Lato-Light", size:SharedUIManager.instance.elementView_subTitleSize)
        self.subTitle!.text = element!.subTitle!
        self.addSubview(self.subTitle!)
        self.subTitle!.numberOfLines = 2
        self.subTitle!.sizeToFit()

        ypos += self.subTitle!.frame.height + 5
        
        for detail in element!.details {

            if detailCounter == 0 {
                ySpace = 0
            } else {
                ySpace = 10
            }
            
            if addSpaceForQuote {
                ySpace = 25
            }
            
            switch detail.elementDetailType! {
            case .Title:      //1
                addSpaceForQuote = false
                ypos += ySpace
                let title = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - xpos), titleSize))
                title.font = UIFont(name: "Lato-Regular", size: titleSize)
                title.text = detail.text
                title.textColor = UIColor.appTextColor()
                title.numberOfLines = 0
                title.sizeToFit()
                title.alpha = 1
                self.addSubview(title)
                ypos += title.frame.height
                self.labels!.append(title)
                
                break
            case .Paragraph:  //2
                addSpaceForQuote = false
                ypos += ySpace
                let paragraph = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - (xpos + xpos)), 0))
                paragraph.font = UIFont(name: "Lato-Light", size: textSize)
                paragraph.text = detail.text
                paragraph.textColor = UIColor.appTextColor()
                paragraph.numberOfLines = 0
                paragraph.sizeToFit()
                paragraph.alpha = 1
                self.addSubview(paragraph)
                ypos += paragraph.frame.height
                self.labels!.append(paragraph)
                
                break
            case .Quote:      //3
                addSpaceForQuote = true
                ypos += 25
                let quote = UILabel(frame: CGRectMake(30, ypos, (frame.width - 30), 0))
                quote.text = detail.text
                quote.textColor = element!.media[0].vibrantColor!
                quote.font = UIFont(name: "Lato-Regular", size: quoteSize)
                quote.numberOfLines = 0
                quote.sizeToFit()
                quote.alpha = 1
                self.addSubview(quote)
                self.labels!.append(quote)
                
                let quoteView = UIView(frame: CGRectMake(xpos, (ypos - 5), 1, (quote.frame.height + 12)))
                quoteView.backgroundColor = element!.media[0].vibrantColor!
                self.addSubview(quoteView)
                detailViews!.append(quoteView)
                
                ypos += quoteView.frame.height
                
                break
            case .ListItem:   //4
                addSpaceForQuote = false
                ypos += 5
                for listItem in detail.body! {
                    ypos += 5
                    let item = UILabel(frame: CGRectMake((xpos + 10), ypos, (frame.width - 50), 0))
                    item.text = listItem
                    item.textColor = UIColor.appTextColor()
                    item.font = UIFont(name: "Lato-Light", size: textSize)
                    item.numberOfLines = 0
                    item.sizeToFit()
                    item.alpha = 1
                    self.addSubview(item)
                    self.labels!.append(item)
                    
                    let yposition = ypos + 7
                    let pointView = UIView(frame: CGRectMake(xpos, (yposition), 4, 4))
                    pointView.backgroundColor = UIColor.appTextColor()
                    pointView.layer.cornerRadius = 2
                    self.addSubview(pointView)
                    detailViews!.append(pointView)
                    
                    ypos += item.frame.height
                }
                ypos += 5
                break
            case .Link:       //5
                addSpaceForQuote = false
                ypos += 25
                let link = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - (xpos + xpos)), 0))
                link.text = detail.text
                link.textColor = UIColor.appTextColor()
                link.font = UIFont(name: "Lato-Light", size: textSize)
                link.numberOfLines = 0
                link.sizeToFit()
                link.alpha = 1
                self.addSubview(link)
                ypos += link.frame.height
                self.labels!.append(link)
                break
            case .PriceList:   //6
                addSpaceForQuote = false
                ypos += 5
                for priceItem in detail.priceList! {
                    ypos += 5
                    let price = UILabel(frame: CGRectMake(0, ypos, (frame.width - 50), 0))
                    price.text = "\(priceItem.currency!) \(priceItem.price!)"
                    price.textColor = UIColor.appTextColor()
                    price.font = UIFont(name: "Lato-Regular", size: priceListSize)
                    price.numberOfLines = 0
                    price.sizeToFit()
                    price.alpha = 1
                    self.addSubview(price)
                    self.labels!.append(price)
                    
                    price.frame.origin.x = frame.width - (price.frame.width + 20)
                    
                    let desc = UILabel(frame: CGRectMake(xpos, ypos, (frame.width - 50), 0))
                    desc.text = priceItem.description!
                    desc.textColor = UIColor.appTextColor()
                    desc.font = UIFont(name: "Lato-Light", size: priceListSize)
                    desc.numberOfLines = 0
                    desc.alpha = 1
                    desc.sizeToFit()
                    self.addSubview(desc)
                    self.labels!.append(desc)
                    
                    desc.frame = CGRectMake(xpos, ypos, frame.width - (price.frame.width + 50), desc.frame.height)
                    
                    ypos += desc.frame.height
                }
                ypos += 15
                break
            }
            
            detailCounter++
        }
        
        /*
        ypos += 40 //space
        biinitBtn = BNUIButton_BiinItLarge(frame: CGRectMake(((SharedUIManager.instance.screenWidth / 2) - 42), ypos, 84, 84))
        biinitBtn!.addTarget(self, action: "biinIt:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(biinitBtn!)
        
        ypos += 90
        
        let biinitLbl = UILabel(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, (titleSize + 2)))
        biinitLbl.font = UIFont(name: "Lato-Regular", size:titleSize)
        biinitLbl.textColor = UIColor.appTextColor()
        biinitLbl.textAlignment = NSTextAlignment.Center
        biinitLbl.text = "Biin it!"
        self.addSubview(biinitLbl)
        */
        
        ypos += 200 //Last space
        
        /*
        var html = "<div style='font-family:Lato; color:#0000;'> <h1>Best coffee ever.</h1>"
        html += "<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.&nbsp;<br></p>"
        html += "<blockquote style='background: #f9f9f9;border-left: 10px solid #ccc;margin: 1.5em 10px;padding: 0.5em 10px;'>Late and shake together.</blockquote>"
        html += "<ul><li>Small &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $2.5</li><li>Medium &nbsp; &nbsp; &nbsp;$3</li><li>Large &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; $6</li></ul><p><br></p></div>"
        
        var webView = UIWebView(frame: CGRectMake(0, ypos, SharedUIManager.instance.screenWidth, 500))
        webView.backgroundColor = UIColor.clearColor()
        webView.loadHTMLString(html, baseURL: nil)
        webView.scrollView.scrollEnabled = false
        self.addSubview(webView)
        
        
        ypos += 500
        */
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, ypos)

        
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
    
    func biinIt(sender:BNUIButton_BiinItLarge) {
//        BNAppSharedManager.instance.collectIt(elementIdentifier!, isElement:true)
//        (father as! ElementView).applyBiinIt()
//        biinitBtn!.showDisable()
    }
    
    func showBiinItButton(value:Bool){
//        if value {
//            biinitBtn!.showEnable()
//        } else {
//            biinitBtn!.showDisable()
//        }
    }
    
    func clean() {
        for view in detailViews! {
            view.removeFromSuperview()
        }
        
        detailViews!.removeAll()
        detailViews = nil
        
        
        for label in labels! {
            label.removeFromSuperview()
        }
        
        labels!.removeAll()
        labels = nil
        
        biinitBtn?.removeFromSuperview()
        
        title?.removeFromSuperview()
        subTitle?.removeFromSuperview()
    }
    
    func show() {
        
    }
}

