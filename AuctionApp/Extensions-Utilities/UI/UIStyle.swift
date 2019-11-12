//
//  UIStyle.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/12/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class UIStyle {
    
    static func applyBaseLabelStyle(label: UILabel!, size: CGFloat, color: UIColor! = .darkGray) {
        label.font = UIFont(name: "Menlo", size: size)
        label.textColor = color
    }
    
    static func applyCornerRadius(button: UIButton!) {
        button.layer.cornerRadius = 15
    }
}
