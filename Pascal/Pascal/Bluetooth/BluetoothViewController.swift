//
//  BluetoothViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/27/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class BluetoothViewController: UIViewController {

    var bluetoothManager: BluetoothManager!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("bluetooth view did load...")
        
        bluetoothManager = BluetoothManager()
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
