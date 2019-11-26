//
//  RegisterPageViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userEmailtextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        let username = usernameTextField.text
        let email = userEmailtextField.text
        let password = userPasswordTextField.text
        let confirmPassword = repeatPasswordTextField.text
        
        // Check for empty field
        if let email = email, let password = password, let confirmPassword = confirmPassword, let username = username, username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            displayAlertMessage(vc: self, message: "Все поля обязательно должны быть заполнены")
            return
        }
        
        // Check if passwords match
        if password != confirmPassword {
            displayAlertMessage(vc: self, message: "Пароли не совпадают")
        }
        
        self.showSpinner(onView: self.view)
        let register = RegisterValidation(username: username!, email: email!, password: password!, passwordConfirmation: confirmPassword!)
        RequestBuilder.shared.validateRegister(register: register) { (result) in
            result.code == 200 ? self.continueRegisterRedirect(register: register): DispatchQueue.main.async {
                displayAlertMessage(vc: self, message: result.message)
                self.removeSpinner()
            }
        }
    }
    
    
    private func continueRegisterRedirect(register: RegisterValidation) {
        DispatchQueue.main.async {
            self.removeSpinner()
            let vc = FinalRegisterViewController(nibName: "FinalRegisterViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true, completion: nil)
            vc.setupRegister(registerValid: register)
        }
    }
}
