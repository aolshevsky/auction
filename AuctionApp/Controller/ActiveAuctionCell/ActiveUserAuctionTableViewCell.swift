//
//  ActiveAuctionTableViewCell.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/18/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class ActiveUserAuctionTableViewCell: UITableViewCell {

    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var cellAuction: Auction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setUserAuction(auction: Auction) {
        cellAuction = auction
        self.auctionImageView.downloaded(from: auction.imageUrl)
        self.titleLabel.text = auction.title
        self.priceLabel.text = NumberUtils.convertFloatPriceToString(value: auction.currentPrice)
        
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.auctionImageView, radius: 20)
    }
    
}
