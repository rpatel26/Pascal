//
//  Authenticate.swift
//  Pascal
//
//  Created by Ravi Patel on 5/11/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// global DispatchGroup for thread control
let global_dispatchGroup = DispatchGroup()
func run(completion: @escaping() -> Void)
{
    DispatchQueue.main.async{
        completion()
    }
}


class Authenticate{
    static let instance = Authenticate()
    
    
    func isUserLoggedIn(success: @escaping () -> (), failure: @escaping () -> ()){
        if Auth.auth().currentUser != nil{
            success()
        }
        else{
            failure()
        }
    }
    
    func signOutUser(success: @escaping () -> (), failure: @escaping () -> ()){
        do {
            try Auth.auth().signOut()
            success()

        }catch let signOutError as NSError{
            print ("Error signing out: %@", signOutError)
            failure()
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // For user registration
    var registration_isValid:Bool = false
    func register_user(email: String, passWord: String, success: @escaping () -> (), failure: @escaping () -> ())
    {
        Auth.auth().createUser(withEmail: email, password: passWord) { (user, error) in
            // error creating new user
            if let err = error{
                print("error creating new user = ", err)
                failure()
            }
            else{
                if let _ = Auth.auth().currentUser{
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        // cound not send email verification
                        if let err = error{
                            print("error sending email verification = ", err)
                            failure()
                        }
                        else{
                            User.instance.uuid = Auth.auth().currentUser?.uid
                            success()
                        }
                    })
                }
                else{
                    // user alread in the database, cannot recreate user
                    print("error: user alread in the database, cannot recreate user")
                    failure()
                }
            }
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // For user authentication
    func authenticate_user_login(email: String, passWord: String, success: @escaping () -> (), failure: @escaping () -> ())
    {
        Auth.auth().signIn(withEmail: email, password: passWord) { (user, error) in
            if let _ = error{
                failure()
            }
            else{
                print("auth success")
                // check if user has verified their email
                if let user = Auth.auth().currentUser{
                    if !user.isEmailVerified{
                        failure()
                    }
                    else {
                        print("userid = ", user.uid)
                        User.instance.uuid = user.uid
                        User.instance.getUserInfo(UID: user.uid, success: {
                            // success
                            success()
                        }, failure: {
                            // failure
                            failure()
                        })
                    }
                }

            }
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // For sending password reset link
    func send_password_reset_link(email: String, success: @escaping () -> (), failure: @escaping () -> ()){
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            // error sending password reset link
            if error != nil{
                failure()
            }
            else{
                // password reset link send
                success()
            }
        }
    }
}
