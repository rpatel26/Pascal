//
//  User.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import Foundation
import FirebaseFirestore

class User{
    
    static let instance = User()
    
    var firstName: String!
    var lastName: String!
    var phone: String!
    var email: String!
    var password: String!
    var age: String!
    var uuid: String!
    
    private var db: Firestore!
    
    init() {
        firstName = nil
        lastName = nil
        phone = nil
        email = nil
        password = nil
        age = nil
        uuid = nil
        
        self.db = Firestore.firestore()
    }
    
    func getUserInfo(UID uid: String, success: @escaping () -> (), failure: @escaping () -> ()){
     
        self.db.collection("User").document(uid).getDocument { (snapshot, error) in
            if error != nil {
                failure()
            }
            else{
                let data = snapshot?.data()
                self.firstName = (data!["First Name"] as! String)
                self.lastName = (data!["Last Name"] as! String)
                self.email = (data!["Email"] as! String)
                self.phone = (data!["Phone"] as! String)
                self.age = (data!["Age"] as! String)
                success()
            }
        }
    }
    
    func registerUser(success: @escaping () -> (), failure: @escaping () -> ()) {
        Authenticate.instance.register_user(email: self.email, passWord: self.password, success: {
            // user registration success
            print("success user registration...")
            success()
        }) {
            // user registration failure
            print("failure during user registration...")
            failure()
        }
    }
    
    func storeUserInfo(success: @escaping () -> (), failure: @escaping () -> ()) {
        self.db.collection("User").document(self.uuid).setData([
            "First Name": self.firstName!,
            "Last Name": self.lastName!,
            "Email": self.email!,
            "Phone": self.phone!,
            "Age": self.age!
        ], merge: true) { (err) in
            // do nothing
            if err != nil{
                failure()
            }
            success()
        }
    }
}
