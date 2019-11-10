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
    }
    
    var allAuctions: [Auction] = []
    
    private func createAuctions() -> [Auction] {
        var tempAuctions: [Auction] = []
        
        let auction1 = Auction(image: #imageLiteral(resourceName: "audi"), title: "Audi TT", price: 450, isStar: true)
        let auction2 = Auction(image: #imageLiteral(resourceName: "bugatti"), title: "Buggati-Veron", price: 4000, isStar: false)
        let auction3 = Auction(image: #imageLiteral(resourceName: "classic"), title: "Тачка деда", price: 100, isStar: false)
        let auction4 = Auction(image: #imageLiteral(resourceName: "merce"), title: "Тачка прадеда", price: 3220, isStar: true)
        let auction5 = Auction(image: #imageLiteral(resourceName: "merce2"), title: "Тачка бабули", price: 890, isStar: false)
        
        tempAuctions.append(auction1)
        tempAuctions.append(auction2)
        tempAuctions.append(auction3)
        tempAuctions.append(auction4)
        tempAuctions.append(auction5)

        return tempAuctions
    }
    
    func getFilterFavouritesAuctioun() -> [Auction] {
        let  res = allAuctions.filter{ a in a.isStar }
        return res
    }
}
