//
//  MonthTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 24/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class MonthTableViewController: FirebaseTableViewController {
    
    override func viewDidLoad() {
        self.segueId = super.noSegue
        self.ref = Database.database().reference().child("/months")
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.checkAdmin()
    }
    
    func checkAdmin(){
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("users/\(uid)")
        ref.observeSingleEvent(of: .value, with: {
            (snap) in
            print("Vale", snap.value)
            let user = snap.value as! NSDictionary
            let isAdmin = (user["isAdmin"] as! Bool)
            if isAdmin  {
                self.enableAdmin()
            }
//            self.enableAdmin()
        })
    }
    
    func enableAdmin(){
        let btt = UIBarButtonItem(title: "Admin", style: .plain, target: self, action: #selector(self.presentAdmin))
//        btt.title = "asd"
        self.navigationItem.rightBarButtonItem = btt
    }
    
    @objc func presentAdmin(){
        self.performSegue(withIdentifier: "adminLog", sender: "admin")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthCell", for: indexPath) as!  ProfitTableViewCell
        let data = self.dataToDisplay[indexPath.item]
        
        cell.title.text = data.name
        cell.profit.text = data.profit ?? "..."
        cell.data = (data as! BaseFirebaseRef)
        cell.path = "/months/\(data.key!)"
//        cell.accessoryType = .disclosureIndicator
//        cell.setEdit()
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is String{
            return
        }
        let cell = sender as! ProfitTableViewCell
        let dest = segue.destination as! WeekTableViewController
        
        dest.month = cell.data
        dest.navigationItem.title = Constants.MONTH_ACR.keys.contains(cell.data!.name.uppercased()) ? Constants.MONTH_ACR[cell.data!.name.uppercased()] : cell.data!.name
    }
}
