//
//  AdminWeekTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase
class AdminWeekTableViewController: FirebaseTableViewController {

    var month: ChildRef!
    
    override func viewDidLoad() {
        self.ref = Database.database().reference().child("/months/\(month.key!)/weeks")
        super.viewDidLoad()
//        self.addCellId = "addMonth"
//        self.dataCellId = "adminMonthCell"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func generateData(with snap: DataSnapshot) -> BaseFirebaseRef {
        print("Generated based on", snap)
        let month = ChildRef(fromDict: snap.value!, key: snap.key, childKey: "daysRef")
        
        return month
    }
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.dataToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addWeek", for: indexPath) as! AddWeekTableViewCell
            cell.path = "months/\(self.month.key!)/weeks"
//            cell.path = "/weeks/\(self.month)"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminWeekCell", for: indexPath) as! ProfitTableViewCell
        let data = self.dataToDisplay[indexPath.item - 1]
        
        cell.title.text = data.name
        cell.profit.text = data.profit
        return cell
    }
    
}
