//
//  DataSource.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation

class DataSource {
    
    static let shared: DataSource = DataSource()
    
    var currentUser: User!
    var allUsers: [User] = []
    var allFavouriteAuctions: [Auction] = []
    var allAuctions: [Auction] = []
    var allRaisers: [Raiser] = []
    
    func getUserById(id: String) -> User {
        let res = allUsers.filter{ a in a.id == id }
        return res[0]
    }
    
    func updateCurrentUser() {
        allUsers.removeAll(where: { u in u.id == currentUser.id })
        allUsers.append(currentUser)
    }
    
    func updateAuction(auction: Auction) {
        allAuctions.removeAll(where: { a in a.id == auction.id })
        allAuctions.append(auction)
    }
    
    func setupFavoriteAuctions(auctions: [Auction]) {
        auctions.forEach { a in updateFavoriteAuction(auctionId: a.id)}
    }
    
    func updateFavoriteAuction(auctionId: String) {
        if let auction = allAuctions.first(where: { a in a.id == auctionId }) {
            print("Change all auction liked!")
            auction.isLiked = !auction.isLiked
        }
    }
    
    func getFilterFavouritesAuctioun() -> [Auction] {
        let res = allAuctions.filter{ a in a.isLiked }
        return res
    }
}
