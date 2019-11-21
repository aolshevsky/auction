//
//  RaiserTableViewCell.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/17/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class RaiserTableViewCell: UITableViewCell {

    @IBOutlet weak var raiserImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UILabel!
    @IBOutlet weak var raiseCountTextField: UILabel!
    
    weak var cellRaiser: Raiser!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setRaiser(raiser: Raiser) {
        self.cellRaiser = raiser
        // TODO
        // self.raiserImageView.downloaded(from: raiser.user.imageUrl)
        let user = DataSource.shared.getUserById(id: raiser.userId)
        self.raiserImageView.image = user.image
        self.fullNameTextField.text = user.getFullName()
        self.raiseCountTextField.text = NumberUtils.convertFloatPriceToString(value: Float(raiser.getCount()))
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.raiserImageView, radius: 20)
    }
    
}
