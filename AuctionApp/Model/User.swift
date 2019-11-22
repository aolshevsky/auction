//
//  User.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit


class User: Codable {
    
    var id: String
    
    var imageUrl: String
    
    var firstName: String
    var lastName: String
    
    var email: String
    var username: String
    var phone: String
    var address: String
    var cardNumber: String
    
    var birthday: Date
    
    var registrationDate: Date
    
    init (username: String, email: String, firstName: String, lastName: String, phone: String, birhday: Date, cardNumber: String, address: String) {
        self.id = ""
        self.imageUrl = String()
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.cardNumber = cardNumber
        self.address = address
        self.birthday = Date()
        self.registrationDate = Date()
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func getAge() -> Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.year], from: birthday, to: Date()).year!
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName
        case lastName
        case phone = "phoneNumber"
        case birthday
        case address
        case imageUrl
        case username
        case registrationDate
        case cardNumber
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .firstName)
        try container.encode(self.imageUrl, forKey: .imageUrl)
        try container.encode(DateUtils.dateToString(date: self.birthday), forKey: .birthday)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.phone, forKey: .phone)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decode(String.self, forKey: .username)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.phone = try container.decode(String.self, forKey: .phone)
        let decodeBirth = try container.decode(String.self, forKey: .birthday)
        self.birthday = DateUtils.getDateFormatter().date(from: decodeBirth)!
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.address = try container.decode(String.self, forKey: .address)
        let decodeRegDate = try container.decode(String.self, forKey: .registrationDate)
        self.registrationDate = DateUtils.getDateFormatter().date(from: decodeRegDate)!
        self.cardNumber = try container.decode(String.self, forKey: .cardNumber)
        // missing
        self.imageUrl = "https://firebasestorage.googleapis.com/v0/b/auction-42d96.appspot.com/o/users%2Fade4cd46-cf09-4533-adc8-ed773563bf71.png?alt=media&token=4f09175e-f867-42c7-b6d8-cb98f396f0b7"
    }
}
