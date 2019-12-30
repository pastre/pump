//
//  TabBarViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 30/12/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseAuth

let kUPDATE_TABBAR = Notification.Name("updteTabBar")

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var isLogged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        self.updateVcState()

        NotificationCenter.default.addObserver(self, selector: #selector(self.onRemoteUpdate), name: kUPDATE_TABBAR, object: nil)
    }
    
    @objc func onRemoteUpdate() {
        self.updateVcState()
    }
    
    override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        self.updateVcState()
        
        super.tabBar(tabBar, willBeginCustomizing: items)
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
        
        let vcNames = ["main", "registros", "main"]
        self.updateVcs(ids: vcNames)
        self.isLogged = false
    }
    
    func setLoggedIn() {
        if self.isLogged { return }
        let vcNames = ["perfil", "registros", "sinais"]
        self.updateVcs(ids: vcNames)
        self.isLogged = true
    }
    
    func updateVcs(ids vcIds: [String]){
        print("Setting views to ", vcIds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let names = ["Perfil", "Registros", "Sinais"]
        let vcs = vcIds.map { (vcId) -> UIViewController in
            let vc = storyboard.instantiateViewController(withIdentifier: vcId)
            let vcName = names[vcIds.firstIndex(of: vcId)!]
            vc.tabBarItem = UITabBarItem(title: vcName, image: nil, selectedImage: nil)
            return vc
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
