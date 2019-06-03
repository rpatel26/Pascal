//
//  SignUpViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstname_textfield: UITextField!
    @IBOutlet weak var lastname_textfield: UITextField!
    @IBOutlet weak var email_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    @IBOutlet weak var phone_textfield: UITextField!
    @IBOutlet weak var age_textfield: UITextField!
    @IBOutlet weak var signup_button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to change view when keyboard appeards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        firstname_textfield.delegate = self
        lastname_textfield.delegate = self
        email_textfield.delegate = self
        password_textfield.delegate = self
        phone_textfield.delegate = self
        age_textfield.delegate = self

        
        signup_button.customize_button()
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
        if textField == firstname_textfield {
            lastname_textfield.becomeFirstResponder()
        }
        else if textField == lastname_textfield{
            age_textfield.becomeFirstResponder()
        }
        else if textField == age_textfield{
            phone_textfield.becomeFirstResponder()
        }
        else if textField == phone_textfield{
            email_textfield.becomeFirstResponder()
        }
        else if textField == email_textfield{
            password_textfield.becomeFirstResponder()
        }
        else if textField == password_textfield{
            self.view.endEditing(true)
            signup_button_clicked(self)
        }
        return true
    }
    
    @IBAction func signup_button_clicked(_ sender: Any) {
        self.view.endEditing(true)
        
        if let firstName = firstname_textfield.text, let lastName = lastname_textfield.text, let email = email_textfield.text, let phone = phone_textfield.text, let age = age_textfield.text, let password = password_textfield.text{
            
            User.instance.firstName = firstName
            User.instance.lastName = lastName
            User.instance.email = email
            User.instance.password = password
            User.instance.phone = phone
            User.instance.age = age
            
            User.instance.registerUser(success: {
                // success registering user
                User.instance.storeUserInfo(success: {
                    // success storing user info
                    let alert = UIAlertController(title: "Success", message: "An email has been sent to \(email). Please follow the instructions in the verifcation email to finish creating your account.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
                        //
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "launch_screen")
                        self.present(viewController, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }, failure: {
                    // failed to store user info
                    let alert = UIAlertController(title: "Error", message: "Failed to create a new user.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true)
                })
            }) {
                // failed to register user
                let alert = UIAlertController(title: "Error", message: "Failed to create a new account.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
        else{
            // Not all field is entered
            let alert = UIAlertController(title: "Error", message: "Make sure all of the textfield are not empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
