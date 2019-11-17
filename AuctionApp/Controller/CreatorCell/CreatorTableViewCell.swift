//
//  CreatorTableViewCell.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/17/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

class CreatorTableViewCell: UITableViewCell {

    
    @IBOutlet weak var creatorImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UILabel!
    @IBOutlet weak var descriptionTextField: UILabel!
    
    weak var cellUser: User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(user: User) {
        self.cellUser = user
        // TODO
        // self.creatorImageView.downloaded(from: user.imageUrl)
        self.creatorImageView.image = user.image
        self.fullNameTextField.text = user.getFullName()
        self.descriptionTextField.text = user.email
        UIStyle.applyCornerRadius(view: self.creatorImageView, radius: 25)
    }
    
}
