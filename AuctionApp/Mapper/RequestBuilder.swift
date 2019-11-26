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
        request.httpRequest(url: url, params: params, httpMethod: httpMethod, isAuth: isAuth, completion: { (statusCode, data) in
            completion(data)
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
    
    func getOwnedAuctions(userId: String, completion: @escaping ([Auction]) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/auctions/owned/\(userId)", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<[Auction]>.self, from: data) ?? nil
            guard let auctions = data?.result else { return }
            completion(auctions)
        })
    }
    
    func getAuctions(userId: String? = nil, status: String? = nil, filter: String? = nil, completion: @escaping ([Auction]) -> ()) {
        var suff = "?"
        if let userId = userId, !userId.isEmpty {
            suff += "userId=\(userId)"
        }
        if let status = status, !status.isEmpty {
            suff += "status=\(status)"
        }
        if let filter = filter, !filter.isEmpty {
            suff += "filter=\(filter)"
        }
        baseGetRequest(url: "\(request.hostName)/api/auctions" + suff, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<[Auction]>.self, from: data) ?? nil
            guard let auctions = data?.result else { return }
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
    
    func postRaiseAuction(auctionId: String, raiser: Raiser, completion: @escaping (RequestResult<Int>) -> ()) {
        let raiserData = try! JSONEncoder().encode(raiser)
        baseHTTPRequest(url: "\(request.hostName)/api/auctions/\(auctionId)/raise", httpMethod: "POST", params: raiserData, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Int>.self, from: data) ?? nil
            if let data = data {
                return completion(data)
            }
            return completion(RequestResult(code: 500, message: "Ошибка сервера", status: "", result: 0))
        })
    }

    // MARK: Favorites
    func getAllFavorites(completion: @escaping ([Auction]) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/favorites", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<[Auction]>.self, from: data) ?? nil
            guard let auctions = data?.result else { return }
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
    func getProfile(completion: @escaping (RequestResult<User>) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/me/", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<User>.self, from: data) ?? nil
            guard let user = data?.result else { return }
            DataSource.shared.currentUser = user
            completion(data!)
        })
    }

    func updateProfile(user: User) {
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
    
    func updateBalance(cardBalance: CardBalance) {
        let cardBalanceData = try! JSONEncoder().encode(cardBalance)
        baseHTTPRequest(url: "\(request.hostName)/api/me/balance", httpMethod: "POST", params: cardBalanceData, completion: { (data) in })
    }
    
    func getUser(id: String, completion: @escaping (User) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/users/\(id)", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<User>.self, from: data) ?? nil
            guard let user = data?.result else { return }
            completion(user)
        })
    }
    
    // MARK: Authentication
    func authRegister(user: SenderUser, completion: @escaping (RequestResult<Int>) -> ()) {
        let userData = try! JSONEncoder().encode(user)
        //print("User data:", String(data: userData, encoding: String.Encoding.utf8))
        baseHTTPRequest(url: "\(request.hostName)/api/auth/register", httpMethod: "POST", params: userData, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Int>.self, from: data) ?? nil
            if let data = data {
                completion(data)
                return
            }
            completion(RequestResult(code: 500, message: "Ошибка сервера", status: "", result: 0))
        })
    }
    
    func validateRegister(register: RegisterValidation,  completion: @escaping (RequestResult<Int>) -> ()) {
        let registerData = try! JSONEncoder().encode(register)
        baseHTTPRequest(url: "\(request.hostName)/api/auth/register/validate", httpMethod: "POST", params: registerData, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Int>.self, from: data) ?? nil
            if let data = data {
                completion(data)
                return
            }
            completion(RequestResult(code: 500, message: "Ошибка сервера", status: "", result: 0))
        })
    }
    
    func isValidToken(completion: @escaping (Bool) -> ()) {
        baseGetRequest(url: "\(request.hostName)/api/auth/token/validate", completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Bool>.self, from: data) ?? nil
            guard let isValidate = data?.result else { return }
            completion(isValidate)
        })
    }
    
    func changePassword(changePass: ChangePassword, completion: @escaping (RequestResult<Int>) -> ()) {
        let changePassData = try! JSONEncoder().encode(changePass)
        baseHTTPRequest(url: "\(request.hostName)/api/auth/changepassword", httpMethod: "POST", params: changePassData, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Int>.self, from: data) ?? nil
            completion(data!)
        })
    }
    
    func getToken(login: Login, completion: @escaping (RequestResult<Token>) -> ()) {
        let loginData = try! JSONEncoder().encode(login)
        let url: String = "\(request.hostName)/api/auth/token"
        baseHTTPRequest(url: url, httpMethod: "POST", params: loginData, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Token>.self, from: data) ?? nil
            guard let token = data?.result?.token else { return }
            self.request.token = token
            print("Token: ", token)
            completion(data!)
        })
    }
}
