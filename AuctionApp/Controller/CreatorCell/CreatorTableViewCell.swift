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
        styleInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(user: User) {
        self.cellUser = user
        self.creatorImageView.downloaded(from: user.imageUrl)
        self.fullNameTextField.text = user.getFullName()
        self.descriptionTextField.text = user.email
    }
    
    private func styleInit() {
        UIStyle.applyCornerRadius(view: self.creatorImageView, radius: 25)
    }
    
}
