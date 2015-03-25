//  BNMKAnnotationView.swift
//  biin
//  Created by Esteban Padilla on 2/27/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import MapKit

class BNMKAnnotation:NSObject {
    
    var coordinate: CLLocationCoordinate2D!

    
    var title: String!
    var subtitle: String!
    
    override init() {
        
    }
    
    init(title:String, location:CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = location
    }

    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate
    }
    
//    var icon:BNIcon?
//    
//    override init() {
//        super.init()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    

    
    /*
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier!)
        self.backgroundColor = UIColor.redColor()
        icon = BNIcon_TVMedium(color: UIColor.biinColor(), position: CGPoint(x: 0, y: 0))
    }
    
    override func drawRect(rect:CGRect){
        self.icon?.drawCanvas()
    }
*/

}