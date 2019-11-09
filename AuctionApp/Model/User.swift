//
//  User.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class User {
    
    var image: UIImage
    var email: String
    var name: String
    var surname: String
    var phone: String
    var age: Int
    var accoutNumber: String
    
    init(image: UIImage, email: String, name: String, surname: String, phone: String, age: Int, accoutNumber: String) {
        self.image = image
        self.email = email
        self.name = name
        self.surname = surname
        self.phone = phone
        self.age = age
        self.accoutNumber = accoutNumber
    }
    
}
