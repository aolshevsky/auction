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
    
    var price: Float = 200
    let minBetPercent: Float = 5
    
    @IBAction func slider(_ sender: UISlider) {
        let roundedValue = round(sender.value / minBetPercent) * minBetPercent
        sender.value = roundedValue
        newPriceTextField.text = String(Int(price + price / 100 * sender.value)) + " $"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleInit()
    }
    
    func commonInit(auction: Auction) {
        self.price = auction.endPrice
    }
    
    func styleInit() {
        UIStyle.applyCornerRadius(button: self.betButton)
    }
}
