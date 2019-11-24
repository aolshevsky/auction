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
        
        // "123qweA@"
        if let username = userEmail, let password = userPassword, !username.isEmpty, !password.isEmpty {
            let login = Login(username: username, password: password)
            RequestBuilder.shared.getToken(login: login, completion: { (data) in
                if data.code == 200 {
                    self.setupToken(token: data.result!.token)
                    self.toMenuPage()
                }
            })
        }
    }
    
    private func toMenuPage() {
        RequestBuilder.shared.getAuctions(completion: { (auctions) in })
        RequestBuilder.shared.getAllUsers()
        RequestBuilder.shared.getAllFavorites(completion: { (auctions) in
            print("Favorite auctions count: ", auctions.count)
            DispatchQueue.main.async {
                self.mainMenuRedirect()
            }
        })
    }
    
    private func setupToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: DefaultsKeys.token)
    }
    
    private func mainMenuRedirect() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? UITabBarController

        if let vc = vc {
            present(vc, animated: false)
        }
    }
}
