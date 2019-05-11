//
//  ViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/11/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For google sign in
        Authenticate.instance.global_google_uiDeletage = self
        
//        Authenticate.instance.register_user(email: "enmurill@ucsd.edu", passWord: "rick_g", success: {
//            print("user registration successful")
//        }) {
//            print("failed to register user")
//        }
    }


    @IBAction func google_sign_in(_ sender: Any) {

        Authenticate.instance.authenticate_google_signIn {
            if Authenticate.instance.google_sign_in_success {
                // successfull sign in via google account
                print("successfull sign in via google account")
            }
            else{
                // unsuccessfull sign in via google account
                print("unsuccessfull sign in via google account")
            }
        }
    }
    
    
}

