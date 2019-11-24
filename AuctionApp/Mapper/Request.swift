//
//  Request.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


typealias SingleJson = [String: AnyObject]
typealias ArrayJson = [[String: AnyObject]]
typealias ParamsDict = [String: String]


class Request {
    
    static let shared: Request = Request()
    
    let hostName: String = "https://202a8198.ngrok.io"
    var token: String = ""
    
    private func getBearerAuthHeader() -> String {
        return "Bearer \(token)"
    }
    
    private init () {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: DefaultsKeys.token) {
            self.token = token
        }
        // defaults.removeObject(forKey: DefaultsKeys.token)
    }
     
    func createRequestBody(params: ParamsDict) -> Data {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return Data()}
        return httpBody
    }
    
    func getRequest(url: String, isAuth: Bool=true, completion: @escaping (Int, Data) -> ()) {
        guard let url = URL(string: url) else { return completion(400, Data()) }
        var request = URLRequest(url: url)
        
        if isAuth {
            request.setValue(getBearerAuthHeader(), forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            guard let data = data,
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                error == nil else { return completion((response as? HTTPURLResponse)!.statusCode, Data())}

            return completion(httpURLResponse.statusCode, data)
        }.resume()
    }
    
    func httpRequest(url: String, params: Data, httpMethod: String = "POST", isAuth: Bool=true, completion: @escaping (Int, Data) -> ()) {
        guard let url = URL(string: url) else { return completion(400, Data())}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = params
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if isAuth {
            request.setValue(getBearerAuthHeader(), forHTTPHeaderField: "Authorization")
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//           if let response = response {
//               print(response)
//           }
           guard let data = data,
           let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
           error == nil else { return completion((response as? HTTPURLResponse)!.statusCode, Data())}

            return completion(httpURLResponse.statusCode, data)
        }.resume()
    }
}
