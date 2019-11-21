
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
        //RequestBuilder.inst.getProfile()
//        RequestBuilder.shared.getAuctions(completion: { (auctions) in
//            print("Auction: ", auctions.count)
//        })
        
//        RequestBuilder.shared.getAuction(id: "08037ef3-9ab3-491e-76f4-08d76dd848b1", completion: { (auction) in
//            print("Auction: ", auction.title)
//            RequestBuilder.shared.postAuction(auction: auction)
//        })
        
        // RequestBuilder.shared.deleteAuction(id: "4ea68e95-871c-41fe-d276-08d76ec06630")
        print("user: ", DataSource.shared.currentUser)
        RequestBuilder.shared.updateProfile(user: DataSource.shared.currentUser)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if login -> mainView
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
}
