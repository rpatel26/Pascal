//
//  User.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import Foundation

class User{
    
    var firstName: String!
    var lastName: String!
    var phone: String!
    var email: String!
    var age: String!
    var uuid: String!
    
    init() {
        firstName = nil
        lastName = nil
        phone = nil
        email = nil
        age = nil
        uuid = nil
    }
    
    init(firstName: String, lastName: String, phone: String, email: String, age: String, uuid: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.age = age
        self.uuid = uuid
    }
}
