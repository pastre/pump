//
//  TabBarViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 30/12/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var isLogged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateVcState()
        self.tabBarController?.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        self.updateVcState()
        
        return true
    }
    
    func updateVcState() {
        
        if Auth.auth().currentUser == nil {
            self.setDisloged()
        } else {
            self.setLoggedIn()
        }
    }
    
    func setDisloged() {
        if !self.isLogged { return }
        let vcNames = ["main", "registros", "main"]
        self.updateVcs(names: vcNames)
        self.isLogged = false
    }
    
    func setLoggedIn() {
        if self.isLogged { return }
        let vcNames = ["perfil", "registros", "sinais"]
        self.updateVcs(names: vcNames)
        self.isLogged = true
    }
    
    func updateVcs(names vcNames: [String]){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vcs = vcNames.map { (vcName) -> UIViewController in
            return storyboard.instantiateViewController(withIdentifier: vcName)
        }
        
        self.setViewControllers(vcs, animated: false)
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
