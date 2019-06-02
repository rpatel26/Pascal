//
//  WriteToDatabase.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class WriteToDatabase{
    static let instance = WriteToDatabase()
    
    // reference to the firestore database
    var db:Firestore!

    init() {
        db = Firestore.firestore()
    }
    
    func create_new_user(user: User, success: @escaping () -> (), failure: @escaping () -> ()){
        self.db.collection("Users").document(user.uuid).setData([
            "UUID": user.uuid,
            "First Name": user.firstName,
            "Last Name": user.lastName,
            "Age": user.age,
            "Email": user.email,
            "Phone": user.phone
        ], merge: true) { (err) in
            if err != nil{
                failure()
            }
            success()
        }
    }
}
