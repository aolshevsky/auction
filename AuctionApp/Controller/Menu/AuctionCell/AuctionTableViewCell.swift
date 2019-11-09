//
//  AuctTableViewCell.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/6/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class AuctionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    
    weak var cellAuction: Auction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapStarImage)))
        starImageView.isUserInteractionEnabled = true
    }
        
    @objc func tapStarImage() {
        cellAuction.isStar = !cellAuction.isStar
        starImageView.image = getAuctionStarImage(isStar: cellAuction.isStar)
        print("Imageview Clicked " + cellAuction.title)
    }
    
    func getAuctionStarImage(isStar: Bool) -> UIImage {
        if isStar {
            return Images.star!
        }
        return Images.empty_star!
    }
    func setAuction(auction: Auction) {
        cellAuction = auction
        auctionImageView.image = auction.image
        titleLabel.text = auction.title
        priceLabel.text = String(auction.price) + " $"
        starImageView.image = getAuctionStarImage(isStar: auction.isStar)
    }
}
