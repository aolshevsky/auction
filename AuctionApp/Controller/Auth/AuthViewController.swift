
//
//  AuthViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestBuilder.inst.getProfile()
        //RequestBuilder.inst.deleteAuction(id: "57542e1a-c586-40e8-24b6-08d76c77666b", )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if login -> mainView
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
}
