//
//  DataSource.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation

class DataSource {
    
    static let sharedInstance: DataSource = DataSource()
    
    private init () {
        allAuctions = createAuctions()
        allUsers = createUsers()
        allRaisers = createRaisers()
    }
    
    var allAuctions: [Auction] = []
    var allRaisers: [Raiser] = []
    var allUsers: [User] = []
    
    private func createUsers() -> [User] {
        var tempUsers: [User] = []
        let user1 = User(email: "olshevsky.aleksey@gmail.com", name: "Aleksey", surname: "Olshevsky", phone: "228", age: 20, cardNumber: "12-12-12")
        tempUsers.append(user1)
        return tempUsers
    }
    
    private func createRaisers() -> [Raiser] {
        var tempRaisers: [Raiser] = []
        for _ in 0...2 {
            tempRaisers.append(Raiser(user: allUsers[0], count: Int.random(in: 10 ... 100), date: Date()))
        }
        return tempRaisers
    }
    
    private func createAuctions() -> [Auction] {
        var tempAuctions: [Auction] = []
        
        let auction1 = Auction(imageUrl: "https://firebasestorage.googleapis.com/v0/b/auction-42d96.appspot.com/o/auction_3?alt=media&token=81441e05-eb6e-4725-9d04-9445c2e75052", title: "Audi TT", price: 450, description: "sdfsfsdfsdfsdfer wefgwe fwfwef wefwe fwfw efwe f wef wef wef wefwe fwef we fwef wef wef we fwef wef aaaaaaaaaaaaa ferfkwe kfwkef wkef kofw ei efiwei", isStar: true)
        let auction2 = Auction(imageUrl: "https://firebasestorage.googleapis.com/v0/b/auction-42d96.appspot.com/o/auction_4?alt=media&token=9d61f6b1-96d6-4248-b8d9-9f93a2e3a636", title: "Buggati-Veron", price: 4000, isStar: false)
        let auction3 = Auction(imageUrl: "https://firebasestorage.googleapis.com/v0/b/auction-42d96.appspot.com/o/auction_1?alt=media&token=32f6df94-31d1-4a17-bfa2-184487b14cde", title: "Тачка деда", price: 100, isStar: false)
        let auction4 = Auction(imageUrl: "https://firebasestorage.googleapis.com/v0/b/auction-42d96.appspot.com/o/auction_5?alt=media&token=6e436be3-95f6-4879-80ed-58b7903a91d6", title: "Тачка прадеда", price: 3220, isStar: true)
        let auction5 = Auction(imageUrl: "https://firebasestorage.googleapis.com/v0/b/auction-42d96.appspot.com/o/auction_2?alt=media&token=4734663a-706a-4c4d-b5e6-61c40e376986", title: "Тачка бабули", price: 890, isStar: false)
        
        
        tempAuctions.append(auction1)
        tempAuctions.append(auction2)
        tempAuctions.append(auction3)
        tempAuctions.append(auction4)
        tempAuctions.append(auction5)
        
//        var i = 0
//        for a in tempAuctions {
//            i += 1
//            PostStorage.uploadImage(for: a.image, child: "auction_" + String(i))
//        }

        return tempAuctions
    }
    
    func getFilterFavouritesAuctioun() -> [Auction] {
        let  res = allAuctions.filter{ a in a.isStar }
        return res
    }
}
