//
//  DayTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 24/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DayTableViewController: FirebaseTableViewController {
    
    var month: BaseFirebaseRef!
    var week: BaseFirebaseRef!
    
    override func viewDidLoad() {
        self.segueId = "showDay"
        self.ref = Database.database().reference().child("/months/\(month.key!)/weeks/\(week.key!)/days")
        super.viewDidLoad()
    }
    
    override func generateData(with snap: DataSnapshot) -> BaseFirebaseRef {
        print("Generated based on", snap)
        let month = DayRef(fromDict: snap.value!, key: snap.key)
        
        return month
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as!  DayTableViewCell
        let data = self.dataToDisplay[indexPath.item] as! DayRef
        
        cell.title.text = data.name
        cell.profit.text = data.profit ?? "..."
        cell.firstAction.text = data.message1 ?? "..."
        cell.secondAction.text = data.message2 ?? "..."
        cell.data = (data)
        cell.path = "/months/\(data.key!)"
        //        cell.accessoryType = .disclosureIndicator
        //        cell.setEdit()
        
        return cell
    }

}
