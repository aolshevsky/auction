
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
        
        // Needlessly
        RequestBuilder.shared.getAuctions(completion: { (auctions) in
            print("Auction id: ", auctions[0].id)
        })
        
        RequestBuilder.shared.getAllUsers()
        RequestBuilder.shared.getAllFavorites(completion: { (auctions) in print("Favorite auction: ", auctions.count) })
        
//        RequestBuilder.shared.getAuction(id: "08037ef3-9ab3-491e-76f4-08d76dd848b1", completion: { (auction) in
//            print("Auction: ", auction.title)
//            RequestBuilder.shared.postAuction(auction: auction)
//        })
        
        // RequestBuilder.shared.deleteAuction(id: "4ea68e95-871c-41fe-d276-08d76ec06630")
        
        //RequestBuilder.shared.updateProfile(user: DataSource.shared.currentUser)
        
        // RequestBuilder.shared.postRaiseAuction(auctionId: "08037ef3-9ab3-491e-76f4-08d76dd848b1", raiser: Raiser(startPrice: 10, endPrice: 20, date: Date()))
        //RequestBuilder.shared.postFavorite(auctionId: "08037ef3-9ab3-491e-76f4-08d76dd848b1")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if login -> mainView
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
}
