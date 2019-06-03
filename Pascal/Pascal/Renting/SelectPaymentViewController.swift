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
        if indexPath.row == 1{
            return 50
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "add_a_card") as! AddACardTableViewCell
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "card_number") as! CardNumberTableViewCell
            
            return cell
        }
       
    }
    

    @IBOutlet weak var card_tables: UITableView!
    @IBOutlet weak var confirm_button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        card_tables.delegate = self
        card_tables.dataSource = self
        card_tables.alwaysBounceVertical = false
        
        confirm_button.customize_button()
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "Renting", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "rent_a_pascal")
        self.present(viewController, animated: true, completion: nil)
    }
 
    @IBAction func confirm_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "current_pascal_status")
        self.present(viewController, animated: true, completion: nil)
    }
    
}
