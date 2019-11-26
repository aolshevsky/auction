//
//  AuctTableViewCell.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/6/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit
import Lottie

class AuctionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var animView: AnimationView!
    
    
    weak var cellAuction: Auction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleInit()
    }
    
    func setStarAnimation(state: Bool) {
        addSwitchAnimation(filename: "sparkness", state: state)
    }
    
    func styleInit() {
        UIStyle.applyCornerRadius(view: self.auctionImageView, radius: 10)
        self.auctionImageView.contentMode = .scaleAspectFill
    }
    
    
    func setAuction(auction: Auction) {
        cellAuction = auction
        auctionImageView.downloaded(from: auction.imageUrl)
        titleLabel.text = auction.title
        priceLabel.text = NumberUtils.convertFloatPriceToString(value: auction.currentPrice)
        setStarAnimation(state: auction.isLiked)
        styleInit()
    }
    
    
    func addSwitchAnimation(filename: String, state: Bool) {
        let animation = Animation.named(filename)
        let animationSwitch = AnimatedSwitch()
        animationSwitch.animation = animation
        animationSwitch.animationSpeed = 1
        animationSwitch.isOn = state
        animationSwitch.setProgressForState(fromProgress: 0, toProgress: 1, forOnState: true)
        animationSwitch.setProgressForState(fromProgress: 1, toProgress: 0, forOnState: false)
        animationSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        animationSwitch.contentMode = .scaleAspectFit
        
        animationSwitch.translatesAutoresizingMaskIntoConstraints = false
        animView.addSubview(animationSwitch)
        
        NSLayoutConstraint.activate([
            animationSwitch.heightAnchor.constraint(equalTo: animView.heightAnchor),
            animationSwitch.widthAnchor.constraint(equalTo: animView.widthAnchor)])
    }
        
    @objc func switchToggled(animatedSwitch: AnimatedSwitch) {
        if cellAuction.isLiked {
            RequestBuilder.shared.deleteFavorite(auctionId: cellAuction.id)
        } else {
            RequestBuilder.shared.postFavorite(auctionId: cellAuction.id)
        }
    }
}
