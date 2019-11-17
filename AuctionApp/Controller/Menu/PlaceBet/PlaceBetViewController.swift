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
    
    var price: Float = 0
    let minBetPercent: Float = 5
    
    @IBAction func slider(_ sender: UISlider) {
        let roundedValue = round(sender.value / minBetPercent) * minBetPercent
        sender.value = roundedValue
        setNewPrice(newPrice: calculateNewPrice(percent: sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleInit()
    }
    
    func commonInit(auction: Auction) {
        self.price = auction.endPrice
    }
    
    // move from here
    func calculateNewPrice(percent: Float) -> Int {
        return Int(self.price + self.price / 100 * percent)
    }
    
    func setNewPrice(newPrice: Int) {
        newPriceTextField.text = String(newPrice) + " $"
    }
    
    func styleInit() {
        setNewPrice(newPrice: calculateNewPrice(percent: slider.value))
        UIStyle.applyCornerRadius(view: self.betButton)
    }
}
