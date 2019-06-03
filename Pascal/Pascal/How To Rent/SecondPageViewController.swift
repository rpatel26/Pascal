//
//  SecondPageViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/2/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeleft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeleft)
    }
    
    @IBAction func back_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                let storyboard = UIStoryboard(name: "HowToRent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "find_and_unlock")
                self.present(viewController, animated: false, completion: nil)
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                let storyboard = UIStoryboard(name: "HowToRent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "stop_and_return")
                self.present(viewController, animated: false, completion: nil)
            default:
                break
            }
        }
    }

}
