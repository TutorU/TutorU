//
//  LoginViewController.swift
//  TutorU
//
//  Created by Nick McDonald on 2/28/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        User.signInUserWithUsername(self.usernameTextField.text!, withPassword: self.passwordTextField.text!, success: { (signedInUser: User?) in
            // Code
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateInitialViewController()
            self.present(mainViewController!, animated: true, completion: nil)
        }) { (error: Error?) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }
    
}

