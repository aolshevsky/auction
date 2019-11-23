//
//  MainInfoViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class MainInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.closeBackButtonPressed))
    }
    
    @objc func closeBackButtonPressed(){
           self.dismiss(animated: false, completion: nil)
       }
}
