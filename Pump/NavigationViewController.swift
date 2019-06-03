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
    @IBOutlet weak var signalWarningLabel: UILabel!
    
    var userSignalTimestamp: Date?
    var canReceiveSignals: Bool!
    
    override func viewDidLoad() {
        self.canReceiveSignals = false
        self.signalWarningLabel.alpha = 0
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.drawLines()
        self.setupUser()
        self.updateSignalState()
    }
    
    func setupUser(){
        let user = Auth.auth().currentUser!
        Database.database().reference().child("users").child(user.uid).observe(.value) { (data) in
            let asDict = data.value as! NSDictionary
            let timestamp = asDict["signalDeadline"] as! Double
            User.instance.isAdmin = (asDict["isAdmin"] as! Bool)
            self.userSignalTimestamp = Date(timeIntervalSince1970: timestamp)
            
            self.updateSignalState()
        }
    }
    
    func updateSignalState(){
        let enabledImage = UIImage(named: "sinais")!
        let disabledImage = UIImage(named: "disabledSignal")!
        guard let timestamp = self.userSignalTimestamp else {
            self.signalButton.setImage(disabledImage, for: .normal)
            return
        }
        if timestamp < Date(){
            self.signalButton.setImage(disabledImage, for: .normal)
        }else {
            self.signalButton.setImage(enabledImage, for: .normal)
        }
    }
    
    @IBAction func onSignals(_ sender: Any) {
        guard let timestamp = self.userSignalTimestamp else {
            self.invalidSignalTimestamp()
            return 
        }
        if  timestamp > Date(){
            self.performSegue(withIdentifier: "signalSegue", sender: sender)
        } else {
            self.invalidSignalTimestamp()
        }
    }
    
    func invalidSignalTimestamp(){
        self.signalWarningLabel.alpha = 1
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
            self.signalWarningLabel.alpha = 0
        }, completion: nil)
        print("Deu ruim no timestamp")
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
