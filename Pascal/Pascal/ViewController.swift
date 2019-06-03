//
//  ViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/11/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pascal_logo: UIImageView!
    @IBOutlet weak var email_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    
    @IBOutlet weak var forgot_password_button: UIButton!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var signup_button: UIButton!
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.white,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        global_viewController = self
        
        // to change view when keyboard appeards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        email_textfield.delegate = self
        password_textfield.delegate = self
        
        login_button.customize_button()
        signup_button.customize_button()
        
        let attributeString = NSMutableAttributedString(string: "Forgot Password",
                                                        attributes: yourAttributes)
        forgot_password_button.setAttributedTitle(attributeString, for: .normal)
        
        Authenticate.instance.isUserLoggedIn(success: {
            // user is logged in...sign in user
            let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
            self.present(viewController, animated: false, completion: nil)
        }) {
            // do nothing if user not logged in
        }
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
        if textField == password_textfield{
            log_in_button_clicked(self)
        }
        else if textField == email_textfield{
            password_textfield.becomeFirstResponder()
        }
        return true
    }
    
    @IBAction func log_in_button_clicked(_ sender: Any) {
        // login button clicked
        email_textfield.resignFirstResponder()
        password_textfield.resignFirstResponder()
        startActivityIndicator()
        
        if let email = email_textfield.text, let password = password_textfield.text {
            Authenticate.instance.authenticate_user_login(email: email, passWord: password, success: {
                print("log in successful...")
                stopActivityIndicator()
                let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
                self.present(viewController, animated: false, completion: nil)
            }) {
                print("failed login...")
                stopActivityIndicator()
                let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        else{
            print("Email or Password Text Field Cannot be empty!!!....")
            stopActivityIndicator()
            let alert = UIAlertController(title: "Error", message: "Email or Password Text Field Cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func button_clicked(_ sender: Any) {
        startActivityIndicator()
        Authenticate.instance.authenticate_user_login(email: "dtheokar@ucsd.edu", passWord: "pascal", success: {
            print("log in successful...")
            stopActivityIndicator()
            let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
            self.present(viewController, animated: false, completion: nil)
        }) {
            print("failed login...")
            stopActivityIndicator()
            UserDefaults.standard.set(false, forKey: "userLoggedIn")
            
            let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}


extension UITextField{
    
    override open func draw(_ rect: CGRect){
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 4.0
        
        tintColor = UIColor.white
        tintColor.setStroke()
        
        path.stroke()
        textColor = UIColor.white
        borderStyle = .none
    }
}

extension UIButton{
    func customize_button(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.backgroundColor = UIColor.white.cgColor
        self.setTitleColor(UIColor.gray, for: .normal)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowColor = UIColor(red: (0x48/255), green: (0x48/255), blue: CGFloat(0x48/255), alpha: 1.0).cgColor
    }
}


