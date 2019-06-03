//
//  CurrentStatusViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class CurrentStatusViewController: UIViewController {
    @IBOutlet weak var stop_renting_button: UIButton!
    @IBOutlet weak var current_hour_label: UILabel!
    @IBOutlet weak var payment_label: UILabel!
    
    @IBOutlet weak var bluetooth_view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stop_renting_button.customize_button()
        bluetooth_view.backgroundColor = .clear
        bluetooth_view.layer.borderWidth = 2
        bluetooth_view.layer.borderColor = UIColor.white.cgColor
        bluetooth_view.layer.cornerRadius = bluetooth_view.frame.height / 2
    }
    
    @IBAction func stop_renting_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }

}
