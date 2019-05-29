//
//  ProfileViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 27/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var offersTableView: UITableView!
    
    @IBOutlet weak var validDateLabel: UILabel!

    lazy var user = Auth.auth().currentUser!
    
    var offersRef: DatabaseReference!
    var offers: [Offer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.offers = [Offer]()
        
        self.offersTableView.dataSource = self
        self.offersTableView.delegate = self
        
        self.offersRef = Database.database().reference().child("offers")
        
        offersRef.observe(.childAdded) { (snap) in
            self.onOfferAdded(snapshot: snap)
            
        }
        
        self.setupName()
        self.setupPhoneListener()
        
        // Do any additional setup after loading the view.
    }

    func setupPhoneListener(){
        Database.database().reference().child("users").child(user.uid).observe(.value) { (snap) in
            let asDict = snap.value as! NSDictionary
            self.phoneLabel.text = (asDict["phone"] as! String)
            let timestamp = Date(timeIntervalSince1970: asDict["signalDeadline"] as! Double)
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.setLocalizedDateFormatFromTemplate("dd/MMM/yyyy")
//            DateFor
            self.validDateLabel.text = "Recebendo sinais até: \n\(formatter.string(from: timestamp))"
        }
    }
    
    func setupName() {
        self.emailLabel.text = self.user.email
        self.nameLabel.text = self.user.displayName
//        UIImage(cgImage: <#T##CGImage#>)
        // TODO: Carregar uma imagem e editar ela
//        self.userImageView.image = self.user.ph
    }
    
    func onOfferAdded(snapshot: DataSnapshot){
        let asDict = snapshot.value as! NSDictionary
        let toAppend = Offer(fromDict: asDict)
        
        self.offers.append(toAppend)
        self.offersTableView.reloadData()
    }
    
    // MARK: - Table view delegate/data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell") as! OfferTableViewCell
        let offer = self.offers[indexPath.item]
        cell.nameLabel.text = offer.name
        cell.valueLabel.text = "R$\(Int(offer.value))"
        return cell
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
