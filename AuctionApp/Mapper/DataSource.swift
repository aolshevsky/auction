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
    
    func fullUpdateUser(user: User) {
        RequestBuilder.shared.updateProfile(user: user)
        DataSource.shared.currentUser = user
        DataSource.shared.updateCurrentUser()
    }
    
    func updateUserBalance(cardBalance: CardBalance) {
        RequestBuilder.shared.updateBalance(cardBalance: cardBalance)
        DataSource.shared.currentUser.balance += cardBalance.income
        DataSource.shared.updateCurrentUser()
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
            print("Change \(auctionId) auction liked!")
            auction.isLiked = !auction.isLiked
            auction.isLiked ? allFavouriteAuctions.append(auction) :
                allFavouriteAuctions.removeAll(where: { a in a.id == auction.id })
        }
    }
    
    func markAuctionAsFavorite(auctions: [Auction]) -> [Auction] {
        func mark(auction: Auction) -> Auction {
            if allFavouriteAuctions.first(where: { a in a.id == auction.id }) != nil {
                auction.isLiked = true
            }
            return auction
        }
        
        return auctions.map(mark)
    }
    
    func filterAuctions(auctions: [Auction], searchText: String) -> [Auction] {
        return auctions.filter { a in
            a.title.lowercased().contains(searchText) || a.description.lowercased().contains(searchText)
        }
    }
    
    private func getActiveAuctions() -> [Auction] {
        return allAuctions.filter{ a in a.status == AuctionStatus.opened.rawValue }
    }
    
    func getClosedAuctions() -> [Auction] {
        return allAuctions.filter{ a in a.status == AuctionStatus.closed.rawValue }
    }
    
    func getMyActiveAuctions() -> [Auction] {
        return getActiveAuctions().filter { a in a.ownerId == self.currentUser.id}
    }

    func getMyClosedAuctions() -> [Auction] {
        return getClosedAuctions().filter { a in a.ownerId == self.currentUser.id}
    }
    
    func getLastRaiseActiveAuctions(userId: String) -> [Auction] {
        let activeAuctions = getActiveAuctions(userId: userId)
        return activeAuctions.filter{ a in isLastRaiseAuction(userId: userId, auction: a)}
    }
    
    func getNonLastRaiseActiveAuctions(userId: String) -> [Auction] {
        let activeAuctions = getActiveAuctions(userId: userId)
        return activeAuctions.filter{ a in !isLastRaiseAuction(userId: userId, auction: a)}
    }
    
    func getActiveAuctions(userId: String) -> [Auction] {
        let activeAuctions = getActiveAuctions()
        return activeAuctions.filter{ a in isUserRaiseAuction(userId: userId, auction: a)}
    }
    
    func getClosedAuctions(userId: String) -> [Auction] {
        let closedAuctions = getClosedAuctions()
        return closedAuctions.filter{ a in isUserRaiseAuction(userId: userId, auction: a)}
    }
    
    func getLastRaiseClosedAuctions(userId: String) -> [Auction] {
        let activeAuctions = getClosedAuctions(userId: userId)
        return activeAuctions.filter{ a in isLastRaiseAuction(userId: userId, auction: a)}
    }
    
    func isInCollection(auction: Auction, auctions: [Auction]) -> Bool {
        return auctions.contains(where: { a in a.id == auction.id })
    }
    
    private func isLastRaiseAuction(userId: String, auction: Auction) -> Bool {
        if let raisers = auction.raisers, !raisers.isEmpty {
            return raisers.last?.userId == userId
        }
        return false
    }
    
    private func isUserRaiseAuction(userId: String, auction: Auction) -> Bool {
        let userRaises = auction.raisers.filter{ r in r.userId == userId}
        return !userRaises.isEmpty
    }
    
    func getFilterFavouritesAuctioun() -> [Auction] {
        let res = allAuctions.filter{ a in a.isLiked }
        return res
    }
}
