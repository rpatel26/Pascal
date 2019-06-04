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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        
        if textField == self.card_number_textfield{
            return count <= 16
        }
        else if textField == self.month_textfield{
            return count <= 4
        }
        else if textField == self.cvc_textfield{
            return count <= 3
        }
        else{
            return count <= 5
        }
    }
    
    @IBAction func back_button(_ sender: Any) {
        if current_page == CURRENT_PAGE.PAYMENT{
            let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "payment")
            self.present(viewController, animated: true, completion: nil)
        }
        else if current_page == CURRENT_PAGE.RENT{
            let storyboard = UIStoryboard(name: "Renting", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "select_payment")
            self.present(viewController, animated: true, completion: nil)
        }
        else{
            // do nothing
        }
    }
    
    @IBAction func done_button_clicked(_ sender: Any) {
        if self.card_number_textfield.text?.count == 16 && self.month_textfield.text?.count == 4 && self.cvc_textfield.text?.count == 3 && self.zip_code_textfield.text?.count == 5{
            
            // save card information
            let card_number = self.card_number_textfield.text!
            let month = self.month_textfield.text!
            let cvc = self.cvc_textfield.text!
            let zip = self.zip_code_textfield.text!
            
            User.instance.saveCardInfo(card_number: card_number, month: month, CVC: cvc, zip: zip, success: {
                // success
                if current_page == CURRENT_PAGE.PAYMENT{
                    let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "payment")
                    self.present(viewController, animated: true, completion: nil)
                }
                else if current_page == CURRENT_PAGE.RENT{
                    let storyboard = UIStoryboard(name: "Renting", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "select_payment")
                    self.present(viewController, animated: true, completion: nil)
                }
                else{
                    // do nothing
                }
            }) {
                // failure to store card info
                let alert = UIAlertController(title: "Error", message: "Cannot Save Card Information.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
           
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Invalid credit card information.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
       
    }
    

}
