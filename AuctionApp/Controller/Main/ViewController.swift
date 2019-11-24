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
        let login = Login(username: "admin", password: "123qweA@")
        RequestBuilder.shared.getToken(login: login, completion: { () in RequestBuilder.shared.getProfile(){} })

        PostStorage.uploadImage(for: UIImage(named: "star")!, child: "images/opana.png", completion: {(val) in print("Finish")})
        //Request.inst.initToken(username: "admin", password: "123qweA!", completion: { () in })
    }

    @IBAction func moveButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AuthViewController", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? AuthViewController
        if let vc = vc {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

