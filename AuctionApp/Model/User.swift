//
//  User.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class User: Decodable {
    
    var id: String
    
    var imageUrl: String
    var image: UIImage
    
    var firstName: String
    var lastName: String
    
    var email: String
    var phone: String
    var age: Int
    var cardNumber: String
    var birthday: Date
    
    init (email: String, firstName: String, lastName: String, phone: String, age: Int, cardNumber: String) {
        self.imageUrl = String()
        self.image = Images.userBaseImages.randomElement()!!
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.age = age
        self.cardNumber = cardNumber
        self.id = ""
        self.birthday = Date()
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName
        case lastName
        case phone = "phoneNumber"
        case birthday
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.phone = try container.decode(String.self, forKey: .phone)
        let strBirth = try container.decode(String.self, forKey: .birthday)
        self.birthday = DateUtils.get8601DateFormatter().date(from: strBirth)!
        // missing
        self.imageUrl = ""
        self.image = UIImage()
        self.age = 15
        self.cardNumber = ""
    }
}
