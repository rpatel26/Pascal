//
//  MenuBarViewController.swift
//  Pascal
//
//  Created by Ravi Patel on 5/27/19.
//  Copyright © 2019 ECE 140. All rights reserved.
//

import UIKit

class MenuBarViewController: UIViewController {

    var viewWidth: CGFloat!
    var gradient: CAGradientLayer!
    
    @IBOutlet weak var payment_button: UIButton!
    @IBOutlet weak var how_to_rent_button: UIButton!
    @IBOutlet weak var settings_button: UIButton!
    @IBOutlet weak var logout_button: UIButton!
    @IBOutlet weak var welcome_label: UILabel!
    
    
    @IBOutlet weak var menu_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)        
        viewWidth = self.view.bounds.width * 0.65
        customize_menu_view()
        customize_payment_button()
        customize_how_to_rent_button()
        customize_settings_button()
        customize_logout_button()
        
        welcome_label.text = "  Welcome, " + User.instance.firstName
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate_main_view()
    }
    
    private func customize_menu_view(){
        menu_view.frame = CGRect(x: -viewWidth, y: 0, width: viewWidth, height: self.view.bounds.height)
        
        gradient = GradientLayer.instance.getGradient(frame: CGRect(x: 0, y: 0, width: viewWidth, height: self.view.bounds.height))
        menu_view.layer.insertSublayer(gradient, at: 0)
    }

    
    private func customize_payment_button(){
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: menu_view.frame.size.width, height: 1))
        let lineView2 = UIView(frame: CGRect(x: 0, y: payment_button.frame.height, width: menu_view.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.white
        lineView2.backgroundColor = UIColor.white
        payment_button.addSubview(lineView)
        payment_button.addSubview(lineView2)
    }
    
    private func customize_how_to_rent_button(){

        let lineView = UIView(frame: CGRect(x: 0, y: how_to_rent_button.frame.height, width: menu_view.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.white
        how_to_rent_button.addSubview(lineView)
    }
    
    private func customize_settings_button(){
        let lineView = UIView(frame: CGRect(x: 0, y: how_to_rent_button.frame.height, width: menu_view.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.white
        settings_button.addSubview(lineView)
    }
    
    private func customize_logout_button(){
        logout_button.layer.backgroundColor = UIColor.init(red: 140/255, green: 56/255, blue: 182/255, alpha: 1).cgColor
        logout_button.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func animate_main_view(){
        UIView.animate(withDuration: 0.3) {
            self.menu_view.frame.origin.x += self.viewWidth
        }
    }

    
    // when touched anywhere on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // do nothing
        if touches.first!.view != menu_view{
            exit_hamburger_menu()
            
            global_dispatchGroup.notify(queue: .main) {
                let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "landing_page")
                self.present(viewController, animated: false, completion: nil)
            }
        }
    }
    
    private func exit_hamburger_menu(){
        global_dispatchGroup.enter()
        run {
            UIView.animate(withDuration: 0.3, animations: {
                self.menu_view.frame.origin.x -= self.viewWidth
            }, completion: { (didFinish) in
                global_dispatchGroup.leave()
            })
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // do nothing
    }
    
    @IBAction func payment_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "payment_screen")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func settings_button_clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "settings_page")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func logout_button_clicked(_ sender: Any) {
        
        Authenticate.instance.signOutUser(success: {
            // success sign out
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "launch_screen")
            self.present(viewController, animated: true, completion: nil)
        }) {
            // cannot sign out
        }

    }
    
    
}
