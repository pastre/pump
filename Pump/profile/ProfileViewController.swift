//
//  ProfileViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 27/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import StoreKit
import FirebaseDatabase
import FirebaseAuth


class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate{

    
    let products = ["Trintad": 30, "Sessentad": 60, "Noventad": 90]
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var validDateLabel: UILabel!

    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buyingActivityIndicator: UIActivityIndicatorView!
    
    lazy var user = Auth.auth().currentUser!
    
    var offers: [Offer]!
    var validThrough: Date!
   
    // MARK: - Setup methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.offers = [Offer]()
        
        self.offersTableView.dataSource = self
        self.offersTableView.delegate = self
        SKPaymentQueue.default().add(self)
        
        self.setupName()
        self.setupUser()
        self.setupProfilePic()
        self.setupProductRequest()
        self.setupLogoutButton()
        
        let queue = SKPaymentQueue.default();
        var tr = queue.transactions.count
        print("I have", tr, "transactions on hold")
        queue.transactions.forEach {
            print("Clearing", $0)
            queue.finishTransaction($0) }
        tr = queue.transactions.count
        print("I have", tr, "transactions on hold")

    }

    override func viewWillDisappear(_ animated: Bool) {
        
        SKPaymentQueue.default().remove(self)
    }
    
    func setupLogoutButton(){
        
        let item = UIBarButtonItem(title: "Sair", style: .plain, target: self, action:  #selector(self.onLogout(_:)))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func onLogout(_ action: Any?){
        self.buyingActivityIndicator.startAnimating()
        do {
            try Auth.auth().signOut()
//            self.navigationController?.popToRootViewController(animated: true)
            self.view.window!.rootViewController!.dismiss(animated: true, completion: nil)
            self.buyingActivityIndicator.stopAnimating()
        } catch let error {
            print("Error on logout", error)
            self.buyingActivityIndicator.stopAnimating()
        }
    }
    
    func setupProductRequest(){
        let request = SKProductsRequest(productIdentifiers: Set<String>(self.products.keys))
        request.delegate = self
        request.start()
        
    }
    
    func setupUser(){
        Database.database().reference().child("users").child(user.uid).observe(.value) { (snap) in
            let asDict = snap.value as! NSDictionary
            self.phoneLabel.text = (asDict["phone"] as! String)
            let timestamp = Date(timeIntervalSince1970: asDict["signalDeadline"] as! Double)
            self.validThrough = timestamp
            if timestamp < Date(){
                self.validDateLabel.text = "Para receber sinais, compre algum pacote"
            } else {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "pt_BR")
                formatter.setLocalizedDateFormatFromTemplate("dd/MMM/yyyy")
    //            DateFor
                self.validDateLabel.text = "Recebendo sinais até: \n\(formatter.string(from: timestamp))"
            }
        }
    }
    
    func setupName() {
        self.emailLabel.text = self.user.email
        self.nameLabel.text = self.user.displayName
        
//        UIImage(cgImage: <#T##CGImage#>)
        // TODO: Carregar uma imagem e editar ela
//        self.userImageView.image = self.user.ph
    }
    
    func setupProfilePic(){
        self.imageActivityIndicator.startAnimating()
        guard self.user.photoURL != nil else{
            self.userImageView.image = UIImage(named: "defaultUser")
            self.imageActivityIndicator.stopAnimating()
            return
        }
        
    }
    
    func onOfferAdded(snapshot: DataSnapshot){
        let asDict = snapshot.value as! NSDictionary
        let toAppend = Offer(fromDict: asDict)
        
        self.offers.append(toAppend)
        self.offersTableView.reloadData()
    }
    
    // MARK: - Table view methods
    
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
        cell.offer = offer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.buyingActivityIndicator.isAnimating { return }
        
        let row = tableView.cellForRow(at: indexPath) as! OfferTableViewCell
        let product = row.offer.product!
        
        let payment = SKPayment(product: product)
        print("Saca so irmao, dalhe dalhe")
        SKPaymentQueue.default().add(payment)
    }
    
    // MARK: - Payment methods
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Called the delegate")
        self.buyingActivityIndicator.startAnimating()
        for t in transactions{
            print("On queue", t.transactionState.rawValue)
            if t.transactionState != .purchasing{
                if t.transactionState == .purchased{
                    self.onTransactionCompleted(transaction: t)
                }
                queue.finishTransaction(t)
            }
//            SKPaymentQueue.default().finishTransaction(t)
        }
    }
    
    func onTransactionCompleted(transaction: SKPaymentTransaction){
        let pid =  transaction.payment.productIdentifier
        self.upgradeSignalDeadline(add: products[pid]!)
        print("COMPROU PRA BURRO")
    }
    
    func upgradeSignalDeadline(add days: Int){
        
        let calendar = Calendar.current.date(byAdding: .day, value: days, to: self.validThrough)!
        let timestamp = calendar.timeIntervalSince1970
        
        Database.database().reference().child("users").child(user.uid).child("signalDeadline").setValue(timestamp)
        self.buyingActivityIndicator.stopAnimating()
        print("Timestamp is", timestamp, Date().timeIntervalSince1970)
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let prod = response.products
        print("Recebi produtos" , response.products.count)
        for p in prod{
            print(p.localizedDescription, p.localizedTitle, p.price)
            let offer = Offer(name: p.localizedTitle, value: p.price, product: p)
            
            self.offers.append(offer)
            self.offersTableView.reloadData()
        }
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
