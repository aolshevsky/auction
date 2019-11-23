//
//  ChangePasswordViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPassTF: UITextField!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelBtn()
        setupSaveChangesGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Change Pass")
    }
    
    private func setupCancelBtn() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.closeBackButtonPressed))
    }
    
    private func setupSaveChangesGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSaveChanges))
        tapGesture.numberOfTapsRequired = 1
        self.changeBtn.addGestureRecognizer(tapGesture)
    }
    
    private func validatePasswords() -> Bool {
        if let curPass = currentPassTF.text, let newPass = newPassTF.text, let confPass = confirmPassTF.text, curPass.isEmpty || newPass.isEmpty || confPass.isEmpty {
            displayAlertMessage(vc: self, message: "Все поля должны быть заполенены")
            return false
        } else if let newPass = newPassTF.text, let confPass = confirmPassTF.text, newPass != confPass {
            displayAlertMessage(vc: self, message: "Пароли не совпадают. Проверьте введенные пароли")
            return false
        }
        return true
    }
    
    @objc func tappedSaveChanges() {
        if !validatePasswords() { return }
        let changePass = ChangePassword(currentPassword: currentPassTF.text!, newPassword: newPassTF.text!, newPasswordConfirmation: confirmPassTF.text!)
        RequestBuilder.shared.changePassword(changePass: changePass) { data in
            if data.code == 400 {
                displayAlertMessage(vc: self, message: data.message)
            }
        }
    }
    
    @objc func closeBackButtonPressed(){
        self.dismiss(animated: false, completion: nil)
    }
}
