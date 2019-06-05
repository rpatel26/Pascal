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
    @IBOutlet weak var loading_animation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        lottie_animation = AnimationView(name: "ice_cream_animation")
        lottie_animation.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        loading_animation.backgroundColor = UIColor.clear
        
        self.view.addSubview(lottie_animation)
        self.view.backgroundColor = UIColor(red: 59/255, green: 18/255, blue: 81/255, alpha: 1)
        print("view did load....")
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
