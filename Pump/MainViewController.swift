//
//  MainViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 30/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var relatorioButton: UIButton!
    @IBOutlet weak var sinaisButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.drawLines()
    }
    
    func drawLines(){
        
        self.addLine(fromPoint: self.logoImageView.center, toPoint:  self.profileButton.center)
        self.addLine(fromPoint: self.logoImageView.center, toPoint:  self.relatorioButton.center)
        self.addLine(fromPoint: self.logoImageView.center, toPoint:  self.sinaisButton.center)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

extension CGPoint{
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
