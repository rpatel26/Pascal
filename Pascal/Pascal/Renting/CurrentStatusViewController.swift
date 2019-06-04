//
//  CurrentStatusViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit
import CoreBluetooth

class CurrentStatusViewController: UIViewController, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // do nothing...
    }
    
    
    @IBOutlet weak var stop_renting_button: UIButton!
    @IBOutlet weak var current_hour_label: UILabel!
    @IBOutlet weak var payment_label: UILabel!
    
    @IBOutlet weak var bluetooth_view: UIView!
    @IBOutlet weak var connection_status_label: UILabel!
    
    
    fileprivate func customize_bluetooth_view() {
        bluetooth_view.backgroundColor = .clear
        bluetooth_view.layer.borderWidth = 2
        bluetooth_view.layer.borderColor = UIColor.white.cgColor
        bluetooth_view.layer.cornerRadius = bluetooth_view.frame.height / 2
    }
    
    var manager:CBCentralManager = CBCentralManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        
        stop_renting_button.customize_button()
        customize_bluetooth_view()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(bluetooth_view_tapped(sender:)))
        bluetooth_view.addGestureRecognizer(gesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.view) else { return }
        if bluetooth_view.frame.contains(point){
            bluetooth_view.backgroundColor = UIColor.purple
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bluetooth_view.backgroundColor = .clear
    }
    
    @objc func bluetooth_view_tapped2(sender: UILongPressGestureRecognizer){
        if sender.state == .ended {
            print("up")
            bluetooth_view.backgroundColor = .clear
        }
    }
    
    @objc func bluetooth_view_tapped(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            bluetooth_view.backgroundColor = .clear
            //        let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)! as URL
            //        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }

    }
    
    @IBAction func stop_renting_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }

}
