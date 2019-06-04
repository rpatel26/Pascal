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

    var start_rent_time: String!
    var usage_hour: Int!
    var timer_: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
                
        stop_renting_button.customize_button()
        customize_bluetooth_view()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(bluetooth_view_tapped(sender:)))
        bluetooth_view.addGestureRecognizer(gesture)
        
        start_rent_time = User.instance.startRentTime
        usage_hour = findDateDiff(time1Str: self.start_rent_time, time2Str: get_current_time())
        calculatePayment()
        self.current_hour_label.text = "Current Hours: " + String(usage_hour)
        
        
        timer_ = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { (timer) in
            
            self.usage_hour = findDateDiff(time1Str: self.start_rent_time, time2Str: get_current_time())
            self.current_hour_label.text = "Current Hours: " + String(self.usage_hour)
            self.calculatePayment()
        }
    }
    
    func calculatePayment(){
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let payment = Double(self.usage_hour) * 1.50
        self.payment_label.text = "Payment: $" + formatter.string(from: NSNumber(value: payment))!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear...")
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
            let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)! as URL
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }

    }
    
    @IBAction func stop_renting_button_clicked(_ sender: Any) {
        timer_.invalidate()
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }

}
