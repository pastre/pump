//
//  FirstViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 02/06/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NavigationViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var registroButton: UIButton!
    @IBOutlet weak var signalButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.drawLines()
        self.setupUser()
        
    }
    
    func setupUser(){
        let user = Auth.auth().currentUser!
        Database.database().reference().child("users").child(user.uid).child("isAdmin").observeSingleEvent(of: .value) { (data) in
            User.instance.isAdmin = data.value as! Bool
        }
    }
    
    func drawLines(){
        let c = logoImageView.center
        
        self.addLine(fromPoint: c, toPoint: self.profileButton.center)
        self.addLine(fromPoint: c, toPoint: self.registroButton.center)
        self.addLine(fromPoint: c, toPoint: self.signalButton.center)
        
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        line.lineWidth = 1
        line.lineJoin = CAShapeLayerLineJoin.round
        //        self.view.layer.addSublayer(line)
        self.view.layer.insertSublayer(line, below: self.logoImageView.layer)
        //        self.view.layer.below
    }
    
}
