//
//  LaunchScreenViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/19/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    var lottie_animation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        lottie_animation = AnimationView(name: "loading_animation")
        lottie_animation.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.view.addSubview(lottie_animation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playAnimation()
    }
    
    func playAnimation(){
        lottie_animation.contentMode = .scaleAspectFill
        lottie_animation.play { (err) in
            self.performSegue(withIdentifier: "lottie_to_main", sender: self)
        }
    }
}
