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
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = useremailTextField.text
        let userPassword = userPasswordTextField.text
        
        if checkUserByUserEmailPassword(email: userEmail!, password: userPassword!) {
                mainMenuRedirect()
            }
        }
    
    func mainMenuRedirect() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? UITabBarController

        if let vc = vc {
            present(vc, animated: false)
        }
    }

    func checkUserByUserEmailPassword(email: String, password: String) -> Bool{
        return true;
    }
}
