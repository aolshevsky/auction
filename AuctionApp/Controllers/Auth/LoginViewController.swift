//
//  LoginViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var useremailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = useremailTextField.text
        let userPassword = userPasswordTextField.text
        
        if checkUserByUserEmailPassword(email: userEmail!, password: userPassword!) {
            displaySuccessMessage(vc: self, message: "You are authorized")
        }
    }
    
    
    func checkUserByUserEmailPassword(email: String, password: String) -> Bool{
        return true;
    }
}
