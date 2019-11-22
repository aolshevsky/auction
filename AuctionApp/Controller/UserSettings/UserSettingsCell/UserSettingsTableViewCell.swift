//
//  UserSettingsTableViewCell.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class UserSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSetting(setting: String) {
        self.titleLabel.text = setting
    }
    
}
