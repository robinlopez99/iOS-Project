//
//  LoginViewController.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/3/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "logToTabControllerSegue", sender: nil)
    }
    
    @IBAction func usernameWillEnter(_ sender: Any) {
        usernameField.text = ""
    }
    
    @IBAction func passwordWillEnter(_ sender: Any) {
        passwordField.text = ""
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
