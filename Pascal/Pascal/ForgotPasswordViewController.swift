//
//  ForgotPasswordViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email_textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

//        Authenticate.instance.send_password_reset_link(email: "dtheokar@ucsd.edu", success: {
//            print("email send successfull")
//        }) {
//            print("Could not send email. Make sure email is valid")
//        }
        
        // to change view when keyboard appeards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        email_textfield.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touched anywhere on screen begain
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touched anywhere on screen ended
        self.view.endEditing(true)
    }
    
    // objective-c function for when keyboard appears
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -(self.view.frame.width * 0.22)
    }
    
    // objective-c function for when keyboard disappear
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // when hitting enter on the textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        send_button_clicked(self)
        return true
    }
    
    @IBAction func send_button_clicked(_ sender: Any) {
        email_textfield.resignFirstResponder()
        if let email = email_textfield.text{
            Authenticate.instance.send_password_reset_link(email: email, success: {
                print("email send successfull")
                let alert = UIAlertController(title: "Success", message: "Email send successfull", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }) {
                print("Could not send email. Make sure email is valid")
                let alert = UIAlertController(title: "Error", message: "Could not send email. Make sure email is valid", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
}
