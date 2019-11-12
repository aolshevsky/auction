//
//  ProfileViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/11/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tapp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           setupGestures()
        }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBet))
        tapGesture.numberOfTapsRequired = 1
        self.tapp.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tappedBet() {
        let storyboard = UIStoryboard(name: "PlaceBetViewController", bundle: nil)
        let vc =  storyboard.instantiateInitialViewController() as? PlaceBetViewController
        // let vc = PlaceBetViewController(nibName: "PlaceBetViewController", bundle: nil)
        if let vc = vc {
            vc.modalPresentationStyle = .popover
            let popOverVC = vc.popoverPresentationController
            popOverVC?.delegate = self as? UIPopoverPresentationControllerDelegate
            popOverVC?.sourceView = self.tapp
            popOverVC?.sourceRect = CGRect(x: self.tapp.bounds.midX, y: self.tapp.bounds.midY, width: 0, height: 0)
            vc.preferredContentSize = CGSize(width: 250, height: 250)
            self.present(vc, animated: true)
        }
    }
}
