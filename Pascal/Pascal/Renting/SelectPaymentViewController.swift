//
//  SelectPaymentViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class SelectPaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == user_card_object.count{
            return 50
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return user_card_object.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == user_card_object.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "add_a_card") as! AddACardTableViewCell
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "card_number") as! CardNumberTableViewCell
            let card = user_card_object[indexPath.section]
            let card_number = card["Card #"]!
            cell.card_number_label.text = "**** **** **** " + String(card_number.suffix(4))
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == user_card_object.count{
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == user_card_object.count{
            current_page = CURRENT_PAGE.RENT
            let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "payment_screen")
            self.present(viewController, animated: true, completion: nil)
        }
        else{
            self.selected_payment_index = indexPath.section
        }
    }
    

    @IBOutlet weak var card_tables: UITableView!
    @IBOutlet weak var confirm_button: UIButton!
    
    var user_card_object = [[String: String]]()
    var selected_payment_index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        card_tables.delegate = self
        card_tables.dataSource = self
        card_tables.alwaysBounceVertical = false
        
        confirm_button.customize_button()
        
        
        if User.instance.card_object != nil{
            user_card_object = User.instance.card_object
        }
        
        card_tables.reloadData()
        selected_payment_index = -1
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "Renting", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "rent_a_pascal")
        self.present(viewController, animated: true, completion: nil)
    }
 
    @IBAction func confirm_button_clicked(_ sender: Any) {
        if self.selected_payment_index != -1 {
            User.instance.saveStartRentTime(rentTime: get_current_time(), success: {
                // success
                
                User.instance.storeInUser(inUse: true, success: {
                    // store success
                    let storyboard = UIStoryboard(name: "Renting", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "unlock_animation")
                    self.present(viewController, animated: true, completion: nil)
                }, failure: {
                    // store failure
                })
                
               
            }) {
                // failure
                let alert = UIAlertController(title: "Error", message: "Having trouble connecting to database.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
          
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Must select a payment method.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
