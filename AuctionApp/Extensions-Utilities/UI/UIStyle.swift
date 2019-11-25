//
//  UIStyle.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/12/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class UIStyle {
    
    static func applyBaseLabelStyle(label: UILabel!, size: CGFloat, color: UIColor! = .darkGray, font: String = "Kohinoor Devanagari") {
        label.font = UIFont(name: font, size: size)
        label.textColor = color
    }
    
    static func applyBaseLabelStyle(labels: [UILabel?], size: CGFloat, color: UIColor! = .darkGray, font: String = "Menlo") {
        labels.forEach { label in UIStyle.applyBaseLabelStyle(label: label, size: size, color: color, font: font)}
    }
    
    static func applyCornerRadius(view: UIView!, radius: CGFloat = 15) {
        view.layer.cornerRadius = radius
    }
}
