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
    var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzZjhiZDYwYy0zYzM1LTQ0ZjgtOGQ4MS0wNzA3MDAxOTNmOWYiLCJ1bmlxdWVfbmFtZSI6ImFkbWluIiwianRpIjoiYTg1OWRlODEtYjkxZC00ODZmLThmM2MtYmMzOGY2NzkxYzIzIiwiaWF0IjoiMTEvMjAvMjAxOSAxOToxMjoyMCIsIm5iZiI6MTU3NDI3NzE0MCwiZXhwIjoxNjEwMjc3MTQwLCJpc3MiOiJNZSIsImF1ZCI6IkF1ZGllbmNlIn0.EwMhARyWIKP32DVF9VBgztWxpb7O4FTuAsv17rPI5Xk"
    
    private func getBearerAuthHeader() -> String {
        return "Bearer \(token)"
    }
    
    private init () {}
     
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
