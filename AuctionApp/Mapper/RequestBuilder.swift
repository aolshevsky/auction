//
//  RequestBuilder.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class RequestBuilder {
    
    static let inst: RequestBuilder = RequestBuilder()
    private let request = Request.inst
    
    private init () {}
    
    private func baseGetRequest(url: String) {
        DispatchQueue.main.async {
            self.request.getRequest(url: url, completion: { (data) in
                let json = self.request.parseRequestData(data: data)
                print("Response: ", json?.result as Any)
            })
        }
    }
    
    private func baseHTTPRequest(url: String, httpMethod: String = "POST") {
        DispatchQueue.main.async {
            self.request.httpRequest(url: url, params: [:], httpMethod: httpMethod, isAuth: true, completion: { (data) in
                let json = self.request.parseRequestData(data: data, debug: true)
                print("Response: ", json?.result as Any)
            })
        }
    }
    
    func getAllAuctions() {
        baseGetRequest(url: "\(request.hostName)/api/auctions")
    }
    
    func getAllFavorites() {
        baseGetRequest(url: "\(request.hostName)/api/favorites/all")
    }
    
    func getFavorites() {
        baseGetRequest(url: "\(request.hostName)/api/favorites/")
    }
    
    func getFavorites(id: String) {
        baseGetRequest(url: "\(request.hostName)/api/favorites/\(id)")
    }
    
    func getAllFavorites(id: String) {
        baseGetRequest(url: "\(request.hostName)/api/favorites/all\(id)")
    }
    
    func deleteFavorites(id: String) {
        baseHTTPRequest(url: "\(request.hostName)/api/favorites/\(id)", httpMethod: "DELETE")
    }
    
    func deleteAllFavorites(id: String) {
        baseHTTPRequest(url: "\(request.hostName)/api/favorites/all/\(id)", httpMethod: "DELETE")
    }
}
