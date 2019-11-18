//
//  Request.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/19/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class Request {
    
    static let inst: Request = Request()
    
    let hostName: String = "https://25f7648b.ngrok.io"
    var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzZjhiZDYwYy0zYzM1LTQ0ZjgtOGQ4MS0wNzA3MDAxOTNmOWYiLCJ1bmlxdWVfbmFtZSI6ImFkbWluIiwianRpIjoiMzMyZmZhMTUtYzk2ZC00NTg0LTlhNzAtZDg0YjYzMDg4NDEwIiwiaWF0IjoiMTEvMTgvMjAxOSAyMzo0NTo1MyIsIm5iZiI6MTU3NDEyMDc1MywiZXhwIjoxNjEwMTIwNzUzLCJpc3MiOiJNZSIsImF1ZCI6IkF1ZGllbmNlIn0.s5FCj7zWv3FtVxfeh8-QHyE-d0ASeDvPPzOBYYeF7_Q"
    
//    func getToken(username: String, password: String) -> String {
//        let data = ["username": username, "password": password]
//        let url: String = "\(hostName)api/auth/token"
//        return getRequest(url: url, withHeader: false)
//    }
    
    private func getBearerAuthHeader() -> String {
        return "Bearer \(token)"
    }
    
    private init () {
        // token = getRequest(url: <#T##String#>, withHeader: <#T##Bool#>)
    }
    
    func getRequest(url: String, withHeader: Bool) {
        guard let url = URL(string: url) else { return }
        var urlRequest = URLRequest(url: url)
        
        if withHeader {
            urlRequest.setValue(getBearerAuthHeader(), forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data,
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            error == nil else { return }

            do {
              let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response: ", json)
            } catch {
                print("Error: ", error)
            }
        }.resume()
    }
    
    func postRequest() {}
}
