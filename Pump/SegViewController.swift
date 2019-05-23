//
//  SegViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class SegViewController: UIViewController {

    @IBOutlet weak var seg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let normalColor = #colorLiteral(red: 0.8756146891, green: 0.8756146891, blue: 0.8756146891, alpha: 1)
        let clearColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        seg.tintColor = clearColor
        seg.backgroundColor = clearColor
        
        seg.setTitleTextAttributes([ .foregroundColor: normalColor, .backgroundColor: clearColor], for: .normal)
        
        
        seg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor, NSAttributedString.Key.backgroundColor: UIColor.clear], for: .selected)
        
        seg.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onChange(_ sender: Any) {
        let op = seg.selectedSegmentIndex
        
        
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
