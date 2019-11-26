//
//  AuctionDateInfoViewController.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/17/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class AuctionDateInfoViewController: UIViewController {

    @IBOutlet weak var createdDateLable: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var createdDateTextField: UILabel!
    @IBOutlet weak var endDateTextField: UILabel!
    
    var createdDate: Date!
    var endDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleInit()
        initDates()
    }
    
    func setupDates(from: Date!, to: Date!) {
        self.createdDate = from
        self.endDate = to
    }
    
    private func initDates() {
        self.createdDateTextField.text = DateUtils.dateToString(date: self.createdDate)
        self.endDateTextField.text = DateUtils.dateToString(date: self.endDate)
    }

    private func styleInit() {
        UIStyle.applyBaseLabelStyle(label: self.createdDateLable, size: 12)
        UIStyle.applyBaseLabelStyle(label: self.endDateLabel, size: 12)
        UIStyle.applyBaseLabelStyle(label: self.createdDateTextField, size: 12, color: .lightGray)
        UIStyle.applyBaseLabelStyle(label: self.endDateTextField, size: 12, color: .lightGray)
    }
}
