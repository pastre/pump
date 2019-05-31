//
//  WarningViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 31/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class WarningViewController: UIViewController {

    @IBOutlet weak var warningLabel: UILabel!
    
    var message: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.warningLabel.text = self.message
    }
    
    @IBAction func onOk(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
