//
//  User.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum CURRENT_PAGE{
    case PAYMENT
    case RENT
    case NONE
}

var current_page = CURRENT_PAGE.NONE

class User{
    
    static let instance = User()
    
    var firstName: String!
    var lastName: String!
    var phone: String!
    var email: String!
    var password: String!
    var age: String!
    var uuid: String!
    var card_object: [[String: String]]!
    var startRentTime: String!
    
    private var db: Firestore!
    
    init() {
        firstName = nil
        lastName = nil
        phone = nil
        email = nil
        password = nil
        age = nil
        uuid = nil
        card_object = nil
        startRentTime = nil
        
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
                
                if let cards = data!["Cards"] {
                    self.card_object = (cards as! [[String: String]])
                }
//                print("data = ", data)
//                print("data[Cards] = ", data!["Card"])
                success()
            }
        }
    }
    
    func saveCardInfo(card_number: String, month: String, CVC: String, zip: String, success: @escaping () -> (), failure: @escaping () -> ()){
        

        let card = ["Card #": card_number, "Month": month, "CVC": CVC, "Zip Code": zip]
        if self.card_object == nil{
            self.card_object = [[String:String]]()
        }
        self.card_object.append(card)
        
        self.db.collection("User").document(self.uuid).setData([
            "Cards": card_object!
        ], merge: true) { (err) in
            // do nothing
            if err != nil{
                failure()
            }
            success()
        }
    }
    
    func saveStartRentTime(rentTime: String, success: @escaping () -> (), failure: @escaping () -> ()){
        self.startRentTime = rentTime
        self.db.collection("User").document(self.uuid).setData([
            "Start Rent Time": self.startRentTime!
        ], merge: true) { (err) in
            if err != nil{
                failure()
            }
            success()
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

func get_current_time() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    //        let seconds = calendar.component(.second, from: date)
    
    var current_hour = ""
    
    if hour < 10 {
        current_hour = String("0") + String(hour)
    }
    else if hour > 12 {
        current_hour = String(hour - 12)
    }
    else{
        current_hour = String(hour)
    }
    
    let current_minute = minutes < 10 ? String("0") + String(minutes) : String(minutes)
    //        let current_seconds = seconds < 10 ? String("0") + String(seconds) : String(seconds)
    
    //        let current_time = String(current_hour) + ":" + String(current_minute) + ":" + String(current_seconds)
    
    var current_time = ""
    current_time = String(current_hour) + ":" + String(current_minute)
    
    if hour >= 12 {
        current_time = current_time + " PM"
    }
    else{
        current_time = current_time + " AM"
    }
    
    return current_time
}

//func findDateDiff(time1Str: String, time2Str: String) -> String {
//    let timeformatter = DateFormatter()
//    timeformatter.dateFormat = "hh:mm a"
//
//    guard let time1 = timeformatter.date(from: time1Str),
//        let time2 = timeformatter.date(from: time2Str) else { return "" }
//
//    //You can directly use from here if you have two dates
//
//    let interval = time2.timeIntervalSince(time1)
//    var hour = interval / 3600;
//    let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
//    let intervalInt = Int(interval)
//
//    hour += 1
//    return String(Int(hour))
////    return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
//}

func findDateDiff(time1Str: String, time2Str: String) -> Int {
    let timeformatter = DateFormatter()
    timeformatter.dateFormat = "hh:mm a"
    
    guard let time1 = timeformatter.date(from: time1Str),
        let time2 = timeformatter.date(from: time2Str) else { return 0 }
    
    //You can directly use from here if you have two dates
    
    let interval = time2.timeIntervalSince(time1)
    var hour = interval / 3600;
    let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
    let intervalInt = Int(interval)
    
    hour += 1
    return Int(hour)
    //    return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
}
