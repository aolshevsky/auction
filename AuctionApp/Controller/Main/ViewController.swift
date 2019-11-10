//
//  ViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/3/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

