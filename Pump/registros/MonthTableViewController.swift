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


class MonthTableViewController: FirebaseTableViewController {
    
    override func viewDidLoad() {
        self.segueId = "showWeek"
        self.ref = Database.database().reference().child("/months")
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let cell = sender as! ProfitTableViewCell
        let dest = segue.destination as! WeekTableViewController
        
        dest.month = cell.data
    }
}
