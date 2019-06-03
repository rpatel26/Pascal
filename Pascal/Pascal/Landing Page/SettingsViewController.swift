//
//  SettingsViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/27/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var save_button: UIButton!
    @IBOutlet weak var first_name_textfield: UITextField!
    @IBOutlet weak var last_name_textfield: UITextField!
    @IBOutlet weak var reset_password: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to change view when keyboard appeards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        first_name_textfield.delegate = self
        last_name_textfield.delegate = self

        save_button.customize_button()
        reset_password.customize_button()
        
        if User.instance.firstName != nil{
            first_name_textfield.text = User.instance.firstName
        }
        
        if User.instance.lastName != nil {
            last_name_textfield.text = User.instance.lastName
        }
        
        first_name_textfield.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        last_name_textfield.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        self.view.frame.origin.y = -(self.view.frame.width * 0.5)
    }
    
    // objective-c function for when keyboard disappear
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // when hitting enter on the textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == first_name_textfield{
            last_name_textfield.becomeFirstResponder()
        }
        else if textField == last_name_textfield {
            self.view.endEditing(true)
            
        }
        return true
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func save_button_clicked(_ sender: Any) {
        self.view.endEditing(true)
        
        User.instance.firstName = first_name_textfield.text ?? "Stranger"
        User.instance.lastName = last_name_textfield.text ?? "Stranger"
        User.instance.storeUserInfo(success: {
            // success saving
            let alert = UIAlertController(title: "Saved!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
                // go back to map
                let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
                self.present(viewController, animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }) {
            // unable to save
            let alert = UIAlertController(title: "Error!", message: "Unable to save.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
                // go back to map
                let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
                self.present(viewController, animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }
       
    }
    
    @IBAction func reset_password_button_clicked(_ sender: Any) {
        if User.instance.email != nil{
            Authenticate.instance.send_password_reset_link(email: User.instance.email, success: {
                // password link successfully send
                let alert = UIAlertController(title: "Success", message: "We sent you an email to: \(User.instance.email ?? "nil").\n Follow instructions in the email to reset your password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
                    // go back to map
                    let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
                    self.present(viewController, animated: true, completion: nil)
                }))
                self.present(alert, animated: true)
            }) {
                // password link failed to send
            }
        }
        
    }
    
    
}
