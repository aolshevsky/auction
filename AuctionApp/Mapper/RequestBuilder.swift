//
//  RequestBuilder.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class RequestBuilder {
    
    static let shared: RequestBuilder = RequestBuilder()
    private let request = Request.shared
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? jsonDecoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    // completionRes: @escaping (Result<[ResultT], Error>) -> ()
    private func baseGetRequest(url: String, completion: @escaping (Data?) -> ()) {
        request.getRequest(url: url, completion: { (statusCode, data) in
            completion(data)
        })
    }
    
    private func baseHTTPRequest(url: String, httpMethod: String="POST", isAuth: Bool=true, params: Data=Data(), completion: @escaping (Data?) -> ()) {
        DispatchQueue.main.async {
            self.request.httpRequest(url: url, params: params, httpMethod: httpMethod, isAuth: isAuth, completion: { (statusCode, data) in
                completion(data)
            })
        }
    }
    
    func getToken(completion: @escaping () -> ()) {
        let params = ["username": "admin", "password": "123qweA!"]
        let url: String = "\(request.hostName)/api/auth/token"
        baseHTTPRequest(url: url, httpMethod: "POST", params: request.createRequestBody(params: params), completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Token>.self, from: data) ?? nil
            guard let token = data?.result?.token else { return }
            self.request.token = token
            print("Token: ", token)
            completion()
        })
    }
    
    // MARK: Auctions
    func getAuctions(completion: @escaping ([Auction]) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/auctions", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<[Auction]>.self, from: data) ?? nil
            guard let auctions = data?.result else { return }
            DataSource.shared.allAuctions = auctions
            completion(auctions)
        })
    }
    
    func getAuction(id: String, completion: @escaping (Auction) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/auctions/\(id)", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Auction>.self, from: data) ?? nil
            guard let auction = data?.result else { return }
            completion(auction)
        })
    }

    func postAuction(auction: Auction, completion: @escaping (Auction) -> ()) {
        let auctionData = try! JSONEncoder().encode(auction)
        baseHTTPRequest(url: "\(request.hostName)/api/auctions/", httpMethod: "POST", params: auctionData, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Auction>.self, from: data) ?? nil
            guard let auction = data?.result else { return }
            DataSource.shared.allAuctions.append(auction)
            completion(auction)
        })
    }

    func deleteAuction(id: String) {
        baseHTTPRequest(url: "\(request.hostName)/api/auctions/\(id)", httpMethod: "DELETE", completion: { (data) in })
    }
    
    func postRaiseAuction(auctionId: String, raiser: Raiser) {
        let raiserData = try! JSONEncoder().encode(raiser)
        baseHTTPRequest(url: "\(request.hostName)/api/auctions/\(auctionId)/raise", httpMethod: "POST", params: raiserData, completion: { (data) in })
    }

    // MARK: Favorites
    func getAllFavorites(completion: @escaping ([Auction]) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/favorites", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<[Auction]>.self, from: data) ?? nil
            guard let auctions = data?.result else { return }
            DataSource.shared.allFavouriteAuctions = auctions
            DataSource.shared.setupFavoriteAuctions(auctions: auctions)
            completion(auctions)
        })
    }

    func postFavorite(auctionId: String) {
        let params = ["auctionId": auctionId]
        baseHTTPRequest(url: "\(request.hostName)/api/favorites", params: request.createRequestBody(params: params), completion: { (data) in
            DataSource.shared.updateFavoriteAuction(auctionId: auctionId)
        })
    }

    func deleteFavorite(auctionId: String) {
        baseHTTPRequest(url: "\(request.hostName)/api/favorites/\(auctionId)", httpMethod: "DELETE", completion: { (data) in
            DataSource.shared.updateFavoriteAuction(auctionId: auctionId)
        })
    }
    
    // MARK: Profile
    func getProfile() {
        baseGetRequest(url: "\(request.hostName)/api/me/", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<User>.self, from: data) ?? nil
            guard let user = data?.result else { return }
            DataSource.shared.currentUser = user
//            let storagePath = Images.userDatabasePath + user.id + Images.auctionImageType
//            PostStorage.uploadImage(for: user.image, child: storagePath, completion: { (test) in })
        })
    }

    func updateProfile(user: User) {
        user.firstName = "alesha"
        let userData = try! JSONEncoder().encode(user)
        baseHTTPRequest(url: "\(request.hostName)/api/me/", httpMethod: "PUT", params: userData, completion: { (data) in })
    }
    
    // MARK: User
    func getAllUsers() {
        baseGetRequest(url: "\(request.hostName)/api/users", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<[User]>.self, from: data) ?? nil
            guard let users = data?.result else { return }
            DataSource.shared.allUsers = users
            print("Users count: ", users.count)
        })
    }
    
    func getUser(id: String, completion: @escaping (User) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/users/\(id)", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<User>.self, from: data) ?? nil
            guard let user = data?.result else { return }
            completion(user)
        })
    }
    
}
