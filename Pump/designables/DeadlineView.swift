//
//  DeadlineView.swift
//  Pump
//
//  Created by Bruno Pastre on 28/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//


import Foundation
import  UIKit

@IBDesignable
class DeadlineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit(){
//        self.layer.cornerRadius = 40
//        
//        
//        self.layer.shadowOffset =  CGSize(width: 0, height: -2)   // CGSizeMake(0, 1)
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowRadius = 1.2
//        self.layer.shadowOpacity = 0.65
//        //        self.layer.cornerRadius = 1
//        self.clipsToBounds = true
//        self.layer.masksToBounds = false
//        self.layer.masksToBounds = false
    }
}
