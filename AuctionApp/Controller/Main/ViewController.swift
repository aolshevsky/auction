//
//  ViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func moveButton(_ sender: Any) {
        toLoginPage()
        return
        RequestBuilder.shared.isValidToken { (isValid) in
            DispatchQueue.main.async {
                isValid ? self.toMenuPage() : self.toLoginPage()
            }
        }
    }
    
    
    private func toLoginPage() {
        let storyboard = UIStoryboard(name: "AuthViewController", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? AuthViewController
        if let vc = vc {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func toMenuPage() {
       RequestBuilder.shared.getProfile { (data) in }
        RequestBuilder.shared.getAuctions { (auctions) in }
        RequestBuilder.shared.getAllUsers()
        RequestBuilder.shared.getAllFavorites(completion: { (auctions) in
            print("Favorite auction: ", auctions.count)
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Menu", bundle: nil)
                let vc =  storyboard.instantiateInitialViewController() as? UITabBarController

                if let vc = vc {
                    self.present(vc, animated: false)
                }
            }
        })
    }
}

