//
//  CropSwift.swift
//  Pixed
//
//  Created by Nishanth P on 1/24/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import UIKit

class CropSwift: UIView {

    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.blue.cgColor)
        let rectangle = CGRect(x:0,y:0,width:50,height:50)
        context!.addRect(rectangle)
        context!.strokePath()
        
    }
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
