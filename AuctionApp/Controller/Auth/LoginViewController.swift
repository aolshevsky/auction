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
        DataSource.shared.allFavouriteAuctions = []
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.showSpinner(onView: self.view)
        let userEmail = useremailTextField.text
        let userPassword = userPasswordTextField.text
        
        if let username = userEmail, let password = userPassword, !username.isEmpty, !password.isEmpty {
            let login = Login(username: username, password: password)
            RequestBuilder.shared.getToken(login: login, completion: { (data) in
                if data.code == 200 {
                    Token.setupToken(token: data.result!.token)
                    self.toMenuPage()
                } else {
                    DispatchQueue.main.async {
                        displayAlertMessage(vc: self, message: data.message)
                        self.removeSpinner()
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                displayAlertMessage(vc: self, message: "Все поля должны быть заполнены")
                self.removeSpinner()
            }
        }
    }
    
    private func toMenuPage() {
        RequestBuilder.shared.getProfile { (data) in }
        RequestBuilder.shared.getAuctions { (auctions) in }
        RequestBuilder.shared.getAllUsers()
        RequestBuilder.shared.getAllFavorites(completion: { (auctions) in
            print("Favorite auctions count: ", auctions.count)
            DispatchQueue.main.async {
                self.removeSpinner()
                self.mainMenuRedirect()
            }
        })
    }
    
    private func mainMenuRedirect() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? UITabBarController

        if let vc = vc {
            present(vc, animated: false)
        }
    }
}
