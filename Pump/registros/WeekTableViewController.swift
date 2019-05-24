//
//  WeekTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 24/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class WeekTableViewController: FirebaseTableViewController{
    
    var month: BaseFirebaseRef!

    override func viewDidLoad() {
        self.segueId = super.noSegue
        self.ref = Database.database().reference().child("/months/\(month.key!)/weeks")
        super.viewDidLoad()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath) as!  ProfitTableViewCell
        let data = self.dataToDisplay[indexPath.item]
        
        cell.title.text = data.name
        cell.profit.text = data.profit ?? "..."
        cell.data = (data)
        cell.path = "/months/\(data.key!)"
        //        cell.accessoryType = .disclosureIndicator
        //        cell.setEdit()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! ProfitTableViewCell
        let dest = segue.destination as! DayTableViewController
        
        dest.navigationItem.prompt = self.navigationItem.title
        dest.navigationItem.title = cell.data!.name
        
        dest.month = self.month
        dest.week = cell.data
        
    }
}

