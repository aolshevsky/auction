//
//  AuctionInfoViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/9/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class AuctionInfoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var createdDateTextField: UILabel!
    @IBOutlet weak var statusTextField: UILabel!
    @IBOutlet weak var descriptionTextField: UILabel!
    @IBOutlet weak var startPriceTextField: UILabel!
    @IBOutlet weak var creatorTextField: UILabel!
    @IBOutlet weak var endPriceTextField: UILabel!
    @IBOutlet weak var purchasedByTextField: UILabel!
    @IBOutlet weak var endDateTextField: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func commonInit(auction: Auction) {
        self.titleTextField.text = auction.title
        self.createdDateTextField.text = DateUtils.dateToString(date: auction.createDate)
        self.endDateTextField.text = DateUtils.dateToString(date: auction.endDate)
        self.statusTextField.text = auction.status.rawValue
        self.descriptionTextField.text = auction.description
        self.startPriceTextField.text = NumberUtils.convertFloatToString(value: auction.startPrice)
        self.endPriceTextField.text = NumberUtils.convertFloatToString(value: auction.endPrice)
        self.creatorTextField.text = "linked"
        self.purchasedByTextField.text = "linked"
    }
}
