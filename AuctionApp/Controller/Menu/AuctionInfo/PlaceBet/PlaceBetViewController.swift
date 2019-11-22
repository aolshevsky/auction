//
//  PlaceBetViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/12/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class PlaceBetViewController: UIViewController {

    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var newPriceTextField: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var auction: Auction!
    var price: Float = 0
    let minBetPercent: Float = 5
    
    weak var delegate: BetVCDelegate?
    
    @IBAction func slider(_ sender: UISlider) {
        let roundedValue = round(sender.value / minBetPercent) * minBetPercent
        sender.value = roundedValue
        setNewPrice(newPrice: calculateNewPrice(percent: sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBetGestures()
        styleInit()
    }
    
    private func setupBetGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBet))
        tapGesture.numberOfTapsRequired = 1
        self.betButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tappedBet() {
        let currentPrice = calculateNewPrice(percent: slider.value)
        let raiser = Raiser(startPrice: self.auction!.currentPrice, endPrice: currentPrice, date: Date())
        RequestBuilder.shared.postRaiseAuction(auctionId: auction.id, raiser: raiser)
        auction.currentPrice = currentPrice
        auction.raisers.append(raiser)
        DataSource.shared.updateAuction(auction: auction)
        self.dismiss(animated: true, completion: nil)
        delegate?.setupInfoData()
    }
    
    func commonInit(auction: inout Auction) {
        self.price = auction.currentPrice
        self.auction = auction
        setNewPrice(newPrice: calculateNewPrice(percent: slider.value))
    }
    
    // move from here
    func calculateNewPrice(percent: Float) -> Float {
        return Float(self.price + self.price / 100 * percent)
    }
    
    func setNewPrice(newPrice: Float) {
        newPriceTextField.text = String(Int(newPrice)) + " $"
    }
    
    func styleInit() {
        UIStyle.applyCornerRadius(view: self.betButton)
    }
}
