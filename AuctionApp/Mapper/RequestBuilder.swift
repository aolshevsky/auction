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
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? jsonDecoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    // completionRes: @escaping (Result<[ResultT], Error>) -> ()
    private func baseGetRequest(url: String, completion: @escaping (Data?) -> ()) {
        request.getRequest(url: url, completion: { (statusCode, data) in
            // print("From data: ", data)
            //let data = self.decodeJSON(type: RequestResult<ResultT>.self, from: data) ?? nil
            // print("Status code: ", statusCode)
            // print("Data: ", data)
            completion(data)
        })
    }
    
    private func baseHTTPRequest(url: String, httpMethod: String="POST", isAuth: Bool=false, params: ParamsDict=[:], completion: @escaping (Data?) -> ()) {
        DispatchQueue.main.async {
            self.request.httpRequest(url: url, params: params, httpMethod: httpMethod, isAuth: isAuth, completion: { (statusCode, data) in
                // print("From data: ", data)
                //let data = self.decodeJSON(type: RequestResult<ResultT>.self, from: data) ?? nil
                // print("Status code: ", statusCode)
                // print("Data: ", data)
                completion(data)
            })
        }
    }
    
    func getToken() {
        let params = ["username": "admin", "password": "123qweA!"]
        let url: String = "\(request.hostName)/api/auth/token"
        baseHTTPRequest(url: url, httpMethod: "POST", params: params, completion: { (data) in
            let data = self.decodeJSON(type: RequestResult<Token>.self, from: data) ?? nil
            guard let token = data?.result?.token else { return }
            self.request.token = token
            print("Token: ", token)
        })
    }
    
    // MARK: Auctions
    func getAuctions() {
        baseGetRequest(url: "\(request.hostName)/api/auctions", completion: { (data) in
            print("ds")
            
        })
    }
    
//    func getAuction(id: String) {
//        baseGetRequest(url: "\(request.hostName)/api/auctions\(id)")
//    }
//
//    func setAuction(auction: Auction) {
//        // TODO: decode to json
//        baseHTTPRequest(url: "\(request.hostName)/api/auctions", httpMethod: "POST")
//    }
//
//    func deleteAuction(id: String) {
//        baseHTTPRequest(url: "\(request.hostName)/api/auctions/\(id)", httpMethod: "DELETE")
//    }
//
//    // MARK: Favorites
//    func getAllFavorites() {
//        baseGetRequest(url: "\(request.hostName)/api/favorites/all")
//    }
//
//    func getFavorites() {
//        baseGetRequest(url: "\(request.hostName)/api/favorites/")
//    }
//
//    func getFavorites(id: String) {
//        baseGetRequest(url: "\(request.hostName)/api/favorites/\(id)")
//    }
//
//    func getAllFavorites(id: String) {
//        baseGetRequest(url: "\(request.hostName)/api/favorites/all\(id)")
//    }
//
//    func deleteFavorites(id: String) {
//        baseHTTPRequest(url: "\(request.hostName)/api/favorites/\(id)", httpMethod: "DELETE")
//    }
//
//    func deleteAllFavorites(id: String) {
//        baseHTTPRequest(url: "\(request.hostName)/api/favorites/all/\(id)", httpMethod: "DELETE")
//    }
//
    // MARK: Profile
    func getProfile() {
        baseGetRequest(url: "\(request.hostName)/api/me/", completion: { (data) in
            print("From data: ", data)
            let data = self.decodeJSON(type: RequestResult<User>.self, from: data) ?? nil
            print("Res data:", data)
            guard let user = data?.result else { return }
            print("User: ", user)
            
        })
    }

//    func putProfile(user: User) {
//        baseHTTPRequest(url: "\(request.hostName)/api/me/", httpMethod: "PUT")
//    }
    
}
