//
//  PaymentViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/27/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var card_number_textfield: UITextField!
    @IBOutlet weak var month_textfield: UITextField!
    @IBOutlet weak var cvc_textfield: UITextField!
    @IBOutlet weak var zip_code_textfield: UITextField!
    @IBOutlet weak var done_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to change view when keyboard appeards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        card_number_textfield.delegate = self
        month_textfield.delegate = self
        cvc_textfield.delegate = self
        zip_code_textfield.delegate = self
        
        done_button.customize_button()
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
        if textField == card_number_textfield{
            month_textfield.becomeFirstResponder()
        }
        else if textField == month_textfield{
            cvc_textfield.becomeFirstResponder()
        }
        else if textField == cvc_textfield {
            zip_code_textfield.becomeFirstResponder()
        }
        else if textField == zip_code_textfield {
            self.view.endEditing(true)

        }
        return true
    }
    
    @IBAction func back_button(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func done_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }
    

}
