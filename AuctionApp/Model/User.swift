//
//  User.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class User {
    
    var imageUrl: String
    var image: UIImage
    var email: String
    var name: String
    var surname: String
    var phone: String
    var age: Int
    var cardNumber: String
    
    init (email: String, name: String, surname: String, phone: String, age: Int, cardNumber: String) {
        self.imageUrl = String()
        self.image = Images.userBaseImages.randomElement()!!
        self.email = email
        self.name = name
        self.surname = surname
        self.phone = phone
        self.age = age
        self.cardNumber = cardNumber
    }
    
    func getFullName() -> String {
        return "\(self.name) \(self.surname)"
    }
}
