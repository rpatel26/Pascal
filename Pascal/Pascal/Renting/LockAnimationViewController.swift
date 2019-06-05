//
//  LockAnimationViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 6/4/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit
import Lottie

class LockAnimationViewController: UIViewController {
    var lottie_animation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        lottie_animation = AnimationView(name: "data")
        lottie_animation.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.view.addSubview(lottie_animation)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        print("view did load....")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playAnimation()
    }
    
    func playAnimation(){
        lottie_animation.contentMode = .scaleAspectFill
        lottie_animation.play { (err) in
            let storyboard = UIStoryboard(name: "Renting", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "current_pascal_status")
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
}
