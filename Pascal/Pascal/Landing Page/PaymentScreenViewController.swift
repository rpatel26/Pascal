//
//  PaymentScreenViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class PaymentScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == user_cards.count{
            return 50
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user_cards.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == user_cards.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "add_a_card_2") as! AddACard2TableViewCell
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "card_number_2") as! CardNumber2TableViewCell
            let card_number = user_cards[indexPath.row]
            print("card number = ", card_number)
            cell.card_number_label.text = "**** **** **** " + String(card_number.suffix(4))
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == user_cards.count{
            current_page = CURRENT_PAGE.PAYMENT
            let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "payment_screen")
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == user_cards.count{
            return true
        }
        return false
    }

    @IBOutlet weak var cards_table_view: UITableView!
    
    var user_cards = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cards_table_view.delegate = self
        cards_table_view.dataSource = self
        
        if User.instance.cards != nil{
            user_cards = User.instance.cards
        }
        
        print("number of cards = ", user_cards.count)
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: false, completion: nil)
    }
    
}
