//
//  FirstPageViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: false, completion: nil)
    }
    

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                let storyboard = UIStoryboard(name: "HowToRent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "connect_your_phone")
                self.present(viewController, animated: false, completion: nil)
            default:
                break
            }
        }
    }
}
