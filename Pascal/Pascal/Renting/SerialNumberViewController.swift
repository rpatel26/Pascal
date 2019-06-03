//
//  SerialNumberViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class SerialNumberViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var serial_number: UITextField!
    @IBOutlet weak var next_button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // to change view when keyboard appeards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        serial_number.delegate = self
        
        next_button.customize_button()
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
        if textField == serial_number{
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
        return count <= 4
    }
    
    @IBAction func next_button_clicked(_ sender: Any) {
        // TODO: check for valid code entry...
        let storyboard = UIStoryboard(name: "Renting", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "select_payment")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: true, completion: nil)
    }
    
}
